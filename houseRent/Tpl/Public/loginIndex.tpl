<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/headLogin.css" type="text/css" rel="stylesheet">
<link href="/css/register.css" type="text/css" rel="stylesheet">
<link href="/css/house.css" type="text/css" rel="stylesheet">
<link href="/css/community.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<script src="/js/emptyNote.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>首页</title>  
</head>  
<body>  
<script type="text/javascript">
	$(document).ready(function(){
		$('#loginBtn').click(function(){
				var data = {};
				data.email = $('#emailLoginInput').val();
				data.password = $('#pwdLoginInput').val();
				$.post($.URL.user.login,data,loginCallback,"json");
			});
			
			
			$('#regitserBtn').click(function(){
				var data = {};
				data.realName = $('#realNameInput').val();
				data.sex = $('#sexInput').val();
				data.password = $('#passwordInput').val();
				data.repassword = $('#repasswordInput').val();
				data.email = $('#emailInput').val();
				data.verify = $('#verifyInput').val();
				$.post($.URL.user.register,data,registerCallback,"json");
			});
			
			$('#verify').attr('src',$.URL.user.verify);
			
			$("input").emptyValue();
				
	});
	
	function reloadVerifyCode(){  
	        document.getElementById("verify").src=$.URL.user.verify +'/' +Math.random();  
	          
	}
	
	//注册回调函数
	function registerCallback(result)
	{
		$("#msgDiv").html(result.data.msg);
			
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
			alert(result.data.msg);
		}
			
	}
</script>
<div id='mainContainer'>
	<div id='loginIndexContainer'>
    <div id='headContainer'>
    	<div id='logoDiv'><img height=100% src='/assets/logo.jpg'/></div>
    	<div id='headLeftDiv'>
    		<div id='aimDiv'>让您不在为租房烦恼</div>
    		<div id='cityDiv'>城市</div>
    	</div>
    	<div id='headRightDiv'>
    		<div class='headRightRow'>
    			
    			<div class='loginBtnDiv'>
    				<div class='loginColumnDiv'><input id='loginBtn' type='submit' value='登录'/></div>
    				<div class='loginColumnDiv'>&nbsp;</div>
    			</div>
    			
    			<div class='pwdInputDiv'>
    				<div class='loginColumnDiv'><input type='text' data-empty='密码'  pass-empty='true'/><input id='pwdLoginInput' type='password' data-empty='密码'  pass-empty='true'/></div>
    				<div class='loginColumnDiv'><a href='#'>忘记密码</a></div>
    			</div>
    			
    			<div class='nameInputDiv'>
    				<div class='loginColumnDiv'><input id='emailLoginInput' type='text' data-empty='账号'/></div>
    				<div class='loginColumnDiv'><input type='checkbox'/>下次自动登录</div>
    			</div>
    		</div>
    		
    		
    	</div>
    </div>
    
    <div id='registerMainBodyDiv'>
      	<div class='mainTopDiv'>
      		<div class='valueDiv'>
    		<div class='valueLeftDiv'>
    			<div class='valueTitleDiv'>为什么选择租客团？</div>
    			<div class='valueRowDiv'>优质的资源</div>
    			<div class='valueRowDiv'>基于好友关系的好友交易与交换</div>
    			<div class='valueRowDiv'>基于个人属性的推荐</div>
    		</div>
    		<div class='valueRightDiv'>
    			<div class='achievementRowDiv'>2000多个可靠房源</div>
    			<div class='achievementRowDiv'>20000个优质用户</div>
    			<div class='achievementRowDiv'>100多个企业</div>
    			<div class='achievementRowDiv'>50多所高校</div>
    		</div>
    	</div>
    	<div class='registerDiv'>
    		<div class='registerTitle'>没有账号？赶快加入吧</div>
    		<div class='registerRow'><input class='registerInput' id='emailInput' type='text' data-empty='邮箱'/></div>
    		<div class='registerRow'><input class='registerInput' type='text' data-empty='密码'  pass-empty='true'/><input class='registerInput' id='passwordInput' type='password' pass-empty='true' data-empty='密码'/><input type='hidden'/></div>
    		<div class='registerRow'><input class='registerInput' type='text' data-empty='确认密码'  pass-empty='true'/><input class='registerInput' id='repasswordInput' type='password' pass-empty='true' data-empty='确认密码'/></div>
    		<div class='registerRow'><input class='registerInput' id='realNameInput' type='text' data-empty='姓名'/></div>
    		<div class='registerRow'>性别 <input type='radio' name='sex' id='sexInput' value='男' checked/>男 <input type='radio' name='sex' value='女'/>女</div>
			<div class='registerRow'><input id='verifyInput' type="text" name="verify" data-empty='验证码' /><img id="verify" alt="验证码" onClick="reloadVerifyCode()" src=""><a href="javascript:reloadVerifyCode()">看不清楚</a></div>
    		<div class='registerRow'><div id='msgDiv' >&nbsp;</div></div>
    		<div class='registerRow'><div id='regitserBtn' >立即注册</div></div>
    	</div>	
      	</div>
   </div>
   </div>
   
   <!--推荐房源 -->
   <div id='recommendDiv'>
   		<div class='recommendTitle'>优质房源</div>
   		<div class='houseListDiv'>
   			<div class='houseItem'>
   				<div class='houseItemColumn'>海淀区 和平里和平街十四区 2室1厅65平米</div>
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
   			
   			<div class='houseItem'>
   				<div class='houseItemColumn'>和平里和平街十四区 2室1厅65平米</div>
   				<div class='houseItemColumn'>租金价格：3100 元/月 </div>
   				<div class='houseItemColumn'>房屋户型： 2室 1厅 1卫 70㎡</div>
   				<div class='houseItemColumn'>出租时间：2013-6-15</div>
   			</div>
   		</div>
   		
   		<!-- 用户分布，圈子分布 -->
   		<div id='distributionDiv'>
   			<div class='distributionTitleDiv'>用户圈子分布</div>
   			<div class='distributionListDiv'>
   				<div class='communityTitleListDiv'>
   					<div body='companyItemDiv' class='communityTitleDiv'>公司</div>
   					<div body='collegeItemDiv' class='communityTitleDiv'>高校</div>
   				</div>
   				<div class='communityContainerDiv'>
   				<div id='companyItemDiv' class='communityItemDiv'>
   					<div class='communityNameDiv'>百度</div>
   					<div class='communityNameDiv'>联想</div>
   					<div class='communityNameDiv'>神州数码</div>
   					<div class='communityNameDiv'>华为</div>
   					<div class='communityNameDiv'>搜狐</div>
   					<div class='communityNameDiv'>网易</div>
   					<div class='communityNameDiv'>腾讯</div>
   					<div class='communityNameDiv'>新浪</div>
   				</div>
   				
   				<div id='collegeItemDiv' class='communityItemDiv'>
   					<div class='communityNameDiv'>清华大学</div>
   					<div class='communityNameDiv'>北京大学</div>
   					<div class='communityNameDiv'>北京邮电大学</div>
   					<div class='communityNameDiv'>北京交通同学</div>
   					<div class='communityNameDiv'>北京航空航天大学</div>
   					<div class='communityNameDiv'>人民大学</div>
   					<div class='communityNameDiv'>中国地质大学</div>
   					<div class='communityNameDiv'>国防科技大学</div>
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