//导航栏固定效果 
		jq(window).bind("scroll",function () { //浏览器滚动条触发事件
     		var scrollTop = jq(window).scrollTop();

     		if(scrollTop>0){
			    jq('.head').addClass('headscroll');
				jq('.head').css({position:"fixed",top:"0px"});
				jq('.addhead').css({display:"block"});
				
     		}else{
			    jq('.head').removeClass('headscroll');
    			jq('.head').css({position:"relative",top:"0"});
				jq('.addhead').css({display:"none"});
     		}
		});
	//头部下拉效果 
	jq(document).ready(function(){
	jq(".user-ed .lot").hover(function(){
			jq(this).addClass("hover");
			
		},function(){
			jq(this).removeClass("hover");  
			
		}
	); 
	jq(".nav-mo .nav-lis").hover(function(){
			jq(this).addClass("hover");
		},function(){
			jq(this).removeClass("hover");  
		}
	); 
	
	//搜索 
	
	 jq(".seatext").each(function(){
     var thisVal=jq(this).val();
     //判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
     if(thisVal!=""){
       jq(this).siblings("em").hide();
      }else{
       jq(this).siblings("em").show();
      }
     //聚焦型输入框验证 
     jq(this).focus(function(){
       jq(this).siblings("em").hide();
      }).blur(function(){
        var val=jq(this).val();
        if(val!=""){
         jq(this).siblings("em").hide();
        }else{
         jq(this).siblings("em").show();
        } 
      });
    })
	 
	 jq(".seatext").each(function(){
     var thisVal=jq(this).val();
     //判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
     if(thisVal!=""){
       
	   jq('.seabutton').addClass("focus");
      }else{
       
	   jq('.seabutton').removeClass("focus");  
      }
      jq(this).keyup(function(){
       var val=jq(this).val();
       
	   jq('.seabutton').addClass("focus");
      }).blur(function(){
        var val=jq(this).val();
        if(val!=""){
         
		 jq('.seabutton').addClass("focus");
        }else{
         
		 jq('.seabutton').removeClass("focus");  
        }
       })
     }) 
	
    });