<?php
import("@.Model.HouseInfoModel");
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
			$this->assign('user',$_SESSION ['user']);
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
		$user = D ("HouseInfo");
		if($user->create ())
		{
			$user->user_id=$_SESSION['userId'];
			houseType($user,$_POST['room'],$_POST['parlor'],$_POST['washroom']);
			floorInfo($user,$_POST['currentfloor'],$_POST['maxfloor']);
			$user->input_time=intNow();
			if($user->add()){
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
		if(isLogin())
		{
			session_start();
			$this->assign('user',$_SESSION ['user']);
			header ( "Content-Type:text/html; charset=utf-8" );
		}
		header ( "Content-Type:text/html; charset=utf-8" );
		$this->display("houseInfo");
	}
	
	
}
