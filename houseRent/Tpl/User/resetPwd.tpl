<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/resetPwd.css" type="text/css" rel="stylesheet">
<title>重置密码</title>  
</head>  
<body>  
	<div id='mainContainer'>
    <form action="/User/doResetPwd"  method="post" >  
    	<div class='titleDiv'>重置密码 </div>  
    	<div class='rowDiv'>  
        	<div class='labelDiv'>原始密码：</div>  
        	<div class='inputDiv'><input type="text" name="oldPwd"></div>  
      	</div>  
      	<div class='rowDiv'>  
        	<div class='labelDiv'>新密码：</div>  
        	<div class='inputDiv'><input type="password" name="newPwd"></div>  
      	</div>  
        <div class='rowDiv'>  
          <div class='labelDiv'>确认新密码：</div>  
          <div class='inputDiv'><input type="password" name="rePwd"></div>  
        </div>  
      	<div class='messageDiv'>  
    		{$result_msg}  
	   	  </div> 
      	<div class='actionDiv'>  
        	<div id='loginActionDiv'><input type="submit" value="重置"></div>
      	</div>  
	</form>  
	</div>
</body>  
</html>  
 