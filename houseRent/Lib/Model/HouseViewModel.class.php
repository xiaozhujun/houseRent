<?php
class HouseViewModel extends Model{
	
	//自动验证
	protected $_validate=array(
			//每个字段的详细验证内容
	);
	
	//自动填充
	protected $_auto=array(
	);

	//根据用户编号和房源编号查找浏览记录
	function findByIds($houseId,$userId)
	{
		if(is_null($houseId) || is_null($userId))
		{
			return null;
		}
		
		$houseView = $this->where("houseInfoId={$houseId} and userId={$userId}")->find();
		return $houseView;
	}
	
	//保存用户浏览房源记录
	function saveOrUpdate($houseId,$userId)
	{
		if(is_null($houseId) || is_null($userId))
		{
			return 0;
		}
		$houseView = $this->findByIds($houseId, $userId);
		if(is_null($houseView))
		{
			$houseView = array(
					"houseInfoId"=>$houseId,
					"userId"=>$userId,
					createTime=>dateTime(),
					updateTime=>dateTime(),
					count=>1,
			);
			if($this->create($houseView))
			{
				$this->add();
				return 1;
			}
			return 3;
		}
		else
		{
			$data = array(
					id=>$houseView['id'],
					updateTime=>dateTime(),
					count=>$houseView['count']+1,
			);
			
			$this->save($data);
			return 2;
		}
	}
}