<?php

define("UNTREAT",0);
define("PASS",1);
define("REFUSE",2);

import("@.Model.OneDuFriend");

import('Common.Misc',APP_PATH,'.php');
import('Common.DateUtil',APP_PATH,'.php');
import('Common.FriendUtil',APP_PATH,'.php');

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
			"status"=>UNTREAT,
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
		$applyList = $friendApply->where("fromUser={$userId} and status=".UNTREAT)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$applyList = $friendApply->where("fromUser={$userId} and status=".PASS)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$applyList = $friendApply->where("fromUser={$userId} and status=".REFUSE)->field("toUser,fromUser,fromRealName,toRealName,replyInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$applyList = $friendApply->where("toUser={$userId} and status=".UNTREAT)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$applyList = $friendApply->where("toUser={$userId} and status=".PASS)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->select();
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
		$applyList = $friendApply->where("toUser={$userId} and status=".REFUSE)->field("toUser,fromUser,fromRealName,toRealName,replyInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
	
	//返回拒绝好友申请页面
	function refuseApplyPage()
	{
		$result_msg = '';
		if(!isset($_GET[fromUser]) || empty($_GET['fromUser']))
		{
			$result_msg = '操作失败！';
		}
		else
		{
			$user = M('User');
			$appliedFriend = $user->find($_GET['fromUser']);
			$this->assign('realName',$appliedFriend['realName']);
			$this->assign('fromUser',$appliedFriend['id']);
		}
		$this->assign('result_msg',$result_msg);
		$this->display('refuseApply');
	}
	
	//拒绝好友申请
	function refuseApply()
	{
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}
		
		$data = array();
		$data['success'] = false;
		if(!isset($_POST['fromUser']) || empty($_POST['fromUser']))
		{
			$data['msg'] = '申请人未设置，操作失败！';
			$this->ajaxReturn($data);
			return;
		}
		
		$friendApply = M('FriendApply');
		$count = $friendApply->where("fromUser={$_POST['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->count();
		if(!$count)
		{
			$data['msg'] = '没有符合条件的记录！';
			$this->ajaxReturn($data);
			return;
		}
		
		session_start();
		$data = array(
				"status"=>REFUSE,
				"replyInfo"=>$_POST['replyInfo'],
		);
		$result = $friendApply->where("fromUser={$_POST['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->save($data);
		if($result)
		{
			$data['msg'] = '操作成功！';
			$data['success'] = true;
		}
		else 
		{
			$data['msg'] = '操作失败';
		}
		$this->ajaxReturn($data);
		
	}
	
	//拒绝好友申请
	function passApply()
	{
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}
	
		$data = array();
		$data['success'] = false;
		if(!isset($_GET['fromUser']) || empty($_GET['fromUser']))
		{
			$data['msg'] = '申请人未设置，操作失败！';
			$this->ajaxReturn($data);
			return;
		}
		
		$friendApply = M('FriendApply');
		$count = $friendApply->where("fromUser={$_GET['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->count();
		if(!$count)
		{
			$data['msg'] = '没有符合条件的记录！';
			$this->ajaxReturn($data);
			return;
		}
		
		session_start();
		$data = array(
				"status"=>PASS,
		);
		
		$result = $friendApply->where("fromUser={$_GET['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->save($data);
		$friend = M('Friend');
		$friendData = array(
				"fromUser"=>$_GET['fromUser'],
				"toUser"=>$_SESSION['userId'],
				"createTime"=>dateTime(),
		);
		
		addOneDuFriend($friendData["fromUser"],$friendData["toUser"]);
		
		if($friend->create($friendData))
		{
			$friend->add();	
		}
		$friendData = array(
				"fromUser"=>$_SESSION['userId'],
				"toUser"=>$_GET['fromUser'],
				"createTime"=>dateTime(),
		);
		$friend = M('Friend');
		if($friend->create($friendData))
		{
			$friend->add($friendData);
		}
		if($result)
		{
			$data['msg'] = '操作成功！';
			$data['success'] = true;
		}
		else
		{
			$data['msg'] = "操作失败";
		}
		$this->ajaxReturn($data);
	}
	
	//我的好友列表
	function myFriend()
	{
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}
	
		$data = array();
		$data['success'] = false;
			
		$friend = M('Friend');
		session_start();
		$userId = $_SESSION['userId'];
		$friendListId = $friend->join("user ON friend.toUser=user.id")->where("friend.fromUser={$_SESSION['userId']}")->field("user.id,user.name,user.realName")->select();
		
		$data['list'] = $friendListId;
		$data['msg'] = '操作成功！';
		$data['success'] = true;
		$this->ajaxReturn($data);
	}
	
	//邀请的好友列表
	function invitedFriend()
	{
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}
		
		$data = array();
		$data['success'] = false;
		session_start();
		$userModel = M("User");
		$friendList = $userModel->where("invitor={$_SESSION['userId']}")->field("id,name,realName")->select();
		
		$data['list'] = $friendList;
		$data['msg'] = '操作成功！';
		$data['success'] = true;
		$this->ajaxReturn($data);
	}
}