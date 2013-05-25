<?php

import('Common.Misc',APP_PATH,'.php');
class FriendAction extends Action
{
	
	//返回申请好友页面
	function applyFriendPage()
	{
		$result_msg = '';
		if(!isset($_GET[userId]) || empty($_GET['userId']))
		{
			$result_msg = '操作失败！';
		}
		else
		{
			$user = M('User');
			$appliedFriend = $user->find($_GET['userId']);
			$this->assign('realName',$appliedFriend['realName']);
			$this->assign('toUser',$appliedFriend['id']);
		}
		$this->assign('result_msg',$result_msg);
		$this->display('applyFriend');
	}
	
	//申请加为好友
	function applyFriend()
	{
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}
		
		$data = array();
		$data['success'] = false;
		if(!isset($_POST['toUser']) || empty($_POST['toUser']))
		{
			$data['msg'] = '被申请人未设置，操作失败！';
			$this->ajaxReturn($data);
			return;
		}
		
		if(!isset($_POST['authInfo']) || empty($_POST['authInfo']))
		{
			$data['msg'] = '验证信息不能为空！';
			$this->ajaxReturn($data);
			return;
		}
		
		$friendApply = M('FriendApply');
		$isExist = $friendApply->where("fromUser={$_SESSION['userId']}  and toUser={$_POST['toUser']} and status=0")->count();
		if($isExist)
		{
			$data['msg'] = '您已经提交的申请，请耐心等待！';
			$this->ajaxReturn($data);
			return;
		}
		
		session_start();
		$friendApplyData = array(
			"fromUser"=>$_SESSION['userId'],
			"toUser"=>$_POST['toUser'],
			"authInfo"=>$_POST['authInfo'],
			"status"=>0,
		);
		
		if($friendApply->create($friendApplyData))
		{
			if($friendApply->add())
			{
				$data['msg'] = '您的好友申请已经发送成功！';
				$data['success'] = true;
			}
			else 
			{
				$data['msg'] = $friendApply->getError();
			}	
		}
		else
		{
			$data['msg'] = $friendApply->getError();
		}
		
		$this->ajaxReturn($data);
		
	}
}