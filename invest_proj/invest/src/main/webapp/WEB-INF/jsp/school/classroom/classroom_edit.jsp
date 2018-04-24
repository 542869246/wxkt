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
	<!-- Tab切换的样式 -->	
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
					
					<form action="classroom/${msg }.do" name="Form" id="Form" method="post" class="layui-form1">
						<input type="hidden" name="CLASSROOM_ID" id="CLASSROOM_ID" value="${pd.CLASSROOM_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">腾讯摄像头序列号:</td>
								<td><input type="text" name="TENCETLIVEKEY" id="TENCETLIVEKEY" value="${pd.TENCETLIVEKEY}" maxlength="32" placeholder="腾讯摄像头序列号" title="腾讯摄像头序列号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">亲加直播房间号:</td>
								<td><input type="text" name="CLASSROOM_ROOMID" id="CLASSROOM_ROOMID" value="${pd.CLASSROOM_ROOMID}" maxlength="32" placeholder="亲加直播房间号" title="直播房间号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">教室名称:</td>
								<td><input type="text" name="CLASSROOM_NAME" id="CLASSROOM_NAME" value="${pd.CLASSROOM_NAME}" maxlength="32" placeholder="这里输入教室名称" title="教室名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">教室图片:</td>
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
								<td style="width:75px;text-align: right;padding-top: 13px;">教室位置:</td>
								<td><input type="text" name="CLASSROOM_LOC" id="CLASSROOM_LOC" value="${pd.CLASSROOM_LOC}" maxlength="32" placeholder="这里输入教室位置" title="教室位置" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">直播密码:</td>
								<td><input type="text" name="BACKSTAGE_PASSWORD" id="BACKSTAGE_PASSWORD" value="${pd.BACKSTAGE_PASSWORD}" maxlength="30" placeholder="这里输入直播密码" title="直播密码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">使用类型选择</td>
								<td><input type="radio" name="CHECK_TYPE" value="0" <c:if test="${pd.CHECK_TYPE==0 }">checked</c:if>>亲加直播 <input type="radio" name="CHECK_TYPE" value="1" <c:if test="${pd.CHECK_TYPE==1 }">checked</c:if>>腾讯直播</td>
							</tr>
							<c:if test="${msg == 'edit' }">
							<tr>
								<%-- <td style="width:75px;text-align: right;padding-top: 13px;">是否关闭直播</td>
								<td>
									<input type="checkbox" name="ISNOTSTATUS" id="ISNOTSTATUS" value="1" <c:if test="${pd.ISNOTSTATUS==1 }">checked</c:if> />&nbsp;&nbsp;&nbsp;<span id="on_off">已关闭</span>
								</td> --%>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否关闭直播</td>
								<td> <input type="radio" name="ISNOTSTATUS" value="0" <c:if test="${pd.ISNOTSTATUS==0 }">checked</c:if>>已开启<input type="radio" name="ISNOTSTATUS" value="1" <c:if test="${pd.ISNOTSTATUS==1 }">checked</c:if>>已关闭</td>
							</tr>
							</c:if>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">腾讯账号选择:</td>
								<td>
												<select name="CHANNELID" id="CHANNELID" onchange='btnChange(this[selectedIndex].value,this[selectedIndex].text);'>
													<option value="0">请选择</option>
													<c:forEach items="${diclist}" var="dic">
														<option value=${dic.BIANMA} <c:if test="${pd.CHANNELID==dic.BIANMA}">selected="selected"</c:if>>${dic.NAME}</option>
													</c:forEach>
												</select>
											</td>
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
<c:if test="${pd.CLASSROOM_ID!=null}">
	<div style="height: 29px;width: 98%;margin:0px auto;border-bottom: 1px solid #4F99C6;padding-left:5px;">
		<button class="mytab active" 
			onclick="javascript:mytab.active(this,mytab.classroom_sche);">此教室的课表</button>
	</div>
	<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
</c:if>

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
			
			
			if($("#CLASSROOM_NAME").val()==""){
				$("#CLASSROOM_NAME").tips({
					side:3,
		            msg:'请输入教室名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CLASSROOM_NAME").focus();
			return false;
			}
			/* if($("#IMG_ID").val()==""){
				$("#IMG_ID").tips({
					side:3,
		            msg:'请输入教室图片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IMG_ID").focus();
			return false;
			} */
			if($("#BACKSTAGE_PASSWORD").val()==""){
				$("#BACKSTAGE_PASSWORD").tips({
					side:3,
		            msg:'请输入直播密码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BACKSTAGE_PASSWORD").focus();
			return false;
			}
			var nodes=$("[name='CHECK_TYPE']:checked");
			if(nodes.length==0){
				$("#BACKSTAGE_PASSWORD").tips({
					side:3,
		            msg:'请选择直播类型',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			var list= $('input:radio[name="CHECK_TYPE"]:checked').val();
			if(list==0){
				if($("#CLASSROOM_ROOMID").val()==""){
					$("#CLASSROOM_ROOMID").tips({
						side:3,
			            msg:'请输入亲加直播房间号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#CLASSROOM_ROOMID").focus();
				return false;
				}
			}else if(list=="1"){
				if("${key}"==null||"${bizid}"==null){
					alert("请输入正确腾讯直播推流防盗链接和腾讯直播bizid");
				return false;
				}
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
		/* 	//直播是否关闭的状态控制
			$("#ISNOTSTATUS").change(function(){
				if($(this).is(':checked')==true){
					$("#on_off").html("已关闭");
				}else{
					$("#on_off").html("已开启");
				}
			});
			
			if(${pd.ISNOTSTATUS==0}){
				$("#on_off").html("已开启");
			}else{
				$("#on_off").html("已关闭");
			} */
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//页面tab初始化
		$(document).ready(function(){
			$(".active").click();
		});
		var mytab = {
				classroom_sche:"<%=basePath%>schedule/list.do?CLASSROOM_ID=${pd.CLASSROOM_ID}",
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
	<script type="text/javascript" src="plugins/imguploader/js/uploadClassroom.js"></script>
</body>
</html>