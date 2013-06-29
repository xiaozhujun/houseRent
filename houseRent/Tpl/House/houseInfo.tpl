<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<script src="/js/urlUtil.js" type="text/javascript"></script>
<script src="/js/resouce.js" type="text/javascript"></script>
<script src="/js/emptyNote.js" type="text/javascript"></script>
<script src="/js/house.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
<script type="text/javascript" src="/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script src="/js/jquery-dateFormat.js" type="text/javascript"></script>
{if !isset($user)}
<link href="/css/headLogin.css" type="text/css" rel="stylesheet">
{/if}

<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/house/houseInfo.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/js/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>房源详情</title>  
</head>  
<body>  
<script type="text/javascript">
	var houseId = {$houseInfo['houseId']};
	var replyComment = null;
	$(document).ready(function(){
		$("input").emptyValue();
		
		$.get($.URL.house.streetHouseList+"?street={$houseInfo['street']}",null,streetHouseCallback,"json");
		$.get($.URL.houseComment.commentList+"?houseId="+houseId,null,commentListCallback,'json');
		
		$("a.addFriendBtn").fancybox({
							'transitionIn'	:	'elastic',
							'transitionOut'	:	'elastic',
							'speedIn'		:	200, 
							'speedOut'		:	200, 
							'overlayShow'	:	false
							});
							
		$('#loginBtn').click(function(){
				var data = {};
				data.email = $('#emailLoginInput').val();
				data.password = $('#pwdLoginInput').val();
				$.post($.URL.user.login,data,loginCallback,"json");
			});
			
		$("#collectBtn").click(function(){
			var data = {};
			data.houseId = houseId;
			$.post($.URL.houseCollect.collect,data,collectCallback,'json');
		});
		
		$("#commentBtn").click(function(){
			var comment = $("#commentInput").val();
			if(comment=="请输入您的评价！"||comment=="")
			{
				alert("请输入评论内容！");
				return;
			}
		
			var data = {};
			data.houseId = houseId;
			data.comment = comment;
			if(replyComment!=null)
			{
				data.replyComment = replyComment;
			}
			$.post($.URL.houseComment.comment,data,commentCallback,'json');
		});
		
	});
	
	//评论列表回调
	function commentListCallback(result)
	{
		$("#commentList").html("");
		$.each(result.data.commentList,function(index,item){
			var commentRow = $("<div class='commentRow'></div>");
			var commentTitle = $("<div class='commentTitle'></div>")
			var commentUser = $("<div class='commentUser'>"+item.realName+" 评论说：</div>");
			var commentTime = $("<div class='commetTime'>评论时间："+item.createTime+"</div>")
			var commentContent = $("<div class='commentContent'>"+item.comment+"</div>");
			
			commentTitle.append(commentUser).append(commentTime);
			commentRow.append(commentTitle).append(commentContent);
			$("#commentList").append(commentRow);
		});
	}
	
	//评论回调
	function commentCallback(result)
	{
		if(result.data.success)
		{
			$("#commentInput").val('请输入您的评价！');
			$.get($.URL.houseComment.commentList+"?houseId="+houseId,null,commentListCallback,'json');
		}
		else
		{
			alert(result.data.msg);
		}
	}
	
	//收藏房源回调
	function collectCallback(result)
	{
		if(result.data.result)
		{
			alert("收藏成功");
		}
		else
		{
			alert(result.data.msg);
		}
	}
	
	//街道相对应的房源
	function streetHouseCallback(result)
	{
		$.each(result.data.houseList,function(index,value){

   			var houseInfo = $("<div class='houseItem'></div>");
   			houseInfo.attr('houseId',value.houseId);
   			var title = $("<div class='houseItemColumn'></div>").append(value.title);
   			var price = $("<div class='houseItemColumn'></div>").append(value.price).append("&nbsp;元/月");
   			var type = $("<div class='houseItemColumn'></div>").append("房屋户型： "+value.room+"室"+value.parlor+"厅"+value.washroom+"卫");
   			var transferTime = $("<div class='houseItemColumn'></div>").append("出租时间： "+$.format.date(value.transferTime,"yyyy-MM-dd"));
   			houseInfo.append(title).append(price).append(type).append(transferTime);
   			$("#houseList").append(houseInfo);
		});
		
		$('.houseItem').click(function(){
			location=$.URL.house.info+"?id="+$(this).attr("houseId");
		});
	}
	
	//登录回调函数
	function loginCallback(result)
	{
		if(result.data.success)
		{
			location.reload();
		}
		else
		{
			$('#loginMsg').html(result.data.msg);
		}
			
	}
</script>
<div id='mainContainer'>
    <div id='headContainer'>
    	<div id='logoDiv'><a href='/'><img height=100% src='/assets/logo.jpg'/></a></div>
    	<div id='headLeftDiv'>
    		<div id='aimDiv'>让您不在为租房烦恼</div>
    		<div id='cityDiv'>城市</div>
    	</div>
    	<div id='headRightDiv'>
    	{if isset($user)}
    		<div id='headBottomDiv'>
    			<div id='loginRegDiv'>
    				hi,<a href='/User/personCenter'>{$user}</a>&nbsp;<a href='/User/logout'>安全退出</a>
    			</div>
    			<div id='contactDiv'>联系我们</div>
    			<div id='inviteDiv'><a id='inviteLink' href='/mod/user/invite.html'>邀请好友</a></div>
    		</div>
   		{else}
   			<div class='headRightRow'>
    			<div id='topRow'>
	    			<div class='nameInputDiv'>
	    				<div class='loginColumnDiv'><input id='emailLoginInput' type='text' data-empty='账号'/></div>
	    			</div>
	    			<div class='pwdInputDiv'>
	    				<div class='loginColumnDiv'><input type='text' data-empty='密码'  pass-empty='true'/><input id='pwdLoginInput' type='password' data-empty='密码'  pass-empty='true'/></div>
	    			</div>
	    			<div class='loginBtnDiv'>
	    				<div class='loginColumnDiv'><input id='loginBtn' type='submit' value='登录'/></div>
	    			</div>
    			</div>
    			<div id='bottomRow'>
    				<div id='autoLogin'><input type='checkbox'/>下次自动登录</div>
    				<div id='forgotPassword'><a href='#'>忘记密码</a></div>
    				<div id='loginMsg'></div>
    			</div>
    		</div>
    	{/if}
    	</div>
    </div>
    
    <div id='houseInfoBody'>
    	<div id='leftInfo'>
    		<div id='title'>
				{$houseInfo['title']}
    		</div>
    		<div id='details'>
    			<div class='infoRow'>
    				<div class='infoLabel'>租金价格：</div>
    				<div class='infoValue'>{$houseInfo['price']}元</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>房屋户型：</div>
    				<div class='infoValue'>{$houseInfo['room']}室{$houseInfo['parlor']}厅{$houseInfo['washroom']}卫 &nbsp; {$houseInfo["area"]}平米</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>房屋情况：</div>
    				<div class='infoValue'>{$houseInfo['decoration']}</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>所属楼层：</div>
    				<div class='infoValue'>{$houseInfo['currentFloor']}层/{$houseInfo['maxFloor']}层</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>所在区域：</div>
    				<div class='infoValue'>{$region['areaname']}</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>所在地址：</div>
    				<div class='infoValue'>{$houseInfo['street']}{$houseInfo['community']}</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>转让时间：</div>
    				<div class='infoValue'>{$houseInfo['transferTime']}</div>
    			</div>
    		</div>
    		<div id='actions'>
    			<div id='applyBtn' class='myButton'><a class='addFriendBtn' href="/HouseApply/applyHousePage?userId={$houseUser['id']}&houseId={$houseInfo['houseId']}">申请房源</a></div>
    			<div id='collectBtn' class='myButton'>收藏</div>
    		</div>
    		<div id='description'>
    			<div class='underLine'>
    				<div id='descriptionTab'>房源详情</div>
    			</div>
    			<div id='infoDescription'>
					{$houseInfo['detailDescription']}
    			</div>
    		</div>
    		<div id='comment'>
    			<div id='comentTitle'>房源评价：</div>
    			<div id='commentContainer'>
    				<div class='comentRow'>
    					<div class='commentLabel'>内容：</div>
    					<div class='comemntInput'>
    						<textarea id='commentInput' rows="8" cols="60">请输入您的评价！</textarea>
    					</div>
    				</div>
    				<div class='comentRow'>
    					<div class='commentLabel'>&nbsp;</div>
    					<div class='comemntInput'><div id='commentBtn' class='myButton'>评论</div></div>
    				</div>
    			</div>
    			<div id="commentList">
    				
    			</div>
    		</div>
    	</div>
    	<div id='rightInfo'>
    		<div id='user'>
    			<div id='userInfoRow'>
    				<div id='headIcon'><img src='/assets/headIcon.png' height='100%'></div>
    				<div id='userInfoDetail'>
    					<div id='name'>{$houseUser["realName"]}</div>
    					<div id='company'>{$company}</div>
    					<div id='college'>{$college}</div>
    					<div id='addFrinend'><div id='addFriendBtn' class='myButton'><a class='addFriendBtn' href="/Friend/applyFriendPage?userId={$houseUser['id']}">+ 加为好友</a></div></div>
    				</div>
    			</div>
    		</div>
    		
    		<div id='relationship'>
    					<div id='peopleBetween'>通过2个人可以认识她</div>
    					<div id='relationshipDetail'>&nbsp;</div>
    		</div>
    		<div class='underLine'></div>
    		<div id='relatedHouse'>
    					<div id='relatedHouseTitle'>相关房源推荐：</div>
    					<div id='houseList'>
    						
    					</div>
    		</div>
    	</div>
   </div>
</div>
</body>  
</html>  
  
<script>  
      
</script>  