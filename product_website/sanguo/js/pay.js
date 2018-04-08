  /**
  * 支付页面处理程序
  */
  
 #define(function(require, exports, module){
	 
     // 弹出确认浮层
     var popupFullScreen = require('./popupFullScreen.js');
     require('./bank.js');
     var payData=$.parseJSON(bankList);      
     //检测是否是多平台充值用户
     var ishttps = 'https:' == document.location.protocol ? true: false;
     if(ishttps==false){
    	 var orderUrl=window.location.href;
    	  orderUrl=orderUrl.replace('http://','');
    	  orderUrl='https://'+orderUrl;
    	  //alert(orderUrl);
    	 location.href=orderUrl;
     }
    if(location.host=='v1game.cn' && typeof($_GET['uid'])!='undefined'){
        $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"game.getThirdPlatRechargeUrl","ssoUID":$_GET['uid']},function(data){
            dataArray=$.parseJSON(data);
            thirdPlatRechargeUrl=dataArray['result']['data']['items'];
            if(thirdPlatRechargeUrl=='false'){
                $("body").show();
            }else{
                location.href=thirdPlatRechargeUrl;
            }
        });
    }else{
       $("body").show();
    }
    
    //初始化表单
    $('#gameNoInput').val('');
    $('#gameServerInput').val('');
    $('#ssoUIDInput').val('');
    $('#remarkInput').val('');
    $("#denominationYuanCustom").val('');
    
    $("#usernameInput").val('');
    
    for(i in payData['pay_info']){
        selectStyle=i==0 ? 'active' : '';
        payKey=payData['pay_info'][i]['pay_key'];
        if(i==8){
        	$("#payType").append('<li class="pay_it pay_it10" style="display:none"><a id="payButton" class="pay'+payKey+' '+selectStyle+'" serialNumber="'+i+'" href="javascript:void(0);">'+payData['pay_info'][i]['pay_name']+'</a></li>');
        }else{
        	$("#payType").append('<li class="pay_it"><a id="payButton" class="pay'+payKey+' '+selectStyle+'" serialNumber="'+i+'" href="javascript:void(0);">'+payData['pay_info'][i]['pay_name']+'</a></li>');
        }
    }    

    $("a[id=payButton]").click(function(){
        $("#v1Card").removeClass('active');
        $("a[id=payButton]").removeClass('active');
        $(this).addClass('active');
        $("#payTypeName").html($(this).html());
        
        $("[group=general]").show();
        $("[group=v1Card]").hide(); 
        //var userpaytype=$("#payTypeInput").val();
        //console.log(userpaytype);
        //var usergamemoeny=$("#exchangeRateMessage").html();
        //console.log(usergamemoeny);
        //if(userpaytype==7){
        //	$("#exchangeRateMessage").html(usergamemoeny*0.8);
        //}
        serialNumberInt=$(this).attr("serialNumber");  //支付方式序号
        currentPayData=payData['pay_info'][serialNumberInt];
        
        //设置支付方式
        $("#payTypeInput").val(currentPayData['pay_key']);
        $("#remarkInput").val($("#usernameInput").val()+' '+$("#payType li a.active").html()+' '+$("#selectGame").text());
        
        var userpaytype=$("#payTypeInput").val();
        var usergamemoeny=$("#gameratio").val();
        if(userpaytype==7){
        	$("#exchangeRateMessage").html(usergamemoeny*0.8);
        	$("#Ingot").html($("input[id=denominationYuan]:checked").val()*$("#exchangeRateMessage").html());
        }else{
        	$("#exchangeRateMessage").html(usergamemoeny);
        	$("#Ingot").html($("input[id=denominationYuan]:checked").val()*$("#exchangeRateMessage").html());
        }
        //控制右侧银行选择
        $("#bankID ul").html('');
        if(currentPayData['pay_detail'].length>0){
            for(i in currentPayData['pay_detail']){                                      
                $("#bankID ul").append('<li class="bank_item '+currentPayData['pay_detail'][i]['pay_detail_key']+'">'+
                                '<label>'+
                                    '<input type="radio" name="pay[bankNo]" value="'+currentPayData['pay_detail'][i]['pay_detail_key']+'">'+
                                    '<span class="bank_bg" alt="'+currentPayData['pay_detail'][i]['pay_detail_name']+'"></span>'+
                                '</label>'+
                             '</li>');
            }
            
            $("#bankID ul li").eq(0).addClass("bank_act");
            $("#bankID").parent("div").show();
            
            $("#bankID ul li").click(
                function(){
                    $(this).find("input:radio").prop("checked",true);
                    $(this).addClass("bank_act").siblings().removeClass('bank_act');
                }
            );
        }else{
            $("#bankID").parent("div").hide();
        }
        $('#bankID').find('.bank_act').find(':radio').attr('checked', 'checked');
    });
    //设置默认显示
    $("a[id=payButton]").eq(0).click();
    //设置获取订单号
    $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"base.getOrderNo"},function(data){
       orderNoObj=$.parseJSON(data);
       orderNo=orderNoObj['result']['data']['items'];
       $("#orderNo").val(orderNo);
    });
    
    $("#denominationID li").click(function(){
        $("#denominationID li").find("label").removeClass('game_ted');
        $(this).find("label").addClass('game_ted').find("input:radio").prop("checked",true);
        if($(this).index()!=7 && $("#exchangeRateMessage").html()!='-'){
        	if($("#denominationYuanCustom").val()==''){
        		$("#Ingot").html($("input[id=denominationYuan]:checked").val()*$("#exchangeRateMessage").html());
        	}else{
        		$("#Ingot").html($("#denominationYuanCustom").val()*$("#exchangeRateMessage").html());
        	}
            
        }
    });
    $("#denominationID li").eq(3).click();
    //验证输入金额为5-99999元
    $("#denominationYuanCustom").keydown(function(event){
        $("#moneyMessage").show();
        if((event.keyCode>=48 && event.keyCode<=57) || event.keyCode==8 || event.keyCode==46 || event.keyCode==37 || event.keyCode==39 || (event.keyCode>=96 && event.keyCode<=105)){
            return true;
        }else{
            return false;
        }
    });
    
    $(".game_input").keydown(function(event){
        if ( typeof(indexOfKey) != "undefined" ) {
            indexOfKey+=event.key;
        }else{
            indexOfKey=event.key;
        }
        $("#lastPlayList li").each(function(){
            if(event.keyCode==8){
                $(this).show();
                indexOfKey='';
                $(".game_input").val('');
            }else{
                serverNo=$(this).attr("serverNo");
                if(serverNo.indexOf(indexOfKey)!=-1){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            }
        });
    });
    
    $("#denominationYuanCustom").focusout(function(){
        denominationYuanCustom=$(this).val();
        if(denominationYuanCustom<5 || denominationYuanCustom>99999){
            if(denominationYuanCustom!=''){
                $(this).val(5);
                $("#moneyMessage").parent("div").removeClass('error').addClass('ok');
                if($("#exchangeRateMessage").html()!='-')
                    $("#Ingot").html($("#denominationYuanCustom").val()*$("#exchangeRateMessage").html());
            }else{
                $("#denominationID li").eq(5).click();
                if($("#exchangeRateMessage").html()!='-')
                    $("#Ingot").html($("input[id=denominationYuan]:checked").val()*$("#exchangeRateMessage").html());
                $("#moneyMessage").hide();
            }
        }else{
            $("#moneyMessage").parent("div").removeClass('error').addClass('ok');
            if($("#exchangeRateMessage").html()!='-')
                $("#Ingot").html($("#denominationYuanCustom").val()*$("#exchangeRateMessage").html());
        }
    });

    if(typeof($_GET['tCode'])!='undefined' && typeof($_GET['TOID'])!='undefined'){
        $("#usernameInput").attr("readonly",true).css("border","0");
        $("#usernameInput").val($_GET['TOID']);
        $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"user.lastPlayForThird","tCode":$_GET['tCode'],"TOID":$_GET['TOID'],"nums":"9999999999"},function(data){
            lastPlayArray=serverListMenu(data);
            $("#ssoUIDInput").val(lastPlayArray[0]['ssoUID']);
        });
    }else if(typeof($_GET['uid'])!='undefined'){
        $("#usernameInput").attr("readonly",true).css("border","0");
        $("#ssoUIDInput").val($_GET['uid']);
        $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"user.lastPlay","ssoUID":$_GET['uid'],"nums":"1"},function(data){
                    lastPlayObj=$.parseJSON(data);
                    lastPlay=lastPlayObj['result']['data']['items'];
                    if(typeof(lastPlay['data'][0])!='undefined'){
                        lastPlay=lastPlay['data'][0];
                        
                        $("#gameNoInput").val(lastPlay['gameNo']);  //设置游戏ID
                        $("#gameServerInput").val(lastPlay['serverNo']); //设置区服ID
                        $("#exchangeRateMessage").html($(this).attr("exchangeRate"));
                        $("#usernameInput").val(lastPlay['username']);
                        $("#selectGame").html(lastPlay['gameName']+' '+lastPlay['serverNo']+'服');
                        
                        
                        
                        $("#gameratio").val(lastPlay['exchangeRate']);
                        var userpaytype=$("#payTypeInput").val();
                        var gamemoneyli='';
                        if(userpaytype==7){
                        	gamemoneyli=lastPlay['exchangeRate']*0.8;
                        }else{
                        	gamemoneyli=lastPlay['exchangeRate'];
                        }
                        $("#exchangeRateMessage").html(gamemoneyli);
                        $("#remarkInput").val(lastPlay['username']+' '+$("#payType li a.active").html()+' '+$("#selectGame").text());
                        if($("#denominationYuanCustom").val()==''){
                            $("#Ingot").html($("input[id=denominationYuan]:checked").val()*gamemoneyli);
                        }else{
                            $("#Ingot").html($("#denominationYuanCustom").val()*gamemoneyli);
                        }
                    }else{
                        alert('用户不存在,请重新输入用户名');
                        location.href=location.pathname;
                    }
        });
    }else{
        //验证用户名
        $("#usernameInput").focusout(function(){
            if($("#selectGame").hasClass("open")==true) return false;
            var username=$("#usernameInput").val();
            if(!username) return false;
            $("#usernameMessage").text('Loading...').show().parent().css('pay_item');
            $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"user.checkUsername","username":username},function(data){
                $('#selectGame').html('Loading...');
                $("#usernameMessage").show();
                userInfoObj=$.parseJSON(data);
                userInfoArray=userInfoObj['result']['data']['items'];
                if(userInfoArray['result']=='0'){
                    $("#usernameMessage").text('您输入的账号不存在').parent().removeClass('ok').addClass("error");
                    $('#selectGame').html('选择游戏和服务器');   
                }else{
                    $("#usernameMessage").text('').parent().removeClass('error').addClass("ok");
                    $('#ssoUIDInput').val(userInfoArray['ssoUID']);  //设置用户ID
                    $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",{"obj":"user.lastPlay","ssoUID":userInfoArray['ssoUID'],"nums":"9999999999"},function(data){
                        serverListMenu(data);
                    });
                }
            });
        });
        $("#usernameInput").focus(function(){
            $('#selectGame').removeClass('open');
            $('#selectGameList').hide();
        });
        $("#usernameInput").keydown(function(event){
            if(event.keyCode==13){
                $('#usernameInput').focusout();
            }else{
                $('#gameNoInput').val('');
                $('#gameServerInput').val('');
                $('#ssoUIDInput').val('');
                $('#remarkInput').val('');
                $("#denominationYuanCustom").val('');
                $("#Ingot").text('-');
                $("#exchangeRateMessage").text('-');
                $("#usernameInput").focus();
            }
        });
    }
    
    //确认充值第一步
    $('#buttonOK1').click(function() {
        if($("#selectGame").hasClass("open")){
            alert('请选择区服');
        }else{
            if($("#orderNo").val() && $("#payTypeInput").val() && $("#gameNoInput").val() && $("#gameServerInput").val() && $("#ssoUIDInput").val() && $("#remarkInput").val() && $("#toGame").val()){
                var username=$("#usernameInput").val();
                var gameAndServer=$("#selectGame").html();
                var money=$("#denominationYuanCustom").val() ? $("#denominationYuanCustom").val() : $("input[id=denominationYuan]:checked").val();
                var Ingot=$("#Ingot").text();
                var orderNo=$("#orderNo").val();
                var payName=$("#payType li a.active").html();
                var bankName=$("#bankID").find("label.bank_act span").attr("alt");
                var showMessageHtml='<li class="box_item"><span>充值账号：</span><em>'+username+'</em></li>'+
                                    '<li class="box_item"><span>充值游戏：</span><em>'+gameAndServer+'</em></li>'+
                                    '<li class="box_item"><span>充值金额：</span><em><b>'+money+'元</b></em></li>'+
                                    '<li class="box_item"><span>可获得元宝：</span><em><b>'+Ingot+'</b>元宝</em></li>'+
                                    '<li class="box_item"><span>订单号：</span><em>'+orderNo+'</em></li>'+
                                    '<li class="box_item"><span>充值方式：</span><em>'+payName+'</em></li>';
                if(bankName){
                    showMessageHtml+='<li class="box_item"><span>选择银行：</span><em>'+bankName+'</em><a class="money_tab" href="###">限额表</a> </li>';
                }
                $("#confirmPay ul").html(showMessageHtml);
                
                var gameNo=$("#gameNoInput").val();
                var serverNo=$("#gameServerInput").val();
                if(username!='' && gameNo!='' && serverNo!=''){
                    if(typeof($_GET['tCode'])!='undefined' && typeof($_GET['TOID'])!='undefined'){
                        var interfaceParam={"obj":"game.isCreateRoleForThird","tCode":$_GET['tCode'],"TOID":$_GET['TOID'],"gameNo":gameNo,"serverNo":serverNo};
                    }else{
                        var interfaceParam={"obj":"game.isCreateRole","username":username,"gameNo":gameNo,"serverNo":serverNo};
                    }
                    $.getJSON(platformInterface+"?mode=jsonp&jsoncallback=?",interfaceParam,function(data){
                        userInfoObj=$.parseJSON(data);
                        userInfoArray=userInfoObj['result']['data']['items'];
                        if(userInfoArray['result']=='false'){
                            alert(userInfoArray['message']);
                            return false;    
                        }
                        //显示浮层
                        popupFullScreen($('#confirmPay'));
                    });
                    
                    
                }else{
                    alert('请选择游戏和区服');
                    return false;
                }
            }
        }
    });
    
    //确认充值第二步
    $("#buttonOK2").click(function(){
    	var payFormAction='https://pay.v1game.cn/pay/pay'
        $("#payForm").attr("action",payFormAction).submit();
    });
    
    //添加默认支付账户--等待头部登陆信息开发完毕
    if($("#usernameInput").val()=='' && typeof($_GET['uid'])=='undefined'){
        intervalUserNameID=window.setInterval(function(){
            var getUserName=$("#gameusername").val();
            if(getUserName){
                $("#usernameInput").val(getUserName);
                $("#usernameInput").focus();
                $("#usernameInput").focusout();
                window.clearInterval(intervalUserNameID);
            }
        },1000);
    }
    
    
    //设置区服菜单
    function serverListMenu(lastPlayData){
        $('#selectGame').html('选择游戏和服务器');
        $("#lastPlayList").html("");
        lastPlayObj=$.parseJSON(lastPlayData);
        lastPlayArray=lastPlayObj['result']['data']['items']['data'];
        for(i in lastPlayArray){
            lastPlayLiID="#lastPlayList li[gameNo="+lastPlayArray[i]['gameNo']+"][serverNo="+lastPlayArray[i]['serverNo']+"][exchangeRate="+lastPlayArray[i]['exchangeRate']+"]";
            if($(lastPlayLiID).length>0) continue;
            lastPlayItem='<li class="game_item" gameNo="'+lastPlayArray[i]['gameNo']+'" serverNo="'+lastPlayArray[i]['serverNo']+'" exchangeRate="'+lastPlayArray[i]['exchangeRate']+'">'+
                            '<a class="sec_item" title="'+lastPlayArray[i]['gameName']+'">'+
                                '<span class="game_sp">'+lastPlayArray[i]['gameName']+'&nbsp;&nbsp;</span>'+
                                '<em class="game_fw">'+lastPlayArray[i]['serverNo']+'服</em>'+
                            '</a>'+
                          '</li>';
            $("#lastPlayList").append(lastPlayItem);
        }
        //激活选择游戏标签
        $('#selectGame').click(function() {
            $(this).addClass('open');
            if($("#lastPlayList").html()==''){
                $("#lastPlayList").html('<div style="margin: 40px"><a href="http://v1game.cn/ghall.shtml">该账号还未在任何游戏中创建过角色，无法进行充值。您可以到游戏大厅逛逛，一定能找到最适合您的游戏</a></div>');
            }
            $('#selectGameList').show();
        });
        $('#selectGameList li').click(function() {
            $('#selectGame').removeClass('open');
            $('#selectGameList').hide();
            $('#selectGame').html($(this).find('a').text().replace(/\s+/,' '));
            
            $('#gameNoInput').val($(this).attr("gameNo"));  //设置游戏ID
            $('#gameServerInput').val($(this).attr("serverNo")); //设置区服ID
            
            
            $("#gameratio").val($(this).attr("exchangeRate"));
            var userpaytype=$("#payTypeInput").val();
            var gamemoneyli='';
            if(userpaytype==7){
            	gamemoneyli=$(this).attr("exchangeRate")*0.8;
            }else{
            	gamemoneyli=$(this).attr("exchangeRate");
            }
            $("#exchangeRateMessage").html(gamemoneyli);
            $("#remarkInput").val($("#usernameInput").val()+' '+$("#payType li a.active").html()+' '+$("#selectGame").text());
            if($("#denominationYuanCustom").val()==''){
                $("#Ingot").html($("input[id=denominationYuan]:checked").val()*gamemoneyli);
            }else{
                $("#Ingot").html($("#denominationYuanCustom").val()*gamemoneyli);
            }
        });
        $('#selectGame').click();
        return lastPlayArray;
    }
    
    require('./v1CardPay.js');    
    //设置默认显示
    if($_GET['payType']){
        $("a.pay"+$_GET['payType']).click();
    }else{
        $("a[id=payButton]").eq(0).click();    
    }
    
    // 展示更多银行
    $('.pay_main .drop_btn').click(function() {
        $('.pay_main .drop').hide();
        $('.pay_main .bank_chose').addClass('open');
    });
 });