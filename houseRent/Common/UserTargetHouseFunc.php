<?php

//更新用户租房目标区域
function updateUserTargetHouse($userId,$targetHouseName)
{
	$targetHouseModel = D('TargetHouse');
	$userTargetHouseModel = D('UserTargetHouse');
	//判断该公司信息是否存在，不存在则在数据库中添加一条记录
	$targetHouseObj = $targetHouseModel->findByName($targetHouseName);
	if(!$targetHouseObj)
	{
		$targetHouseData = array(
				"name"=>$targetHouseName,
		);
		if($targetHouseModel->create($targetHouseData))
		{
			$targetHouseId = $targetHouseModel->add();
		}
		else 
		{
			return false;
		}
	}
	else 
	{
		$targetHouseId = $targetHouseObj["id"];
	}
	//更新用户的公司模型信息
	$userTargetHouseObj = $userTargetHouseModel->findByUserId($userId);
	if($userTargetHouseObj)
	{
		$userTargetHouseObj['targetHouseId'] = $targetHouseId;
		$result = $userTargetHouseModel->data($userTargetHouseObj)->save();
	}
	else 
	{
		$userTargetHouseObj = array(
				"userId"=>$userId,
				"targetHouseId"=>$targetHouseId,
		);
		if($userTargetHouseModel->create($userTargetHouseObj))
		{
			$userTargetHouseModel->add();
		}
		else 
		{
			return false;
		}
	}
	return true;
}