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
	<base href="<%=basePath%>"
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<style type="text/css">
	</style>
	<script type="text/javascript">
</script>
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
					
					<!-- ztree 下拉列表 -->
					<div id="menuContent" class="menuContent" style="margin:0 auto;display:none; position: absolute;z-index:999;background-color:#fff;" >
						<ul id="treeDemo" class="ztree" style="margin-top:0; width:98%;"></ul>
					</div>
					
					
					<form action="information/editGroupUser.do" name="Form" id="Form" method="post">
						<input type="hidden" name="flag" id="flag" value="${pd.flag }"/>
						<input type="hidden" name="INFORMATION_ID" id="INFORMATION_ID" value="${pd.INFORMATION_ID}"/>
						<input type="hidden" name="INFORMATION_INFO_ID" id="PRODUCTSINFO_ID" value="${pd.INFORMATION_INFO_ID }"/>
						<input type="hidden" name="GROUPBY_USER_ID" id="GROUPBY_USER_ID" value="${pd.GROUPBY_USER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr style="display:none">
								<td style="width:75px;text-align: right;padding-top: 13px;">编号:</td>
								<td><input type="text" name="GROUPBY_ID" id="GROUPBY_ID" value="${pd.GROUPBY_ID}" maxlength="40" placeholder="这里输入编号" title="编号" style="width:48%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">产品名称:</td>
								<td><input type="text" name="PRODUCTS_NAME" id="PRODUCTS_NAME" value="${pd.PRODUCTS_NAME}" maxlength="40" placeholder="这里输入产品名称" title="产品名称" style="width:48%;" readonly/></td>
							</tr>
							
							<tr>
									<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
									<td><input id="typeName" type="text" placeholder="点击选择类型" class="nav-search-input"  autocomplete="off" name="typeName" readonly value="" style="width:100px;"  onclick="showMenu();"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">存续内容:</td>
								<td>
									<%-- <input type="d" value="${pd.INFORMATION_CONTENT}"> --%>
								  <textarea id="INFORMATION_CONTENT" readonly="readonly" name="INFORMATION_CONTENT" cols="43"  rows="5" >${pd.INFORMATION_CONTENT}</textarea> 
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	<!-- 编辑框-->
	
	<!-- 编辑框-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	
	<!-- ztree JS -->
	<script type="text/javascript">
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
			//	beforeClick: beforeClick,
				onClick: onClick
			}
		};


		//function beforeClick(treeId, treeNode) {
		//	var check = (treeNode && !treeNode.isParent);
		//	if (!check) alert("只能选择城市...");
		//	return check;
		//}
		var oldv;
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
			saveValue(v,id);
		}
		<!-- 保存下拉列表的值 -->
		function saveValue(v,id){
			var cityObj = $("#typeName");
			var type = $("#GROUPBY_USER_ID");
			if(oldv != v){
				cityObj.attr("value", v);
				type.attr("value", id);
				oldv =v;
			}
		}

		function showMenu() {
			var cityObj = $("#typeName");
			var cityOffset = $("#typeName").offset();
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
		
		//回显属性类型
		function selectTypeName(treeObj){
				var nodes = treeObj.getNodes();
				var node = treeObj.getNodeByParam("id", "${pd.GROUPBY_USER_ID}");//根据ID获取节点
				treeObj.selectNode(node);//显示选中节点
				$("#typeName").val(node.name);//给类型赋值
				$("#GROUPBY_USER_ID").val(node.id);
		}
		 //批量修改默认值
		function batchUpdate (attrList){
			for(var i = 0;i < i<attrList.length; i++) {
				alert(attrList[i]+",");
			}		 
		 }
		 
		
		$(document).ready(function(){
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
			//修改时默认显示属性的类型
			if( ${msg eq 'edit'}){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				selectTypeName(treeObj);//调用回显方法
			}
			
		});
		
		
		
	</script>
	
	
	
		<script type="text/javascript">
		
		$(top.hangge());
		//保存
		if(${msg == 'save'}){
			$("#PRODUCTS_NAME").parent().parent().hide();
		}
		
		function save(){
			    
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		/* $(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		}); */
		</script>
</body>
</html>