<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<link href="/css/headLogin.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>首页</title>  
</head>  
<body>  
<script type="text/javascript">
	$(document).ready(function(){
		$('#loginBtn').click(function(){
				var data = {};
				data.name = $('#nameInput').val();
				data.password = $('#passwordInput').val();
				$.post($.URL.user.login,data,callback,"json");
			});
			
				
	});
	
	//回调函数
		function callback(result)
		{
			if(result.data.success)
			{
				location="/";
			}
			else
			{
				alert(result.data.msg);
			}
			
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
    		<form action='' method='post'>
    		<div class='headRightRow'>
    			
    			<div class='loginBtnDiv'>
    				<div class='loginColumnDiv'><input id='loginBtn' type='submit' value='登录'/></div>
    				<div class='loginColumnDiv'>&nbsp;</div>
    			</div>
    			
    			<div class='pwdInputDiv'>
    				<div class='loginColumnDiv'><input id='passwordInput' type='text' value='密码'/></div>
    				<div class='loginColumnDiv'><input type='checkbox'/><a href='#'>忘记密码</a></div>
    			</div>
    			
    			<div class='nameInputDiv'>
    				<div class='loginColumnDiv'><input id='nameInput' type='text' value='账号'/></div>
    				<div class='loginColumnDiv'><input type='checkbox'/>下次自动登录</div>
    			</div>
    			
    			</form>
    		</div>
    		
    		
    	</div>
    </div>
    
    <div id='mainBodyDiv'>
      	<div class='mainTopDiv'>
      		<div class='valueDiv'>
    		<div class='valueLeftDiv'>
    			<div class='valueTitleDiv'>为什么选择租客团？</div>
    			<div class='valueRowDiv>优质的资源</div>
    			<div class='valueRowDiv>基于好友关系的好友交易与交换</div>
    			<div class='valueRowDiv>基于个人属性的推荐</div>
    		</div>
    		<div class='valueRightDiv>
    			<div class='achievementRowDiv'>2000多个可靠房源</div>
    			<div class='achievementRowDiv'>20000个优质用户</div>
    			<div class='achievementRowDiv'>100多个企业</div>
    			<div class='achievementRowDiv'>50多所高校</div>
    		</div>
    	</div>
    	<div class='registerDiv'>
    		<div class='registerTitle'>没有账号？赶快加入吧</div>
    		<div class='registerRow'><input id='emalInput' type='text' value='邮箱'></div>
    		<div class='registerRow'><input id='passwordInput' type='text' value='密码'></div>
    		<div class='registerRow'><input type='text' value='姓名'></div>
    		<div class='registerRow'>性别 <input type='radio' name='sex' value='男'/>男 <input type='radio' name='sex' value='女'/>女</div>
    		<div class='registerRow'><input type='' value=''></div>
    	</div>	
      	</div>
   </div>
</div>
</body>  
</html>  
  
<script>  
      
</script>  