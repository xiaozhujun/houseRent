<?php
class BaeAction extends Action {
	public function demo(){
	}
    /*for test*/
	public function test(){
        //session_start();
        //$_SESSION['k1'] = "value1"; 
	}

	public function index(){
		$this->assign('name', "BAE上的thinkphp");
		$this->display();
	}
	public function tpldemo()
	{
		$this->assign('name',__CLASS__ . "::" . __FUNCTION__);
		$this->display();
	}
	public function img()
	{
		ob_start();
		/*通知浏览器,要输出图像*/   
		$im = imagecreate(400 , 300);   
		/*定义图像的大小*/   
		$gray = ImageColorAllocate($im , 235 , 235 , 235);   
		$pink = ImageColorAllocate($im, 255 , 128 , 255);   
		define('FONT_PATH',dirname(__FILE__));
		$fontfile = FONT_PATH . "/simhei.ttf";
		/*   
		$fontfile = FONT_PATH . "/simhei";
		     $fontfile = "C:\WINDOWS\Fonts\SIMHEI.TTF";   
		     不好意思,这句老是粘上后一提交就丢了,不知道是怎么回事
		     ,想测试的朋友们将注释去了现测试吧   
		 */   
		/* $fontfile 字体的路径,视操作系统而定,可以是 
		   simhei.ttf(黑体) , SIMKAI.TTF(楷体) , 
		   SIMFANG.TTF(仿宋) ,SIMSUN.TTC(宋体&新宋体) 
		   等 GD 支持的中文字体*/   
		//$str = iconv('GB2312','UTF-8','中文水印!!!');   
		$str = '中文水印!!!';   
		/*将 gb2312 的字符集转换成 UTF-8 的字符*/   
//		ImageTTFText($im, 30, 0, 50, 140, $pink , $fontfile , $str);   
		if ( false === imagettftext($im, 30, 0, 50, 140, $pink , $fontfile , $str) )
		{
//			$fontfile .= ".ttf";	
//			imagettftext($im, 30, 0, 50, 140, $pink , $fontfile , $str) ;
		}  
		/* 加入中文水印 */   
		Imagepng($im);   
		ImageDestroy($im); 
		$imgrc = ob_get_contents();
		ob_clean();
		var_dump($imgrc);
	}
}
