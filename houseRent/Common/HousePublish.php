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