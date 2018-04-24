﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	
	<!-- ztree JS -->
	<SCRIPT type="text/javascript">
		var setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};


		function beforeClick(treeId, treeNode) {
			var check = (treeNode && !treeNode.isParent);
			if (!check) alert("只能选择基金...");
			return check;
		}
		var oldv="-1";
		function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			id="";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id=nodes[i].id;
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			saveValue(v);
		}
		<!-- 保存下拉列表的值 -->
		function saveValue(v){
			var cityObj = $("#citySel");
			var type = $("#ATTR_TYPEID");
			if(oldv != v ){
				type.attr("value", id);
				cityObj.attr("value", v);
				oldv=v;
			}
		}

		function showMenu() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
		
		
		$(document).ready(function(){
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
		});
		
	</SCRIPT>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div id="menuContent" class="menuContent" style="width:150px;display:none; position: absolute;z-index:999;background-color:#fff;" >
							<ul id="treeDemo" class="ztree" style="margin-top:0; width:150px;"></ul>
						</div>
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="student/list.do" method="post" name="Form" id="Form">
						<input type="hidden" name="stu" id="stu"/>
						<input type="hidden" name="stuName" id="stuName"/>
						<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/>
						<input type="hidden" name="COURSES_ID" id="COURSES_ID" value="${pd.COURSES_ID }"/>
						<input type="hidden" name="USERS_ID" id="USERS_ID" value="${pd.USERS_ID }"/>
						<input type="hidden" name="is_show" id="is_show" value="${pd.is_show }" />
						<input type="hidden" name="scheduleList" id="scheduleList" value="${pd.scheduleList }" />
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="margin-top:5px;width:100%;">
							<tr>
								<td style="vertical-align:top;padding-left:2px;width:234px;">
								 	<div class="nav-search">
										<span class="input-icon"><strong>课程类型:</strong>
											<input id="citySel" type="text" style="width:138px;" placeholder="点击选择类型"  class="nav-search-input"  autocomplete="off" name="attrType"  readonly="readonly" value="${pd.attrType}"   onclick="showMenu(); return false;"/>
											<a onclick="document.getElementById('citySel').value='';document.getElementById('ATTR_TYPEID').value='';" style="cursor:pointer;">清空</a>
										</span>
									</div>
								</td>
								<td style="width:12%;">
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入学生姓名" style="width:150px;" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入学生姓名"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<!-- 排序功能 -->
								<td>
									<div class="nav-search" style="float:right;">
											<select name="type" id="type">
												<option value="1" <c:if test="${pd.type==1 }">selected</c:if>>按照姓名排序</option>
												<option value="2" <c:if test="${pd.type==2 }">selected</c:if>>按照号码排序</option>
											</select>
											<select name="orderby" id="orderby" style="padding:0px;">
												<option value="0" <c:if test="${pd.orderby==0 }">selected</c:if>>正序</option>
												<option value="1" <c:if test="${pd.orderby==1 }">selected</c:if>>倒序</option>
											</select>
									</div>
								</td>
								<!--<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>-->
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
									<!-- <th class="center">学生id</th> -->
									<th class="center">学生姓名</th>
									<th class="center">手机号</th>
									<th class="center">头像</th>
									<th class="center">描述</th>
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
													<label class="pos-rel"><input type='checkbox' name='ids' value="${var.STUDENT_ID}" class="ace" /><span class="lbl"></span></label>
												</td>
											<td class='center' style="width: 30px;">${vs.index+1}<input type="hidden" id="student_id" value="${var.STUDENT_ID }"><input type="hidden" id="student_name" value="${var.STUDENT_NAME }"></td>
											<!-- <td class='center'>${var.STUDENT_ID}</td> -->
											<td class='center'>${var.STUDENT_NAME}</td>
											<td class='center'>${var.PHONE}</td>
											<td class='center'><img src="<%=basePath%>${var.IMG_SRC}" class="center-block" width="25" height="25" onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null"  /></td>
											<td class='center'>${var.STUDENT_COMMENTS}</td>
											<c:choose>
												<c:when test="${pd.is_show==null ||pd.is_show=='' }">
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.STUDENT_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.STUDENT_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.STUDENT_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.STUDENT_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
											</c:when>
											<c:otherwise>
												<td class="center">
													<a class="btn btn-mini btn-success clickdis" studentid="${var.STUDENT_ID }" studentname="${var.STUDENT_NAME }">添加</a>
												</td>
											</c:otherwise>
											</c:choose>
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
								<td style="vertical-align:top;">
									<c:choose>
										<c:when test="${pd.is_show==null || pd.is_show=='' }">
										<c:if test="${QX.add == 1 }">
											<a class="btn btn-mini btn-success" onclick="add();">新增</a>
										</c:if>
										<c:if test="${QX.del == 1 }">
										<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
										</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${pd.is_show == 'student' }">
											<a class="btn btn-mini btn-success" onclick="addcheck('确定要添加选中的数据吗?');">添加</a>
											</c:if>
										</c:otherwise>
										</c:choose>
								</td>
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

		//添加
		$(".clickdis").click(function(){
			var student_id=$(this).attr("studentid");
			var studentname=$(this).attr("studentname");
					if('${pd.is_show}'=='searchStudent'){//课程添加学生
						<%-- window.location.href='<%=basePath%>school_ref/save.do?TEACHERS_ID='+user_id+'&COURSES_ID='+$("#COURSES_ID").val(); --%>
						$.ajax({
							type: "POST",
							url: '<%=basePath%>arrange/save.do', 
					    	data: {"STUDENT_ID":student_id,"COURSE_ID":$("#COURSES_ID").val()},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
							}
						});
						$(this).parent().parent().css("display","none");
					}
					if('${pd.is_show}'=='student'){//家长添加学生
						<%-- window.location.href='<%=basePath%>subject_teacher/save.do?TEACHER_ID='+user_id+'&SUBJECT_ID='+$("#SUBJECT_ID").val(); --%>
						$.ajax({
							type: "POST",
							url: '<%=basePath%>webuser/save.do',
					    	data: {"STUDENT_ID":student_id,"USERS_ID":$("#USERS_ID").val()},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								
							}
						});
						$(this).attr('disabled',"true");
					}
					if('${pd.is_show}'=='search_student'){ //礼物兑换查找学生
						$("#stu").val(student_id);
						$("#stuName").val(studentname);
						top.Dialog.close();
					}
		});
		
		$(function() {
			<%-- if('${pd.is_show}'!=''){
				$(".close_click").dblclick(function(){
					var student_id=$(this).find("[id='student_id']").val();
					var student_name=$(this).find("[id='student_name']").val();
					bootbox.confirm("确定要添加此学生？",function(result){
						if(result){
							if('${pd.is_show}'=='searchStudent'){//课程添加学生
								window.location.href='<%=basePath%>arrange/save.do?STUDENT_ID='+student_id+'&COURSE_ID='+$("#COURSES_ID").val();
							}
							if('${pd.is_show}'=='student'){ //家长添加学生
								window.location.href='<%=basePath%>webuser/save.do?STUDENT_ID='+student_id+'&USERS_ID='+$("#USERS_ID").val();
							}
							if('${pd.is_show}'=='search_student'){ //礼物兑换查找学生
								$("#stu").val(student_id);
								$("#stuName").val(student_name);
								top.Dialog.close();
							}
						}
					})
				});
			} --%>
			
			//排序下拉框change事件
			$("#type").change(function(){
				$("#Form").submit();
			});
			$("#orderby").change(function(){
				$("#Form").submit();
			});
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
			 diag.URL = '<%=basePath%>student/goAdd.do';
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
					var url = "<%=basePath%>student/delete.do?STUDENT_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>student/goEdit.do?STUDENT_ID='+Id;
			 diag.Width = 1050;
			 diag.Height =1555;
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
						if('${pd.is_show}'=='searchStudent'){
							toadd="arrange";
						}else if('${pd.is_show}'=='student'){
							toadd="webuser";
						}
						if(msg == '确定要添加选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>'+toadd+'/addall.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str,"USERS_ID":$("#USERS_ID").val(),"COURSE_ID":$("#COURSES_ID").val()},
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
								url: '<%=basePath%>student/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>student/excel.do';
		}
	</script>


</body>
</html>