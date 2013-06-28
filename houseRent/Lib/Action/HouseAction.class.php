<?php
import("@.Model.HouseInfoModel");
import("@.Model.RegionModel");
import("@.Model.UserModel");
import("@.Model.UserCompanyModel");
import("@.Model.UserCollegeModel");
import("@.Model.HouseViewModel");
import('Common.HousePublish',APP_PATH,'.php');
import('Common.Util',APP_PATH,'.php');
import('Common.Misc',APP_PATH,'.php');

/*
 * 房源相关的操作，发布房源，查询房源
 */
class HouseAction extends Action {
	
	//开始搜索
	function search()
	{
		if(isLogin())
		{
			session_start();
			$this->assign('user',currentUserName());
			header ( "Content-Type:text/html; charset=utf-8" );
		}
		$this->display ( "search" );
	}
	
	//关键字查询房源
	function doSearch()
	{
		
	}
	
	/*
	 * 添加房源页面
	 */
	function publishHouse() {
		header ( "Content-Type:text/html; charset=utf-8" );

		$this->display ( "publishhouse" );
	}
	
	/*
	 * 房源列表页面
	 */
	function houseList() {
		header ( "Content-Type:text/html; charset=utf-8" );
		$data = array();
		$houseinfo = new HouseInfoModel();
		
		$houseinfolist=$houseinfo->findHouse($_POST);
		$data['all_count']=$houseinfolist["allcount"];

		if($data['all_count']==0){
			$data['current_count']=0;
		}
		if($houseinfolist["list"]){
			$data['current_count']=count($houseinfolist["list"]);
			$data['houseinfo_list']=$houseinfolist["list"];
		}else{
			$data['current_count']=0;
			$data['houseinfo_list']=null;
			
		}
		
		$data['houseinfo_list']=$houseinfolist["list"];
		
		
		$this->ajaxReturn($data);
	}
	/*
	 * 提交发布房源信息
	 */
	function publishHouseAction(){
		$data = array();
		if(!isLogin())
		{
			$data['code']=-1;
			$data['msg']="not login!";
			$this->ajaxReturn($data);
		}
		session_start();
		$houseInfo = D ("HouseInfo");
		if($houseInfo->create ())
		{
			$houseInfo->userId=$_SESSION['userId'];
			//houseType($user,$_POST['room'],$_POST['parlor'],$_POST['washroom']);
			//floorInfo($user,$_POST['currentfloor'],$_POST['maxfloor']);
			$houseInfo->createTime=intNow();
			$houseInfo->viewCount=0;
			
			if($houseInfo->add()){
				$data['code']=0;
				$data['msg']="";
			}else{
				$data['code']=1;
				$data['msg']="publish fail!";
			}	
		}
		else
		{
			$data['code']=1;
			$data['msg']=$user->getError();
		}
		
		$this->ajaxReturn($data);

	}
	/*
	 * 根据房屋id查询房屋详情页
	 * 
	 */
	function houseInfoAction(){
		header ( "Content-Type:text/html; charset=utf-8" );
		if(!isLogin())
		{
			$data['code']=-1;
			$data['msg']="not login!";
			$this->assign ( 'data', $data);
			$this->display ( "houseinfo" );
			return ;
		}
		$houseId=$_POST['houseId'];
		$data = array();
		$houseinfo = new HouseInfoModel();
		$data["houseinfo"]=$houseinfo->getHouseInfo($houseId);
		$this->assign ( 'data', $data);
		$this->display ("houseinfo");
	}
	
	//查看房源信息
	function info()
	{
		$houseId = $_GET['id'];
		if(is_null($houseId))
		{
			echo "对不起，您的请求中参数正确！";
			return;
		}
		if(isLogin())
		{
			$this->assign('user',currentUserName());
			header ( "Content-Type:text/html; charset=utf-8" );
		}
		
		$houseInfo = M('HouseInfo');
		$houseInfoObj = $houseInfo->find($houseId);
		$this->assign('houseInfo',$houseInfoObj);
		
		$region = M('Region');
		$regionId = $houseInfoObj['region'];
		$regionObj = $region->find($regionId);
		$this->assign("region",$regionObj);

		$houseUser = M("User");
		$houseUserId = $houseInfoObj["userId"];
		$houseUserObj = $houseUser->find($houseUserId);
		$this->assign("houseUser",$houseUserObj);
		
		$userCompany = new UserCompanyModel();
		$company = $userCompany->getUserCompany($houseUserId);
		$this->assign("company",$company);
		
		$userCollege = new UserCollegeModel();
		$college = $userCollege->getUserCollege($houseUserId);
		$this->assign("college",$college);
		//保存用户浏览房源记录
		$houseViewModel = new HouseViewModel();
		$result = $houseViewModel->saveOrUpdate(currentUserId(),$houseId);
		if(result==1)
		{
			$houseInfo->where("houseId={$houseId}")->setInc("viewCount",1);
		}
		
		
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display("houseInfo");
	}
	
	//关注度高的房子
	function popularHouse()
	{
		$houseInfoModel = new HouseInfoModel();
		$houseList =$houseInfoModel->popularHouse();
		$data = array();
		$data['result'] = true;
		$data['houseList'] = $houseList;
		$this->ajaxReturn($data);
	}
	
	//一个街道的房子
	function streetHouse()
	{
		$data = array();
		$street = $_GET['street'];
		if(is_null($street))
		{
			$data['result'] = false;
			$data['msg']="参数不正确！";
			$this->ajaxReturn($data);
			return;
		}
		
		$houseInfoModel = new HouseInfoModel();
		$data['result'] = true;
		$data['houseList'] = $houseInfoModel->streatHouse($street);
		$this->ajaxReturn($data);
	}
	
	
}
