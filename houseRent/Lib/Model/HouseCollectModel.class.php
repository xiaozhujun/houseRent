<?php
class HouseCollectModel extends Model{

	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
			array("collectUser","require","收藏人不能为空"),
			array("houseUser","require","房源发布人不能为空"),
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
	
	//判断收藏是否存在
	function isExist($userId,$houseId)
	{
		$result = $this->where("collectUser={$userId} and houseId={$houseId} and status=0")->select();
		if(sizeOf($result)>=1)
		{
			return true;
		}
		return false;
	}
	
}