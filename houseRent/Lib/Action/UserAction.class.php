<?php
import("@.Model.UserModel");
// 本类由系统自动生成，仅供测试用途
class UserAction extends Action {
	public function index() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "register" );
	}
	
	// 注册用户
	function add() {
		session_start ();
		if (md5 ( $_POST ['verify'] ) != $_SESSION ['verify']) {
			$this->error ( " {$_POST ['verify']} = $_SESSION ['verify']" );
		}
		
		// 实例化自定义模型 M('User')实例化基础模型
		$user = D ( "User" );
		
		if ($user->create ()) {
			// 执行插入操作，执行成功后，返回新插入的数据库的ID
			if ($user->add ()) {
				$this->regSuccess ();
			} else {
				$this->error ( "{$user->getError ()} register fail " );
			}
		} else {
			// 把错误信息提示给用户看
			$this->error ( $user->getError () );
		}
	}
	
	// 用户登录
	function login() {
		
		// 判断有无参数
		if (!isset ( $_POST ['name'] ))
			// 展示本页面
			$this->display ( 'login' );
		else {
			// 获取参数
			$name = $_POST ['name'];
			$password = $_POST ['password'];
			
			// 执行登录
			$userModel = new UserModel ();
			
			if ($userModel->login ( $name, $password )) {
				$_SESSION ['user'] = $name;
				$this->display ( 'loginSuccess' );
			} else {
				$this->display ( 'loginFail' );
			}
		}
	}
	
	// 注册成功处理
	function regSuccess() {
		$this->display ( "regSuccess" );
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
	function register() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "register" );
	}
} 