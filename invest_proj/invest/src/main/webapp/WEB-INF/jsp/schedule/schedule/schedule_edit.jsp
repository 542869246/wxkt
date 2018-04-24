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
<!-- <link rel="stylesheet" href="static/ace/css/datepicker.css" /> -->
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
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
							<form action="schedule/${msg }.do" name="Form" id="Form"
								class='layui-form' method="post">
								<input type="hidden" name="LESSONS_ID" id="LESSONS_ID"
									value="${pd.LESSONS_ID}" />
									<input type="hidden" name="LESSON_STARTTIME" id="LESSON_STARTTIME"
									value="${pd.LESSON_STARTTIME}" />
									<input type="hidden" name="LESSON_ENDTIME" id="LESSON_ENDTIME"
									value="${pd.LESSON_ENDTIME}" />
									<input type="hidden" name="COURSE_ID" id="COURSE_ID"
									value="${pd.COURSE_ID}" />
									<input type="hidden" name="LESSON_TIME_TYPE" id="LESSON_TIME_TYPE"
									value="${pd.LESSON_TIME_TYPE}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<%-- <tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">开始时间:</td>
											<td><input class="span10 date-picker checkTeacherAddClassroom"
												name="LESSON_STARTTIME" id="LESSON_STARTTIME"
												value="${pd.LESSON_STARTTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="开始时间" title="开始时间" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">结束时间:</td>
											<td><input class="span10 date-picker checkTeacherAddClassroom"
												name="LESSON_ENDTIME" id="LESSON_ENDTIME"
												value="${pd.LESSON_ENDTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="结束时间" title="结束时间" style="width: 98%;" /></td>
										</tr> --%>
										<%-- <tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">课程:</td>
											<td>
												<input type="text" name="COURSE_ID" id="COURSE_ID" value="${pd.COURSE_ID}" maxlength="32" placeholder="这里输入课程id" title="课程id" style="width:98%;"/>
												<select class="chosen-select form-control checkTeacherAddClassroom" name="COURSE_ID"
												id="COURSE_ID" data-placeholder="请选择课程"
												style="vertical-align: top;" style="width:98%;">
													<option value>--请选择--</option>

													<c:forEach items="${coursesList}" var="courses">
														<option value="${courses.id }"
															<c:if test="${courses.id == pd.COURSE_ID}">selected</c:if>>${courses.name }</option>
													</c:forEach>
											</select>
											</td>
										</tr> --%>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">科目:</td>
											<td>
												<%-- <input type="text" name="TEACHERS_ID" id="TEACHERS_ID" value="${pd.TEACHERS_ID}" maxlength="32" placeholder="这里输入老师id" title="老师id" style="width:98%;"/> --%>
												<select  class="chosen-select form-control"
												name="SUBJECT_ID" id="SUBJECT_ID" data-placeholder="请选择科目"
												style="vertical-align: top;" style="width:98%;">
													<option value="">--请选择--</option>
													<c:forEach items="${subjectList}" var="subject">
														<option value="${subject.SUBJECT_ID }"
															<c:if test="${subject.SUBJECT_ID == pd.SUBJECT_ID }">selected</c:if>>${subject.SUBJECT_NAME }</option>
													</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">老师:</td>
											<td>
												<%-- <input type="text" name="TEACHERS_ID" id="TEACHERS_ID" value="${pd.TEACHERS_ID}" maxlength="32" placeholder="这里输入老师id" title="老师id" style="width:98%;"/> --%>
												<select  class="chosen-select form-control"
												name="TEACHERS_ID" id="TEACHERS_ID" data-placeholder="请选择老师"
												style="vertical-align: top;" style="width:98%;">
													<option value="">--请选择--</option>
													<c:forEach items="${teachList}" var="teach">
														<option value="${teach.USER_ID }"
															<c:if test="${teach.USER_ID == pd.TEACHERS_ID }">selected</c:if>>${teach.NAME }</option>
													</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">教室:</td>
											<td>
												<%-- <input type="text" name="CLASSROOM_ID" id="CLASSROOM_ID" value="${pd.CLASSROOM_ID}" maxlength="32" placeholder="这里输入教室id" title="教室id" style="width:98%;"/> --%>
												<select  class="chosen-select form-control"
												name="CLASSROOM_ID" id="CLASSROOM_ID"
												data-placeholder="请选择教室" style="vertical-align: top;"
												style="width:98%;">
													<option value=''>--请选择--</option>
													<c:forEach items="${classList}" var="classs">
														<option value="${classs.CLASSROOM_ID }" <c:if test="${classs.CLASSROOM_ID == pd.CLASSROOM_ID }">selected</c:if>>${classs.CLASSROOM_NAME }</option>
													</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">备注:</td>
											<td><input type="text" name="LESSON_NAME"
												id="LESSON_NAME" value="${pd.LESSON_NAME}" maxlength="32"
												placeholder="这里输入备注" title="备注" style="width: 98%;" /></td>
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<!-- <script src="static/ace/js/date-time/bootstrap-datepicker.js"></script> -->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/js/layer/layer.js"></script>
	
	<script type="text/javascript">
		$(function() {
		checkTeacherAndClassroom();
		$("#SUBJECT_ID").change(function(){
			checkTeacherAndClassroom();	
		});
			//日期框
			/* $('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			}); */
			
			/* $('#COURSE_ID,#CLASSROOM_ID,#TEACHERS_ID').mousedown(function(){
				if($('#LESSON_STARTTIME').val()==null||$('#LESSON_STARTTIME').val()==''){
					$("#LESSON_STARTTIME").tips({
						side : 3,
						msg : '请输入开始时间',
						bg : '#AE81FF',
						time : 1
					});
					return
				}else if($('#LESSON_ENDTIME').val()==null||$('#LESSON_ENDTIME').val()==''){
					$("#LESSON_ENDTIME").tips({
						side : 3,
						msg : '请输入结束时间',
						bg : '#AE81FF',
						time : 1
					});
					return
				}
<<<<<<< .mine
			})
=======
			}) */
			//当选择课程后　　判断查找　　此课程下的老师ＡＮＤ　以及当前时间段不在教课的老师　　
			//				判断查找　　　此时间段没有使用在使用的教室
			
			/* $('#CLASSROOM_ID').click(
					function() {
						checkTeacherAndClassroom();
				})
				$('#TEACHERS_ID').click(
					function() {
						checkTeacherAndClassroom();
				}) */
					
		});
		
	
		function checkTeacherAndClassroom(){
			$.ajax({
				url : '/invest/schedule/listBySubjectId',
				type : 'POST',
				data : {
					'COURSE_ID' : $("#COURSE_ID").val(),
					'SUBJECT_ID' : $("#SUBJECT_ID").val(),
					'start':$('#LESSON_STARTTIME').val(),
					'end':$('#LESSON_ENDTIME').val(),
					'CLASSROOM_ID':$('#CLASSROOM_ID').val(),
					'TEACHERS_ID':$('#TEACHERS_ID').val()
				},
				dataType : 'json',
				success : function(data) {
					if(data.teachList!=null){
						var teacher_id=$('#TEACHERS_ID').val();
						$('#TEACHERS_ID').empty()
						var teachcontent = '<option value>--请选择--</option>'
						$.each(data.teachList, function(index, t) {
							if(teacher_id==t.USER_ID){
								teachcontent += '<option value="'+t.USER_ID+'" selected>'+ t.NAME + '</option>'
							}else{
								teachcontent += '<option value="'+t.USER_ID+'">'+ t.NAME + '</option>'
							}
						})
					}
					if(data.classroomList!=null){
						var classroom_id=$('#CLASSROOM_ID').val();
						$('#CLASSROOM_ID').empty()
						var classcontent = '<option value>--请选择--</option>'
						$.each(data.classroomList, function(index, c) {
							if(classroom_id==c.CLASSROOM_ID){
								classcontent += '<option value="'+c.CLASSROOM_ID+'" selected>'+ c.CLASSROOM_NAME + '</option>'
							}else{
								classcontent += '<option value="'+c.CLASSROOM_ID+'">'+ c.CLASSROOM_NAME + '</option>'
							}
						})
					}
					
					$('#TEACHERS_ID').append(teachcontent)
					$('#CLASSROOM_ID').append(classcontent)
				}

			})
		}

		$(top.hangge());
		//保存
		function save() {
			/* if ($("#LESSON_STARTTIME").val() == "") {
				$("#LESSON_STARTTIME").tips({
					side : 3,
					msg : '请输入开始时间',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			}
			if ($("#LESSON_ENDTIME").val() == "") {
				$("#LESSON_ENDTIME").tips({
					side : 3,
					msg : '请输入结束时间',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			} */
			/* if ($("#LESSON_STARTTIME").val()>$("#LESSON_ENDTIME").val()) {
				$("#LESSON_STARTTIME").tips({
					side : 3,
					msg : '开始时间必须小于结束时间',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			} */
			if ($("#SUBJECT_ID").val() == "") {
				$("#SUBJECT_ID").tips({
					side : 3,
					msg : '请选择科目',
					bg : '#AE81FF',
					time : 2
				});
				$("#SUBJECT_ID").focus();
				return false;
			}
			if ($("#TEACHERS_ID").val() == "") {
				$("#TEACHERS_ID").tips({
					side : 3,
					msg : '请选择老师',
					bg : '#AE81FF',
					time : 2
				});
				$("#TEACHERS_ID").focus();
				return false;
			}
			if ($("#CLASSROOM_ID").val() == "") {
				$("#CLASSROOM_ID").tips({
					side : 3,
					msg : '请选择教室',
					bg : '#AE81FF',
					time : 2
				});
				$("#CLASSROOM_ID").focus();
				return false;
			}
			//checkStudent();
			layer.confirm("<div style='color:red;text-align:center;font-size:18px'>确定吗？<div>", {title:'提示'}, function(index){
				 $("#Form").submit();
			});
		}
		
		//检查多课程的学生是否冲突
		
		function checkStudent(){
			var tan='';
			$.ajax({
				url:'/invest/schedule/checkStudent',
				type:'POST',
				data:{
					'COURSE_ID' : $("#COURSE_ID").val(),
					'start':$('#LESSON_STARTTIME').val(),
					'end':$('#LESSON_ENDTIME').val()
				},
				dataType:'json',
				success:function(data){
					var tan='';
					if(data!=''){
						$.each(data,function(index,s){
							tan+="<div style='color:red'>此课程的"+s.student_name+"在此时间段内还有其他课程</div>"
						})
					}
					
					layer.confirm(tan+="<div style='color:red;text-align:center;font-size:18px'>确定吗？<div>", {title:'提示'}, function(index){
						 $("#Form").submit();
					});
				}
			})
		}
		
	</script>
	<script src="static/ace/js/laydate/laydate.js"></script>
	<script>
		//执行一个laydate实例
		/* laydate.render({
			elem : '#LESSON_STARTTIME'
			,type: 'datetime'
				,theme: '#76ACCD',
				min: 0,
				max: 365,
				//回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
				done: function(value, date, endDate){
					if(value!=''){
						$("#LESSON_STARTTIME").val(value);
						if($("#LESSON_ENDTIME").val()!='' && $("#LESSON_ENDTIME").val()!=null){
 							checkTeacherAndClassroom();
						}
						//$('#CLASSROOM_ID,#COURSE_ID').removeAttr("disabled")
					}else{
						$("#CLASSROOM_ID").val("");
						$("#COURSE_ID").val("");
						$("#TEACHERS_ID").val("");
						$('#CLASSROOM_ID,#COURSE_ID,#TEACHERS_ID').attr("disabled","disabled");
					}
				}
		});
		laydate.render({
			elem : '#LESSON_ENDTIME'
			,type: 'datetime'
				,theme: '#76ACCD',
				min: 0,
				max: 365,
				//回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
				done: function(value, date, endDate){
					if(value!=''){
						$("#LESSON_ENDTIME").val(value);
						$('#CLASSROOM_ID,#COURSE_ID').removeAttr("disabled")
						if($("#TEACHERS_ID").val()!=''){
							$("#TEACHERS_ID").removeAttr("disabled")
						}
 						checkTeacherAndClassroom();
					}else{
						$("#CLASSROOM_ID").val("");
						$("#COURSE_ID").val("");
						$("#TEACHERS_ID").val("");
						$('#CLASSROOM_ID,#COURSE_ID,#TEACHERS_ID').attr("disabled","disabled");
					}
				}
		}); */
		
	</script>
</body>
</html>