<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
		<div class="content-wrap">
			<div class="right-content">
				<div class="content-body">
					<?php if(Yii::$app->session['login_user'] && $action !='find_password' ){?>
					<!--已登录-->	
					<div class="logined">
						<div>亲爱的<span class="red"><?=$login?></span></div>
						<div>欢迎登录</div>
					</div>
					<div class="btn-grounp">
						<button onclick="window.location.href='/site/recharge'">充值</button>
						<input type="text" style="display:none" name="phone_login" id="phone_login" value="<?=$login?>">
						<button onclick="find_password();">修改密码</button>
						<button class="log-off" onclick="logout();">注销</button>
					</div>
					<?php }else{?>
						<?php if($action=='login'){?>
						<!--登录-->	
						<div class="form">
							<table>
								<tr>
									<td class="text-right">用户账号：</td>
									<td><input type="text" name="phone_login" id="phone_login"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">输入密码：</td>
									<td><input type="password" name="password_login" id="password_login"></td>
									<td><a class="red" onclick="find_password();">忘记密码？</a></td>
								</tr>
								<tr>
									<td class="text-right"></td>
									<td>您还没有账号，请<a class="red" href="<?=Url::toRoute(['site/accountcenter','action'=>'regist'])?>"> 注册</a></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td><button class="btn" onclick="login();">用户登录</button></td>
									<td></td>
								</tr>
							</table>
						</div>
						<?php }?>
						<?php if($action=='regist'){?>
						<!--注册-->
						<div class="form">
							<table>
								<tr>
									<td class="text-right">注册手机号:</td>
									<td><input type="text" id="phone_reg" name="phone_reg"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">验证码:</td>
									<td>
										<input style="width:200px;" type="text" id="captcha_reg" name="captcha_reg">
										<img class="v-code" id='id_img_captcha' src="/site/getcaptcha"/>
										<!-- <img class="v-code" src="images/v-code.jpg" alt="验证码图片"> -->
									</td>
									<td><a class="red" onclick="change_captcha();">换一张</a></td>
								</tr>
								<tr>
									<td class="text-right">手机验证码:</td>
									<td>
										<input style="width:200px;" type="text" name="code_reg" id="code_reg">
										<a id="btn_code1" class="v-code" onclick="get_code();">点击发送</a>
										<a id="btn_code2" class="v-code disabled hide">重新发送(59s)</a>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">输入密码:</td>
									<td><input type="password" id="password_reg" name="password_reg"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">输入真实姓名:</td>
									<td><input type="text" id="phone_reg" name="phone_reg"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">输入身份证信息:</td>
									<td><input type="text" id="phone_reg" name="phone_reg"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right"></td>
									<td>您已经有账号，请<a class="red" href="<?=Url::toRoute(['site/accountcenter','action'=>'login'])?>"> 登录</a></td>
								</tr>
								 <tr>
								   <td><input type="checkbox" id="agreed" checked="checked" style="height:14px;width:14px;margin-left:100px;"></td>
                                   <td>我已同意<a href="<?=Url::toRoute(['site/yh'])?>" style="width:240px;display:inline-block;font-size:14px;color:red;padding:10px 0;">《上海魔克游戏网通行用户服务协议》</a></td>
                                </tr>
								<tr>
									<td></td>
									<td><button class="btn" onclick="reg();">立即注册</button></td>
									<td></td>
								</tr>
							</table>
						</div>
						<?php }?>
						<?php if($action=='find_password'){?>
						<!--找回密码-->
						<div class="form">
							<table>
								<tr>
									<td class="text-right">验证方式：</td>
									<td>密保手机</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">你的账号：</td>
									<td><?=$account_name?></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">验证码：</td>
									<td>
										<input style="width:200px;" type="text" name="captcha_reset" id="captcha_reset">
										<img class="v-code" id='id_img_captcha' src="/site/getcaptcha"/>
										<!-- <img class="v-code" src="images/v-code.jpg" alt="验证码图片"> -->
									</td>
									<td><a class="red" onclick="change_reset_captcha();">换一张</a></td>
								</tr>
								<tr>
									<td class="text-right">您的手机号码：</td>
									<td><?=$account_phone?></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right"></td>
									<td>
										<!-- <button class="btn mini-btn">点击发送</button> -->
										<a id="btn_code1" class="v-code" onclick="get_reset_code();">点击发送</a>
										<a id="btn_code2" class="v-code disabled hide">重新发送(59s)</a>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">短信验证码：</td>
									<td><input type="text" id="code_reset" name="code_reset"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">新密码：</td>
									<td><input type="text" id="new_password" name="new_password"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">确认密码：</td>
									<td><input type="text" id="new_password_repeat" name="new_password_repeat"></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td><button class="btn" onclick="reset_password();">确认</button></td>
									<td></td>
								</tr>
							</table>
						</div>
						<?php }?>
						<?php if($action=='reset_password'){?>
						<!--修改密码一-->
						<div class="form">
							<table>
								<tr>
									<td class="text-right">你的账号：</td>
									<td><?=$login?></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">新密码：</td>
									<td><input type="text"></td>
									<td></td>
								</tr>
								<tr>
									<td class="text-right">确认密码：</td>
									<td><input type="text"></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td><button class="btn">确认</button></td>
									<td></td>
								</tr>
							</table>
						</div>
						<?php }?>
					<?php }?>
					
					
					
				</div>
			</div>
			<div class="left-content">
				<!--下载区块-->
				<div class="download-module">
					<div class="module-bg"></div>
					<div class="download">
						<div class="qr-code">
							<img src="/images/qr-code.jpg" alt="">
						</div>
						<div class="mobile-download">
							<a href="https://itunes.apple.com/cn/app/id1187917222?mt=8" class="ios">
								<span class="ios-icon"></span>
								APP Store下载
							</a>
							<a href="http://dl.enjoymi.com:8089/common_download/get_enjoymi_sgzj_game.html" class="android">
								<span class="android-icon"></span>
								Android 下载
							</a>
						</div>
						<div class="channel">
							关注我们：
							<a class="wechat" href="">
								<span><img src="/images/qr-code1.jpg" alt=""></span>
							</a>
							<a class="webo" href="http://weibo.com/u/6056895319"></a>
						</div>
					</div>
				</div>
				<!--活动-->
				<div class="latest-activity">
					<a href="<?=$three_pic[0]->short?>">
					<div class="activity activity_01" style="background: #fff url(<?=$three_pic[0]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
					<a href="<?=$three_pic[1]->short?>">
					<div class="activity activity_02" style="background: #fff url(<?=$three_pic[1]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
					<a href="<?=$three_pic[2]->short?>">
					<div class="activity activity_03" style="background: #fff url(<?=$three_pic[2]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
				</div>
			</div>
		</div>

		
		<div class="mark" id="mark" style="display:none;"></div>
		<!--弹窗-->
		<div class="pop-wrap" id="pop-wrap" style="display:none;">
			<div class="pop-header">
				<span class="close">&times;</span>
				提示信息
			</div>
			<div class="pop-body">
				<div class="content-box">
					<div class="" id='popstr' name='popstr'>密码设置成功</div>
				</div>
			</div>
			<div class="pop-footer">
				<button onclick="popup_close();">确定</button>
			</div>
		</div>

		<script type="text/javascript">
			var pop_url = null;
			function popup_show(str){
				document.getElementById('popstr').innerHTML = str;
				document.getElementById("mark").style.display="block";
				document.getElementById("pop-wrap").style.display="block";
			}

			function popup_close(){
				document.getElementById("mark").style.display="none";
				document.getElementById("pop-wrap").style.display="none";
				if(pop_url){
					window.location.href=pop_url;
				}
			}
            // new Clipboard('.btn');
            function change_captcha(){
            	var timestamp = new Date().getTime();  
                $('#id_img_captcha').attr("src", "/site/getcaptcha" + '?'+ timestamp);
            }

            function change_reset_captcha(){
            	var timestamp = new Date().getTime();  
                $('#id_img_captcha').attr("src", "/site/getcaptcha" + '?'+ timestamp);
            }

            // $(".tab span").click(function(){
            //         $(".tab span").removeClass("active");
            //         $(this).addClass("active");
            //         $(".tab-box").addClass("hide");
            //         $(".tab-box").eq($(".tab span").index($(this))).removeClass("hide");
            // })

            // function copy_gift(){
            //     var e=document.getElementById("gift_input");//对象是content 
            //     // e.select(); //选择对象 
            //     // document.execCommand("Copy"); //执行浏览器复制命令

            //     window.clipboardData.setData("Text",e.value);
            //     popup_show("复制成功"); 
            // }

            // function show_gift(code){
            //     $("#gift").removeClass("hide");
            //     $("#login_div").addClass("hide");
            //     document.getElementById("gift_input").value=code;
            // }

            function get_error_msg(error_code){
                var error_msg=new Array();
                error_msg[-1]="未知错误";
                error_msg[0]="成功";
                error_msg[1]="账号重复";
                error_msg[2]="生成账号失败";
                error_msg[3]="账号或密码无效";
                error_msg[4]="账号不存在";
                error_msg[21]="手机号重复";
                error_msg[22]="已绑定手机号";
                error_msg[23]="短信验证码无效";
                error_msg[24]="未绑定手机号";
                error_msg[31]="邮箱重复";
                error_msg[32]="已绑定邮箱";
                error_msg[41]="图形验证码无效";
                if(error_msg[error_code]){
                    return error_msg[error_code];
                }else{
                    return "未知错误";
                }
            }

            function settime(countdown) {
                if (countdown == 0) { 
                    $("#btn_code1").removeClass("hide");
                    $("#btn_code1").removeClass("disabled");
                    $("#btn_code2").addClass("hide");
                    $("#btn_code2").addClass("disabled");
                    countdown = 60; 
                } else { 
                    $("#btn_code2").html("重新发送(" + countdown + ")"); 
                    countdown--;
                    setTimeout(function() { 
                        settime(countdown) 
                    },1000)
                }
            }

            function get_code(){
                var phone = document.getElementById("phone_reg").value;
                var captcha = document.getElementById("captcha_reg").value;
                if(!phone){
                    popup_show("请输入手机号");
                    pop_url = null;
                    return;
                }
                if(!captcha){
                    popup_show("请输入验证码");
                    pop_url = null;
                    return;
                }
                $.ajax({
                    type: "GET",
                    url: "/site/sendcode",
                    dataType: 'json',
                    data: "phone_number="+phone+"&captcha_text="+captcha,
                    success: function(data){
                        if(data.result.error_code == 0){
                            $("#btn_code2").removeClass("hide");
                            $("#btn_code2").removeClass("disabled");
                            $("#btn_code1").addClass("hide");
                            $("#btn_code1").addClass("disabled");
                            settime(60);
                            popup_show("验证码已发送，请查收");
                            pop_url = null;
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url = null;
                            var t = new Date().getTime();  
                            $('#id_img_captcha').attr("src", "/site/getcaptcha" + '?'+ t);
                        }
                    }
                });
            }

            function get_reset_code(){
                var account = '<?=$account_name?>';
                var captcha = document.getElementById("captcha_reset").value;
                if(!captcha){
                    popup_show("请输入验证码");
                    pop_url = null;
                    return;
                }
                $.ajax({
                    type: "GET",
                    url: "/site/sendresetcode",
                    dataType: 'json',
                    data: "account="+account+"&captcha_text="+captcha,
                    success: function(data){
                        if(data.result.error_code == 0){
                            $("#btn_code2").removeClass("hide");
                            $("#btn_code2").removeClass("disabled");
                            $("#btn_code1").addClass("hide");
                            $("#btn_code1").addClass("disabled");
                            settime(60);
                            popup_show("验证码已发送，请查收");
                            pop_url = null;
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url = null;
                            var t = new Date().getTime();  
                            $('#id_img_captcha').attr("src", "/site/getcaptcha" + '?'+ t);
                        }
                    }
                });
            }

            function reset_password(){
                var account = '<?=$account_name?>';
                var code = document.getElementById("code_reset").value;
                var new_password = document.getElementById("new_password").value;
                var new_password_repeat = document.getElementById("new_password_repeat").value;
                if(new_password!=new_password_repeat){
                	popup_show("两次输入的密码不相同！");
                	pop_url = null;
                	return;
                }
                $.ajax({
                    type: "GET",
                    url: "/site/resetpassword",
                    dataType: 'json',
                    data: "account="+account+"&password="+new_password+"&message_code="+code,
                    success: function(data){
                        if(data.result.error_code==0){
                            popup_show('密码修改成功！');
                            pop_url = "/site/accountcenter";
                        	//window.location.href="/site/accountcenter";
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url = null;
                        }
                    }
                });
            }



            function reg(){
                var phone = document.getElementById("phone_reg").value;
                var code = document.getElementById("code_reg").value;
                var password = document.getElementById("password_reg").value;
                $.ajax({
                    type: "GET",
                    url: "/site/reg",
                    dataType: 'json',
                    data: "phone_number="+phone+"&password="+password+"&message_code="+code,
                    success: function(data){
                        if(data.result.error_code==0){
                            popup_show('注册成功！');
                        	// window.location.href="/site/accountcenter";
                        	pop_url = "/site/accountcenter";
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url = null;
                        }
                    }
                });
            }

            function find_password(){
                var phone = document.getElementById("phone_login").value;
                $.ajax({
                    type: "GET",
                    url: "/site/findpassword",
                    dataType: 'json',
                    data: "account="+phone,
                    success: function(data){
                        if(data.result.error_code==0){
                        	var account = data.result.account;
                        	var phone_num = data.result.mobile_phone;
                        	window.location.href="/site/accountcenter?action=find_password&account="+account;
                            //success
                        }else{
                            popup_show("请输入正确的账号");
                            pop_url=null;
                        }
                    }
                });
            }

            function login(){
                var phone = document.getElementById("phone_login").value;
                var password = document.getElementById("password_login").value;
                $.ajax({
                    type: "GET",
                    url: "/site/login",
                    dataType: 'json',
                    data: "account="+phone+"&password="+password,
                    success: function(data){
                        if(data.result.error_code==0){
                        	popup_show('登陆成功！');
                        	pop_url = "/site/accountcenter";
                        	// window.location.href="/site/accountcenter";
                            //success
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url=null;
                        }
                    }
                });
            }

            function logout(){
                $.ajax({
                    type: "GET",
                    url: "/site/logout",
                    dataType: 'json',
                    data: "",
                    success: function(data){
                        if(data.result.error_code==0){
                        	popup_show('登出成功！');
                        	// window.location.href="/site/accountcenter";
                        	pop_url="/site/accountcenter";
                            //success
                        }else{
                            popup_show(get_error_msg(data.result.error_code));
                            pop_url=null;
                        }
                    }
                });
            }
        </script>