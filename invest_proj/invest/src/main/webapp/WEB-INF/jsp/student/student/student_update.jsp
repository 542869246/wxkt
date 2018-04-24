<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="plugins/imguploader/tool/webuploader/webuploader.css">
	
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	
	<style type="text/css">
		.mytab{
			    border: 0;
			    width: 90pt;
			    height: 28px;
			    line-height: 28px;
			    background-color: #eef0ee;
			    white-space: nowrap;
			    z-index: 101;
			    outline: 0;
			}
		.active{
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
					
					<form action="student/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="STUDENT_ID" id="STUDENT_ID" value="${pd.STUDENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">学生姓名:</td>
								<td><input type="text" name="STUDENT_NAME" id="STUDENT_NAME" value="${pd.STUDENT_NAME}" maxlength="32" placeholder="这里输入学生姓名" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">手机号:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" placeholder="这里输入手机号" title="手机号" style="width:98%;" maxlength="11"   oninput="value=value.replace(/[^\d]/g,'')"
					onkeyup="value=value.replace(/[^\d]/g,'')"
					onkeydown="value=value.replace(/[^\d]/g,'')" /></td>
							</tr>
							<tr>
								<td style="width: 75px; text-align: right; padding-top: 13px;">头像:</td>
								<td>
									<div id="uploader-demo">
									<!--用来存放item-->
									<div id="filePicker" style="float: left;" class="uploader-list fileList webuploader-container">选择图片</div>
									</div>
									<div id='zmy' align="left">
											<c:if test="${pd.IMG_SRC!=null}">
												<img src="<%=basePath%>${pd.IMG_SRC}" class="center-block" width="50" height="50" onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null" alt="pic" />
											</c:if>
									</div> 
									<!-- 选择图片  上传活动 --> 
									<input type="hidden" name="IMG_SRC" id="IMG_SRC" value="${pd.IMG_SRC}" />
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">描述:</td>
								<td><input type="text" name="STUDENT_COMMENTS" id="STUDENT_COMMENTS" value="${pd.STUDENT_COMMENTS}" maxlength="100" placeholder="这里输入描述" title="描述" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
<c:if test="${pd.whereTo!=null && pd.whereTo!='' || pd.STUDENT_ID!=null}">
	<div style="height: 29px;width: 98%;margin:0px auto;border-bottom: 1px solid #4F99C6;padding-left:5px;">
		<button class="mytab active" 
			onclick="javascript:mytab.active(this,mytab.productMation);">今日学习</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productZiliao);">能力积分值</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productNews);">学生的课程</button>
			<button class="mytab" 
			onclick="mytab.active(this,mytab.studentparents);">学生的家长</button>
	</div>
	<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
</c:if>
<!-- /.main-container -->
<!-- 产品联动 -->
	 <script type="text/javascript" src="static/js/njms.area.1.1.js"></script> 
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			
			if($("#STUDENT_NAME").val()==""){
				$("#STUDENT_NAME").tips({
					side:3,
		            msg:'请输入学生姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDENT_NAME").focus();
			return false;
			}
			//判断手机号的正确格式
			 if($("#PHONE").val()!=''){
				if (!(/^1[3|4|5|7|8][0-9]{9}$/.test($("#PHONE").val()))) {
					$("#PHONE").tips({
							side:3,
			           		msg:'请输入正确的手机号',
			           	 	bg:'#AE81FF',
			           	 	time:2
						});
						$("#PHONE").val("");
						$("#PHONE").focus();
						return false;
					}
			 }
			/* if($("#IMG_SRC").val()==""){
				$("#IMG_SRC").tips({
					side:3,
		            msg:'请上传头像',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMG_SRC").focus();
			return false;
			}  */
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//页面tab初始化
		$(document).ready(function(){
			$(".active").click();
		});
		var mytab = {
				
				productMation:"<%=basePath%>/webschedule/list.do?STUDENT_ID=${pd.STUDENT_ID}&COURSES_ID=${pd.COURSES_ID}",
				productZiliao:"<%=basePath%>/ability/list.do?STUDENT_ID=${pd.STUDENT_ID}",
				productNews:"<%=basePath%>/arrange/list.do?STUDENT_ID=${pd.STUDENT_ID}",
				studentparents:"<%=basePath%>/webuser/list.do?STUDENT_ID=${pd.STUDENT_ID}",
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
	<!-- 图片上传 js-->
	<script type="text/javascript" src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/imguploader/js/uploadStudent.js"></script>
</body>
</html>