<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/js/config.js" type="text/javascript"></script>
<script src="/js/urlUtil.js" type="text/javascript"></script>
<script src="/js/resouce.js" type="text/javascript"></script>
<script src="/js/emptyNote.js" type="text/javascript"></script>
<script src="/js/house.js" type="text/javascript"></script>

{if !isset($user)}
<link href="/css/headLogin.css" type="text/css" rel="stylesheet">
{/if}

<link href="/css/common.css" type="text/css" rel="stylesheet">
<link href="/css/header.css" type="text/css" rel="stylesheet">
<link href="/css/house/search.css" type="text/css" rel="stylesheet">
<link href="/css/searchInput.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<meta name="Keywords" content="租房,租客,团租,租客团,房源,圈子" />
<meta name="Description" content="租客团是中国领先的提供房源分享与交换社区服务的互联网技术公司，为用户提供免费的房源分享、检索、交换、交易服务。" />
<meta name="robots" content="search, follow" />
<meta name="googlebot" content="search, follow" />   
<title>租客团-房源检索</title>

</head>  
<!-- <body onload='loadregion()'>   -->
<body>
 <script type="text/javascript">
	var hrefstr=window.location.href;
    var key=test("key");
    var price=test("price");
    var region=test("region");
    var room=test("room");
    var type=test("type");
 	$(document).ready(function(){
 		{if !isset($user)}
 		$('#loginBtn').click(function(){
				var data = {};
				data.email = $('#emailLoginInput').val();
				data.password = $('#pwdLoginInput').val();
				$.post($.URL.user.login,data,loginCallback,"json");
			});
 		{/if}
 		
 		
 		$("input").emptyValue();
 		
 		$('#searchBtn').click(function(){
 			key = $('#searchInput').val();
 			if(key!="")
 			{
 				var data = {};
	    		getPramsFromUrl(data,key,price,region,room,type);
	    		$.post($.URL.house.houselist,data,callback,"json");
 			}
 			else
 			{
 				$("#searchMsg").html("请输入房源搜索关键字！");
 			}
 		});
 		
    	for(var i=0;i<region_array.length;i++){
            var newNode = document.createElement("a");
            newNode.href=getretionlink(key,price,region,room,type,region_array[i][0],1);
            newNode.type='region';
            newNode.value = region_array[i][0];
            newNode.class="region_"+region_array[i][0];
            newNode.innerHTML=region_array[i][1];
            var parent = $("#region").append(newNode);
    	}
    	for(var i=0;i<price_array.length;i++){
            var newNode = document.createElement("a");
            newNode.href=getretionlink(key,price,region,room,type,price_array[i][0],2);
            newNode.type='price';
            newNode.value = price_array[i][0];
            newNode.class="price_"+price_array[i][0];
            newNode.innerHTML=price_array[i][1];
            var parent = $("#price").append(newNode);
    	}
    	for(var i=0;i<room_array.length;i++){
            var newNode = document.createElement("a");
            newNode.href=getretionlink(key,price,region,room,type,room_array[i][0],3);
            newNode.type='room';
            newNode.value = room_array[i][0];
            newNode.class="room_"+room_array[i][0];
            newNode.innerHTML=room_array[i][1];
            var parent = $("#room").append(newNode);
    	}
    	for(var i=0;i<type_array.length;i++){
            var newNode = document.createElement("a");
            newNode.href=getretionlink(key,price,region,room,type,type_array[i][0],4);
            newNode.type='type';
            newNode.value = type_array[i][0];
            newNode.class="type_"+type_array[i][0];
            newNode.innerHTML=type_array[i][1];
            var parent = $("#type").append(newNode);
            
    	}
    	var data = {};
    	getPramsFromUrl(data,key,price,region,room,type);
    	$.post($.URL.house.houselist,data,callback,"json");
    	//$.post($.URL.house.houselist,data,callback,"json");
    	
    	$("dd a").click(function(){
    		$(this).addClass('selected').siblings().removeClass('selected');
    		linkType = $(this).attr("type");
    		if(linkType=='region')
    		{
    			region = $(this).attr("value");
    		}
    		else if(linkType=='type')
    		{
    			type = $(this).attr("value");
    		}
    		else if(linkType=='price')
    		{
    			price = $(this).attr("value");
    		}
    		else if(linkType=='room')
    		{
    			room = $(this).attr("value");
    		}
    		var data = {};
    		getPramsFromUrl(data,key,price,region,room,type);
    		$.post($.URL.house.houselist,data,callback,"json");
    	
    		return false;
    	});
    	
 	});
 	
 	{if !isset($user)}
 	//登录回调函数
	function loginCallback(result)
	{
		if(result.data.success)
		{
			location.reload();
		}
		else
		{
			$('#loginMsg').html(result.data.msg);
		}
			
	}
	{/if}
 	
 	//回调函数
		function callback(result)
		{
			if(result.data.current_count==0){
				$('#result').html("亲，没有检索到相匹配的房源哦！");
			}else{
				renderingPage(result.data);
				$('.houseItem').click(function(){
					location=$.URL.house.info+"?id="+$(this).attr("houseId");
				});
			}
		}
 	
 	function getPramsFromUrl(data,key,price,region,room,type){
		if(key!=""){
			data['key']=key;
		}
		if(price!=""){
			data['price']=price;
		}
		if(region!=""){
			data['region']=region;
		}
		if(room!=""){
			data['room']=room;
		}
		if(type!=""){
			data['type']=type;
		}
 	}
	function renderingPage(data){
		var htmlstr="";
		for(var i=0;i<data.current_count;i++){
			htmlstr+="<div class='houseItem' houseId='" + data.houseinfo_list[i].houseId + "'>";
				htmlstr+="<div class='houseItemColumn'>"+"<a href='http://sh.58.com/zufang/12561126238593x.shtml' target='_blank' ><img src='http://4.pic.58control.cn/p1/tiny/n_1570546758288410.jpg' /></a>"+"</div>";
				htmlstr+="<div class='houseItemColumn'>";
					htmlstr+="<div class='titleinfo'>"+"标题："+data.houseinfo_list[i].title+"</div>";
					htmlstr+="<div class='regioninfo'>"+"区域："+data.houseinfo_list[i].region+"</div>";
				htmlstr+="</div>";
			htmlstr+="</div>";
		}
		
		$('#result').html(htmlstr);
	}
	function getretionlink(key,price,region,room,type,value,category){
		var link=$.URL.house.search;
		if(category==1){
			link+="?region="+value;
			if(key!=""){
				link+="&key="+key;
			}
			if(price!=""){
				link+="&price="+price;
			}
			if(room!=""){
				link+="&room="+room;
			}
			if(type!=""){
				link+="&type="+type;
			}
		}
		if(category==2){
			link+="?price="+value;
			if(key!=""){
				link+="&key="+key;
			}
			if(region!=""){
				link+="&region="+region;
			}
			if(room!=""){
				link+="&room="+room;
			}
			if(type!=""){
				link+="&type="+type;
			}
		}
		if(category==3){
			link+="?room="+value;
			if(key!=""){
				link+="&key="+key;
			}
			
			if(region!=""){
				link+="&region="+region;
			}
			if(price!=""){
				link+="&price="+price;
			}
			if(type!=""){
				link+="&type="+type;
			}
		}
		if(category==4){
			link+="?type="+value;
			if(key!=""){
				link+="&key="+key;
			}
			
			if(region!=""){
				link+="&region="+region;
			}
			if(price!=""){
				link+="&price="+price;
			}
			if(room!=""){
				link+="&room="+room;
			}
		}
		if(category==5){
			link+="?key="+value;
			if(type!=""){
				link+="&type="+type;
			}
			
			if(region!=""){
				link+="&region="+region;
			}
			if(price!=""){
				link+="&price="+price;
			}
			if(room!=""){
				link+="&room="+room;
			}
		}
		return link;
	}
	
	function test(paramName)  
	{  
	    var reg = new RegExp("(^|\\?|&)"+ paramName+"=([^&]*)(\\s|&|$)", "i");
	  
	    if (reg.test(hrefstr)) //test为script ID 
	        return URL.decode(RegExp.$2); 
	    else
	        return "";
	}


</script>
<div id='mainContainer'>
    <div id='headContainer'>
    	<div id='logoDiv'><a href='/'><img height=100% src='/assets/logo.jpg'/></a></div>
    	<div id='headLeftDiv'>
    		<div id='aimDiv'>让您不在为租房烦恼</div>
    		<div id='cityDiv'>城市</div>
    	</div>
    	<div id='headRightDiv'>
    	
    	
    	{if isset($user)}
    		<div id='headBottomDiv'>
    			<div id='loginRegDiv'>
    				hi,<a href='/User/personCenter'>{$user}</a>&nbsp;<a href='/User/logout'>安全退出</a>
    			</div>
    			<div id='contactDiv'>联系我们</div>
    			<div id='inviteDiv'><a id='inviteLink' href='/mod/user/invite.html'>邀请好友</a></div>
    		</div>
   		{else}
   			<div class='headRightRow'>
    			<div id='topRow'>
	    			<div class='nameInputDiv'>
	    				<div class='loginColumnDiv'><input id='emailLoginInput' type='text' data-empty='账号'/></div>
	    			</div>
	    			<div class='pwdInputDiv'>
	    				<div class='loginColumnDiv'><input type='text' data-empty='密码'  pass-empty='true'/><input id='pwdLoginInput' type='password' data-empty='密码'  pass-empty='true'/></div>
	    			</div>
	    			<div class='loginBtnDiv'>
	    				<div class='loginColumnDiv'><input id='loginBtn' type='submit' value='登录'/></div>
	    			</div>
    			</div>
    			<div id='bottomRow'>
    				<div id='autoLogin'><input type='checkbox'/>下次自动登录</div>
    				<div id='forgotPassword'><a href='#'>忘记密码</a></div>
    				<div id='loginMsg'></div>
    			</div>
    		</div>
    	{/if}
    		
    		
    	</div>
    </div>
	<div id='houseListContainer'>

	<div id="keysearch">
			<input id='searchInput' type="text"  maxlength="100" data-empty='按照关键字检索您想要的房源'>
			<div id='searchBtn' class='myButton'>搜索一下</div>
    		<div id='searchMsg'></div>
	</div>

    <div id="choise">
		<dl class="secitem" id="filter_quyu"> 
		<dt>区域：</dt> 
		<dd id="region">
	    <!--   <a   id="region_0" href="/zufang/" class='select'>全北京</a> 
		<a   id="region_1" href="/huangpu/zufang/">东城</a> 
		<a   id="region_2" href="/luwan/zufang/">西城</a> 
		<a   id="region_3" href="/jingan/zufang/">崇文</a> 
		<a   id="region_0" href="/xuhui/zufang/">宣武</a> 
		<a   id="region_0" href="/pudongxinqu/zufang/">朝阳</a> 
		<a   id="region_0" href="/changning/zufang/">丰台</a> 
		<a   id="region_0" href="/hongkou/zufang/">石景山</a> 
		<a   id="region_0" href="/yangpu/zufang/">海淀</a> 
		<a   id="region_0" href="/putuo/zufang/">门头沟</a> 
		<a   id="region_0" href="/zhabei/zufang/">房山</a> 
		<a   id="region_0" href="/minxing/zufang/">通州</a> 
		<a   id="region_0" href="/baoshan/zufang/">顺义</a> 
		<a   id="region_0" href="/jiading/zufang/">昌平</a> 
		<a   id="region_0" href="/qingpu/zufang/">大兴</a> 
		<a   id="region_0" href="/fengxiansh/zufang/">平谷</a> 
		<a   id="region_0" href="/nanhui/zufang/">怀柔</a> 
		<a   id="region_0" href="/chongming/zufang/">密云</a> 
		<a   id="region_0" href="/jinshan/zufang/">延庆</a> -->
		</dd> 
		</dl> 
		
		<dl class="secitem" id="filter_price"><dt>租金：</dt>
		<dd id="price">
		<!--  <a href="http://sh.58.com/zufang/" class='select'>不限</a> 
		<a href='/zufang/b8/' >600元以下</a> 
		<a href='/zufang/b9/' >600-1000元</a> 
		<a href='/zufang/b10/' >1000-1500元</a> 
		<a href='/zufang/b11/' >1500-2000元</a> 
		<a href='/zufang/b12/' >2000-3000元</a> 
		<a href='/zufang/b13/' >3000-5000元</a> 
		<a href='/zufang/b14/' >5000-8000元</a> 
		<a href='/zufang/b15/' >8000元以上</a> -->
		</dd>
		</dl>
		
		<dl class="secitem" id="filter_tingshi"><dt>厅室：</dt>
		<dd id="room">
		<!--<a href="http://sh.58.com/zufang/" class='select'>不限</a> 
		<a href='/zufang/i1/' >一室</a> 
		<a href='/zufang/i2/' >两室</a> 
		<a href='/zufang/i3/' >三室</a> 
		<a href='/zufang/i4/' >四室</a> 
		<a href='/zufang/i5/' >四室以上</a> -->
		</dd></dl>
		
		<dl class="secitem" id="filter_fangshi"> 
		<dt>方式：</dt> 
		<dd id="type"> 
		<!--<a class="select">整套出租</a> 
		<a href="/hezu/">单间出租</a> 
		<a href="/hezu/g2/">床位出租</a> -->
		</dd> 
		</dl>
    </div>
    
    <div id="result"> 

    </div>
	</div>
</div>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fa712b75dc1788d09dbf388a019b92836' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>  
</html>  







