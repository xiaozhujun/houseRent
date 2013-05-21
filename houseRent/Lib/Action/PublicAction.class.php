<?php
import('Common.Misc',APP_PATH,'.php');

class PublicAction extends Action
{
	//平台首页
	function index()
	{
		if(!isLogin())
		{
			redirect('/User/login');
			return;
		}
		
		session_start();
		$this->assign('user',$_SESSION ['user']);
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "index" );
	}
}