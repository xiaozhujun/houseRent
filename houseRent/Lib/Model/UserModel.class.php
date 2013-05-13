<?php  
class UserModel extends Model{  
  
    //自动验证  
    protected $_validate=array(  
            //每个字段的详细验证内容  
            array("name","require","用户名不能为空"),  
            array("name","checkLength","用户名长度不符合要求",0,'callback'), 
    		array('name','isUserExist','账号已经使用',0,'callback'),
            array("password","require","密码不能为空"),  
            array("password","checkLength","密码长度的要求是5~15位之间",0,'callback'),  
            array("password","repassword","两次密码输入不一致",0,'confirm'),  
            array("email","require","qq必须填写"),  
    		array("email","email","邮箱格式不正确",2),
    		array('email','isEmailExist','邮箱已经使用',0,'callback'),
            );  
      
    //自动填充  
    protected $_auto=array(  
              
            array("password","md5",3,'function') ,
    		array("activateCode","genActivateCode",3,'callback'),
            array("createTime","dateTime",3,'callback'),  
            array("codeEffectTime","getCodeEffectTime",3,'callback'),  
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
        	$md5_pass = md5($password);
        	$result=$this->query("select name from user where name='$name' and password='$md5_pass' and status=1");
        	if(sizeof($result)==1)
        	{
        		return true;
        	}
        	else
        	{
        		$result=$this->query("select name from user where name='$name' and status=0");
        		if(sizeof($result)==1)
        		{
        			$this->error='您的用户需要激活哦！';
        			return false;
        		}
        	}
        	$this->error='用户名或者密码错误！';
        	return false;
        }
        
        //更新用户激活码及事件信息
        function updateActivateInfo($name)
        {
        	//判断用户是否存在
        	if(!$this->isUserExist($name))
        	{
        		$this->error = '账号不存在';
        		return false;
        	}
        	//判断用户是否激活
        	if($this->isUserActivated($name))
        	{
        		$this->error = '账号已经激活';
        		return false;
        	}
        	
        	$date = date('Y-m-d h-i-s');
        	$querySQL = "select id from user where status=0 and name='{$name}'";
        	$result = $this->query($querySQL);
        	if(sizeof($result)>=1)
        	{
        		$data_update=array(
        				'status'=>0,
        				'activateCode'=>$this->genActivateCode(),
        				'codeEffectTime'=>$this->getCodeEffectTime(),
        				'id'=>$result[0]['id'],
        		);
        		return $this->save($data_update);
        	}
        	
        	return false;
        }
        
        //判断用户是否存在
        function isUserExist($name)
        {
        	$querySQL = "select id from user where name='{$name}'";
        	$result = $this->query($querySQL);
        	if(sizeof($result)>=1)
        	{
        		return false;
        	}
        	return true;
        }
        
        //判断邮箱是否存在
        function isEmailExist($email)
        {
        	$querySQL = "select id from user where email='{$email}'";
        	$result = $this->query($querySQL);
        	if(sizeof($result)>=1)
        	{
        		return false;
        	}
        	return true;
        }
        
        //判断用户是否已经激活
        function isUserActivated($name)
        {
        	$querySQL = "select id from user where name='{$name}' and status=1";
        	$result = $this->query($querySQL);
        	if(sizeof($result)==1)
        	{
        		return true;
        	}
        	return false;
        }
        
        //激活用户
        function regActivate($name,$activateCode)
        {
        	$date = date('Y-m-d h-i-s');
        	$querySQL = "select id from user where name='{$name}' and activateCode='{$activateCode}' and  codeEffectTime >='{$date}' and codeEffectTime IS NOT NULL and status=0";
        	$result = $this->query($querySQL);
        	if(sizeof($result)==1)
        	{
        		$data_update=array(
        				'status'=>1,
        				'activateCode'=>NULL,
        				'codeEffectTime'=>NULL,
        				'activeTime'=> date('Y-m-d h-i-s'),
        				'id'=>$result[0]['id'],
        		);
        		return $this->save($data_update);
        	}
        	else 
        	{
        		if($this->isUserActivated($name))
        		{
        			$this->error = '用户已经激活，您可以正常登陆哦！';
        			return false;
        		}
        		
        		$querySQL = "select id from user where status=0 and name='{$name}' and codeEffectTime < '{$date}'";
        		$result = $this->query($querySQL);
        		if(sizeof($result)==1)
        		{
        			$this->error = '激活码已经过期，请重新申请激活！';
        			return false;
        		}
        	}
        	$this->error = '对不起，您的激活请求失败了哦！您可以重新申请激活或者联系管理员帮您解决！';
        	return false;
        }
        
        //通过用户名查找
        function findByName($name)
        {
        	if($name!=null && $name!='')
        	{
        		$querySQL = "select * from user where name='{$name}'";
        		$list= $this->query($querySQL);
        		if(sizeof($list)>=1)
        		{
        			return $list[0];
        		}
        	}
        	return null;
        }
        
        //添加激活码
        function genActivateCode()
        {
        	import('ORG.Util.String');
        	return md5(String::randString(6, 1));
        }
      
        //返回访问者的IP地址  
        function getIp(){  
              
            return $_SERVER['REMOTE_ADDR'];  
        }  
      
        //当前系统时间
        function dateTime(){  
                  
            return date("Y-m-d h:i:s");  
        }  
        
        //激活码有效期截止时间
        function getCodeEffectTime()
        {
        	return date('Y-m-d h-i-s', time()+86400);
        }
}  