<?php
import('Common.DateUtil',APP_PATH,'.php');
class HouseViewModel extends Model{

	//根据用户编号和房源编号查找申请记录
	function findByIds($houseId,$userId)
	{
		if(is_null($houseId) || is_null($userId))
		{
			return null;
		}
		
		$houseApply = $this->where("userId={$userId} and houseId={$houseId} and status=0")->find();
		return $houseView;
	}
	
	//保存用户申请房源记录
	function saveOrUpdate($houseId,$userId)
	{
		if(is_null($houseId) || is_null($userId))
		{
			return 0;
		}
		
		$houseApply = $this->findByIds($houseId, $userId);
		if(is_null($houseApply))
		{
			$houseApply = array(
					"houseId"=>$houseId,
					"userId"=>$userId,
					createTime=>dateTime(),
					updateTime=>dateTime(),
					status=>0,
			);
			
			if($this->create($houseApply))
			{
				$this->add();
				return 1;
			}
			return 0;
		}
		else
		{
			return 2;
		}
	}
}