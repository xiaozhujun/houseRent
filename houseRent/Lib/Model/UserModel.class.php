<?php  
class UserModel extends Model{  
  
    //自动验证  
    protected $_validate=array(  
            //每个字段的详细验证内容  
            array("username","require","用户名不能为空"),  
            array("username","checkLength","用户名长度不符合要求",0,'callback'),  
            array("password","require","密码不能为空"),  
            array("password","checkLength","密码长度的要求是5~15位之间",0,'callback'),  
            array("password","repassword","两次密码输入不一致",0,'confirm'),  
            array("qq","require","qq必须填写"),  
            );  
      
      
    //自动填充  
    protected $_auto=array(  
              
            array("password","md5",3,'function'),  
            array("cdate","shijian",3,'callback'),  
            array("dizhi","getIp",3,'callback'),  
                  
            );  
      
      
        //自定义验证方法，来验证用户名的长度是否合法  
        //$date形参  可以写成任意如 $AA  $bb  
        function checkLength($data){  
            //$data里存放的就是要验证的用户输入的字符串  
            if(strlen($data)<5||strlen($data)>15){  
                  
                return false;  
            }else{  
                  
                return true;  
            }  
        }

        //用户登录
        function login($name,$password)
        {
        	$result=$this->query("select name from user where name='$name' and password='$password'");
        	if(sizeof($result)==1)
        	{
        		return true;
        	}
        	return false;
        }
      
        //返回访问者的IP地址  
        function getIp(){  
              
            return $_SERVER['REMOTE_ADDR'];  
        }  
      
        function shijian(){  
                  
            return date("Y-m-d H:i:s");  
        }  
}  