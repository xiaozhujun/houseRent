<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/friend/applyFriend.css" type="text/css" rel="stylesheet">  
<title>申请添加好友</title>  
</head>  
<body>  
	<script type="text/javascript">
		$(document).ready(function(){
			$('#applydBtn').click(function(){
				var data = {};
				data.toUser = {$toUser};
				data.authInfo = $('#authInfo').val();
				$.post($.URL.friend.applyFriend,data,callback,"json");
			});
		});
		
		function callback(result)
		{
			$('.messageDiv').html(result.data.msg);
		}
	</script>
	<div id='applyFriendContainer'>
    <div class='applyFriendTitleDiv'>申请添加好友 </div> 
    <div class='rowDiv'>  
        <div class='labelDiv'>好友姓名：</div>  
        <div id="realNameDiv" class='inputDiv'>{$realName}</div>  
      </div> 
    <div class='rowDiv'>  
        <div class='labelDiv'>请您输入验证信息：</div>  
        <div id="realNameDiv" class='inputDiv'>
        	<textarea rows=3 cols=20 id="authInfo"></textarea>
        	<input type='hidden' value=''/>
        </div>  
      </div> 
      <div class='messageDiv'> 
	   	 </div> 
      <div class='actionDiv'>  
        <div class='actionRightDiv'><input id='applydBtn' type="button" value="申请"></div>
      </div>  
	</div>
</body>  
</html>  
 