<?php
import ( "@.Model.UserModel" );
import ( 'Common.MailUtil', APP_PATH, '.php' );
import ( 'Common.Misc', APP_PATH, '.php' );

// 本类由系统自动生成，仅供测试用途
class UserAction extends Action {
	public function index() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "register" );
	}
	
	// 注册用户
	function add() {
		$data = array();
		$data['success'] = false;
		if (C ( 'USE_INVITATION' ) && (! isset ( $_POST ['invitor'] ) || ! isset ( $_POST ['invitationCode'] ))) {
			$data['msg'] = '您需要邀请码或者现有用户发送邀请邮件方可注册，对您的支持表示衷心的感谢哦！';
			$this->ajaxReturn($data);
			return;
		}
		
		session_start ();
		$error_msg = '';
		// $_GET $_POST
		$verify = $_POST ['verify'];
		$email = $_POST ['email'];
		$realName = $_POST['realName'];
		if (! isset ( $verify ) || $verify == '') {
			$data['msg'] =  '验证码不能为空';
			$this->ajaxReturn($data);
			return;
		}
		
		if (md5 ( $verify ) != $_SESSION ['verify']) {
			$data['msg'] =  '验证码不正确';
			$this->ajaxReturn($data);
			return;
		}
		
		// 实例化自定义模型 M('User')实例化基础模型
		$user = D ( "User" );
		
		if ($user->create ()) {
			$vo = $user->data;
			// 执行插入操作，执行成功后，返回新插入的数据库的ID
			if ($user->add ()) {
				$vo = $user->findByEmail ( $email );
				// 发送欢迎邮件
				$activateAddress = C ( 'DOMAIN' ) . C ( 'BASE_URL' ) . '?m=User&a=regActivate&email=' . $email . '&activateCode=' . $vo ['activateCode'];
				$subject = '租客团，感谢您的支持！';
				$email_content = "亲爱的，{$realName}:<br>感谢您的支持并使用租客团，我们将竭尽所能与您分担租房、住房过程中的烦扰哦！\n\t请您点击激活链接，开始使用我们为精心打造的服务吧！\n\t{$activateAddress}";
				if(C('IS_TEST'))
				{
					$email = C('TEST_EMAIL');
				}
				// 发送邮件
				$email_result = sendMail ( $email, $realName, $subject, $email_content );
				
				$data['msg'] =  '恭喜您，注册成功！已发送激活邮件，请您注意查收账户激活邮件！';
				$data['success'] = true;
				$this->ajaxReturn($data);
				return;
			} else {
				$data['msg'] = $user->getError();
				$this->ajaxReturn($data);
				return;
			}
		} else {
			// 把错误信息提示给用户看
			$data['msg'] = $user->getError();
			$this->ajaxReturn($data);
			return;
		}
	}
	
	// 用户注册激活
	function regActivate() {
		if (! isset ( $_GET ['email'] ) || ! isset ( $_GET ['activateCode'] )) {
			$this->assign ( 'result_msg', '请求出错，请您重新申请激活！' );
			$this->display ( 'regActivateFail' );
			return;
		}
		
		$email = $_GET ['email'];
		$activateCode = $_GET ['activateCode'];
		// 执行登录
		$userModel = new UserModel ();
		if ($userModel->regActivate ( $email, $activateCode )) {
			header ( "Content-Type:text/html; charset=utf-8" );
			redirect('/',3,'恭喜您，激活成功！系统3秒内将自动跳转到首页登录！感谢您的支持！');
		} else {
			header ( "Content-Type:text/html; charset=utf-8" );
			redirect('/User/resendActivate',5,'对不起，激活失败！系统5秒内将自动跳转到重新发送激活邮件申请页！感谢您的支持！');
		}
	}
	
	//登录页
	function login()
	{
		$this->display ( 'login' );
	}
	
	// 用户登录
	function doLogin() {
		$data = array();
		$data['success'] = false;
		// 判断有无参数
		if (! isset ( $_POST ['email']) )
		{
			$data['msg'] = '请填写登陆邮箱！';
			$this->ajaxReturn($data);
			return;
		}
		else if (! isset ( $_POST ['password']) )
		{
			$data['msg'] = '请填写登陆密码！';
			$this->ajaxReturn($data);
			return;
		}
		else {
			// 获取参数
			$email = $_POST ['email'];
			$password = $_POST ['password'];
			
			// 执行登录
			$userModel = new UserModel ();
			
			if ($userModel->login ( $email, $password )) {
				session_start ();
				$vo = $userModel->findByEmail($email);
				$_SESSION ['user'] = $vo['realName'];
				$_SESSION ['userId'] = $vo['id'];
				
				$data['success'] = true;
				$this->ajaxReturn($data);
			} else {
				$data['msg'] = $userModel->getError ();
				$this->ajaxReturn($data);
			}
		}
	}
	
	// 用户登出
	function logout() {
	
		session_start ();
		session_destroy();
		header ( "Content-Type:text/html; charset=utf-8" );
		redirect ('/');
	}
	
	// 生成图片验证码
	function verify() {
		/**
		 * 在thinkPHP中如何实现验证码
		 *
		 * ThinkPHP已经为我们提供了图像处理的类库ThinkPHP\Extend\...
		 *
		 * 如何导入类库？
		 * 导入类库用"import(文件路径)来导入，但是注意文件的路径中的\要替换成 . 号"
		 * 1）导入系统的类库 import(从library开始算起) import('ORG.Util.Image')注意大小写
		 * 2）导入项目类库 import("@.ORG.Image") 我们需要在我恩的项目的Lib目录中存放
		 */
		// 导入图形处理类库
		import ( "ORG.Util.Image" );
		// import("@.ORG.Image");
		
		// 生成图形验证码
		/*
		 * length：验证码的长度，默认为4位数 mode：验证字符串的类型，默认为数字，其他支持类型有0 字母 1 数字 2 大写字母 3 小写字母 4中文 5混合（去掉了容易混淆的字符oOLl和数字01） type：验证码的图片类型，默认为png width：验证码的宽度，默认会自动根据验证码长度自动计算 height：验证码的高度，默认为22 verifyName：验证码的SESSION记录名称，默认为verify
		 */
		// 实现英文验证码
		image::buildImageVerify ( 4, 1, 'gif', 60, 22, 'verify' );
		// 实现中文验证码
		// image::GBVerify();
	}
	
	// 用户注册页面
	function register() {
		header ( "Content-Type:text/html; charset=utf-8" );
		if (isset ( $_GET ['invitor'] )) {
			$this->assign ( 'invitor', $_GET ['invitor'] );
		}
		if (isset ( $_GET ['invitationCode'] )) {
			$this->assign ( 'invitationCode', $_GET ['invitationCode'] );
		}
		
		$this->display ( "register" );
	}
	
	// 重新发送激活信息
	function resendActivate() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "resendActivate" );
	}
	
	// 重新发送激活信息
	function resendActivateAction() {
		// $_GET $_POST
		$email = $_POST ['email'];
		if (! isset ( $email )) {
			$this->assign ( 'result_msg', '用户名不能为空' );
			$this->display ( 'resendActivate' );
			return;
		}
		
		$user = new UserModel ();
		
		$update_result = $user->updateActivateInfo ( $email );
		$email_result = false;
		$result_msg = '';
		if ($update_result) {
			$vo = $user->findByEmail ( $email );
			
			// 发送欢迎邮件
			$activateAddress = C ( 'DOMAIN' ) . C ( 'BASE_URL' ) . '?m=User&a=regActivate&email=' . $email . '&activateCode=' . $vo ['activateCode'];
			$subject = '租客团，账号激活！';
			$email_content = "亲爱的，{$vo['realName']}:<br>感谢您的支持并使用租客团，我们将竭尽所能与您分担租房、住房过程中的烦扰哦！\n\t请您点击激活链接，开始使用我们为精心打造的服务吧！\n\t{$activateAddress}";
			
			if (IS_BAE) {
				import ( "COM.BAIDU.Bcms" );
				global $accessKey, $secretKey, $host;
				$bcms = new Bcms ( $accessKey, $secretKey, $host );
				$email_result = $bcms->mail ( C ( 'EMAIL_QUEUE' ), $email_content, array (
						0 => $email 
				), array (
						Bcms::MAIL_SUBJECT => $subject 
				) );
			} else {
				$email_result = think_send_mail ( $email, $vo['realName'], $subject, $email_content );
			}
			
			if ($email_result) {
				$result_msg = '已经成功发送激活邮件，请注意查收！';
			} else {
				$result_msg = '邮件发送失败，请重试或联系管理员！';
			}
		} else {
			$result_msg = $user->getError ();
		}
		
		$this->assign ( 'result_msg', $result_msg );
		$this->display ( 'resendActivate' );
	}
	
	//用户重置密码
	function resetPwd()
	{
		if(!isLogin())
		{
			redirect ( C('LOGIN_URL'));
			return;
		}
		
		if(!isset($_POST['oldPwd'])|| empty($_POST['oldPwd'])||!isset($_POST['newPwd'])||empty($_POST['newPwd'])||!isset($_POST['rePwd'])||empty($_POST['rePwd']))
		{
			$result = array("success"=>false,"msg"=>"参数填写不完整！");
			$this->ajaxReturn($result);
			return;
		}
		
		if($_POST['newPwd'] == $_POST['oldPwd'])
		{
			$result = array("success"=>false,"msg"=>"对不起，您输入的新密码与老密码一致！");
			$this->ajaxReturn($result);
			return;
		}
		
		if($_POST['newPwd'] != $_POST['rePwd'])
		{
			$result = array("success"=>false,"msg"=>"新密码与确认密码不一致！");
			$this->ajaxReturn($result);
			return;
		}
		
		session_start ();
		$userId = $_SESSION['userId'];
		$userModel = new UserModel();
		$user = $userModel->find($userId);
		
		if(md5($_POST['oldPwd']) != $user['password'])
		{
			$result = array("success"=>false,"msg"=>$user['email']);
			$this->ajaxReturn($result);
			return;
		}
		
		if($userModel->resetPwd($user['id'],$_POST['newPwd']))
		{
			$result = array("success"=>true,"msg"=>"重置密码成功！");
			$this->ajaxReturn($result);
		}
		else
		{
			$result = array("success"=>false,"msg"=>"重置密码失败！");
			$this->ajaxReturn($result);
		}
		
	}
	
	//维护个人信息
	function update()
	{
		if(!isLogin())
		{
			redirect ( C('LOGIN_URL'));
			return;
		}
		
		$data = array();
		if(isset($_POST['phone']) && !empty($_POST['phone']))
		{
			$data["phone"] = $_POST['phone'];
		}
		session_start();
		$data["id"] = $_SESSION['userId'];
		
		$userModel = new UserModel();
		if($userModel->update($data))
		{
			$result = array("success"=>true,"msg"=>"更新信息成功！");
			$this->ajaxReturn($result);
		}
		else
		{
			$result = array("success"=>false,"msg"=>"更新信息失败！");
			$this->ajaxReturn($result);
		}
	}
	
	//返回用户的基本信息
	function info()
	{
		if(!isLogin())
		{
			redirect ( C('LOGIN_URL'));
			return;
		}
		
		session_start();
		$userModel =M('User');
		$vo = $userModel->where('id='.$_SESSION['userId'])->getField('id,email,realName,phone,identifyNum');
		$this->ajaxReturn($vo[$_SESSION['userId']]);
	}
	
	//查找系统好友
	function findFriend()
	{
		
		if(!isLogin())
		{
			redirect ( C('LOGIN_URL'));
			return;
		}
		
		$condition = $_POST['condition'];
		$data = array();
		$data['success'] = false;
		if(!isset($condition) || empty($condition))
		{
			$data['msg'] = '请输入查询条件';
			$this->ajaxReturn($data);
			return;
		}
		
		$userModel = M('User');
		$list = $userModel->where("email='{$condition}' or realName='{$condition}'")->limit(12)->getField('id,id,realName');
		$data['list'] = array_values($list);
		$data['success'] = true;
		$this->ajaxReturn($data);
	}
	
	//个人中心
	function personCenter()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "loginIndex" );
		}
		else
		{
			session_start();
			$this->assign('user',$_SESSION ['user']);
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "personCenter" );
		}
	}
	
}