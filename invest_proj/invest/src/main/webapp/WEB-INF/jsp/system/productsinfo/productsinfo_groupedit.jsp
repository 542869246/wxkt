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
	<style type="text/css">
		.mytab{
			    border: 0;
			    width: 90pt;
			    height: 28px;
			    line-height: 28px;
			    background-color: #eef0ee;
			    white-space: nowrap;
			    z-index: 101;
			    outline: 0;
			}
		.active{
			background-color: #438eb9;
   			color: #fff;
		} 
	</style>
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
		var oldv1="-1";
		var oldv="0";
		function onClick(e, treeId, treeNode) {
			var zTree = null;
			if(CurInput =='1'){
				zTree= $.fn.zTree.getZTreeObj("treeDemo");
			}else{
				zTree= $.fn.zTree.getZTreeObj("treeAttrDemo");
			}
			nodes = zTree.getSelectedNodes(),
			v = "";
			id="";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id=nodes[i].id;
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			if(CurInput =='1'){
				saveValue1(v)
			}else{
				saveValue(v)
			}
			;
		}
		<!-- 保存下拉列表的值 -->
		function saveValue(v){
			var cityObj = $("#attrSel");
			var type = $("#ATTR_TYPEID");
			if(oldv != v ){
				type.attr("value", id);
				cityObj.attr("value", v);
				oldv=v;
			}
		}<!-- 保存下拉列表的值 -->
		function saveValue1(v){
			var cityObj = $("#citySel");
			var type = $("#PRODUCTS_TYPE1_ID");
			if(oldv1 != v ){
				type.attr("value", id);
				cityObj.attr("value", v);
				oldv1=v;
			}
		}

		function showMenu(fn) {
			
			if(fn=='1'){
				CurInput = '1';
				var cityObj = $("#citySel");
				var cityOffset = $("#citySel").offset();
				$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

				$("body").bind("mousedown", onBodyDown);
			}else{
				CurInput = '0';
				var cityObj = $("#attrSel");
				var cityOffset = $("#attrSel").offset();
				$("#menuAttrContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

				$("body").bind("mousedown", onBodyDown1);
			}
			
		}
		//隐藏产品类型树状图
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		//隐藏产品属性树状图
		function hideMenu1() {
			$("#menuAttrContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown1(event) {
			if (!(event.target.id == "menuAttrContent" || $(event.target).parents("#menuAttrContent").length>0)) {
				hideMenu1();
			}
		}
		
		//回显产品类型
		function huiXian(treeObj){
				var nodes = treeObj.getNodes();
				var node = treeObj.getNodeByParam("id", "${pd.PRODUCTS_TYPE1_ID}");//根据ID获取节点
				treeObj.selectNode(node);//显示选中节点
				$("#citySel").val(node.name);//给类型赋值
				$("#PRODUCTS_TYPE1_ID").val(node.id);
				
		}
		
		
		$(document).ready(function(){
			//加载产品类型树状图
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
			
			//加载产品属性树状图
			var zna = '${zTreeAttrNodes}';
			/* console.log(zna); */
			var zTreeAttrNodes = eval(zna);
			/* console.log(zTreeAttrNodes); */
			$.fn.zTree.init($("#treeAttrDemo"), setting, zTreeAttrNodes);
			
			
			//修改时默认显示属性的类型
			if( ${msg eq 'edit'}){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				huiXian(treeObj);//调用回显方法
			}
		});
		
	</SCRIPT>
	
	<!-- 点击多选按钮对属性进行增删操作 -->
	<!-- <script type="text/javascript">
		/* 给多选框绑定单击事件 */
		
		function refEdit(obj){
			alert($(obj).is(':checked'));
			if($(obj).is(':checked')) {
				var proid = $("#PRODUCTSINFO_ID").val();
				alert(proid);
				var attrid = $(obj).val();
				alert(attrid);
			}
		}
	</script> -->
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
					
					<!-- 产品类型下拉树 -->
					<div id="menuContent" class="menuContent" style="width:150px;display:none; position: absolute;z-index:999;background-color:#fff;" >
						<ul id="treeDemo" class="ztree" style="margin-top:0; width:150px;"></ul>
					</div>
					<!-- 产品属性下拉树 -->
					<div id="menuAttrContent" class="menuContent" style="width:150px;display:none; position: absolute;z-index:999;background-color:#fff;" >
						<ul id="treeAttrDemo" class="ztree" style="margin-top:0; width:150px;"></ul>
					</div>
					<form action="productsinfo/${msg }.do" name="Form" id="Form" method="post" enctype="Multipart/form-data" >
						<input type="hidden" name="PRODUCTSINFO_ID" id="PRODUCTSINFO_ID" value="${pd.PRODUCTSINFO_ID}"/>
						<input type="hidden" name="PRODUCTS_TYPE1_ID" id="PRODUCTS_TYPE1_ID" value="${pd.PRODUCTS_TYPE1_ID}"/>
						<%-- 属性<input type="text" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/> --%>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">产品名称:</td>
								<td><input type="text" name="PRODUCTS_NAME" id="PRODUCTS_NAME" value="${pd.PRODUCTS_NAME}" maxlength="50" placeholder="这里输入产品名称" title="产品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">产品类型:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<div class="nav-search">
											&nbsp;&nbsp;<input id="citySel" type="text" placeholder="点击选择类型" disabled="disabled"  class="nav-search-input"  autocomplete="off" name="attrType"  style="width:20%;"  onclick="showMenu(1);return false;"/>
											<a onclick="document.getElementById('citySel').value='';document.getElementById('PRODUCTS_TYPE1_ID').value='';" style="cursor:pointer;">清空</a>
										</span>
									</div>
								</td>
								<%-- <td><input type="text" name="PRODUCTS_TYPE1_ID" id="PRODUCTS_TYPE1_ID" value="${pd.NAME}" maxlength="40" placeholder="这里输入模块类型" title="模块类型" style="width:98%;"/></td> --%>
							</tr>
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">属性类型:</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<div class="nav-search">
											<input id="attrSel" type="text" placeholder="点击选择类型"  class="nav-search-input"  autocomplete="off" name="attrSel"   style="width:20%;"  onclick="showMenu(0);return false;"/>
											<a onclick="document.getElementById('attrSel').value='';document.getElementById('ATTR_TYPEID').value='';" style="cursor:pointer;">清空</a>
										</span>
									</div>
								</td>
							</tr> -->
							<%-- <tr>
								<td colspan="2">
									<div class="panel panel-default">
								    <div class="panel-body">
								    	<!-- 遍历产品相关联的属性 -->
								    	<c:if test="${empty varsList }">
								    		<span>请选择属性...</span>
								    	</c:if>
								    	<c:forEach var="attr" items="${varsList }">
								    		<input type="checkbox" name="attrbute" value="${attr.ATTRIBUTE_ID }" onclick="refEdit(this);" />${attr.ATTR_NAME  }&nbsp;&nbsp;&nbsp;
								    	</c:forEach>
								    </div>
								</div>
								</td>
								
							</tr> --%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标签:</td> 
								<td><input type="text" name="PRODUCTS_COUNTERSTATE" id="PRODUCTS_COUNTERSTATE" value="${pd.PRODUCTS_COUNTERSTATE}" maxlength="50" placeholder="这里输入标签一" title="标签一:" style="width:30%;"/>|<input type="text" name="PRODUCTS_PAPERSTATE" id="PRODUCTS_PAPERSTATE" value="${pd.PRODUCTS_PAPERSTATE}" maxlength="50" placeholder="这里输入标签二" title="标签二" style="width:30%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">首期缴费比例:</td>
								<td><input type="text" name="PRODUCTS_SQJFBI" id="PRODUCTS_SQJFBI" value="${pd.PRODUCTS_SQJFBI}" maxlength="50" placeholder="这里输入首期缴费比例" title="首期缴费比例" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">折线图:</td>
								<td><input type="file" id="IMG_URL" name="uploadFile"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">业绩比较基准:</td>
								<td><input type="text" name="PRODUCTS_YJBJJZ" id="PRODUCTS_YJBJJZ" value="${pd.PRODUCTS_YJBJJZ}" maxlength="50" placeholder="这里输入业绩比较基准" title="业绩比较基准" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">首期投入:</td>
								<td><input type="text" name="PRODUCTS_START" id="PRODUCTS_START" value="${pd.PRODUCTS_START}" maxlength="50" placeholder="这里输入首期投入" title="首期投入" style="width:98%;"/></td>
							</tr>
							<%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="PRODUCTS_CREATEBY" id="PRODUCTS_CREATEBY" value="${pd.PRODUCTS_CREATEBY}" maxlength="50" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
							</tr> --%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">基准:</td>
								<td><input type="text" name="PRODUCTS_ATTRIBUTE" id="PRODUCTS_ATTRIBUTE" value="${pd.PRODUCTS_ATTRIBUTE}" maxlength="50" placeholder="这里输入基准" title="基准" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">预期投资天数:</td>
								<td><input type="text" name="PRODUCTS_TERM" id="PRODUCTS_TERM" value="${pd.PRODUCTS_TERM}" maxlength="50" placeholder="这里输入预期投资天数" title="预期投资天数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">最大投资金额:</td>
								<td><input type="text" name="PRODUCTS_AMOUT" id="PRODUCTS_AMOUT" value="${pd.PRODUCTS_AMOUT}" maxlength="50" placeholder="这里输入最大投资金额" title="最大投资金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">年化收益:</td>
								<td><input type="text" name="PRODUCTS_NHSR" id="PRODUCTS_NHSR" value="${pd.PRODUCTS_NHSR}" maxlength="50" placeholder="这里输入年化收益" title="年化收益" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">概要:</td>
								<td><input type="text" name="PRODUCTS_TEXT" id="PRODUCTS_TEXT" value="${pd.PRODUCTS_TEXT}" maxlength="50" placeholder="这里输入首文本" title="文本" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收益:</td>
								<td><input type="text" name="PRODUCTS_INCOME" id="PRODUCTS_INCOME" value="${pd.PRODUCTS_INCOME}" maxlength="50" placeholder="这里输入收益" title="收益" style="width:98%;"/></td>
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

<!-- tab 切换选项卡 -->
<c:if test="${pd.PRODUCTSINFO_ID!=null}">
	<div style="height: 29px;width: 98%;margin:0px auto;border-bottom: 1px solid #4F99C6;padding-left:5px;">
		<button class="mytab active" 
			onclick="javascript:mytab.active(this,mytab.productMation);">存续信息</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productZiliao);">${pd.PRODUCT_MENU==null?'相关资料':pd.PRODUCT_MENU}</button>
		<button class="mytab" 
			onclick="mytab.active(this,mytab.productNews);">${pd.PRODUCT_MENU==null?'相关新闻':pd.ROOM_MENU}</button>
			<button class="mytab" 
			onclick="mytab.active(this,mytab.productAttr);">${pd.PRODUCT_MENU==null?'其他属性':pd.ROOM_MENU}</button>
			<button class="mytab" 
			onclick="mytab.active(this,mytab.productUsers);">${pd.PRODUCT_MENU==null?'购买用户':pd.ROOM_MENU}</button>
	</div>
	<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
</c:if>
<!-- /.main-container -->
	
	
	<!-- 产品联动 -->
	 <script type="text/javascript" src="static/js/njms.area.1.1.js"></script> 

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
		//保存
		function save(){
			if($("#PRODUCTS_NAME").val()==""){
				$("#PRODUCTS_NAME").tips({
					side:3,
		            msg:'请输入产品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCTS_NAME").focus();
			return false;
			}
			if($("#citySel").val()==""){
				$("#citySel").tips({
					side:3,
		            msg:'请输入产品类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#citySel").focus();
			return false;
			}
			 /* if($("#PRODUCTS_SQJFBI").val()==""){
				$("#PRODUCTS_SQJFBI").tips({
					side:3,
		            msg:'请输入业绩比较基准',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCTS_SQJFBI").focus();
			return false;
			}
			if($("#PRODUCTS_START").val()==""){
				$("#PRODUCTS_START").tips({
					side:3,
		            msg:'请输入首期投入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCTS_START").focus();
			return false;
			}  */
			var reg = /^\d+(\.\d+)?$/; 
			if($("#PRODUCTS_SQJFBI").val()!=""){
				if(reg.test($("#PRODUCTS_SQJFBI").val())==false){
					$("#PRODUCTS_SQJFBI").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_SQJFBI").focus();
				return false;
				} 
			}
			var reg = /^\d+(\.\d+)?$/; 
			if($("#PRODUCTS_START").val()!=""){
				if(reg.test($("#PRODUCTS_START").val())==false){
					$("#PRODUCTS_START").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_START").focus();
				return false;
				} 
			}
			if($("#PRODUCTS_TERM").val()!=""){
				if(reg.test($("#PRODUCTS_TERM").val())==false){
					$("#PRODUCTS_TERM").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_TERM").focus();
				return false;
				} 
			}
			if($("#PRODUCTS_AMOUT").val()!=""){
				if(reg.test($("#PRODUCTS_AMOUT").val())==false){
					$("#PRODUCTS_AMOUT").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_AMOUT").focus();
				return false;
				} 
			}
			if($("#PRODUCTS_NHSR").val()!=""){
				if(reg.test($("#PRODUCTS_NHSR").val())==false){
					$("#PRODUCTS_NHSR").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_NHSR").focus();
				return false;
				} 
			}
			if($("#PRODUCTS_INCOME").val()!=""){
				if(reg.test($("#PRODUCTS_INCOME").val())==false){
					$("#PRODUCTS_INCOME").tips({
						side:3,
			            msg:'输入格式错误',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#PRODUCTS_INCOME").focus();
				return false;
				} 
			}
			//判断上传文件类型是否为pdf
			var file=$("#IMG_URL")[0].value;
			//alert(file);
			var str=file.substring(file.lastIndexOf(".")+1); 
			if(str!="png"&&str!="jpg"){
				alert("上传文件必须为png/jpg格式!");
				return false;
			}	
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		
		
	//页面tab初始化
		$(document).ready(function(){
			$(".active").click();
			
		});
		var mytab = {
				productMation:"<%=basePath%>/information/list.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}",
				productZiliao:"<%=basePath%>/details/list.do?DETAILS_INFO_ID=${pd.PRODUCTSINFO_ID}",
				productNews:"<%=basePath%>/news/list.do?NEWS_PRODUCTS_ID=${pd.PRODUCTSINFO_ID}",
				productAttr:"<%=basePath%>/attribute/goShowAttr.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}",
				productUsers:"<%=basePath%>/invest/list.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}",
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