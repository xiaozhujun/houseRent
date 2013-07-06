<?php
class OneDuFriendModel extends Model{
	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("fromUser","require","好友七点不能为空"),
			array("oneDuUser","require","好友七点不能为空"),
			array("toUser","require","跟节点不能为空"),
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

}