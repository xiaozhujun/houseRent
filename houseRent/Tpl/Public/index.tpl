<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<link href="/css/house.css" type="text/css" rel="stylesheet">
<link href="/css/publishHouse.css" type="text/css" rel="stylesheet">
<link href="/css/intention.css" type="text/css" rel="stylesheet">
<link href="/css/searchInput.css" type="text/css" rel="stylesheet">
<link href="/css/jquery/jquery-ui-1.10.3.custom.min.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.9.1.js" type="text/javascript"></script>
<script src="/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<script src="/js/emptyNote.js" type="text/javascript"></script>
<script src="/js/house.js" type="text/javascript"></script>
<script src="/js/jquery-dateFormat.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="租房,租客,团租,租客团,房源,圈子" />
<meta name="Description" content="租客团是中国领先的提供房源分享与交换社区服务的互联网技术公司，为用户提供免费的房源分享、检索、交换、交易服务。" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />  
<title>租客团-首页</title>  
</head>  
<body>  
<script type="text/javascript">
	$(document).ready(function(){
		$("#inviteLink").click(function(){
			$("#mainContentDiv").load($(this).attr("href"));
			return false;
		});
		
		$('.houseType').click(function(){
			var body = $(this).attr('body'); 
			$(this).addClass('houseTypeSelected');
			$(this).siblings().removeClass('houseTypeSelected');
			
			$('#'+body).show();
			$('#'+body).siblings().hide();
			
			if(body=='publishHouse')
			{
				$('#'+body).load($(this).attr('url'));
			}
			
		});
		
		$("input").emptyValue();
		
		$('#searchBtn').click(function(){
 			var newKey = $('#searchInput').val();
 			if(newKey!="")
 			{
 				location = $.URL.house.search + "?key="+$("#searchInput").val();
 			}
 			else
 			{
 				$("#searchMsg").html("请输入房源关键字！");
 			}
 			
 		});
 		
 		$('#companyInput').autocomplete({
                source: doCompanyAutoComplete,//获取数据的后台页面
                select: updateCompany,
        });
        
        $('#collegeInput').autocomplete({
                source: doCollegeAutoComplete,//获取数据的后台页面
                select: updateCollege,
        });
        
        $('#targetHouseInput').autocomplete({
                source: doTargetHouseAutoComplete,//获取数据的后台页面
                select: updateTargetHouse,
        });
        
        $('#companyInput').focusout(function(){
        	updateCompany();
        });
        $('#collegeInput').focusout(function(){
        	updateCollege();
        });
         $('#targetHouseInput').focusout(function(){
        	updateTargetHouse();
        });
        
        $.get($.URL.house.friendHouseList,null,friendHouseCallback,"json");
        $.get($.URL.house.oneDuHouseList,null,oneDuHouseCallback,"json");
   		
   		{if !is_null($companyName)}
        	var companyData = {};
        	companyData.company = '{$companyName}';
        	$.post($.URL.house.companyHouseList,companyData,companyHouseCallback,"json");
        {/if}
        
        {if !is_null($collegeName)}
        	var collegeData = {};
        	collegeData.college = '{$collegeName}';
        	$.post($.URL.house.collegeHouseList,collegeData,collegeHouseCallback,"json");
        {/if}
        
        {if !is_null($communityName)}
        	var communityData = {};
        	communityData.community = '{$communityName}';
        	$.post($.URL.house.communityHouseList,communityData,communityHouseCallback,"json");
        {/if}
        
	});
	
	function communityHouseCallback(result)
	{
		if(result.data.houseList.length>0)
		{
			$("#communityHouseList").html("");
		}
		
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			houseInfo.click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
   			$("#communityHouseList").append(houseInfo);
		});
	}
	
	function collegeHouseCallback(result)
	{
		if(result.data.houseList.length>0)
		{
			$("#collegeHouseList").html("");
		}
		
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			houseInfo.click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
   			$("#collegeHouseList").append(houseInfo);
		});
	}
	
	
	function companyHouseCallback(result)
	{
		
		if(result.data.houseList.length>0)
		{
			$("#companyHouseList").html("");
		}
		
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			houseInfo.click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
   			$("#companyHouseList").append(houseInfo);
		});
	}
	
	function oneDuHouseCallback(result)
	{
	
		if(result.data.houseList.length>0)
		{
			$("#oneDuHouseList").html("");
		}
		
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			houseInfo.click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
   			$("#oneDuHouseList").append(houseInfo);
		});
	}
	
	function friendHouseCallback(result)
	{
		if(result.data.houseList.length>0)
		{
			$("#directFriendHouseList").html("");
		}
	
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			houseInfo.click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
   			$("#directFriendHouseList").append(houseInfo);
		});
	}
	
	function doCompanyAutoComplete(request,response)
	{
		var data = {};
 		data.name = request.term;
		$.post($.URL.company.autoComplete,data,function(result){
			if(result.data.result)
			{
				response(result.data.list);
			}
			else
			{
				$('#companyInputMsg').html(result.data.msg);
			}
		},'json');
	}
	
	//更新用户所属公司
	function updateCompany(){
    		if($('#companyInput').val()!=$('#companyInput').attr('oldVal'))
    		{
    			var data = {};
    			data.name = $('#companyInput').val();
    			$.post($.URL.company.add,data,companyAddCallback,'json');
    		}
    }
	
	//添加公司回调函数
	function companyAddCallback(result)
	{
		$('#companyInputMsg').html(result.data.msg);
	}
	
	//向后台请求匹配的高校信息
	function doCollegeAutoComplete(request,response)
	{
		var data = {};
 		data.name = request.term;
		$.post($.URL.college.autoComplete,data,function(result){
			if(result.data.result)
			{
				response(result.data.list);
			}
			else
			{
				$('#collegeInputMsg').html(result.data.msg);
			}
		},'json');
	}
	
	//更新用户所属高校
	function updateCollege(){
    		if($('#collegeInput').val()!=$('#collegeInput').attr('oldVal'))
    		{
    			var data = {};
    			data.name = $('#collegeInput').val();
    			$.post($.URL.college.add,data,collegeAddCallback,'json');
    		}
    }
	
	//添加高校回调函数
	function collegeAddCallback(result)
	{
		$('#collegeInputMsg').html(result.data.msg);
	}
	
	//向后台请求匹配的高校信息
	function doTargetHouseAutoComplete(request,response)
	{
		var data = {};
 		data.name = request.term;
		$.post($.URL.targetHouse.autoComplete,data,function(result){
			if(result.data.result)
			{
				response(result.data.list);
			}
			else
			{
				$('#targetHouseInputMsg').html(result.data.msg);
			}
		},'json');
	}
	
	//更新用户所属目标房源
	function updateTargetHouse(){
    		if($('#targetHouseInput').val()!=$('#targetHouseInput').attr('oldVal'))
    		{
    			var data = {};
    			data.name = $('#targetHouseInput').val();
    			$.post($.URL.targetHouse.add,data,targetHouseAddCallback,'json');
    		}
    }
	
	//添加目标住房区域回调函数
	function targetHouseAddCallback(result)
	{
		$('#targetHouseInputMsg').html(result.data.msg);
	}
</script>
<div id='mainContainer'>
    <div id='headContainer'>
    	<div id='logoDiv'><img height=100% src='/assets/logo.jpg'/></div>
    	<div id='headLeftDiv'>
    		<div id='aimDiv'>让您不在为租房烦恼</div>
    		<div id='cityDiv'>城市</div>
    	</div>
    	<div id='headRightDiv'>
    		
    		<div id='headBottomDiv'>
    			<div id='loginRegDiv'>
    			{if isset($user)}
    				hi,<a href='/User/personCenter'>{$user}</a>&nbsp;<a href='/User/logout'>安全退出</a>
    			{else}
    				<a href='/User/login'>登陆</a>/<a href='/User/register'>注册</a>
    			{/if}
    			</div>
    			<div id='contactDiv'>联系我们</div>
    			{if isset($user)}
    			<div id='inviteDiv'><a id='inviteLink' href='/mod/user/invite.html'>邀请好友</a></div>
    			{/if}
    		</div>
    	</div>
    </div>
    
    <div id='mainBodyDiv'>
    	<div id='searchDiv'>
    		<input id='searchInput' type='text' data-empty='按照关键字检索您想要的房源'>
    		<div id='searchBtn' class='myButton'>搜索</div>
    		<div id='searchMsg'></div>
    	</div>
    	
    	<div id='houseTypeDiv'>
    		<div id='typeHead'>
    			<div body='friendHouse' class='houseType houseTypeSelected'>好友房源</div>
    			<div body='intentionHouse' class='houseType'>推荐房源</div>
    			<div body='publishHouse' url='/publishhouse.html' class='houseType'>发布房源</div>
    		</div>
    		<div id='houseList'>
    			<div id='friendHouse'>
    				<div id='oneDegree'>
    					<div class='degreeTitle'>直系好友房源</div>
    					<div id='directFriendHouseList' class='houseListDiv'>
				   			&nbsp;&nbsp;没有找到您好友的房源，邀请好友一起来找房吧！
				   		</div>
    				</div>
    				<div id='twoDegree'>
    					<div class='degreeTitle'>二度房源</div>
    					<div id='oneDuHouseList' class='houseListDiv'>
				   			&nbsp;&nbsp;没有找到您好友的好友房源哦，邀请好友一起来找房吧！
				   		</div>
    				</div>
    			</div>
    			<div id='intentionHouse'>
    				<div id='intention'>
    					<div class='intentionRowDiv'>
    						<div class='intentionLableDiv'>您所在的公司：</div>
    						<div class='intentionInputDiv'>
    							<input id='companyInput' oldVal="{$companyName}" value="{$companyName}" class='intentionInput' type='text' data-empty='推荐你同事的房源信息'>
    							<div id='companyInputMsg' class='msgDiv'></div>
    						</div>
    					</div>
    					<div class='intentionRowDiv'>
    						<div class='intentionLableDiv'>您所在的学校：</div>
    						<div class='intentionInputDiv'>
    							<input id='collegeInput' oldVal="{$collegeName}" value="{$collegeName}" class='intentionInput' type='text' data-empty='推荐你校友的房源'>
    							<div id='collegeInputMsg' class='msgDiv'></div>
    						</div>
    					</div>
    					<div class='intentionRowDiv'>
    						<div class='intentionLableDiv'>您中意的小区：</div>
    						<div class='intentionInputDiv'>
    							<input id='targetHouseInput' oldVal="{$communityName}" value="{$communityName}" class='intentionInput' type='text' data-empty='推荐意向居住地的房源'>
    							<div id='targetHouseInputMsg' class='msgDiv'></div>
    						</div>
    					</div>
    				</div>
    				
    				<div id='intentionHouseList'>
    					<div class="houseListDiv">同事房源：</div>
    					<div id='companyHouseList' class='houseListDiv'>
				   			暂无匹配房源，邀请同事一起使用吧！
				   		</div>
				   		<div class="houseListDiv">校友房源：</div>
				   		<div id='collegeHouseList' class='houseListDiv'>
				   			暂无匹配房源哦，邀请校友一起使用吧！
				   		</div>
				   		<div class="houseListDiv">中意小区房源：</div>
				   		<div id='communityHouseList' class='houseListDiv'>
				   			&nbsp;&nbsp;暂无目标小区的房源哦！
				   		</div>
    				</div>
    			</div>
    			
    			<div id='publishHouse'>
    				您还没有发布房源哦！
    			</div>
    		</div>
    	</div>
   </div>
</div>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fa712b75dc1788d09dbf388a019b92836' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>  
</html>  
  
<script>  
      
</script>  