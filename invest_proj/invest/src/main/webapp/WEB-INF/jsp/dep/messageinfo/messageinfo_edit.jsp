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
	<!-- ZTree css -->
	<link rel="stylesheet" href="plugins/ZTree_zjt/css/demo.css" type="text/css">
	<link rel="stylesheet" href="plugins/ZTree_zjt/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="plugins/File/File.css" type="text/css">
	
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
					<div id="zhongxin" style="padding-top: 13px;">
					<form action="messageinfo/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<!-- <input type="hidden" name="MESSAGEINFO_CONTEXT" id="MESSAGEINFO_CONTEXT"/> -->
						<!--<code id="testcon" style="display:none;">${pd.MESSAGEINFO_CONTEXT}</code>-->
						<input type="hidden" name="MESSAGEINFO_ID" id="MESSAGEINFO_ID" value="${pd.MESSAGEINFO_ID}"/>
						
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">标题:</td>
								<td><input type="text" name="MESSAGEINFO_TITLE" id="MESSAGEINFO_TITLE" value="${pd.MESSAGEINFO_TITLE}" maxlength="200" placeholder="这里输入标题" title="标题" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">选择分组:</td>
								<td>
								<!-- <input type="text" name="MESSAGEINFO_GROUP_ID" id="MESSAGEINFO_GROUP_ID" value="${pd.MESSAGEINFO_GROUP_ID}" maxlength="715827882" placeholder="这里输入分组编号" title="分组编号" style="width:98%;"/> -->
								<div class="content_wrap">
									<div class="zTreeDemoBackground left">
										<ul class="list"> 
											<li class="title"><input id="citySel" type="text" readonly value="${groupName}" style="width:98%;" onclick="showMenu();" /></li>
											<input type="hidden" name="MESSAGEINFO_GROUP_ID" id="MESSAGEINFO_GROUP_ID" value="${pd.MESSAGEINFO_GROUP_ID }" maxlength="715827882" placeholder="这里输入分组编号" title="分组编号" style="width:98%;"/>
										</ul>
									</div>
								
								</div>
								
								<div id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 10000">
									<ul id="treeDemo" class="ztree" style="margin-top:0; width:180px; height: 200px;"></ul>
								</div>
								</td>
							</tr>
							
							
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">选择产品:</td>
								<td><input type="text" id="PRODUCTS_NAME" onclick="proList();" value="${proName}" maxlength="40" placeholder="这里选择产品" readonly="readonly" title="产品编号" style="width:98%;"/>
									<input type="hidden" name="MESSAGEINFO_PRODUCTS_ID" id="MESSAGEINFO_PRODUCTS_ID"  value="${pd.MESSAGEINFO_PRODUCTS_ID}" maxlength="40" placeholder="这里输入产品编号" title="产品编号" />
								</td>
								
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">资料上传:</td>
								<td>
									<div style="float: left">
									<input name="MESSAGEINFO_STATE" type="radio" value="1"  <c:if test="${pd.MESSAGEINFO_STATE==1 }">checked</c:if>  />关联产品存续 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input name="MESSAGEINFO_STATE"  type="radio" value="0" <c:if test="${pd.MESSAGEINFO_STATE==0 }">checked</c:if>    />自定义上传&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<!-- <div id="tbhide" style="float: left">
									<a href="javascript:;"   class="file ">选择文件
    								<input type="file" name="uploadFile" id="uploadFile">
									</a>
									</div> -->
								</td>
							</tr>
							
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">状态:</td>
								<td><input type="number" name="MESSAGEINFO_STATE" id="MESSAGEINFO_STATE" value="${pd.MESSAGEINFO_STATE}" maxlength="32" placeholder="这里输入状态" title="状态" style="width:98%;"/></td>
							</tr>
							 -->
							
							 <tr id="tbhide">
								<td style="width:85px;text-align: right;padding-top: 13px;">pdf上传:</td>
								<td >
									<a href="javascript:;"   class="file ">+ 选择文件
    								<input type="file" name="uploadFile" id="uploadFile" onchange="getfilename();" accept=".pdf">
									</a>
									<label style="display: inline-block;transform:translate(20px,-12px)" id="pdfurl"></label>
									<input  type="hidden" name="MESSAGEINFO_URL" id="MESSAGEINFO_URL" value="${pd.MESSAGEINFO_URL }" readonly="readonly" style="width: 85%;" />
								</td>
							</tr>
						
							
							<tr id="inhide">
								<td style="width:85px;text-align: right;padding-top: 13px;">产品存续内容:</td>
								<td><input type="text" id="INFORMATION_CONTENT" onclick="infoList();"  value="${mationName}" maxlength="40" placeholder="选择产品续存" readonly="readonly"  title="产品续存" style="width:98%;"/>
									<input type="hidden" name="MESSAGEINFO_INFORMATION_ID" id="MESSAGEINFO_INFORMATION_ID"  value="${pd.MESSAGEINFO_INFORMATION_ID}" maxlength="40" placeholder="这里输入产品编号" title="产品编号" />
								</td>
							</tr>
							 
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">摘要:</td>
								<td>
									 <textarea style="resize: none"   cols="103" rows="6" name="MESSAGEINFO_CONTEXT" id="MESSAGEINFO_CONTEXT"  >${pd.MESSAGEINFO_CONTEXT}</textarea>
								 <!-- <script id="editor" type="text/plain" style="width:643px;height:259px;"></script> -->
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 编辑框-->
	<%-- <script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script> --%>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	
	<!-- zTree js -->
	<!-- <script type="text/javascript" src="plugins/ZTree_zjt/js/jquery-1.4.4.min.js"></script>  -->
	<script type="text/javascript" src="plugins/ZTree_zjt/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="plugins/ZTree_zjt/js/jquery.ztree.excheck.js"></script>
	
		<script type="text/javascript">
		
		
		window.onload=function(){

			var radios=$('input[name="MESSAGEINFO_STATE"]');
			if($('input[name="MESSAGEINFO_STATE"]:checked').val()==0){
				$("#inhide").hide();
				$("#tbhide").show(); 
			}else if($('input[name="MESSAGEINFO_STATE"]:checked').val()==1){
				$("#tbhide").hide();
				$("#inhide").show();
			}else{
				$(":radio[value=0]").attr("checked","checked");
				$("#inhide").hide();
				$("#tbhide").show(); 
			}
			for(var i=0;i<radios.length;i++){
				radios[i].onclick=function(){
					var status=$('input[name="MESSAGEINFO_STATE"]:checked').val();
					if(status==0){
						$("#inhide").hide();
						$("#tbhide").show(); 
					}else{
						$("#tbhide").hide();
						$("#inhide").show();
						

					}
				}
			}
		}
		
		
		if(${pd.MESSAGEINFO_CONTEXT!=null}){
		    window.setTimeout(setContent,1000);//一秒后再调用赋值方法
			}
			    //给ueditor插入值
			    function setContent(){
			        UE.getEditor('editor').execCommand('insertHtml', $('#testcon').html());
			        
			    	}
				    function getAllHtml() {
			
				        return UE.getEditor('editor').getAllHtml();
				    }
		$(top.hangge());
		
		function getfilename(){
			var f=document.getElementById("uploadFile").files;
			$("#pdfurl").html(f[0].name);
			
		}

		
		//保存
		function save(){
			if($("#MESSAGEINFO_TITLE").val()==""){
				$("#MESSAGEINFO_TITLE").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_TITLE").focus();
			return false;
			}
			/*if($("#MESSAGEINFO_CONTEXT").val()==""){
				$("#MESSAGEINFO_CONTEXT").tips({
					side:3,
		            msg:'请输入摘要',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_CONTEXT").focus();
			return false;
			}*/
			/*if($("#MESSAGEINFO_URL").val()==""){
				$("#MESSAGEINFO_URL").tips({
					side:3,
		            msg:'请输入文件上传',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_URL").focus();
			return false;
			}*/
			/* if($("#MESSAGEINFO_PRODUCTS_ID").val()==""){
				$("#MESSAGEINFO_PRODUCTS_ID").tips({
					side:3,
		            msg:'请选择产品',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_PRODUCTS_ID").focus();
			return false;
			} */
			if($("#MESSAGEINFO_STATE").val()==""){
				$("#MESSAGEINFO_STATE").tips({
					side:3,
		            msg:'请输入状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_STATE").focus();
			return false;
			}
			/* if($("#MESSAGEINFO_GROUP_ID").val()==""){
				$("#MESSAGEINFO_GROUP_ID").tips({
					side:3,
		            msg:'请输入分组编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MESSAGEINFO_GROUP_ID").focus();
			return false;
			} */
			if($("#MESSAGEINFO_INFORMATION_ID").val()=='' && $("#pdfurl").text()=='' && $("#MESSAGEINFO_URL").val()==''){
				$("#MESSAGEINFO_INFORMATION_ID").tips({
					side:3,
		            msg:'选择关联产品续存或自定义上传文件',
		            bg:'#AE81FF',
		            time:2
		        });
				
			return false;
			}
			
			/* var getall=getAllHtml();
			$("#MESSAGEINFO_CONTEXT").val(getall);
			console.info($("#Form").serialize()); */
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//zTree设置

		var setting = {
			check: {
				enable: true,
				chkboxType: { "Y" : "ps", "N" : "ps" }
			},
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
				onCheck: onCheck
			}
		};
		//准备
		$(document).ready(function(){
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval("("+zn+")");
			console.info(zTreeNodes);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
		});
		//在点击之前
		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}
		//获取所有选中节点的值
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true),
			v = "";
			id="";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id+=nodes[i].id+",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
			var GROUP_ID=$("#MESSAGEINFO_GROUP_ID");
			GROUP_ID.attr("value",id);
			
		}
		//1点击事件
		function showMenu() {
			var cityObj = $("#citySel");//文本框
			var cityOffset = $("#citySel").offset();//触发事件相对与文本发生偏移
			//偏移两个属性top 和 left   在触发下滑事件（快速）
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
			//鼠标按下触发事件onBodyDown
			$("body").bind("mousedown", onBodyDown);
		}

		//3
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		//2
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}


		</script>
		<script type="text/javascript">
		function proList(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择产品";
			 diag.URL = '<%=basePath%>productsinfo/listAllMess.do';
			 diag.Width = 1000;
			 diag.Height = 850;
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
		function infoList(){
			var mess= $("#MESSAGEINFO_PRODUCTS_ID").val();
			if( mess=='' ){
				alert("请先选择产品");
				/* $("#tbhide").show();  */
				$("#inhide").show();
				/* $(":radio[value=0]").attr("checked","checked"); */
				
			}else{
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="产品续存";
			 diag.URL = '<%=basePath%>information/listMess.do?INFORMATION_INFO_ID='+mess;
			 diag.Width = 1000;
			 diag.Height = 850;
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
			 $("#tbhide").hide(); 
			 $("#inhide").show();
			}
		}
		</script>
</body>
</html>