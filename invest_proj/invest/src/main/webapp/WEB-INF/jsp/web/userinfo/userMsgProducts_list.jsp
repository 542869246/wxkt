
.<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<form action="userProduct/listMess.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
						<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/>
						<!-- 保存选中的产品ID -->
						<input name="select_checkbox" lang="" hidden="hidden"/>
							<tr>
								<td style="vertical-align:top;padding-left:2px;">
								 	<div class="nav-search">
										<span class="input-icon"><strong>类型:</strong>
											<input id="citySel" type="text" placeholder="点击选择类型"  class="nav-search-input"  autocomplete="off" name="attrType"  value="${pd.attrType}"   onclick="showMenu(); return false;"/>
											<a onclick="document.getElementById('citySel').value='';document.getElementById('ATTR_TYPEID').value='';" style="cursor:pointer;">清空</a>
										</span>
									</div>
								</td>
								
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:30px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width: 35px;">
										<label class="pos-rel">
											<input type="checkbox" class="ace" id="zcheckbox" />
											<span class="lbl"></span>
										</label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">产品名称</th>
									<th class="center" hidden="hidden">属性名</th>
									<th class="center" hidden="hidden">默认值</th>
									<th class="center">基金类型</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
												<tr style="background-color:rgba(5f,5f,5f,0.3)">
												
													<td class='center'>
														<label class="pos-rel">
															<input type='checkbox' name='ids' value="${var.PRODUCTSINFO_ID}" ${var.iscz == 'iscz'?"checked disabled":""} class="ace" />
															<span class="lbl"></span>
														</label>
													</td>
													
													<td class='center' style="width: 30px;">${vs.index+1}
													</td>
													<td class='center'>${var.PRODUCTS_NAME}</td>
													<td class='center' hidden="hidden">${var.ATTR_NAME}</td>
													<td class='center' hidden="hidden">${var.ATTR_VALUE}</td>
													<td class='center'>${var.NAME }</td>
													
												</tr>
									</c:forEach>
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
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-success" id="batchSave" title="添加已选">添加已选</a>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>

<!-- tab 切换选项卡 -->
<c:if test="${pd.PRODUCT_ID!=null}">
	<div style="height: 29px;width: 98%;margin:0px auto;border-bottom: 1px solid #4F99C6;padding-left:5px;">
		<button class="mytab active" 
			onclick="javascript:mytab.active(this,mytab.productImgURL);">产品图片管理</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productCoreURL);">${pd.PRODUCT_MENU==null?'产品评分管理':pd.PRODUCT_MENU}</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productSetMeal);">${pd.ROOM_MENU==null?'套餐管理':pd.ROOM_MENU}</button>
	</div>
	<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
</c:if>
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
	/*window.onload=function(){
		var radios=$('input[name="ids"]');
		for(var i=0;i<radios.length;i++){
			radios[i].onclick=function(){
				var status=$('input[name="ids"]:checked').val();
				alert(status);
			}
		}
	}*/
	
	
		$(document).on("click",".addproc",function(){
			var $xt = $(this).parents("tr");
			var $a=$(this);
			var ta=this.lang;
			$.ajax({
				type:"post",
				url:"<%=basePath%>userProduct/save.do",
				data:{"PRODUCTSINFO_ID":ta},
				success:function(res){
					console.info(res);
					$xt.css({'background-color':'rgba(5f,5f,5f,0.3)'});
					$a.attr("disabled","disabled");
					console.info(parent.parent.$("#_DialogFrame_0").contents().find("#products"));
				}
			});
		})
		
		
		$("#btnr").click(function(){
			var status=$('input[name="ids"]:checked').val();
			if(status ==null){
				alert("请选择一列产品");
			}else{
			var st=$('input[name="ids"]:checked').attr("lang");
			parent.parent.$("#_DialogFrame_0").contents().find("#MESSAGEINFO_PRODUCTS_ID").val(status);
			parent.parent.$("#_DialogFrame_0").contents().find("#PRODUCTS_NAME").val(st);
			top.Dialog.close();
			}
		})

		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		//批量新增
		$("#batchSave").on("click",function(){
			
			var select_checkbox = $("input[name='select_checkbox']").attr("lang");
			
			var select_checkbox = "";// select_checkbox  保存所选中的所有ID
			$("#simple-table > tbody > tr > td input[type=checkbox]").each(function(){
				var flag = $(this).attr("disabled");
				console.log();
				if(!flag && $(this).is(':checked')) select_checkbox += $(this).val()+",";
				$("input[name='select_checkbox']").attr("lang",select_checkbox);
			});
			
			console.log(window.parent.parent.$("#_DialogFrame_0").contents());
			  //window.parent.parent.$("#_DialogFrame_0").location.reload();
			if(null==select_checkbox || select_checkbox == ""){
				alert("您没有选择任何产品!");
				return false;
			}

			
			
			
			$.ajax({
				type: "POST",
				url: "<%=basePath%>userProduct/batchSave.do",
		    	data: {"select_checkbox":select_checkbox},
				success: function(res){
					if(res=="yes"){
						alert("添加成功！！");
						window.location.reload();
						parent.parent.$("#_DialogFrame_0").contents().find("#findProdictsFrame").attr("src","<%=basePath%>/userinfo/findProdictsByUserId.do");	
					}else{
						alert("添加失败！！");
					}
				}
			});
			
		});
		
		
		/*全选框是否被选中 开始*/
		function chekboxAll(){
			var flag = true; // 声明一个变量保存所有复选框是否选中
			$('#simple-table > tbody > tr > td input[type=checkbox]').each(function(){
				var thisFlag = $(this).attr("disabled");
				if(!thisFlag){
					flag=thisFlag;
				}
			});
		};
		/*全选框是否被选中 结束*/
		
		$(function() {
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = $(this);
					if(th_checked) {
						$(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					}else{
						$(row).removeClass(active_class).find('input[type=checkbox]').each(function(){
							if(!$(this).attr("disabled")){
								$(this).prop('checked', false);
							}
						});
					}
				});
			});
			/* 复选框全选控制 结束*/
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
		});
		
	</script>
	
	
	

	
	
		
</body>
</html>