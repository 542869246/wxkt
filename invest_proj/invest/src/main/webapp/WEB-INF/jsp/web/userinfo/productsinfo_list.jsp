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
<body class="no-skin" >

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
					
					
						<div class="col-xs-12" style="padding: 0px; margin: 0px;">
							
						<!-- 检索  -->
						<form action="userinfo/findProdictsByUserId.do" method="post" name="Form" id="Form">
						
						<table id="simple-table"
									class="table table-striped table-bordered table-hover"
									style="margin-bottom: 0px;">
										<thead>
											<tr>
												<th colspan="100" >
													<div>
													<select id="FindDICTIONARIES_ID" name="FindDICTIONARIES_ID" style="width: 170px;">
														<option value="" ${INVEST_DICTIONARIESID == ""?selected:""}>请选择..</option>
														<c:forEach items="${dictList}" var="dict" varStatus="vs">
															<option value="${dict.DICTIONARIES_ID }" ${INVEST_DICTIONARIESID == dict.DICTIONARIES_ID?"selected":""}>${dict.NAME }</option>
														</c:forEach>
														<option hidden="hidden" value="empty" ${INVEST_DICTIONARIESID == "empty"?"selected":""}>其它类型</option>
													</select>
													<a style="margin: 0px;" class="btn btn-light btn-xs" onclick="tosearch();" title="查询">
														<i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>
													</a>
													</div>
												</th>
											</tr>
											<tr>
												<th class="center" style="width: 50px;">序号</th>
												<th class="center" hidden="hidden">用户ID</th>
												<th class="center" hidden="hidden">微信号</th>
												<th class="center">产品名称</th>
												<th class="center">购买时间</th>
												<th class="center">产品类型</th>
												<th class="center">操作</th>
											</tr>
										</thead>
										<tbody id="products">
										<!-- 这里开始循环-->
										<c:choose>
											<c:when test="${not empty varList}"> 
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td hidden="hidden">
																<input name="investId" value="${var.INVEST_ID }"/>
															</td>
															<td hidden="hidden" class='center'><label class="pos-rel"><input
																	type='checkbox' name='ids' value="${var.USERINFO_ID}"
																	class="ace" /><span class="lbl"></span></label>
															</td>
															<td class='center' style="width: 30px;">${vs.index+1}</td>
															<td class='center' hidden="hidden">${pd.USERINFO_ID}</td>
															<td class='center' hidden="hidden">${pd.USER_OPPNID}</td>
															<td hidden="hidden"><input name="INVEST_PRODICTS_ID" lang="${var.INVEST_PRODICTS_ID}"/></td>
															<td class='center'>${var.PRODUCTS_NAME}</td>
															<td class='center'>${var.INVEST_CREATETIME}</td>
															<!--<td class='center'>${var.INVEST_DICTIONARIESID}</td>-->
															
															<td class='center'>${var.NAME}</td>
															<%-- <td class='center'>
																<select id="DICTIONARIES_ID" name="DICTIONARIES_ID" lang="${var.INVEST_DICTIONARIESID }">
																<option value="" ${var.INVEST_DICTIONARIESID == ""?selected:""}>请选择..</option>
																	<c:forEach items="${dictList}" var="dict" varStatus="vs">
																		<option value="${dict.DICTIONARIES_ID }" ${var.INVEST_DICTIONARIESID == dict.DICTIONARIES_ID?"selected":""}>${dict.NAME }</option>
																	</c:forEach>
																</select>
															</td> --%>
															
															
															<td class="center">
																<div class="hidden-sm hidden-xs btn-group">
																		<a class="btn btn-xs btn-danger delProducts" lang="{`-INVEST_ID`-:`-${var.INVEST_ID }`-, `-USERINFO_ID`-:`-${pd.USERINFO_ID}`-}"> 
																			<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																		</a>
																</div>
																<div class="hidden-md hidden-lg">
																	<div class="inline pos-rel">
																		<a class="btn btn-xs btn-danger delProducts" lang="{`-INVEST_ID`-:`-${var.INVEST_ID }`-, `-USERINFO_ID`-:`-${pd.USERINFO_ID}`-}"> 
																			<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																		</a>
																	</div>
																</div>
															</td>
														</tr> 
													</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="100" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose> 
									</tbody>
								</table>
								
								
						<!-- 分页 -->		
						<div class="page-header position-relative" style="margin: 0px; padding: 0px;">
							<table style="width:100%;">
								<tr>
									<td style="vertical-align:top;"><div class="pagination" style="float: right;padding: 10px;margin: 0px;">${page.pageStr}</div></td>
								</tr>
							</table>
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
		
		<%-- //当这个下拉框失去焦点的同时把这个复选框修改的值保存到数据库
		$("select[name='DICTIONARIES_ID']").blur(function(){
			var beforeDict = $(this).attr("lang");
			var endDict = $(this).val(); 
			var investId = $(this).parent().siblings().children("input[name='investId']").val();
			if(beforeDict != endDict){
				$(this).attr("lang",endDict);
				$.ajax({
					type:"post",
					data:{
						"INVEST_DICTIONARIESID":endDict,
						"INVEST_ID":investId
					},
					dataType:"JSON",
					url:"<%=basePath%>userinfo/updateEndDict.do"
				});
			}
		}); --%>
		
		// 给删除用户已购产品添加绑定事件
		$("#products").on("click",".delProducts",function(){
			if (!confirm("您确定要删除吗？？"))
				return false;
			var userAndProd = $(this).attr("lang");
			$.ajax({
				type:"post",
				url:"<%=basePath%>userinfo/delProducts.do",
				data:{"userAndProd":userAndProd}
			});
			window.location.reload();
		})
		
		
		
		
		$(function() {
		
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
			 diag.URL = '<%=basePath%>productsinfo/goAdd.do';
			 diag.Width = 800;
			 diag.Height = 750;
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
					var url = "<%=basePath%>productsinfo/delete.do?PRODUCTSINFO_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>productsinfo/goEdit.do?PRODUCTSINFO_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 700;
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
								url: '<%=basePath%>productsinfo/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>productsinfo/excel.do';
		}
	</script>


</body>
</html>