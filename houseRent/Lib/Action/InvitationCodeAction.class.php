<?php
import("@.Model.UserModel");
import("@.Model.UserInvitationCodeModel");
import('Common.MailUtil',APP_PATH,'.php');
import('Common.Misc',APP_PATH,'.php');

// 邀请码相关服务
class InvitationCodeAction extends Action {
	
	//默认首页
	public function index() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "inviteFriend" );
	}
	
	//创建邀请码
	function inviteFriend()
	{
		//$_GET $_POST
		$data = array();
		$data['success'] = false;
		/**/
		if(!isLogin())
		{
			$data['msg'] = '亲爱的，您还没有登陆，请登陆哦！';
		}
		else if(!isset($_POST['invitedEmail']))
		{
			$data['msg'] = '请填写邀请人的邮箱，谢谢！';
		}
		else 
		{
			$email = $_POST['invitedEmail'];
			$name = $_SESSION['user'];
			//$name = 'xiaozhujun';
			$userInvitationCode = new UserInvitationCodeModel();
			$user = new UserModel();
			$vo = $user->findByName($name);
			$userId = $vo["id"];
			$invitationCode = $userInvitationCode->createInvitationCode($userId);
			if(isset($invitationCode))
			{
				$activateAddress = C('DOMAIN').C('REGISTER_URL').'?invitor='.$userId.'&invitationCode='.$invitationCode;
				$subject = "{$name}邀请您加入租客团";
				$email_content = "亲爱的，您的好友{$name}邀请您加入租客团。<br>感谢您的支持并使用租客团，我们将竭尽所能与您分担租房、住房过程中的烦扰哦！\n\t请您点击链接地址完成注册，开始使用我们为精心打造的服务吧！\n\t{$activateAddress}";
			
				//发送邮件
				$email_result = sendMail($email, $name, $subject, $email_content);
				if($email_result)
				{
					$data['msg'] = '邀请邮件已经发送，请提醒您的好友查收邮件哦！';
					$data['success'] = true;
				}
				else
				{
					$data['msg'] = '邀请失败，请您重试或者与管理员联系';
				}
			}
			else
			{
				$data['msg'] = '邀请失败，请您重试或者与管理员联系';
			}
			
		}
		
		$this->ajaxReturn($data);
	}
	
}