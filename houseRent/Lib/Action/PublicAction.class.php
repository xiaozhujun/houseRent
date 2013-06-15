<?php
import('Common.Misc',APP_PATH,'.php');
import("@.Model.UserCompanyModel");
import("@.Model.CompanyModel");

class PublicAction extends Action
{
	//平台首页
	function index()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "loginIndex" );
			//redirect(C('LOGIN_URL'));
			//return;
		}
		else 
		{
			session_start();
			$this->assign('user',$_SESSION ['user']);
			$companyName = "";
			$userCompany = new UserCompanyModel();
			$userCompanyObj = $userCompany->findByUserId($_SESSION['userId']);
			if($userCompanyObj)
			{
				$company = new CompanyModel();
				$companyObj = $company->find($userCompanyObj['companyId']);
				$companyName =$companyObj['name'];
			}
			
			$this->assign('companyName',$companyName);
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->display ( "index" );
		}
	}
}