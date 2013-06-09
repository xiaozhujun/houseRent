<?php
/*
 * 返回当前时间戳
 */
function intNow(){
	return mktime();
}
/*
 * 返回系统当前时间
 */
function dateTime(){                 
	return date("Y-m-d H:i:s");  
} 