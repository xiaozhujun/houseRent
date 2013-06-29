<?php
import ( "@.Model.HouseInfoModel" );
import ( "@.Model.HouseCommentModel" );

import ( 'Common.MailUtil', APP_PATH, '.php' );
import ( 'Common.DateUtil', APP_PATH, '.php' );
import ( 'Common.Misc', APP_PATH, '.php' );

// 本类由系统自动生成，仅供测试用途
class HouseCommentAction extends Action {
	
	//收集房源
	function comment() {
		if(!isLogin())
		{
			redirect("/login.html");
			return;
		}

		$data = array();
		$data['success'] = false;
		$houseId = $_POST["houseId"];
		$comment = $_POST["comment"];
		
		if(is_null($houseId)||is_null($comment))
		{
			$data['msg'] = "参数不能为空！";
			$this->ajaxReturn($data);
			return;
		}
		
		
		
		session_start ();
		$userId = currentUserId();
		$userModel = new UserModel();
		$user = $userModel->find($userId);
		
		$houseCommentModel = new HouseCommentModel();
		$houseCommentObj = array(
				"userId"=>$userId,
				"realName"=>$user['realName'],
				"comment"=>$comment,
				"houseId"=>$houseId,
				"createTime"=>dateTime()
		);
		
		if(!is_null($_POST['replyComment']))
		{
			$replyComment = $houseCommentModel->find($_POST['replyComentId']);
			$houseCommentObj['replyUser'] = $replyComment['realName'];
			$houseCommentObj['replyComentId'] = $replyComment['id'];
		}
		
		if($houseCommentModel->create($houseCommentObj))
		{
			$houseCommentModel->add();
			$data['success'] = true;
		}
		else 
		{
			$data['msg'] = $houseCommentModel->getError();
		}
		$this->ajaxReturn($data);
	}
	
	//房源评论列表
	function houseCommentList()
	{
		$data = array();
		$houseId = $_GET['houseId'];
		if(is_null($houseId))
		{
			$data['result'] = false;
			$data['msg'] = "参数不能为空！";
			$this->ajaxReturn($data);
			return;
		}
		$houseComentModel = new HouseCommentModel();
		$commentList = $houseComentModel->where("houseId={$houseId}")->order("id desc")->limit(10)->select();
		
		$data['result'] = true;
		$data['commentList'] = $commentList;
		
		$this->ajaxReturn($data);
	}
	
}