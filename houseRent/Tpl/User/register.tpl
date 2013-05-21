<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/register.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>注册</title>  
</head>  
<body>  
<div id='mainContainer'>
    <form action="/User/add"  method="post" >  
    <div class='titleDiv'>请认真填写以下注册信息</div>  
    <div class='rowDiv'>  
    	<div class='labelDiv'>用户名：</div>  
        <div class='inputDiv'><input type="text" name="name">*(长度的要求是5~15位之间)</div>  
    </div> 
     <div class='rowDiv'>  
    	<div class='labelDiv'>真实姓名：</div>  
        <div class='inputDiv'><input type="text" name="realName">*</div>  
    </div> 
    <div class='rowDiv'>  
    	<div class='labelDiv'>密码：</div>  
        <div class='inputDiv'><input type="password" name="password">*(长度的要求是5~15位之间)</div>  
    </div>  
    <div class='rowDiv'>  
    	<div class='labelDiv'>确认密码：</div>  
        <div class='inputDiv'><input type="password" name="repassword">*</div>  
    </div> 
    <div class='rowDiv'>  
    	<div class='labelDiv'>邮箱：</div>  
        <div class='inputDiv'><input type="text" name="email">*</div>  
    </div> 
     <div class='rowDiv'>  
    	<div class='labelDiv'>手机号：</div>  
        <div class='inputDiv'><input type="text" name="phone">*</div>  
    </div> 
    <div class='rowDiv'>  
    	<div class='labelDiv'>身份证号：</div>  
        <div class='inputDiv'><input type="text" name="identifyNum">*</div>  
    </div> 
    <div class='rowDiv'>  
    	<div class='labelDiv'>验证码：</div>  
        <div class='inputDiv'><input type="text" name="verify" ><img id="verify" alt="验证码" onClick="show()" src="/User/verify"><a href="javascript:show()">看不清楚</a></div>  
    </div>
    <div class='messageDiv'>  
    	{$result_msg}  
    </div>      
    <div class='actionDiv'>  
    	<div id='registerActionDiv'><input type="submit" value="注册"></div>
    	<div id='loginLinkDiv'><a href="/User/login">登录</a></div></div>  
    </div>     
	<input type='hidden' name='invitor' value='{$invitor}'/>
	<input type='hidden' name='invitationCode' value='{$invitationCode}'/>
</form>  
</div>
</body>  
</html>  
  
<script>  
  
      
    function show(){  
        document.getElementById("verify").src="/User/verify/"+Math.random();  
          
    }  
      
      
</script>  