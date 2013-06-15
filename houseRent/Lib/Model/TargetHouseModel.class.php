<?php
class TargetHouseModel extends Model
{
//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("name","require","目标地点不能为空"),
			array("userId","require","用户编号不能为空"),
	);
	
	//自动填充
	protected $_auto=array(
			array("createTime","dateTime",1,'callback'),
	);
	
	//当前系统时间s
	function dateTime()
	{
		return date("Y-m-d H:i:s");
	}
	
	//通过名称查找目标住房对象
	function findByName($name)
	{
		if(is_null($name))
		{
			return null;
		}
		return $this->where("name='{$name}'")->find();
	}
	
	//判断目标住房是否存在
	function isExist($name)
	{
		$targetHouse = $this->findByName($name);
		if($targetHouse) return true;
		return false;
	}
	
}