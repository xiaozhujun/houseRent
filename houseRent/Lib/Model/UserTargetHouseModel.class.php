<?php
class UserTargetHouseModel extends Model{
	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("targetHouseId","require","目标住房不能为空"),
			array("userId","require","用户编号不能为空"),
	);
	
	//自动填充
	protected $_auto=array(
			array("createTime","dateTime",1,'callback'),
	);
	
	//当前系统时间
	function dateTime()
	{
		return date("Y-m-d H:i:s");
	}
	
	//根据用户编号查找
	function findByUserId($userId)
	{
		if(is_null($userId)) return null;
		return $this->where("userId={$userId}")->find();
	}

}