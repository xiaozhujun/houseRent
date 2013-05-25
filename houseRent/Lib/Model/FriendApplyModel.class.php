<?php
class FriendApplyModel extends Model{

	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("fromUser","require","申请人不能为空"),
			array("toUser","require","申请人不能为空"),
	);

	//自动填充
	protected $_auto=array(
			array("createTime","dateTime",3,'callback'),
			array("updateTime","dateTime",3,'callback'),
	);

	//当前系统时间
	function dateTime()
	{
		return date("Y-m-d H:i:s");
	}
	
}