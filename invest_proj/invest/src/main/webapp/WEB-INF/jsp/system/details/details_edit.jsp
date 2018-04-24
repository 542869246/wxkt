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
					
					<form action="details/${msg }.do" name="Form" id="Form" method="post"> 
						<input type="hidden" name="DETAILS_ID" id="DETAILS_ID" value="${pd.DETAILS_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr style="display:none;">
								<td style="width:75px;text-align: right;padding-top: 13px;">产品编号:</td>
								<td>
									<input type="text" name="DETAILS_INFO_ID" id="DETAILS_INFO_ID" value="${pd.DETAILS_INFO_ID}" maxlength="40" placeholder="这里输入产品编号" title="产品编号" style="width:98%;"/>
								</td>
							</tr>
							
							
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">pdf路径:</td>
								<td>
								
									<input type="hidden" name="DETAILS_URL" id="DETAILS_URL" value="${pd.DETAILS_URL}">
									<input type="file" name="pdffile" id="pdffile" onchange="savepdf()" />
									<span class="pdfxianshi">${pd.DETAILS_URL}</span>
									
									
								</td>
							</tr>
							
							
							
							
							
							
							
							
							
							
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">标题:</td>
								<td><input type="text" name="DETAILS_TITLE" id="DETAILS_TITLE" value="${pd.DETAILS_TITLE}" maxlength="50" placeholder="这里输入标题" title="标题" style="width:98%;"/></td>
							</tr>
							<%-- <c:if test="${msg == 'save'}">
								<tr>
									<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
									<td><input class="span10 date-picker" name="DETAILS_CREATETIME" id="DETAILS_CREATETIME" value="${pd.DETAILS_CREATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
								</tr>
							</c:if> --%>
							<tr style="display:none ">
								<td style="width:75px;text-align: right;padding-top: 13px;">操作人:</td>
								<td><input type="text" name="DETAILS_CREATEBY" id="DETAILS_CREATEBY" value="${pd.DETAILS_CREATEBY}" maxlength="50" placeholder="这里输入操作人" title="操作人" style="width:98%;"/></td>
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
		<script type="text/javascript">
		$(top.hangge());
		
		$(function(){
			if($("#DETAILS_URL").val()!=""){
				var str =$("#DETAILS_URL").val()
				var index = str .lastIndexOf("\/");  
				str  = str .substring(index + 1, str .length);
				$(".pdfxianshi").text(str);
			}
		})
		
		function savepdf(){
			
			//debugger
			var fileObj = document.getElementById("pdffile").files[0]; // js 获取文件对象 
			var str=fileObj.name.substring(fileObj.name.lastIndexOf(".")+1); 
			if($("#DETAILS_URL").val()!="" && str!="pdf"){
				alert("上传文件必须为PDF格式!");
				return false;
			}
			var form = new FormData();  
			form.append("pdffile", fileObj); // 文件对象  
			//debugger
			$.ajax({
				type:"post",
				url:"details/savepdf",
				data:form,
				async:false,
				contentType: false,  
		        processData: false,
				success:function(data){
					console.info(data);
					$("#DETAILS_URL").val(data);
					var str =$("#DETAILS_URL").val()
					var index = str .lastIndexOf("\/");  
					str  = str .substring(index + 1, str .length);
					$(".pdfxianshi").text(str);
				}
			});
		}

		
		
		
		//保存
		function save(){
			if($("#DETAILS_INFO_ID").val()==""){
				$("#DETAILS_INFO_ID").tips({
					side:3,
		            msg:'请输入产品编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS_INFO_ID").focus();
			return false;
			}
			if($("#DETAILS_URL").val()==""){
				$("#DETAILS_URL").tips({
					side:3,
		            msg:'请选择PDF文件',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS_URL").focus();
			return false;
			} 
			
			
			if($("#DETAILS_TITLE").val()==""){
				$("#DETAILS_TITLE").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS_TITLE").focus();
			return false;
			}
			
			
			if($("#DETAILS_CREATETIME").val()==""){
				$("#DETAILS_CREATETIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS_CREATETIME").focus();
			return false;
			}
/* 			if($("#DETAILS_CREATEBY").val()==""){
				$("#DETAILS_CREATEBY").tips({
					side:3,
		            msg:'请输入操作人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DETAILS_CREATEBY").focus();
			return false;
			} */
			/* var file=$("#DETAILS_URL")[0].value;
			var str=file.substring(file.lastIndexOf(".")+1); 
			if($("#DETAILS_URL").val()!="" && str!="pdf"){
				alert("上传文件必须为PDF格式!");
				return false;
			}
			*/

			
			
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