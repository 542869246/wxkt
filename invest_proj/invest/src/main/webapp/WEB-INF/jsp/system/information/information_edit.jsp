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
					
					<form action="information/${msg }.do" name="Form" id="Form" method="post" >
						<input type="hidden" name="INFORMATION_ID" id="INFORMATION_ID" value="${pd.INFORMATION_ID}"/>
						<input type="hidden" name="INFORMATION_INFO_ID" id="PRODUCTSINFO_ID" value="${pd.INFORMATION_INFO_ID }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr style="display:none">
								<td style="width:20%;text-align: right;padding-top: 13px;">编号:</td>
								<td><input type="text" name="INFORMATION_ID" id="INFORMATION_ID" value="${pd.INFORMATION_ID}" maxlength="40" placeholder="这里输入编号" title="编号" style="width:48%;"/></td>
							</tr>
							<tr style="display:none;">
								<td style="width:75px;text-align: right;padding-top: 13px;">产品名称:</td>
								<td><input type="hiddent" name="PRODUCTS_NAME" id="PRODUCTS_NAME" value="${pd.PRODUCTS_NAME}" maxlength="40" placeholder="这里输入产品名称" title="产品名称" style="width:48%;" readonly/></td>
							</tr>
							<tr style="display:none;">
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="INFORMATION_CREATEBY" id="INFORMATION_CREATEBY" value="${pd.INFORMATION_CREATEBY}" maxlength="20" placeholder="这里输入创建人" title="创建人" style="width:48%;"/></td>
							</tr>
							  <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">存续时间:</td>
								<td><input class="span10 date-picker" name="INFORMATION_MESSAGETIME" id="INFORMATION_MESSAGETIME" value="${pd.INFORMATION_MESSAGETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:48%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">PDF:</td>
								<td>
									<input type="hidden" name="INFORMATION_PDFURL" id="INFORMATION_PDFURL" value="${pd.INFORMATION_PDFURL}" />
									<input type="file" name="pdffile" id="pdffile" onchange="savepdf()" />
									<span class="pdfxianshi" >${pd.INFORMATION_PDFURL}</span>
									
									<%-- <input type="hidden" name="DETAILS_URL" id="DETAILS_URL" value="${pd.DETAILS_URL}">
									<input type="file" name="pdffile" id="pdffile" onchange="savepdf()" />
									<span class="pdfxianshi">${pd.DETAILS_URL}</span> --%>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">存续内容:</td>
								<td>
									<%-- <input type="d" value="${pd.INFORMATION_CONTENT}"> --%>
								  <textarea id="INFORMATION_CONTENT" name="INFORMATION_CONTENT" cols="48%"  rows="5" >${pd.INFORMATION_CONTENT}</textarea> 
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
		<script type="text/javascript">
		
		$(function(){
			if($("#INFORMATION_PDFURL").val()!=""){
				var str =$("#INFORMATION_PDFURL").val()
				var index = str .lastIndexOf("\/");  
				str  = str .substring(index + 1, str .length);
				$(".pdfxianshi").text(str);
			}
		})
		
		function savepdf(){
			
			//debugger
			var fileObj = document.getElementById("pdffile").files[0]; // js 获取文件对象 
			var str=fileObj.name.substring(fileObj.name.lastIndexOf(".")+1); 
			if($("#INFORMATION_PDFURL").val()!="" && str!="pdf"){
				alert("上传文件必须为PDF格式!");
				return false;
			}
			var form = new FormData();  
			form.append("pdffile", fileObj); // 文件对象  
			//debugger
			$.ajax({
				type:"post",
				url:"information/savepdf",
				data:form,
				async:false,
				contentType: false,  
		        processData: false,
				success:function(data){
					console.info(data);
					$("#INFORMATION_PDFURL").val(data);
						var str =$("#INFORMATION_PDFURL").val()
						var index = str .lastIndexOf("\/");  
						str  = str .substring(index + 1, str .length);
						$(".pdfxianshi").text(str);
					
				}
			});
		}
		
		
		
		$(top.hangge());
		//保存
		if(${msg == 'save'}){
			$("#PRODUCTS_NAME").parent().parent().hide();
		}
		
		function save(){
			/* if($("#INFORMATION_ID").val()==""){
				$("#INFORMATION_ID").tips({
					side:3,
		            msg:'请输入编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_ID").focus();
			return false;
			} */
			if($("#INFORMATION_MESSAGETIME").val()==""){
				$("#INFORMATION_MESSAGETIME").tips({
					side:3,
		            msg:'请输入存续时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_MESSAGETIME").focus();
			return false;
			}
			 if($("#INFORMATION_CONTENT").val()==""){
				$("#INFORMATION_CONTENT").tips({
					side:3,
		            msg:'请输入存续内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_CONTENT").focus();
			return false;
			} 
			/* if($("#INFORMATION_INFO_ID").val()==""){
				$("#INFORMATION_INFO_ID").tips({
					side:3,
		            msg:'请输入产品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_INFO_ID").focus();
			return false;
			} */
			/* if($("#INFORMATION_CREATEBY").val()==""){
				$("#INFORMATION_CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_CREATEBY").focus();
			return false;
			} */
			/* if($("#INFORMATION_CREATETIME").val()==""){
				$("#INFORMATION_CREATETIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_CREATETIME").focus();
			return false;
			} */
			/* if($("#INFORMATION_PDFURL").val()==""){
				$("#INFORMATION_PDFURL").tips({
					side:3,
		            msg:'请输入PDF',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INFORMATION_PDFURL").focus();
			return false;
			} */
			
			var file=$("#INFORMATION_PDFURL")[0].value;
			//alert(file);
			var str=file.substring(file.lastIndexOf(".")+1); 
			if($("#INFORMATION_PDFURL").val()!="" && str!="pdf"){
				alert("上传文件必须为pdf格式!");
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
		</script>
</body>
</html>