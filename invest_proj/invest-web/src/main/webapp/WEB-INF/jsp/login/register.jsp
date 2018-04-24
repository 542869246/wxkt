<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="static/js/simpleAlert.js"></script>
		<link rel="stylesheet" href="static/css/paging.css" />
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/simpleAlert.css" />
		<style type="text/css">
			#code{
				    width: 0.8rem;
				    height: 0.8rem;
				    position: absolute;
				    right: 4.25rem;
    				top: 0.30rem;
				    display: block;
			}
		</style>
		<title>用户注册</title>
	</head>
	<body>
		<div class="wrapper">
			<div class="forgot_password">
				<p>
					<input type="text" placeholder="请输入手机号" maxlength="11" name="phone" />
					<a class="clean" href="javascript:;"></a>
				</p>
				<p>
					<input type="text" placeholder="请输入短信验证码" maxlength="11" name="dxyzm" />
					<a class="getCode" onclick="getdx()">获取验证码</a>
				</p>
				<p>
					<input type="text" placeholder="请输入验证码" maxlength="11" name="code" style="width:9.5rem"/>
					<a id="code" onclick="getcode()" style="right:3.8rem;"><img src="index/getCode" style="display: inline;" width="80" height="35"></a>
				</p>
				<a class="enter" onclick="reg()" style="width: 14.75rem;">绑定</a>
			</div>
		</div>
		<script>
		
			//确定按钮点击事件
			//$(".enter").on("click",function(){});
			function reg(){
				var phone=$.trim($("input[name='phone']").val());
				var dx=$.trim($("input[name='dxyzm']").val());
				var code=$.trim($("input[name='code']").val());
				if(phone==""){
				  var onlyChoseAlert = simpleAlert({
	                    "content":"手机号码不能为空!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
				  return ;
				}else if(dx==""){
					 var onlyChoseAlert = simpleAlert({
	                    "content":"请输入短信验证码!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
				  return ;
				}else if(code==""){
					 var onlyChoseAlert = simpleAlert({
	                    "content":"请输入图形验证码!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
				  return ;
				}
				var rdata="";
				$.ajaxSetup({ async : false });    
				$.get("index/validateCode",function(data){
					rdata=data.toLowerCase();
				});
				if(rdata==""||rdata != code){
	                var onlyChoseAlert = simpleAlert({
	                    "content":"图形验证码错误!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
	                return;
				}
				var cfg={
					url:'userinfo/register',
					data:{
						USER_PHONE:phone,
						dxyzm:dx,
					}
				}
				var baseDao = new BaseDao(cfg);
				var rdata = baseDao.getResponseData();
				console.info(rdata);
				if(rdata.msg=="ok"){
					open("index/toindex","_self");
				}else{
				 var onlyChoseAlert = simpleAlert({
	                    "content":"短信验证码错误!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })					
				}
			}
			
			
			//获取图形验证码
			//$("#code").on("click",function(){});
			function getcode(){
				$('#code img').attr('src','index/getCode?abc='+Math.random());
			}
			var flag=true;
			//获取短信验证码
			//$('.getCode').click(function(){});
			function getdx(){
	            var phone=$.trim($("input[name='phone']").val());
				if(phone==""){
				  var onlyChoseAlert = simpleAlert({
	                    "content":"请输入手机号码!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
				  return ;
				}
				if(flag){
					flag=!flag;
		            var btn = $(".getCode");  
		            var count = 60;  
		            var resend = setInterval(function(){  
		                count--;  
		                if (count > 0){
		                	btn.addClass("cd")
		                    btn.text(count+"秒");
		                }else {  
		                    clearInterval(resend); 
		                    btn.text("获取验证码").removeClass("cd");  
		                    flag=!flag;
		                }  
		            }, 1000); 

					$.get("validation/save",{VALIDATION_PHONE:phone},function(rdata){
						//console.info(rdata);
						if(rdata.msg!="ok"){
							var onlyChoseAlert = simpleAlert({
			                    "content":rdata.msg,
			                    "buttons":{
			                        "确定":function () {
			                            onlyChoseAlert.close();
			                        }
			                    }
			                })
						}
					});
	            }
	        }
		</script>
	</body>
</html>