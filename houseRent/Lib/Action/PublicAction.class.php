<?php
import('Common.Misc',APP_PATH,'.php');
import("@.Model.UserCompanyModel");
import("@.Model.CompanyModel");
import("@.Model.UserCollegeModel");
import("@.Model.CollegeModel");

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
			
			$this->assign('companyName',$companyName);
			$this->assign('collegeName',$collegeName);
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "index" );
		}
	}
}