﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
</head>
<body class="no-skin">
<div id="zhongxin" style="padding-top: 13px;">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<!-- 检索  -->
							<form action="invest/userList.do" method="post" name="Form"
								id="Form">
								 <input type="hidden" name="PRODUCTSINFO_ID" id="PRODUCTSINFO_ID" value="${pd.PRODUCTSINFO_ID}"/>
								 <input type="hidden" name="usersid" id="usersid" value="${pd.usersid}"/>
								<table style="margin-top: 5px;">
									<tr>
										<td>
											<div class="nav-search">
												<span class="input-icon"> <input type="text"
													placeholder="昵称" class="nav-search-input"
													id="nav-search-input" autocomplete="off" style="width:145px;" name="keywords"
													title="这里输入昵称" /> <i
													class="ace-icon fa fa-search nav-search-icon"></i>
												</span>
											</div>
										</td>
										<td><input type="hidden" placeholder="用户类型分组"
											class="user_groupid" id="user_groupid" autocomplete="off"
											name="user_groupid" value="${pd.user_groupid }" /></td>
										<td><input type="hidden" placeholder="识别分组类型"
											class="user_parentid" id="user_parentid" autocomplete="off"
											name="user_parentid" value="${pd.user_parentid }" /></td>
										<c:if test="${QX.cha == 1 }">
											<td style="vertical-align: top; padding-left: 2px"><a
												class="btn btn-light btn-xs" onclick="tosearch();"
												title="查询"><i id="nav-search-icon"
													class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
										</c:if>
										<c:if test="${QX.toExcel == 1 }">
											<td style="vertical-align: top; padding-left: 2px;"><a
												class="btn btn-light btn-xs" onclick="toExcel();"
												title="导出到EXCEL"><i id="nav-search-icon"
													class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
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
												disabled="disabled"	id="zcheckbox" /><span class="lbl"></span></label></th>
											<th class="center" style="width: 50px;">序号</th>
											<th class="center" hidden="hidden">用户ID</th>
											<th class="center">昵称</th>
											<th class="center">电话号码</th>
											<th class="center" hidden="hidden">密码</th>
											<th class="center">等级</th>
											<th class="center">微信号</th>
											<th class="center">认证状态</th>
											<th class="center">注册时间</th>
											<!-- <th class="center">操作</th> -->
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td class='center'><label class="pos-rel"><input
																	type='checkbox' name='ids' value="${var.USERINFO_ID}"
																	onclick="addUsersId(this);" class="ace" /><span class="lbl"></span></label></td>
															<td class='center' style="width: 30px;">${vs.index+1}</td>
															<td class='center' hidden="hidden">${var.USERINFO_ID}</td>
															<td class='center'>${var.USER_NICKNAME}</td>
															<td class='center'>${var.USER_PHONE}</td>
															<td class='center' hidden="hidden">${var.USER_PASSWORD}</td>
															<td class='center'>${var.LEVEL_NAME}</td>
															<!--<td class='center'><img src="${var.USER_PHOTO}" alt="${var.USER_PHOTO}"/> </td>-->
															<td class='center'>${var.USER_OPPNID}</td>
															<td class='center'>
																<c:choose>
																	<c:when test="${var.USER_ATTESTATION == 0}">
																		<span style="color: red;">未认证</span>
																	</c:when>
																	<c:otherwise>
																		<span>已认证</span>
																	</c:otherwise>
																</c:choose>
															</td>

															<td class='center'>${var.USER_CREATETIME}</td>
															<%-- <td class="center"><c:if
																	test="${QX.edit != 1 && QX.del != 1 && QX != 1 }">
																	<span
																		class="label label-large label-grey arrowed-in-right arrowed-in"><i
																		class="ace-icon fa fa-lock" title="无权限"></i></span>
																</c:if>
																
																
																<div class="hidden-md hidden-lg">
																	<div class="inline pos-rel">
																		<c:if test="${QX.edit == 1 }">
																			<a style="cursor: pointer;"
																				onclick="del('${var.USERINFO_ID}');"
																				class="tooltip-success" data-rel="tooltip"
																				title="删除"> <span class="red"> <i
																							class="ace-icon fa fa-trash-o bigger-120"></i>
																				</span>
																			</a>
																		</c:if>
																	</div>
																</div></td> --%>
																
																
																
																
																<!--<td class="center"><c:if
																	test="${QX.edit != 1 && QX.del != 1 && QX != 1 }">
																	<span
																		class="label label-large label-grey arrowed-in-right arrowed-in"><i
																		class="ace-icon fa fa-lock" title="无权限"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs btn-group">
																	<c:if test="${QX.edit == 1 }">
																		<a class="btn btn-xs btn-success" title="编辑"
																			onclick="edit('${var.USERINFO_ID}');"> <i
																			class="ace-icon fa fa-pencil-square-o bigger-120"
																			title="编辑"></i>
																		</a>
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<a class="btn btn-xs btn-danger"
																			onclick="del('${var.USERINFO_ID}');"> <i
																			class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
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
																					onclick="edit('${var.USERINFO_ID}');"
																					class="tooltip-success" data-rel="tooltip"
																					title="修改"> <span class="green"> <i
																							class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																					</span>
																				</a></li>
																			</c:if>
																			<c:if test="${QX.del == 1 }">
																				<li><a style="cursor: pointer;"
																					onclick="del('${var.USERINFO_ID}');"
																					class="tooltip-error" data-rel="tooltip" title="删除">
																						<span class="red"> <i
																							class="ace-icon fa fa-trash-o bigger-120"></i>
																					</span>
																				</a></li>
																			</c:if>
																		</ul>
																	</div>
																</div></td>-->
																
															<!--<td  class="alert alert-warning center">禁止操作</td>-->
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
													<td colspan="100" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
									<table style="width: 100%;">
										<tr>
											<td style="vertical-align: top;">
												<c:if
													test="${QX.add == 1 }">
													<a class="btn btn-mini btn-success" onclick="guanlianUsers();">新增</a>
												</c:if> <%-- <c:if test="${QX.del == 1 }">
													<a class="btn btn-mini btn-danger"
														onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除"><i
														class='ace-icon fa fa-trash-o bigger-120'></i></a>
												</c:if> --%>
											</td>
											<td style="vertical-align: top;"><div class="pagination"
													style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
										</tr>
									</table>
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
	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up"
		class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
		$(function() {
			var successFlag =  "${success}";
			if(successFlag == "Y"){														  <%-- "<%=basePath%>/invest/list.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}" --%>
				parent.parent.$("#_DialogFrame_0").contents().find("#myFrame").attr("src","<%=basePath%>/invest/list.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}");	
				top.Dialog.close();
				$(top.hangge());//关闭加载状态
			}
			
			
			
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
				var th_checked = $(this).checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = $(this);
					if(th_checked) {$(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);}
					else {$(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);}
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>userinfo/goAdd.do';
			 diag.Width = 850;
			 diag.Height = 405;
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
		
		//保存打钩的用户id
		function addUsersId(fn){
			//勾选 true 关联该属性
			
			//alert(fn);
			 if($(fn).is(':checked')){
				 var str =$("#usersid").val();
				  /* alert(str); */
				 str+=$(fn).val()+",";
				 $("#usersid").val(str);
				 // alert(str); 
				
			}else{
				 var str =$("#usersid").val();
				 sr = $(fn).val()+",";
				 /* alert(sr); */
				 str=str.replace(sr,"");
				 $("#usersid").val(str);
				  //alert(str); 
				  
			}
			
		}
		
		//新增用户
		function guanlianUsers(){
			$("#Form").attr("action","invest/guanlianUesr.do");
			$("#Form").submit();
		}
		
		
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>userinfo/delete.do?USERINFO_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>userinfo/goEdit.do?USERINFO_ID='+Id;
			 diag.Width = 1050;
			 diag.Height = 635;
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
								url: '<%=basePath%>userinfo/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>userinfo/excel.do';
		}
	</script>


</body>
</html>