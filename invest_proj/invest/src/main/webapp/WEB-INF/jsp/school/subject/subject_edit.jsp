<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />

<link rel="stylesheet" href="static/js/bootstrap-colorpicker.css" />
<style type="text/css">
.mytab {
	border: 0;
	width: 90pt;
	height: 28px;
	line-height: 28px;
	background-color: #eef0ee;
	white-space: nowrap;
	z-index: 101;
	outline: 0;
}

.active {
	background-color: #438eb9;
	color: #fff;
}
</style>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<form action="subject/${msg }.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID"
									value="${pd.SUBJECT_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">科目名称:</td>
											<td><input type="text" name="SUBJECT_NAME"
												id="SUBJECT_NAME" value="${pd.SUBJECT_NAME}" maxlength="50"
												placeholder="这里输入科目名称" title="科目名称" style="width: 10%;text-align: center;background-color: ${pd.SUBJECT_COLOR}" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">选择颜色:
											</td>
											<td style="ovarflow: hidden;">
												<!-- <input id="SUBJECT_COLOR" name="SUBJECT_COLOR" type="text" class="form-control"
												style="float: left; width: 80%;" /> 
												<span id="mycp"
												style="margin-left:10px;float: left; border: 1px solid #d5d5d5; display: inline-block; height: 34px; width: 34px;">
											</span> -->

												<div class="input-append color"
													data-color="rgb(255, 146, 180)" data-color-format="rgb">
													<input type="text" id="SUBJECT_COLOR" name="SUBJECT_COLOR"
														class="span2" value="">
													<!-- add-on 后缀 -->
													<span class="add-on" style=""><i id="color_change"
														style=""></span>
												</div>


											</td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
												class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
							</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- tab 切换选项卡 -->
	<c:if test="${pd.SUBJECT_ID!=null}">
		<div
			style="height: 29px; width: 98%; margin: 0px auto; border-bottom: 1px solid #4F99C6; padding-left: 5px;">
			<button class="mytab active"
				onclick="javascript:mytab.active(this,mytab.subjectUser);">科目下的老师</button>
			<!-- <button class="mytab" 
			onclick="mytab.active(this,mytab.usersToActivity);">参加的活动</button> -->
		</div>
		<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no
			width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
	</c:if>

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#SUBJECT_NAME").val()==""){
				$("#SUBJECT_NAME").tips({
					side:3,
		            msg:'请输入科目名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBJECT_NAME").focus();
			return false;
			}
			
			if($("#SUBJECT_NAME").val()!=""){
				var flag=true;
				
				if($("#SUBJECT_NAME").val()!="${pd.SUBJECT_NAME}"){
					$.ajax({
						url:'${pageContext.request.contextPath}/subject/findSubject',
						dataType:'json',
						type:'post',
						data:{'SUBJECT_NAME':$("#SUBJECT_NAME").val()},
						async:false,
						success:function(msg){
								if(msg.count>0){
									$("#SUBJECT_NAME").tips({
										side:3,
							            msg:'科目名称已存在',
							            bg:'#AE81FF',
							            time:2
							        });
									$("#SUBJECT_NAME").focus();
									flag= false;
							}
						}
					})
				}
				
			if(!flag){
				return false;
			}
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		$(function() {
		
			 // 配置颜色选择器
			    $('.color').colorpicker({
			        // 格式，十六进制
			        format : "hex"
			    });
			    // 触发事件，当颜色选择器的颜色改变时，body的背景颜色也改变
			    $(".color").on("changeColor", function (e) {
			        //$("#SUBJECT_COLOR")[0].style.backgroundColor = e.color.toHex();
			        $("#SUBJECT_NAME")[0].style.backgroundColor = "#"+e.color.toHex();
			    });
			    
			    $("#SUBJECT_COLOR").val('${pd.SUBJECT_COLOR }');
				$("#color_change").css("background-color","${pd.SUBJECT_COLOR}");
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
				
		});
		
		$(document).ready(function(){
			//Tab初始化
			$(".active").click();
		});
		
		var mytab = {
				subjectUser:"<%=basePath%>subject_teacher/list.do?SUBJECT_ID=${pd.SUBJECT_ID}",
				<%-- usersToActivity:"<%=basePath%>takein/list.do?USERS_ID=${pd.USERS_ID}", --%>
				active:function(dom,param){
					if(!dom||!param||$.trim(param)==""){
						return;
					}
					$("#myFrame").prop("src",param);
					$(".active").removeClass("active");
					$(dom).addClass("active");
				}
		};
		
		/**iframe高度根据内容自适应*/
		function iFrameHeight() { 
			var ifm= document.getElementById("myFrame"); 
			var subWeb = document.frames ? document.frames["myFrame"].document : ifm.contentDocument; 
			if(ifm != null && subWeb != null) { 
				ifm.height = subWeb.body.scrollHeight; 
			} 
		};
		
		</script>
</body>
</html>