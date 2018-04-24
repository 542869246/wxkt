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
	<style type="text/css">
.mytab {
	border: 0;
	width: 90pt;
	height: 28px;
	line-height: 28px;
	background-color: #eef0ee;
	white-space: nowrap;
	z-index: 101;
	outline: 0;
}

.active {
	background-color: #438eb9;
	color: #fff;
}
</style>
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
					
					<form action="brandadv/edit.do" name="Form" id="Form" method="post">
					
					
						<input type="hidden" name="BRAND_ID" id="BRAND_ID" value="${pd.BRAND_ID}"/>
						<input type="hidden" name="BRAND_CONTENT" id="BRAND_CONTENT"/>
						<code id="testcon" style="display:none;">${pd.BRAND_CONTENT}</code>
						<div id="zhongxin" style="padding-top: 13px;">
						
						<div style="float:left; width: 90%;" >
						
						<div style="margin-top: 10px;margin-left: 20px;">
			            </div>
						</div>
							 
					
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">内容:</td>
								<td>
								 <script id="editor" type="text/plain" style="width:42%;height:20%;"></script>
								</td>
							</tr>
							 -->
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">品牌入驻:</td>
								<td>
									<script id="editor" type="text/plain" style="width:90%;height:300px;float: left;"></script>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
								<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="window.location.reload()">取消</a>
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
<c:if test="${pd.BRAND_ID!=null}">
		<div
			style="height: 29px; width: 98%; margin: 0px auto; border-bottom: 1px solid #4F99C6; padding-left: 5px;">
			<button class="mytab active"
				onclick="javascript:mytab.active(this,mytab.brandJoiner);">入驻列表</button>
		</div>
		<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no
			width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
</c:if>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 编辑框 -->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	
		<script type="text/javascript">
		$(function(){
			if(${pd.BRAND_CONTENT!=null}){
			    window.setTimeout(setContent,1000);//一秒后再调用赋值方法
				}
		})
			//给ueditor插入值
		    function setContent(){
		        UE.getEditor('editor').execCommand('insertHtml', $('#testcon').html());
		        
		    	}
			//ueditor-html
			    function getAllHtml() {
		
			        return UE.getEditor('editor').getContent();
			    }
		$(top.hangge());
		//保存
		function save(){
			var getall=getAllHtml();
			$("#BRAND_CONTENT").val(getall);
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
				brandJoiner:"<%=basePath%>school_brand_joiner/list.do",
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