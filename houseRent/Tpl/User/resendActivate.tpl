<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>登录</title>  
</head>  
<body>  
    <form action="?m=User&a=resendActivateAction"  method="post" >  
      <table align="center">  
        <th height="95"><H2>发送激活邮件</H2></th>  
      <tr>  
      <td><table align="center">  
        <tr>  
          <td width="74" align="right">用户名：</td>  
          <td width="304" align="left"><input type="text" name="name"></td>  
          </tr>
          <tr>  
          <td colspan="2" align="center"><font color='red'>{$result_msg}</font></td>  
          </tr>    
        <tr>  
          <td colspan="2" align="center"><input type="submit" value="确定">&nbsp;<a href="?m=User&a=login">登陆</a></td>  
          </tr>  
        </table></td>  
      </tr>  
      </table>  
</form>  
</body>  
</html>  
 