(function($){
	$.fn.val2 = $.fn.val;
	//重写jquery val方法，增加data-empty过滤
	   $.fn.val = function(){
	    	var value = $(this).val2.apply(this,arguments);
	    	var empty = $(this).attr("data-empty");
	    	if(typeof empty != "undefined"&&empty==value){
	    		value = "";
	    	}
	    	return value;
	    };
	    
	$.fn.emptyValue = function(arg){
        this.each(function(){
            var input = $(this);
            var options = arg;
            if(typeof options == "string"){
                options = {empty: options}
            }
            options = jQuery.extend({
                empty: input.attr("data-empty")||"",
                className: "gray"
            }, options);
            
            return input.focus(function(){
                $(this).removeClass(options.className);
                if($(this).val2() == options.empty){
                	
                    $(this).val2("");
                    if(typeof $(this).attr('pass-empty') != "undefined" && $(this).attr('pass-empty')=="true" && $(this).next().attr('pass-empty')=='true')
                	{
                    	$(this).hide();
                    	$(this).next().show();
                    	$(this).next().val2("");
                    	$(this).next().focus();
                	}
                }
            }).blur(function(){
                if($(this).val2()==""){
                    $(this).val2(options.empty);
                    if(typeof $(this).attr('pass-empty') != "undefined" && $(this).attr('pass-empty')=="true"  && $(this).prev().attr('pass-empty')=='true')
                    	{
	                    	$(this).hide();
	                    	$(this).prev().show();
	                    	$(this).prev().addClass(options.className);
	                    	$(this).prev().val2(options.empty);
                    	}
                }
                else
                {
                	if(typeof $(this).attr('pass-empty') != "undefined" && $(this).attr('pass-empty')=="true"  && $(this).prev().attr('pass-empty')=='true')
                	{
                    	$(this).prev().hide();
                	}
               	}
                $(this).addClass(options.className);
            }).blur();
        });
    };
  
})(jQuery);