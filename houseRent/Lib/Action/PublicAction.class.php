<?php
class PublicAction extends Action
{
	//平台首页
	function index()
	{
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display ( "index" );
	}
	
	
}