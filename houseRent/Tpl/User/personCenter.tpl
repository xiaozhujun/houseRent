<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/user/personCenter.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>个人中心</title>  
</head>  
<body>  
<script type="text/javascript">
	$(document).ready(function(){
		$('.moduleTitle').click(function(){
			$(this).next().toggle(500);
		});
		
		$('.menuItem').click(function(){
			$('#mainContentDiv').load($(this).attr('page'));
		});
		
		$("#inviteLink").click(function(){
			$("#mainContentDiv").load($(this).attr("href"));
			return false;
		});
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
    		
    		<div id='headBottomDiv'>
    			<div id='loginRegDiv'>
    			{if isset($user)}
    				hi,{$user}&nbsp;<a href='/User/logout'>安全退出</a>
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
    	<div id='menuDiv'>
    		<div class='menuModule'>
	    		<div class='moduleTitle'>个人信息</div>
	    		<div class='menuItems'>
	    			<div class='menuItem' page='/mod/user/update.html'><div class='menuNameDiv'>维护信息</div></div>
	    			<div class='menuItem' page='/mod/user/resetPwd.html'><div class='menuNameDiv'>修改密码</div></div>
	    		</div>
	    	</div>
	    	
	    	<div class='menuModule'>
	    		<div class='moduleTitle'>房源管理</div>
	    		<div class='menuItems'>
	    			<div class='menuItem'><div class='menuNameDiv'>房源推荐</div></div>
	    			<div class='menuItem'><div class='menuNameDiv'>我的房源</div></div>
	    			<div class='menuItem'><div class='menuNameDiv'>关注房源</div></div>
	    			<div class='menuItem' page='/mod/houseApply/applyingList.html'><div class='menuNameDiv'>房源申请</div></div>
	    		</div>
	    	</div>

	    	<div class='menuModule'>
	    		<div class='moduleTitle'>好友管理</div>
	    		<div class='menuItems'>
	    			<div class='menuItem' page='/mod/friend/friendList.html'><div class='menuNameDiv'>好友列表</div></div>
	    			<div class='menuItem' page='/mod/friend/addFriend.html'><div class='menuNameDiv'>添加好友</div></div>
	    			<div class='menuItem' page='/mod/friend/applyingList.html'><div class='menuNameDiv'>好友申请</div></div>
	    			<div class='menuItem' page='/mod/user/invite.html'><div class='menuNameDiv'>邀请好友</div></div>
	    		</div>
	    	</div>
	    	
    	</div>
    	<div id='mainContentDiv'>
    		我是主界面哦！
    	</div>
   </div>
</div>
</body>  
</html>  
  
<script>  
      
</script>  