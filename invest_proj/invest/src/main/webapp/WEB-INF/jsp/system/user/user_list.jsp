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
<%@ include file="../index/top.jsp"%>
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
							<form action="user/listUsers.do" method="post" name="userForm"
								id="userForm">
								<input type="hidden" name="userid" id="userid"/>
								<input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="${pd.SUBJECT_ID }"/>
								<input type="hidden" name="username" id="username"/>
								<input type="hidden" name="COURSES_ID" id="COURSES_ID"
									value="${pd.COURSES_ID }" /> <input type="hidden"
									name="is_show" id="is_show" value="${pd.is_show }" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table style="margin-top: 5px;">
										<tr>
											<td>
												<div class="nav-search">
													<span class="input-icon"> <input
														class="nav-search-input" autocomplete="off"
														id="nav-search-input" type="text" name="keywords"
														value="${pd.keywords }" placeholder="这里输入老师姓名" /> <i
														class="ace-icon fa fa-search nav-search-icon"></i>
													</span>
												</div>
											</td>
											<td style="vertical-align: top; padding-left: 2px;"><select
												class="chosen-select form-control" name="ROLE_ID"
												id="role_id" data-placeholder="请选择角色"
												style="vertical-align: top; width: 120px;">
													<option value=""></option>
													<option value="">全部</option>
													<c:forEach items="${roleList}" var="role">
														<option value="${role.ROLE_ID }"
															<c:if test="${pd.ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
													</c:forEach>
											</select></td>
											<c:if test="${QX.cha == 1 }">
												<td style="vertical-align: top; padding-left: 2px;"><a
													class="btn btn-light btn-xs" onclick="searchs();"
													title="检索"><i id="nav-search-icon"
														class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
												<c:if test="${QX.toExcel == 1 }">
													<td style="vertical-align: top; padding-left: 2px;"><a
														class="btn btn-light btn-xs" onclick="toExcel();"
														title="导出到EXCEL"><i id="nav-search-icon"
															class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
												</c:if>
											</c:if>
											<c:if test="${pd.is_show==null ||pd.is_show=='' }">
											<td><a class="btn btn-mini btn-success" onclick="add();" style="margin-left: 5px;">新增</a></td>
											</c:if>
										</tr>
									</table>
									<!-- 检索  -->

									<table id="simple-table"
										class="table table-striped table-bordered table-hover"
										style="margin-top: 5px;">
										<thead>
											<tr>
													<th class="center" style="width: 35px;"><label
														class="pos-rel"><input type="checkbox" class="ace"
															id="zcheckbox" /><span class="lbl"></span></label></th>
												<th class="center" style="width: 50px;">序号</th>
												<th class="center">编号</th>
												<th class="center">用户名</th>
												<th class="center">姓名</th>
												<th class="center">角色</th>
												<th class="center">手机号码</th>
												<th class="center"><i class="ace-icon fa fa-envelope-o"></i>邮箱</th>
												<th class="center"><i
													class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>最近登录</th>
												<th class="center">上次登录IP</th>
												<c:choose>
													<c:when test="${pd.is_show==null ||pd.is_show=='' }">
														<th class="center">修改密码</th>
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
												<c:when test="${not empty userList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${userList}" var="user" varStatus="vs">

															<tr class="close_click">
																	<td class='center' style="width: 30px;"><c:if
																			test="${user.USERNAME != 'admin'}">
																			<label><input type='checkbox' name='ids'
																				value="${user.USER_ID }" id="${user.EMAIL }"
																				alt="${user.PHONE }" title="${user.USERNAME }"
																				class="ace" /><span class="lbl"></span></label>
																		</c:if> <c:if test="${user.USERNAME == 'admin'}">
																			<label><input type='checkbox'
																				disabled="disabled" class="ace" /><span class="lbl"></span></label>
																		</c:if></td>
																<td class='center' style="width: 30px;">${vs.index+1}<input type="hidden" id="user_id" value="${user.USER_ID }" /><input type="hidden" id="user_name" value="${user.NAME }"></td>
																<td class="center">${user.NUMBER }</td>
																<td class="center"><a
																	onclick="viewUser('${user.USERNAME}')"
																	style="cursor: pointer;">${user.USERNAME }</a></td>
																<td class="center">${user.NAME }</td>
																<td class="center">${user.ROLE_NAME }</td>
																<td class="center">${user.PHONE }</td>
																<td class="center"><a title="电子邮件"
																	style="text-decoration: none; cursor: pointer;"<c:if test="${pd.is_show==null ||pd.is_show=='' }"> onclick="sendEmail('${user.EMAIL}')"</c:if></a> ${user.EMAIL }&nbsp;<i
																		class="ace-icon fa fa-envelope-o"></i></a></td>
																<td class="center">${user.LAST_LOGIN}</td>
																<td class="center">${user.IP}</td>
																<c:choose>
																	<c:when test="${pd.is_show==null ||pd.is_show=='' }">
																		<td class="center"><a onclick="updatepwd('${user.USER_ID}')" style="cursor: pointer;">修改密码</a></td>
																		<td class="center"><c:if
																			test="${QX.edit != 1 && QX.del != 1 }">
																			<span
																				class="label label-large label-grey arrowed-in-right arrowed-in"><i
																				class="ace-icon fa fa-lock" title="无权限"></i></span>
																		</c:if>
																		<div class="hidden-sm hidden-xs btn-group">
																			<c:if test="${QX.edit == 1 }">
																				<a class="btn btn-xs btn-success" title="编辑"
																					onclick="editUser('${user.USER_ID}');"> <i
																					class="ace-icon fa fa-pencil-square-o bigger-120"
																					title="编辑"></i>
																				</a>
																			</c:if>
																			<c:if test="${QX.del == 1 }">
																				<a class="btn btn-xs btn-danger"
																					onclick="delUser('${user.USER_ID }','${user.USERNAME }');">
																					<i class="ace-icon fa fa-trash-o bigger-120"
																					title="删除"></i>
																				</a>
																			</c:if>
																		</div>
																		<div class="hidden-md hidden-lg">
																			<div class="inline pos-rel">
																				<button
																					class="btn btn-minier btn-primary dropdown-toggle"
																					data-toggle="dropdown" data-position="auto">
																					<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																				</button>
																				<ul
																					class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																					<c:if test="${QX.edit == 1 }">
																						<li><a style="cursor: pointer;"
																							onclick="editUser('${user.USER_ID}');"
																							class="tooltip-success" data-rel="tooltip"
																							title="修改"> <span class="green"> <i
																									class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																							</span>
																						</a></li>
																					</c:if>
																					<c:if test="${QX.del == 1 }">
																						<li><a style="cursor: pointer;"
																							onclick="delUser('${user.USER_ID }','${user.USERNAME }');"
																							class="tooltip-error" data-rel="tooltip"
																							title="删除"> <span class="red"> <i
																									class="ace-icon fa fa-trash-o bigger-120"></i>
																							</span>
																						</a></li>
																					</c:if>
																				</ul>
																			</div>
																		</div>
																		</td>
																	</c:when>
																	<c:otherwise>
																		<td class="center">
																			<a class="btn btn-mini btn-success clickdis" userid="${user.USER_ID }" username="${user.NAME }">添加</a>
																		</td>
																	</c:otherwise>
																</c:choose>
															</tr>

														</c:forEach>
													</c:if>
													<c:if test="${QX.cha == 0 }">
														<tr>
															<td colspan="10" class="center">您无权查看</td>
														</tr>
													</c:if>
												</c:when>
												<c:otherwise>
													<tr class="main_info">
														<td colspan="10" class="center">没有相关数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									<div class="page-header position-relative">
										<table style="width: 100%;">
											<tr>
												<c:choose>
													<c:when test="${pd.is_show==null || pd.is_show=='' }">
														<td style="vertical-align: top;"><c:if
															test="${QX.add == 1 }">
															<a class="btn btn-mini btn-success" onclick="add();">新增</a>
															<a title="批量删除" class="btn btn-mini btn-danger"
																onclick="makeAll('确定要删除选中的数据吗?');"><i 
																class='ace-icon fa fa-trash-o bigger-120'></i></a>
														</c:if>
														<c:if test="${QX.email == 1 }"><a title="批量发送电子邮件" class="btn btn-mini btn-primary" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="ace-icon fa fa-envelope bigger-120"></i></a></c:if>
														<%-- <c:if test="${QX.sms == 1 }"><a title="批量发送短信" class="btn btn-mini btn-warning" onclick="makeAll('确定要给选中的用户发送短信吗?');"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if> --%>	
														</td>
													</c:when>
													<c:otherwise>
														<c:if test="${pd.is_show!=''}">
														<a class="btn btn-mini btn-success" onclick="addcheck('确定要添加选中的数据吗?');">添加</a>
														</c:if>
													</c:otherwise>
												</c:choose>
												<td style="vertical-align: top;"><div
														class="pagination"
														style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
											</tr>
										</table>
										<%-- <table style="width:100%;">
											<tr>
												<td style="vertical-align:top;">
													<c:if test="${QX.add == 1 }">
													<a class="btn btn-mini btn-success" onclick="add();">新增</a>
													</c:if>
													<c:if test="${QX.FHSMS == 1 }"><a title="批量发送站内信" class="btn btn-mini btn-info" onclick="makeAll('确定要给选中的用户发送站内信吗?');"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if>
													<c:if test="${QX.email == 1 }"><a title="批量发送电子邮件" class="btn btn-mini btn-primary" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="ace-icon fa fa-envelope bigger-120"></i></a></c:if>
													<c:if test="${QX.sms == 1 }"><a title="批量发送短信" class="btn btn-mini btn-warning" onclick="makeAll('确定要给选中的用户发送短信吗?');"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if>
													<c:if test="${QX.del == 1 }">
													<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
													</c:if>
												</td>
												<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
											</tr>
										</table> --%>
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>

<script type="text/javascript">
$(top.hangge());

//检索
function searchs(){
	top.jzts();
	$("#userForm").submit();
}

//删除
function delUser(userId,msg){
	bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
		if(result) {
			top.jzts();
			var url = "<%=basePath%>user/deleteU.do?USER_ID="+userId+"&tm="+new Date().getTime();
			$.get(url,function(data){
				nextPage(${page.currentPage});
			});
		};
	});
}

//添加
$(".clickdis").click(function(){
	var user_id=$(this).attr("userid");
	var user_name=$(this).attr("username");
			if('${pd.is_show}'=='addteacher'){//课程添加老师
				<%-- window.location.href='<%=basePath%>school_ref/save.do?TEACHERS_ID='+user_id+'&COURSES_ID='+$("#COURSES_ID").val(); --%>
				$.ajax({
					type: "POST",
					url: '<%=basePath%>courses_teacher/save.do', 
			    	data: {"USER_ID":user_id,"COURSES_ID":$("#COURSES_ID").val()},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						
					}
				});
				$(this).parent().parent().css("display","none");
			}
			if('${pd.is_show}'=='user'){//科目添加老师
				<%-- window.location.href='<%=basePath%>subject_teacher/save.do?TEACHER_ID='+user_id+'&SUBJECT_ID='+$("#SUBJECT_ID").val(); --%>
				$.ajax({
					type: "POST",
					url: '<%=basePath%>subject_teacher/save.do',
			    	data: {"TEACHER_ID":user_id,"SUBJECT_ID":$("#SUBJECT_ID").val()},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						
					}
				});
				$(this).attr('disabled',"true");
			}
			if('${pd.is_show}'=='searchTeacherByUsers'){ //微信用户查找老师
				$("#userid").val(user_id);
				$("#username").val(user_name);
				top.Dialog.close();
			}
});

//新增
function add(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="新增";
	 diag.URL = '<%=basePath%>user/goAddU.do';
	 diag.Width = 469;
	 diag.Height = 510;
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

//修改密码
function updatepwd(user_id){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="修改密码";
	 diag.URL = '<%=basePath%>user/goUpdatepwd.do?USER_ID='+user_id;
	 diag.Width = 469;
	 diag.Height = 210;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			nextPage(${page.currentPage});
		}
		diag.close();
	 };
	 diag.show();
}
//修改
function editUser(user_id){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="资料";
	 diag.URL = '<%=basePath%>user/goEditU.do?USER_ID='+user_id;
	 diag.Width = 969;
	 diag.Height = 910;
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
				if('${pd.is_show}'=='user'){
					toadd="subject_teacher";
				}else if('${pd.is_show}'=='addteacher'){
					toadd="courses_teacher";
				}
				if(msg == '确定要添加选中的数据吗?'){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>'+toadd+'/addall.do?tm='+new Date().getTime(),
				    	data: {DATA_IDS:str,"COURSES_ID":$("#COURSES_ID").val(),"SUBJECT_ID":$("#SUBJECT_ID").val()},
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
			var emstr = '';
			var phones = '';
			var username = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	
				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
				  	
				  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
				  	else phones += ';' + document.getElementsByName('ids')[i].alt;
				  	
				  	if(username=='') username += document.getElementsByName('ids')[i].title;
				  	else username += ';' + document.getElementsByName('ids')[i].title;
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
				if(msg == '确定要删除选中的数据吗?'){
					top.jzts();
					$.ajax({
						type: "POST",
						url: '<%=basePath%>user/deleteAllU.do?tm='+new Date().getTime(),
				    	data: {USER_IDS:str},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							 $.each(data.list, function(i, list){
									nextPage(${page.currentPage});
							 });
						}
					});
				}else if(msg == '确定要给选中的用户发送邮件吗?'){
					sendEmail(emstr);
				}else if(msg == '确定要给选中的用户发送短信吗?'){
					sendSms(phones);
				}else if(msg == '确定要给选中的用户发送站内信吗?'){
					sendFhsms(username);
				}
			}
		}
	});
}

//去发送短信页面
function sendSms(phone){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送短信";
	 diag.URL = '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser';
	 diag.Width = 600;
	 diag.Height = 265;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//去发送电子邮件页面
function sendEmail(EMAIL){
	top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送电子邮件";
	 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
	 diag.Width = 660;
	 diag.Height = 486;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//发站内信
function sendFhsms(username){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="站内信";
	 diag.URL = '<%=basePath%>fhsms/goAdd.do?username='+username;
	 diag.Width = 660;
	 diag.Height = 444;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
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

//导出excel
function toExcel(){
	var keywords = $("#nav-search-input").val();
	var lastLoginStart = $("#lastLoginStart").val();
	var lastLoginEnd = $("#lastLoginEnd").val();
	var ROLE_ID = $("#role_id").val();
	window.location.href='<%=basePath%>user/excel.do?keywords='+keywords+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
}

//打开上传excel页面
function fromExcel(){
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="EXCEL 导入到数据库";
	 diag.URL = '<%=basePath%>user/goUploadExcel.do';
	 diag.Width = 300;
	 diag.Height = 150;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location.reload()",100);
			 }else{
				 nextPage(${page.currentPage});
			 }
		}
		diag.close();
	 };
	 diag.show();
}	

//查看用户
function viewUser(USERNAME){
	if('admin' == USERNAME){
		bootbox.dialog({
			message: "<span class='bigger-110'>不能查看admin用户!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}
	 top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="资料";
	 diag.URL = '<%=basePath%>user/view.do?USERNAME='+USERNAME;
	 diag.Width = 469;
	 diag.Height = 380;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}
		
</script>
</html>
