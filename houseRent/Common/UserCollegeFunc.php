<?php

//更新用户所在高校信息
function updateUserCollege($userId,$collegeName)
{ 	
	$collegeModel = D('College');
	$userCollegeModel = D('UserCollege');
	//判断该公司信息是否存在，不存在则在数据库中添加一条记录
	$collegeObj = $collegeModel->findByName($collegeName);
	if(!$collegeObj)
	{
		$collegeData = array(
				"name"=>$collegeName,
		);
		if($collegeModel->create($collegeData))
		{
			$collegeId = $collegeModel->add();
		}
		else 
		{
			return false;
		}
	}
	else 
	{
		$collegeId = $collegeObj["id"];
	}
	//更新用户的公司模型信息
	$userCollegeObj = $userCollegeModel->findByUserId($userId);
	if($userCollegeObj)
	{
		$userCollegeObj['collegeId'] = $collegeId;
		$result = $userCollegeModel->data($userCollegeObj)->save();
	}
	else 
	{
		$userCollegeObj = array(
				"userId"=>$userId,
				"collegeId"=>$collegeId,
		);
		if($userCollegeModel->create($userCollegeObj))
		{
			$userCollegeModel->add();
		}
		else 
		{
			return false;
		}
	}
	return true;
}