<?php
import('Common.Misc',APP_PATH,'.php');

class PublicAction extends Action
{
	//平台首页
	function index()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "loginIndex" );
			//redirect(C('LOGIN_URL'));
			//return;
		}
		else 
		{
			session_start();
			$this->assign('user',$_SESSION ['user']);
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "index" );
		}
	}
}