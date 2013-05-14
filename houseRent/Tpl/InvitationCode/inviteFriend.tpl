<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>登录</title>  
</head>  
<body>  
    <form action="?m=InvitationCode&a=inviteFriend"  method="post" >  
      <table align="center">  
        <th height="95"><H2>邀请好友</H2></th>  
      <tr>  
      <td><table align="center">  
        <tr>  
          <td align="right">好友邮箱：</td>  
          <td width="304" align="left"><input type="text" name="invitedEmail"></td>  
          </tr>
          <tr>  
          <td colspan="2" align="center"><font color='red'>{$result_msg}</font></td>  
          </tr>    
        <tr>  
          <td colspan="2" align="center"><input type="submit" value="邀请"></td>  
          </tr>  
        </table></td>  
      </tr>  
      </table>  
</form>  
</body>  
</html>  
 