<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<script src="/js/urlUtil.js" type="text/javascript"></script>
<script src="/js/resouce.js" type="text/javascript"></script>
<script src="/js/emptyNote.js" type="text/javascript"></script>
<script src="/js/house.js" type="text/javascript"></script>
{if !isset($user)}
<link href="/css/headLogin.css" type="text/css" rel="stylesheet">
{/if}

<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/house/houseInfo.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>房源详情</title>  
</head>  
<body>  
<script type="text/javascript">
	$(document).ready(function(){
		$("input").emptyValue();
	});
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
    				<div class='infoValue'>{$houseInfo['price']}</div>
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
    				<div class='infoValue'>{$houseInfo['addressInfo']}</div>
    			</div>
    			<div class='infoRow'>
    				<div class='infoLabel'>转让时间：</div>
    				<div class='infoValue'>{$houseInfo['transferTime']}</div>
    			</div>
    		</div>
    		<div id='actions'>
    			<div id='applyBtn' class='myButton'>申请房源</div>
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
    						<textarea id='detail_description' rows="8" cols="60">请输入您的评价！</textarea>
    					</div>
    				</div>
    				<div class='comentRow'>
    					<div class='commentLabel'>&nbsp;</div>
    					<div class='comemntInput'><div id='commentBtn' class='myButton'>评论</div></div>
    				</div>
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
    					<div id='addFrinend'><div id='addFriendBtn' class='myButton'>+ 加为好友</div></div>
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
    						<div class='houseItem'>
					   				<div class='houseItemColumn'>和平里和平街十四区 2室1厅65平米</div>
					   				<div class='houseItemColumn'>租金价格：3100 元/月 </div>
					   				<div class='houseItemColumn'>房屋户型： 2室 1厅 1卫 70㎡</div>
					   				<div class='houseItemColumn'>出租时间：2013-6-15</div>
					   			</div>
    							<div class='houseItem'>
					   				<div class='houseItemColumn'>和平里和平街十四区 2室1厅65平米</div>
					   				<div class='houseItemColumn'>租金价格：3100 元/月 </div>
					   				<div class='houseItemColumn'>房屋户型： 2室 1厅 1卫 70㎡</div>
					   				<div class='houseItemColumn'>出租时间：2013-6-15</div>
					   			</div>
    							<div class='houseItem'>
					   				<div class='houseItemColumn'>和平里和平街十四区 2室1厅65平米</div>
					   				<div class='houseItemColumn'>租金价格：3100 元/月 </div>
					   				<div class='houseItemColumn'>房屋户型： 2室 1厅 1卫 70㎡</div>
					   				<div class='houseItemColumn'>出租时间：2013-6-15</div>
					   			</div>
    							<div class='houseItem'>
					   				<div class='houseItemColumn'>和平里和平街十四区 2室1厅65平米</div>
					   				<div class='houseItemColumn'>租金价格：3100 元/月 </div>
					   				<div class='houseItemColumn'>房屋户型： 2室 1厅 1卫 70㎡</div>
					   				<div class='houseItemColumn'>出租时间：2013-6-15</div>
					   			</div>
    					</div>
    		</div>
    	</div>
   </div>
</div>
</body>  
</html>  
  
<script>  
      
</script>  