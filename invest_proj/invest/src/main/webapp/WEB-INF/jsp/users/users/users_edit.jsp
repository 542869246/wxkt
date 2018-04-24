<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<!-- <link rel="stylesheet" href="static/ace/css/datepicker.css" /> -->
<link rel="stylesheet" href="static/layui-v2.2.45/layui/css/layui.css">
<!-- Tab切换的样式 -->
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

.layui-form-item .layui-form-checkbox[lay-skin=primary] {
	margin-top: 0px;
	margin-right: 5px;
}

.layui-form-item .layui-form-checkbox {
	margin-top: 0px;
}

.layui-form-checkbox[lay-skin=primary] {
	margin-left: 15px;
}
.layui-form-select dl {
    width: 25%;
        min-width: 25%;
}
.layui-input, .layui-textarea {
    width:25%;
}
.layui-form-select dl dd.layui-this {
    background-color: #76ACCD;
}
.layui-form-checked[lay-skin=primary] i {
    border-color: #76ACCD;
    background-color:#76ACCD;
}
.layui-form-select .layui-edge {
    left: 195px;
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

							<form action="users/${msg }.do" name="Form" id="Form"
								method="post" class="layui-form">
								<input type="hidden" name="USERS_ID" id="USERS_ID"
									value="${pd.USERS_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 130px; text-align: right; padding-top: 13px;" class="bitianxiang">用户姓名:</td>
											<td><input type="text" name="USERS_NAME" id="USERS_NAME"
												value="${pd.USERS_NAME}" maxlength="18"
												placeholder="这里输入用户姓名" title="用户姓名" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">手机号码:</td>
											<td><input type="text" name="USERS_PHONE"
												id="USERS_PHONE" value="${pd.USERS_PHONE}" maxlength="18"
												placeholder="这里输入手机号码" title="手机号码" style="width: 98%;"
												readonly /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">头像:</td>
											<td align="left"><img src="${pd.USERS_PHOTO}"
												class="center-block" width="50" height="50"
												onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null"
												alt="pic" /> <input type="hidden" name="USERS_PHOTO"
												id="USERS_PHOTO" value="${pd.USERS_PHOTO }" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">实时查看权限:</td>
											<td><select id="USERS_WHETHER" name="USERS_WHETHER" lay-filter='zyf_select'>
													<option value="0"
														<c:if test="${pd.USERS_WHETHER==0 }">selected</c:if>>默认</option>
													<option value="1"
														<c:if test="${pd.USERS_WHETHER==1 }">selected</c:if>>永久</option>
													<option value="2"
														<c:if test="${pd.USERS_WHETHER==2 }">selected</c:if>>临时</option>
											</select></td>
										</tr>
										<tr display="none" id="classroomDisplay">
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">选择实时教室:</td>
											<td>
												<div class="layui-form-item">
													<div class="layui-input-block"
														style='margin-left: 0; width: 80%;'>
															<c:forEach items="${classroomList }" var="var"
																varStatus="stat">
																<input type="checkbox" lay-skin="primary"
																	name="users_classroom" class="users_classroom"
																	value="${var.CLASSROOM_ID }"
																	<c:forEach items="${rooms }" var="room"><c:if test="${var.CLASSROOM_ID==room }">checked</c:if></c:forEach> />${var.CLASSROOM_NAME }												
																	<c:if test="${stat.index%6==0 &&stat.index != 0}">
																		<br />
																	</c:if>
															</c:forEach>
													</div>
												</div> <input type="hidden" name="USERS_CLASSROOM"
												id="USERS_CLASSROOM" />
											</td>
										</tr>
										<tr class="timeDisplay" style="display: none">

											<td
												style="width: 75px; text-align: right; padding-top: 13px;">实时查看开始时间</td>
											<td><input
												class="span10 date-picker checkTeacherAddClassroom"
												name="USERS_STARTTIME" id="USERS_STARTTIME"
												value='<fmt:formatDate value="${pd.USERS_STARTTIME}" pattern="yyyy-MM-dd HH:mm:ss" />'
												type="text" data-date-format="yyyy-mm-dd" placeholder="开始时间"
												title="开始时间" style="width: 25%;" /></td>
										</tr>
										<tr class="timeDisplay" style="display: none">
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">实时查看结束时间</td>
											<td><input
												class="span10 date-picker checkTeacherAddClassroom"
												name="USERS_ENDTIME" id="USERS_ENDTIME"
												value='<fmt:formatDate value="${pd.USERS_ENDTIME}" pattern="yyyy-MM-dd HH:mm:ss" />'
												type="text" data-date-format="yyyy-mm-dd" placeholder="结束时间"
												title="结束时间" style="width: 25%;" /></td>
										</tr>
										<tr>
											<td style="width: 75px; text-align: right; padding-top: 13px;">是不是教师</td>
											<td>
												<input type="text"
												id="NAME" maxlength="18" value="${pd.NAME }"
												placeholder="请选择教师" title="选择教师" style="width: 20%;"
												readonly />
												<input type="hidden" id="USER_ID" name="USER_ID" value="${pd.USER_ID }"/>
												<a id="usesid_clear" style="cursor:pointer;color:#76ACCD;">清空</a>
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
	<c:if test="${pd.USERS_ID!=null}">
		<div
			style="height: 29px; width: 98%; margin: 0px auto; border-bottom: 1px solid #4F99C6; padding-left: 5px;">
			<button class="mytab active"
				onclick="javascript:mytab.active(this,mytab.usersChilds);">家长的小孩</button>
			<!-- <button class="mytab" 
			onclick="mytab.active(this,mytab.usersToActivity);">参加的活动</button> -->
		</div>
		<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no
			width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
	</c:if>

	<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<!-- <script src="static/ace/js/date-time/bootstrap-datepicker.js"></script> -->
	<script src="static/ace/js/laydate/laydate.js"></script>
	<script type="text/javascript"
		src="static/layui-v2.2.45/layui/layui.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script>
		//执行一个laydate实例
		laydate.render({
			elem : '#USERS_STARTTIME'
			,type: 'datetime'
				,theme: '#76ACCD',
				min: 0,
				max: 365
		});
		laydate.render({
			elem : '#USERS_ENDTIME'
			,type: 'datetime'
				,theme: '#76ACCD',
				min: 0,
				max: 365
		});
		
	</script>
	<script type="text/javascript">
		
		layui.use('form', function() {
			var form = layui.form;
			//下拉框时的判断
			form.on('select(zyf_select)', function(data){
				if(data.value=='1'){
					$("#classroomDisplay").show();
					$(".timeDisplay").hide();
					$("input:checkbox").attr("checked",false);
					$(".layui-form-checkbox").removeClass("layui-form-checked");
				}else if(data.value=='2'){
					$(".timeDisplay").show();
					$("#classroomDisplay").show();
					$("#USERS_STARTTIME").val("");
					$("#USERS_ENDTIME").val("");
				}else{
					$(".timeDisplay").hide();
					$("#classroomDisplay").hide();
				} 
			});
		});
		//选择老师
		$("#NAME").click(function(){
			searchTeacher();
		});
		//清空是否是老师的框
		$("#usesid_clear").click(function(){
			$("#NAME").val("");
			$("#USER_ID").val("");
		});
		$(top.hangge());
		//保存
		function save(){
			/* if($("#USERS_NAME").val()==""){
				$("#USERS_NAME").tips({
					side:3,
		            msg:'请输入用户姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERS_NAME").focus();
			return false;
			} */
			if($("#USERS_PHONE").val()==""){
				$("#USERS_PHONE").tips({
					side:3,
		            msg:'请输入手机号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERS_PHONE").focus();
			return false;
			}
			if($("#USERS_WHETHER").val()=="1"){
				if($("input:checkbox:checked").length<1){
					$("#classroomDisplay").tips({
						side:3,
			            msg:'请选择教室',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#USERS_WHETHER").focus();
				return false;
				}
			}
			if($("#USERS_WHETHER").val()=="2"){
				if($("input:checkbox:checked").length<1){
					$("#classroomDisplay").tips({
						side:3,
			            msg:'请选择教室',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#USERS_WHETHER").focus();
				return false;
				}
				if($("#USERS_STARTTIME").val()==""){
					$("#USERS_STARTTIME").tips({
						side:3,
			            msg:'请输入开始时间',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#USERS_STARTTIME").focus();
				return false;
				}
				if($("#USERS_ENDTIME").val()==""){
					$("#USERS_ENDTIME").tips({
						side:3,
			            msg:'请输入结束时间',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#USERS_ENDTIME").focus();
				return false;
				}
			}
			
			if($("#USERS_OPENID").val()==""){
				$("#USERS_OPENID").tips({
					side:3,
		            msg:'请输入微信openID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERS_OPENID").focus();
			return false;
			}
			if($("#USERS_ISMEMBER").val()==""){
				$("#USERS_ISMEMBER").tips({
					side:3,
		            msg:'请输入是否会员',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERS_ISMEMBER").focus();
			return false;
			}
			//循环获取选择的教室  拼接到字符串中
			var users_str="";
			var users_classroom=$("input:checkbox:checked");
			
			for(var i=0;i<users_classroom.length;i++){
				users_str+= users_classroom[i].value+",";
			}
			$("#USERS_CLASSROOM").val(users_str);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			
			
			//修改 选择实时查看状态时的判断  为1和2时选择教室   为2时可以选择时间
			if($("#USERS_WHETHER").val()=='1'){
				$("#classroomDisplay").show();
				$(".timeDisplay").hide();
			}else if($("#USERS_WHETHER").val()=='2'){
				$(".timeDisplay").show();
				$("#classroomDisplay").show();
			}else{
				$(".timeDisplay").hide();
				$("#classroomDisplay").hide();
			}
			
			/* $(".layui-unselect").change(function(){
				
			}); */
			/* //日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true}); */
		});
		
		//选择老师事件   弹出老师列表进行选择
		function searchTeacher(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>user/listUsers.do?is_show=searchTeacherByUsers';
			 diag.Width = 1050;
			 diag.Height = 1500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						// setTimeout("self.location=self.location",100);
						 $("#Form").submit();
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				$("#USER_ID").val(diag.innerFrame.contentWindow.document.getElementById('userid').value);
				$("#NAME").val(diag.innerFrame.contentWindow.document.getElementById('username').value);
				if(diag.innerFrame.contentWindow.document.getElementById('username').value!=""){
					$("#USERS_NAME").val(diag.innerFrame.contentWindow.document.getElementById('username').value);
				}
				diag.close();
			 };
			 diag.show();
		};
		
		
		//页面tab初始化
		$(document).ready(function(){
			$(".active").click();
		});
		var mytab = {
				usersChilds:"<%=basePath%>webuser/list.do?USERS_ID=${pd.USERS_ID}",
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