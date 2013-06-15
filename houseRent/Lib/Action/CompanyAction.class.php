<?php
import("@.Model.UserModel");
import("@.Model.CompanyModel");
import("@.Model.UserCompanyModel");
import('Common.Misc',APP_PATH,'.php');
import('Common.UserCompanyFunc',APP_PATH,'.php');

class CompanyAction extends Action
{
	//用户输入自己的公司
	function add()
	{
		if(!isLogin())
		{
			header ( "Content-Type:text/html; charset=utf-8" );
			$this->redirect(C('LOGIN_URL'));
		}
		else
		{
			$data = array();
			$data['result'] = false;
			session_start();
			$userId = $_SESSION['userId'];
			if(is_null($_POST['name']))
			{
				$data['msg'] = "公司名不能为空";
				$this->ajaxReturn($data);
				return;
			}		
			if(!updateUserCompany($userId, $_POST['name']))
			{
				$data['msg'] = "操作错误";
				$this->ajaxReturn($data);
				return;
			}
			else
			{
				$data['msg'] = "修改成功";
				$data['result'] =true;
				$this->ajaxReturn($data);
				return;
			}
		}
	}
	
	//自动完成检索功能
	function autoComplete()
	{
		$list = array();
		if(isset($_POST['company']) && !is_null($_POST['company']))
		{
			$company = M('Company');
			$map = array();
			$map['name'] = array('like','%'.$_POST['company'].'%');
			$list = $company->where($map)->limit(10)->getField('name',true);
		}
		if(is_null)
		{
			$list = array();
		}
		$data = array();
		$data['list'] = $list;
		$data['result'] = true;
		$this->ajaxReturn($data);
	}
}