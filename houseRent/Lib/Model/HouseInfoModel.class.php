<?php
class HouseInfoModel extends Model{
	protected $trueTableName = 'house_info';
	
    /*
     * 通过参数信息查找房源
     */
    function findHouse($region,$price,$houseType)
    {
    	$wheresql="";
    	if(!is_null($region)){
    		if($wheresql!=""){
    			$wheresql.=" region="+$region;
    		}else{
    			$wheresql.=" and region="+$region;
    		}
    		
    	}
       	if(!is_null($price)){
       	    if($wheresql!=""){
    			$wheresql.=" price="+$price;
    		}else{
    			$wheresql.=" and price="+$price;
    		}
    	}
        if(!is_null($houseType)){
            if($wheresql!=""){
    			$wheresql.=" house_type="+$houseType;
    		}else{
    			$wheresql.=" and house_type="+$houseType;
    		}
    	}
    	if($wheresql!=""){
    		$wheresql=" where ".$wheresql;
    	}
    	$querySQL = "select * from house_info ".$wheresql;
    	$countSQL="select count(*) count  from house_info ".$wheresql;
    	
    	$list["list"]= $this->query($querySQL);
    	$count=$this->query($countSQL);
    	$list["allcount"]=$count[0]["count"];
    	return $list;
    }

}