<?php
//判断用户是否登陆
function  isLogin()
{
	session_start();
	if(isset($_SESSION ['user']))
	{
		return true;
	}
	return false;
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