<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/invite.css" type="text/css" rel="stylesheet">
<title>邀请好友</title>  
</head>  
<body>  
	<div id='mainContainer'>
    <form action="/InvitationCode/inviteFriend"  method="post" >  
    	<div class='titleDiv'>邀请好友</div>  
    	<div class='rowDiv'>  
        	<div class='labelDiv'>好友邮箱：</div>  
        	<div class='inputDiv'><input type="text" name="invitedEmail"></div>
        	<div class='selectDiv'>
        		<select name='relationship'>
        			<option value='frend'>朋友</option>
        			<option value='workmate'>同事</option>
        			<option value='classmate'>同学</option>
        			<option value='relatives'>亲属</option>
        			<option value='other'>其它</option>
        		</select>
        	</div>  
      	</div>  
      	<div class='messageDiv'>  
    		{$result_msg}  
	   	</div> 
      	<div class='actionDiv'>  
        	<div id='inviteActionDiv'><input type="submit" value="邀请"></div>
      	</div>  
	</form>  
	</div>
</body>  
</html>  
 