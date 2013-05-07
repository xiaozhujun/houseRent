<?php
class YourAppAction extends Action{
	protected $queue_len = 10;
	public function  _empty(){
		Log::record('YourAppAction --START--',Log::WARN);
		echo ("please declare your method");
	}
	public function _before_BaeCacheSet()
	{
		echo ("<pre>");
	}
	public function _after_BaeCacheSet()
	{
		echo ("</pre>");
	}
	public function BaeCacheSet()
	{
	    $Cache = Cache::getInstance('Bae',array('expire'=>'60'));
	    for($i = 0;$i< 15;$i++){
		$k ="key".$i; 
		$r = $Cache->set($k,$i);
		if ( $r ) echo ("set [$k] ok\n"); 
		else
		echo ("set [$k] failed\n");
	    }
	}
	public function BaeCacheGet()
	{
	    echo ("<pre>");
	    $Cache = Cache::getInstance('Bae',array('expire'=>'60'));
	    for($i = 0;$i< 15;$i++){
		$k ="key".$i; 
		$r = $Cache->get($k);
		if ( $r!== false ) echo ("get [$k] ok value[$r]\n"); 
		else echo ("get[$k] failed\n");
	    }
	    echo ("</pre>");
	}
	public function test()
	{
	   $mem = new BaeMemcache();
	   var_dump($mem->set("key","value"));
	   var_dump($mem->get("key"));	
	}
	public function queueCache()
	{
            echo("<pre>");
	    $Cache = Cache::getInstance('Bae',array('expire'=>'60','length'=>$this->queue_len));
	    $len = 15;
	    for($i = 0;$i< $len;$i++){
		$k ="key".$i; 
		$r = $Cache->set($k,$i);
		if ( $r ) echo ("set [$k] ok\n"); 
		else echo ("set [$k] failed\n");
	    }
	    sleep(1);
	    for($i = $len-1,$j = $this->queue_len;$i>=0 ;$i--,$j--){
		$k ="key".$i; 
		$r = $Cache->get($k);
		if ( $r !== false && $j > 0 ) echo ("get [$k] ok\n"); 
		else if ( $r === false && $j <= 0) echo ("get [$k] ok\n"); 
		else echo ("get [$k] failed\n");
	    }
	    echo("</pre>");
	}
	public function setAndget()
	{
		dump("test start ..............");
	}
	public function testCacheCompress()
	{
		dump("test testCacheCompress..............");
		C('DATA_CACHE_COMPRESS',true);
		C('DATA_CACHE_CHECK',true);
		$this->queueCache();
		C('DATA_CACHE_COMPRESS',false);
		C('DATA_CACHE_CHECK',false);
		$this->queueCache();
		C('DATA_CACHE_COMPRESS',true);
		C('DATA_CACHE_CHECK',false);
		$this->queueCache();
		C('DATA_CACHE_COMPRESS',false);
		C('DATA_CACHE_CHECK',true);
		$this->queueCache();
	}
	
}
