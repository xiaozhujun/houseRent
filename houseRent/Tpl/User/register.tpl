<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>注册</title>  
</head>  
<body>  
    <form action="?m=User&a=add"  method="post" >  
      <table align="center">  
        <th height="95"><H2>请认真填写以下注册信息</H2></th>  
      <tr>  
      <td><table align="center">  
        <tr>  
          <td width="74" align="right">用户名：</td>  
          <td align="left"><input type="text" name="name">*(长度的要求是5~15位之间)</td>  
          </tr>  
        <tr>  
          <td align="right">密码：</td>  
          <td align="left"><input type="password" name="password">*(长度的要求是5~15位之间)</td>  
          </tr>  
        <tr>  
          <td align="right">确认密码:</td>  
          <td align="left"><input type="password" name="repassword">*</td>  
          </tr>  
        <tr>  
          <td align="right">QQ:</td>  
          <td align="left"><input type="text" name="qq">*</td>  
          </tr>  
        <tr>  
          <td align="right">验证码:</td>  
          <td align="left"><input type="text" name="verify" >  
            <img id="verify" alt="验证码" onClick="show()" src="?m=User&a=verify"><a href="javascript:show()">看不清楚</a></td>  
          </tr> 
           <tr>  
          <td colspan="2" align="center"><font color='red'>{$error_msg}</font></td>  
          </tr>  
        <tr>  
          <td colspan="2" align="center"><input type="submit" value="提交"> &nbsp;<a href="?m=User&a=login">登录</a></td>  
          </tr>  
        </table></td>  
      </tr>  
      </table>  
</form>  
</body>  
</html>  
  
<script>  
  
      
    function show(){  
        document.getElementById("verify").src="?m=User&a=verify&random="+Math.random();  
          
    }  
      
      
</script>  