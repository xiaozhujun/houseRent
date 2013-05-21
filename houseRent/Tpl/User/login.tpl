<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/user/login.css" type="text/css" rel="stylesheet">
<title>登录</title>  
</head>  
<body>  
	<div id='mainContainer'>
    <form action="/User/doLogin"  method="post" >  
    	<div class='titleDiv'>用户登录 </div>  
    	<div class='rowDiv'>  
        	<div class='labelDiv'>用户名：</div>  
        	<div class='inputDiv'><input type="text" name="name"></div>  
      	</div>  
      	<div class='rowDiv'>  
        	<div class='labelDiv'>密码：</div>  
        	<div class='inputDiv'><input type="password" name="password"></div>  
      	</div>  
      	<div class='messageDiv'>  
    		{$result_msg}  
	   	</div> 
       	<div class='rowDiv'>  
        	<div id='rememberLoginDiv'><input type='checkbox'/>下次自动登录</div>
        	<div id='forgotPwdDiv'><a href=''>忘记密码？</a></div>
      	</div>  
      	<div class='actionDiv'>  
        	<div id='loginActionDiv'><input type="submit" value="登录"></div>
        	<div id='registerLinkDiv'><a id='registerLink' href="/User/register">注册</a></div></div>  
      	</div>  
	</form>  
	</div>
</body>  
</html>  
 