<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/friend/applyFriend.css" type="text/css" rel="stylesheet">  
<title>拒绝好友申请</title>  
</head>  
<body>  
	<script type="text/javascript">
		$(document).ready(function(){
			$('#refuseBtn').click(function(){
				var data = {};
				data.fromUser = {$fromUser};
				data.houseId = {$houseId};
				data.replyInfo = $('#replyInfo').val();
				$.post($.URL.houseApply.refuseApply,data,callback,"json");
			});
		});
		
		function callback(result)
		{
			$('.messageDiv').html(result.data.msg);
		}
	</script>
	<div id='applyFriendContainer'>
    <div class='applyFriendTitleDiv'>拒绝房源申请 </div> 
    <div class='rowDiv'>  
        <div class='labelDiv'>来自：</div>  
        <div id="realNameDiv" class='inputDiv'>{$realName}</div>  
      </div> 
    <div class='rowDiv'>  
        <div class='labelDiv'>房源：</div>  
        <div id="realNameDiv" class='inputDiv'>{$houseInfoTitle}</div>  
      </div> 
    <div class='rowDiv'>  
        <div class='labelDiv'>请您输入拒绝信息（选填）：</div>  
        <div id="realNameDiv" class='inputDiv'>
        	<textarea rows=3 cols=20 id="replyInfo"></textarea>
        	<input type='hidden' value=''/>
        </div>  
      </div> 
      <div class='messageDiv'> 
	   	 </div> 
      <div class='actionDiv'>  
        <div class='actionRightDiv'><input id='refuseBtn' type="button" value="拒绝"></div>
      </div>  
	</div>
</body>  
</html>  
 