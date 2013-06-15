<?php

//更新用户所在公司信息
function updateUserCompany($userId,$companyName)
{
	$companyModel = D('Company');
	$userCompanyModel = D('UserCompany');
	//判断该公司信息是否存在，不存在则在数据库中添加一条记录
	$companyObj = $companyModel->findByName($companyName);
	if(!$companyObj)
	{
		$companyData = array(
				"name"=>$companyName,
		);
		if($companyModel->create($companyData))
		{
			$companyId = $companyModel->add();
		}
		else 
		{
			return false;
		}
	}
	else 
	{
		$companyId = $companyObj["id"];
	}
	//更新用户的公司模型信息
	$userCompanyObj = $userCompanyModel->findByUserId($userId);
	if($userCompanyObj)
	{
		$userCompanyObj['companyId'] = $companyId;
		$result = $userCompanyModel->data($userCompanyObj)->save();
	}
	else 
	{
		$userCompanyObj = array(
				"userId"=>$userId,
				"companyId"=>$companyId,
		);
		if($userCompanyModel->create($userCompanyObj))
		{
			$userCompanyModel->add();
		}
		else 
		{
			return false;
		}
	}
	return true;
}