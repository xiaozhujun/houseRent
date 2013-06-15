<?php
import('Common.Misc',APP_PATH,'.php');
import("@.Model.UserCompanyModel");
import("@.Model.CompanyModel");
import("@.Model.UserCollegeModel");
import("@.Model.CollegeModel");
import("@.Model.UserTargetHouseModel");
import("@.Model.TargetHouseModel");

class PublicAction extends Action
{
	//平台首页
	function index()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "loginIndex" );
		}
		else 
		{
			session_start();
			$this->assign('user',$_SESSION ['user']);
			$companyName = "";
			$collegeName = "";
			$targetHouseName = "";
			
			//获得当前用户的公司名称
			$userCompany = new UserCompanyModel();
			$userCompanyObj = $userCompany->findByUserId($_SESSION['userId']);
			if($userCompanyObj)
			{
				$company = new CompanyModel();
				$companyObj = $company->find($userCompanyObj['companyId']);
				$companyName =$companyObj['name'];
			}
			
			//获得当前用户的高校名称
			$userCollege = new UserCollegeModel();
			$userCollegeObj = $userCollege->findByUserId($_SESSION['userId']);
			if($userCollegeObj)
			{
				$college = new CollegeModel();
				$collegeObj = $college->find($userCollegeObj['collegeId']);
				$collegeName =$collegeObj['name'];
			}
			
			//获得当前用户的目标住房
			$userTargetHouse = new UserTargetHouseModel();
			$userTargetHouseObj = $userTargetHouse->findByUserId($_SESSION['userId']);
			if($userTargetHouseObj)
			{
				$targetHouse = new TargetHouseModel();
				$targetHouseObj = $targetHouse->find($userTargetHouseObj['targetHouseId']);
				$targetHouseName =$targetHouseObj['name'];
			}
			
			$this->assign('companyName',$companyName);
			$this->assign('collegeName',$collegeName);
			$this->assign('targetHouseName',$targetHouseName);
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "index" );
		}
	}
}