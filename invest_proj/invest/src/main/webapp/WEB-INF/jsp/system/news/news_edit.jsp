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
					
					<form action="news/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="NEWS_PRODUCTS_ID" id="NEWS_PRODUCTS_ID" value="${pd.NEWS_PRODUCTS_ID }"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<!-- <td style="width:75px;text-align: right;padding-top: 13px;">产品:</td> -->
								<%-- <td>
									<c:choose>
										<c:when test="${not empty product }">
										<select name="NEWS_PRODUCTS_ID">
											<c:forEach items="${product }" var="pro">
												<c:choose>
													<c:when test="${pd.NEWS_PRODUCTS_ID eq pro.PRODUCTSINFO_ID }">
														<option selected="selected" value="${pro.PRODUCTSINFO_ID }">${pro.PRODUCTS_NAME }</option>
													</c:when>
													<c:otherwise>
														<option value="${pro.PRODUCTSINFO_ID }">${pro.PRODUCTS_NAME }</option>
													</c:otherwise>
												</c:choose>				
											</c:forEach>
										</select>
									</c:when>
									</c:choose>
								</td> --%>
								
							</tr>
							<tr style="display:none;">
								<td style="width:75px;text-align: right;padding-top: 13px;">id:</td>
								<td><input type="text" name="NEWS_ID" id="NEWS_ID " value="${pd.NEWS_ID }" maxlength="200" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">第三方连接:</td>
								<td><input type="text" name="NEWS_URL" id="NEWS_URL" value="${pd.NEWS_URL}" maxlength="200" placeholder="这里输入第三方连接" title="第三方连接" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">新闻标题:</td>
								<td><input type="text" name="NEWS_TITLE" id="NEWS_TITLE" value="${pd.NEWS_TITLE}" maxlength="100" placeholder="这里输入新闻标题" title="新闻标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">插入时间:</td>
								<td><input class="span10 date-picker" name="NEWS_INSERTTIME" id="NEWS_INSERTTIME" value="${pd.NEWS_INSERTTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="插入时间" title="插入时间" style="width:98%;"/></td>
							</tr>
							<tr style="display:none;">
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="NEWS_CREATEBY" id="NEWS_CREATEBY" value="${pd.NEWS_CREATEBY}" maxlength="50" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
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
		//保存
		function save(){
			/* if($("#PRODUCTS_NAME").val()==""){
				$("#PRODUCTS_NAME").tips({
					side:3,
		            msg:'请输入产品',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRODUCTS_NAME").focus();
			return false;
			} */
			if($("#NEWS_URL").val()==""){
				$("#NEWS_URL").tips({
					side:3,
		            msg:'请输入第三方连接',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWS_URL").focus();
			return false;
			}
			if($("#NEWS_TITLE").val()==""){
				$("#NEWS_TITLE").tips({
					side:3,
		            msg:'请输入新闻标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWS_TITLE").focus();
			return false;
			}
			if($("#NEWS_INSERTTIME").val()==""){
				$("#NEWS_INSERTTIME").tips({
					side:3,
		            msg:'请输入插入时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWS_INSERTTIME").focus();
			return false;
			}
			/* if($("#NEWS_CREATEBY").val()==""){
				$("#NEWS_CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWS_CREATEBY").focus();
			return false;
			} */
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