<?php
class HouseCommentModel extends Model{

	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("userId","require","评论人不能为空"),
			array("comment","require","评论内容不能为空"),
			array("houseId","require","房源编号不能为空"),
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