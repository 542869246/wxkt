<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
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
							
						<!-- 检索  -->
						<form action="courses/list.do" method="post" name="Form" id="Form">
						<input type="hidden" name="STUDENT_ID" id="STUDENT_ID" value="${pd.STUDENT_ID }" >
						<input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID }" >
						<input type="hidden" name="is_show" id="is_show" value="${pd.is_show }" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入课程名称" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入课程名称"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<%-- <td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="SUBJECT_ID" id="SUBJECT_ID" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value="">全部</option>
								 	<c:forEach items="${SUBJECT_LIST }" var="SUB">
										<option value="${SUB.SUBJECT_ID }" <c:if test="${pd.SUBJECT_ID==SUB.SUBJECT_ID }">selected</c:if>>${SUB.SUBJECT_NAME }</option>
									</c:forEach>
								  	</select>
								</td> --%>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="STATUS_ID" id="STATUS_ID" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value="">全部</option>
								 	<c:forEach items="${STATUS_LIST }" var="STA">
										<option value="${STA.DICTIONARIES_ID }" <c:if test="${pd.STATUS_ID==STA.DICTIONARIES_ID }">selected</c:if>>${STA.NAME }</option>
									</c:forEach>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<!-- <th class="center">科目</th> -->
									<th class="center">课程名称</th>
									<th class="center">开始时间</th>
									<th class="center">结束时间</th>
									<th class="center">课程状态</th>
									<th class="center">审核人</th>
								
									<th class="center">备注</th>
									<c:choose>
										<c:when test="${pd.is_show==null ||pd.is_show=='' }">
											<th class="center">操作</th>
										</c:when>
										<c:otherwise>
											<th class="center">添加</th>
										</c:otherwise>
									</c:choose>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr class="close_click">
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.COURSES_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}<input type="hidden" id="courses_id" value="${var.COURSES_ID }" /></td>
											<%-- <td class='center'>
												<c:forEach items="${SUBJECT_LIST }" var="SUB">
													<c:if test="${SUB.SUBJECT_ID==var.SUBJECT_ID }">${SUB.SUBJECT_NAME }</c:if>
												</c:forEach>
											</td> --%>
											<td class='center'>${var.COURSES_NAME}</td>
											
											<td class='center'><fmt:formatDate value="${var.ARRANGE_STARTTIME}" pattern="yyyy-MM-dd HH:ss:mm"/></td>
											<td class='center'><fmt:formatDate value="${var.ARRANGE_ENDTIME}" pattern="yyyy-MM-dd HH:ss:mm"/></td>
										
											<td class='center'>
												<c:forEach items="${STATUS_LIST }" var="STA">
													<c:if test="${STA.DICTIONARIES_ID==var.COURSE_STATUS }">${STA.NAME }</c:if>
												</c:forEach>
											</td>
											<td class='center'>
												
													${var.NAME}
													
											</td>
											<td class='center' style="display: none;">${var.user_id}</td>
											<td class="center">${var.COURSES_REMARK}</td>
											
											
										
											<c:choose>
												<c:when test="${pd.is_show==null ||pd.is_show=='' }">
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.COURSES_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.COURSES_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
													<c:if test="${QX.sms == 1 }"><a title="发送短信" class="btn btn-mini btn-warning" onclick="make('${var.COURSES_ID}')"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.COURSES_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.COURSES_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
												</c:when>
												<c:otherwise>
													<td class='center'>
														<a class="btn btn-mini btn-success clickdis" coursesid="${var.COURSES_ID }">添加</a>
													</td>
												</c:otherwise>
											</c:choose>
											</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
							<c:choose>
								<c:when test="${pd.is_show==null || pd.is_show=='' }">
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
								</c:when>
								<c:otherwise>
									<a class="btn btn-mini btn-success" onclick="addcheck('确定要添加选中的数据吗?');">添加</a>
								</c:otherwise>
							</c:choose>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//给课程下面的学生  学生的今日学习是否已看   如果没看   给此学生的所有家长发送短信
		function make(courses_id){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>courses/listStuById.do',
		    	data: {"COURSES_ID":courses_id},
				dataType:'json',
				//beforeSend: validateData,
				success: function(data){
					if(data.status==1){
						alert("此课程下没有学生！");
						return;
					}
					if(data.status==0){
						if(data.listUsers.length==0){
							alert("没有家长未看小孩今日学习！");
							return;
						}
						bootbox.confirm("有"+data.listUsers.length+"位家长未看小孩今日学习，确定要发送短信吗？",function(result){
							if(result){
								$.ajax({
									type: "POST",
									url: '<%=basePath%>courses/sendSMS.do',
							    	data: {"listUsers":JSON.stringify(data.listUsers)},
									dataType:'json',
									success: function(data){
										alert(data.message);
									}
								})
							}else{
								return;
							}
						})
					}
				}
			});
		}
		
		
		//添加
		$(".clickdis").click(function(){
			var courses_id=$(this).attr("coursesid");
					if('${pd.is_show}'=='courses'){//学生添加课程
						<%-- window.location.href='<%=basePath%>school_ref/save.do?TEACHERS_ID='+user_id+'&COURSES_ID='+$("#COURSES_ID").val(); --%>
						$.ajax({
							type: "POST",
							url: '<%=basePath%>arrange/save.do', 
					    	data: {"COURSE_ID":courses_id,"STUDENT_ID":$("#STUDENT_ID").val()},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								
							}
						});
						$(this).attr('disabled',"true");
					}
					if('${pd.is_show}'=='addcourses'){//老师添加课程
						<%-- window.location.href='<%=basePath%>subject_teacher/save.do?TEACHER_ID='+user_id+'&SUBJECT_ID='+$("#SUBJECT_ID").val(); --%>
						$.ajax({
							type: "POST",
							url: '<%=basePath%>courses_teacher/save.do',
					    	data: {"COURSES_ID":courses_id,"USER_ID":$("#USER_ID").val()},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
							}
						});
						$(this).attr('disabled',"true");
					}
		}); 
		
		$(function() {
			
			<%-- if("${pd.is_show}"!=''){
				$(".close_click").dblclick(function(){
					var courses_id=$(this).find("[id='courses_id']").val();
					bootbox.confirm("确定要添加此课程？",function(result){
						if(result){
							if('${pd.is_show}'=='courses'){//学生添加课程
								window.location.href='<%=basePath%>arrange/save.do?COURSE_ID='+courses_id+'&STUDENT_ID='+$("#STUDENT_ID").val();
							}
							if('${pd.is_show}'=='addcourses'){//老师添加课程
								window.location.href='<%=basePath%>courses_teacher/save.do?COURSE_ID='+courses_id+'&STUDENT_ID='+$("#STUDENT_ID").val();
							}
						}
					})
				});
			} --%>
			
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>courses/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
				
			 };
			 diag.show();
			
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>courses/delete.do?COURSES_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>courses/goEdit.do?COURSES_ID='+Id;
			 diag.Width = 1250;
			 diag.Height = 1500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
			diag.close();
				
			 };
			 diag.show();
			
		}
		
		
		//批量添加
		function addcheck(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
		  			for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						var toadd="";
						if('${pd.is_show}'=='courses'){
							toadd="arrange";
						}else if('${pd.is_show}'=='addcourses'){
							toadd="courses_teacher";
						}
						if(msg == '确定要添加选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>'+toadd+'/addall.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str,"STUDENT_ID":$("#STUDENT_ID").val(),"USER_ID":$("#USER_ID").val()},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 /* $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 }); */
									 if(data.msg=="ok"){
										top.Dialog.close();
									 }
								}
							});
						}
					}
				}
			});
		}
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>courses/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>courses/excel.do';
		}
	</script>


</body>
</html>