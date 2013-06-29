<?php
//判断用户是否登陆
function  isLogin()
{
	session_start();
	if(is_null($_SESSION['user']))
	{
		return false;
	}
	return true;
}

//判断用户是否管理员
function isAdmin()
{
	
}

//当前用户编号
function currentUserName()
{
	$userName = $_SESSION['user'];
	return 	$userName;
}

//当前用户编号
function currentUserId()
{
	$userId = $_SESSION['userId'];
	return 	$userId;
}