<?php

import('Common.DateUtil',APP_PATH,'.php');
//添加一度好友
function addOneDuFriend($fromUser,$toUser)
{
	$data = null;
	$oneDuModel = new OneDuFriendModel();
	
	$friendModel = new FriendModel();
	$endFriendList = $friendModel->where("fromUser={$toUser}")->field("toUser")->select();
	foreach ($endFriendList as $item)
	{
		$data = array(
				"fromUser"=>$fromUser,
				"oneDuUser"=>$toUser,
				"toUser"=>$item["toUser"],
				"createTime"=>dateTime(),
		);
		
		if($oneDuModel->create($data))
		{
			$oneDuModel->add();
		}
	}
	
	$friendModel = new FriendModel();
	$endFriendList = $friendModel->where("fromUser={$fromUser}")->field("toUser")->select();
	foreach ($endFriendList as $item)
	{
		$data = array(
				"fromUser"=>$toUser,
				"oneDuUser"=>$fromUser,
				"toUser"=>$item["toUser"],
				"createTime"=>dateTime(),
		);
		if($oneDuModel->create($data))
		{
			$oneDuModel->add();
		}
	}
}