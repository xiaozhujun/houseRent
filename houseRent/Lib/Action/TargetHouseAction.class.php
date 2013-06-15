<?php
import("@.Model.UserModel");
import("@.Model.TargetHouseModel");
import("@.Model.UserTargetHouseModel");
import('Common.Misc',APP_PATH,'.php');
import('Common.UserTargetHouseFunc',APP_PATH,'.php');

class TargetHouseAction extends Action
{
	//用户输入自己的公司
	function add()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->redirect(C('LOGIN_URL'));
		}
		else
		{
			$data = array();
			$data['result'] = false;
			session_start();
			$userId = $_SESSION['userId'];
			if(is_null($_POST['name']))
			{
				$data['msg'] = "公司名不能为空";
				$this->ajaxReturn($data);
				return;
			}		
			if(!updateUserTargetHouse($userId, $_POST['name']))
			{
				$data['msg'] = "操作错误";
				$this->ajaxReturn($data);
				return;
			}
			else
			{
				$data['msg'] = "修改成功";
				$data['result'] =true;
				$this->ajaxReturn($data);
				return;
			}
		}
	}
	
	//自动完成检索功能
	function autoComplete()
	{
		$list = array();
		if(isset($_POST['name']) && !is_null($_POST['name']))
		{
			$targetHouse = M('TargetHouse');
			$map = array();
			$map['name'] = array('like',"%{$_POST['name']}%");
			$list = $targetHouse->where($map)->getField('id,name');
		}
		if(is_null($list))
		{
			$list = array();
		}
		$data = array();
		$data['list'] = $list;
		$data['result'] = true;
		$this->ajaxReturn($data);
	}
}