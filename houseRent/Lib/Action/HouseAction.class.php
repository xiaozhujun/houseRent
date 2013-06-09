<?php
import("@.Model.HouseInfoModel");
import('Common.HousePublish',APP_PATH,'.php');
import('Common.Util',APP_PATH,'.php');
import('Common.Misc',APP_PATH,'.php');

/*
 * 房源相关的操作，发布房源，查询房源
 */
class HouseAction extends Action {
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
		$houseinfolist=$houseinfo->findHouse(null,null,null);
		$count=count($houseinfolist["list"]);
		$data['houseinfo_list']=$houseinfolist["list"];
		$data['current_count']=$count;
		$data['all_count']=$houseinfolist["allcount"];
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
		
		$user = D ("HouseInfo");
		$user->create ();
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
		$this->ajaxReturn($data);

	}
	
	
}
