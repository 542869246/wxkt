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
			var type = $("#ATTR_TYPEID");
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
				var node = treeObj.getNodeByParam("id", "${pd.ATTR_TYPEID}");//根据ID获取节点
				treeObj.selectNode(node);//显示选中节点
				$("#typeName").val(node.name);//给类型赋值
				$("#ATTR_TYPEID").val(node.id);
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
					<c:choose>
						<c:when test="${msg eq 'goShowAttr' }">
							
							<form action="attribute/goShowAttr.do" method="post" id="Frm">
								<input type="hidden" name="PRODUCTSINFO_ID" id="PRODUCTSINFO_ID" value="${pd.PRODUCTSINFO_ID }"/>
								<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/>
								
								<table id="" class="table table-striped table-bordered table-hover">
									<!-- <tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
											<td>
												<input id="typeName" type="text" placeholder="点击选择类型"  class="nav-search-input" lang="p" autocomplete="off" name="typeName" readonly value=""  onclick="showMenu();"/>
												<a onclick="document.getElementById('typeName').value='';" style="cursor:pointer;">清空</a>
												<input type="submit" class="btn btn-xs btn-info" value="搜索" />
											</td>
											
									</tr> -->
									<thead>
										<tr>
											<th style="display:none">id</th>
											<th>属性名</th>
											<th>值</th>
											<th>排序</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${not empty attrList}">
										<!-- dd<input type="test" name="batchUpdate" id="batchUpdate" value=""/> -->
										<c:forEach var="attr" items="${attrList }">
											<tr>
												<td style="display:none"><input type="text" name="PRODUCTATTR_ATTR_TYPEID" value="${attr.PRODUCTATTR_ATTR_TYPEID }" /></td>
												<td style="vertical-align:middle;">${attr.ATTR_NAME }</td>
												<td><input type="text" id="ATTRVALUE" name="ATTRVALUE" value="${attr.PRO_ATTR_VAL }" /></td>
												<td><input type="number" name="ATTR_ASC" id="ATTR_ASC" value="${attr.PRO_ATTR_ASC }"/></td>
											</tr>
										</c:forEach>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
										</c:choose>
										<tr>
										<td style="text-align: center;" colspan="10">
											<a class="btn btn-mini btn-warning" onclick="attrs('${pd.PRODUCTSINFO_ID}');">关联</a>
											<a class="btn btn-mini btn-primary" onclick="edit();">保存</a>
											<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
										</td>
								</tr>
									</tbody>
								</table>
							</form>
						</c:when>
						<c:otherwise>
							<iframe name="postTo" style="display:none"></iframe>
							<form action="attribute/${msg }.do" name="Form" target="postTo" id="Form" method="post">
						<input type="hidden" name="ATTRIBUTE_ID" id="ATTRIBUTE_ID" value="${pd.ATTRIBUTE_ID}"/>
						<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
									<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
									<td><input id="typeName" type="text" placeholder="点击选择类型" class="nav-search-input"  autocomplete="off" name="typeName" readonly value="" style="width:98%;"  onclick="showMenu();"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">属性名:</td>
								<td><input type="text" name="ATTR_NAME" id="ATTR_NAME" value="${pd.ATTR_NAME}" maxlength="50" placeholder="这里输入属性名" title="属性名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">默认值:</td>
								<td><input type="text" name="ATTR_VALUE" id="ATTR_VALUE" value="${pd.ATTR_VALUE}" maxlength="200" placeholder="这里输入默认值" title="默认值" style="width:98%;"/></td>
							</tr>
							<!-- 
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
								<td><input type="text" name="typeName" id="typeName" value="${pd.typeName}" maxlength="40" placeholder="这里输入类型" title="类型" style="width:98%;"/></td>
							</tr>
							 -->
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
						</c:otherwise>
					</c:choose>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		
		//修改
		function attrs(id){
		
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="关联属性";
			 diag.URL ="<%=basePath%>attribute/guanlianAttrlist.do?PRODUCTSINFO_ID="+id;
			 diag.Width = 1000;
			 diag.Height = 750;
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
		
		//保存
		function save(){
			 if($("#typeName").val()==""){
				$("#typeName").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#typeName").focus();
			return false;
			} 
			 if($("#ATTR_NAME").val()==""){
				$("#ATTR_NAME").tips({
					side:3,
		            msg:'请输入属性名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ATTR_NAME").focus();
			return false;
			} 
			if($("#ATTR_VALUE").val()==""){
				$("#ATTR_VALUE").tips({
					side:3,
		            msg:'请输入默认值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ATTR_VALUE").focus();
			return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		function edit(){
			$("#Frm").attr("action","attribute/editVal.do"); 
			
			/* var at = $("input[name=ATTRVALUE]");
			var pi = $("input[name=PRODUCTATTR_ATTR_TYPEID]");
			alert(at.length);
			alert(pi.length);
			  $.ajax({
				type:"post",
				url:"attribute/editVal.do",
				data:{"ATTRVALUE":at,"PRODUCTATTR_ATTR_TYPEID":pi},
				dataType:'JSON',
				async:false,
				success:function  (obj) {
					console.log(obj);
				},
				error:function  (obj) {
					console.log(obj);
				}  
			  }); */
			/*  if($("#typeName").val()==""){
				$("#typeName").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#typeName").focus();
			return false;
			}  */
			 /* if($("#ATTR_NAME").val()==""){
				$("#ATTR_NAME").tips({
					side:3,
		            msg:'请输入属性名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ATTR_NAME").focus();
			return false;
			}  */
			if($("#ATTRVALUE").val()==""){
				$("#ATTRVALUE").tips({
					side:3,
		            msg:'请输入属性值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ATTRVALUE").focus();
			return false;
			}
			
			
			 $("#Frm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show(); 
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>