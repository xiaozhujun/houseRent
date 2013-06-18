<?php
/*
 * 设置房屋类型参数
 */
	function houseType($user,$room,$parlor,$washroom){
		$user->house_type=0;
		if(!empty($room)){
			$user->house_type+=$room*100;
		}
		if(!empty($parlor)){
			$user->house_type+=$parlor*10;
		}
		if(!empty($washroom)){
			$user->house_type+=$washroom;
		}
	}
/*
 * 设置楼层数，当前层和最高层 100010 表示共100层，当前房子在10层
 */
function floorInfo($user,$currentfloor,$maxfloor){
	$user->flor_info=0;
	if(!empty($currentfloor)){
		$user->flor_info+=$currentfloor;
	}
	if(!empty($maxfloor)){
		$user->flor_info+=$maxfloor*1000;
	}
}
/*
* 根据价格获取房价具体参数
* [[0,'不限'],[1,'600元以下'],[2,'600-1000元'],[3,'1000-1500元'],[4,'1500-2000元'],[5,'2000-3000元'],[6,'3000-5000元'],[7,'5000-8000元'],[8,'8000元以上']];
*/
function getPriceInfo($pricetype){
	$price_array = array('0' => '','1' => ' price<=600','2' => ' price>600 and price<=1000','3' => ' price>1000 and price<=1500','4' => ' price>1500 and price<=2000','5' => ' price>2000 and price<=3000','6' => ' price>3000 and price<=5000','7' => ' price>5000 and price<=8000','8' => ' price>8000');
	return $price_array[$pricetype];	
}
/*
* 根据room获取具体参数
* room_array=[[0,'不限'],[1,'一室'],[2,'两室'],[3,'三室'],[4,'四室'],[5,'四室以上']];;
*/
function getRoomInfo($pricetype){
	$room_array = array('0' => '','1' => ' room=1','2' => ' room=2','3' => ' room=3','4' => ' room=4','5' => ' room>=5');
	return $room_array[$pricetype];	
}

/*
* 根据关键词获取具体参数
* 
*/
function getKeyWordInfo($key){
	$keyword="";
	$keyword.=" (title like '%".$key."%'"." or remark like '%".$key."%' or decoration like '%".$key."%')";
	return 	$keyword;
}