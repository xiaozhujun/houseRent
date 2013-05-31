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
		$userModel = M('User');
		$fromUser = $userModel->find($_SESSION['userId']);
		$toUser = $userModel->find($_POST['toUser']);
		$friendApplyData = array(
			"fromUser"=>$_SESSION['userId'],
			"fromRealName"=>$fromUser['realName'],
			"toUser"=>$_POST['toUser'],
			"toRealName"=>$toUser['realName'],
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
	
	//没有被处理的申请
	function applyingUntreated()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
		
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=0 and fromUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
		
		
	}
	
	//被通过的申请
	function applyingPassed()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
	
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=1 and fromUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
	
	//被拒绝的申请
	function applyingRefused()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
	
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=2 and fromUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
	
	//没有处理的申请
	function applyingUntreat()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
	
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=0 and toUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	
	
	}
	
	//通过的申请
	function applyingPass()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
	
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=1 and toUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
	
	//拒绝的申请
	function applyingRefuse()
	{
		$data = array();
		$data['success'] = false;
		if(!isLogin())
		{
			$data['msg'] = "没有权限！";
			$this->ajaxReturn($data);
			return;
		}
	
		session_start();
		$userId = $_SESSION['userId'];
		$friendApply = M('FriendApply');
		$applyList = $friendApply->where('status=2 and toUser='.$userId)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
}