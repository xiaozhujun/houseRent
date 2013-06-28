<?php

define("UNTREAT",0);
define("PASS",1);
define("REFUSE",2);
import("@.Model.UserModel");
import("@.Model.HouseApplyModel");
import('Common.Misc',APP_PATH,'.php');
import('Common.DateUtil',APP_PATH,'.php');
class HouseApplyAction extends Action
{
	//返回申请房源页面
	function applyHousePage()
	{
		$result_msg = '';
		if(!isset($_GET[userId]) || empty($_GET['userId']))
		{
			$result_msg = '操作失败！';
		}
		else
		{
			$user = new UserModel();
			$house = new HouseInfoModel();
			$appliedUser = $user->find($_GET['userId']);
			$appliedHouse = $house->find($_GET['houseId']);
			
			$this->assign('realName',$appliedUser['realName']);
			$this->assign('toUser',$appliedUser['id']);
			$this->assign('houseInfoTitle',$appliedHouse['title']);
			$this->assign('houseId',$_GET['houseId']);
		}
		$this->assign('result_msg',$result_msg);
		$this->display('applyHouse');
	}
	
	//申请房源
	function applyHouse()
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
		
		$houseApply = M('HouseApply');
		$isExist = $houseApply->where("houseId={$_POST['houseId']} and fromUser={$_SESSION['userId']}  and toUser={$_POST['toUser']} and status=0")->count();
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
		$houseApplyData = array(
			"fromUser"=>$_SESSION['userId'],
			"fromRealName"=>$fromUser['realName'],
			"toUser"=>$_POST['toUser'],
			"houseId"=>$_POST['houseId'],
			"toRealName"=>$toUser['realName'],
			"authInfo"=>$_POST['authInfo'],
			"status"=>UNTREAT,
			"createTime"=>dateTime(),
			"updateTime"=>dateTime(),
		);
		
		if($houseApply->create($houseApplyData))
		{
			if($houseApply->add())
			{
				$data['msg'] = '您的房源申请已经发送成功！';
				$data['success'] = true;
			}
			else 
			{
				$data['msg'] = $houseApply->getError();
			}	
		}
		else
		{
			$data['msg'] = $houseApply->getError();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("fromUser={$userId} and status=".UNTREAT)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("fromUser={$userId} and status=".PASS)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("fromUser={$userId} and status=".REFUSE)->field("toUser,fromUser,fromRealName,toRealName,replyInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("toUser={$userId} and status=".UNTREAT)->field("houseId,toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->limit(1,10)->select();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("toUser={$userId} and status=".PASS)->field("toUser,fromUser,fromRealName,toRealName,authInfo,createTime")->order("createTime desc")->select();
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
		$houseApply = M('HouseApply');
		$applyList = $houseApply->where("toUser={$userId} and status=".REFUSE)->field("toUser,fromUser,fromRealName,toRealName,replyInfo,createTime")->order("createTime desc")->limit(1,10)->select();
		$data['success'] = true;
		$data['list'] = $applyList;
		$this->ajaxReturn($data);
	}
	
	//返回拒绝房源申请页面
	function refuseApplyPage()
	{
		$result_msg = '';
		if(!isset($_GET[fromUser]) || empty($_GET['fromUser']))
		{
			$result_msg = '操作失败！';
		}
		else
		{
			$user = new UserModel();
			$house = new HouseInfoModel();
			$appliedUser = $user->find($_GET['fromUser']);
			$appliedHouse = $house->find($_GET['houseId']);
			
			$this->assign('realName',$appliedUser['realName']);
			$this->assign('fromUser',$appliedUser['id']);
			$this->assign('houseInfoTitle',$appliedHouse['title']);
			$this->assign('houseId',$_GET['houseId']);
			
		}
		$this->assign('result_msg',$result_msg);
		$this->display('refuseApply');
	}
	
	//拒绝房源申请
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
		
		$houseApply = M('HouseApply');
		$count = $houseApply->where("houseId={$_POST['houseId']} and fromUser={$_POST['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->count();
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
		$result = $houseApply->where("houseId={$_POST['houseId']} and fromUser={$_POST['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->save($data);
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
	
	//拒绝房源申请
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
		
		$houseApply = M('HouseApply');
		$count = $houseApply->where("houseId={$_POST['houseId']} and fromUser={$_GET['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->count();
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
		
		$result = $houseApply->where("houseId={$_POST['houseId']} and fromUser={$_GET['fromUser']} and toUser={$_SESSION['userId']} and status=".UNTREAT)->save($data);
		$house = M('House');
		$houseData = array(
				"fromUser"=>$_GET['fromUser'],
				"toUser"=>$_SESSION['userId'],
				"createTime"=>dateTime(),
		);
		if($house->create($houseData))
		{
			$house->add();	
		}
		$houseData = array(
				"fromUser"=>$_SESSION['userId'],
				"toUser"=>$_GET['fromUser'],
				"createTime"=>dateTime(),
		);
		$house = M('House');
		if($house->create($houseData))
		{
			$house->add($houseData);
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
	
}