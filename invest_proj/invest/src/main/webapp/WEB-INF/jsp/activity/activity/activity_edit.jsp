<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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
<!-- 图片上传 -->
<link rel="stylesheet" type="text/css"
	href="plugins/imguploader/tool/webuploader/webuploader.css">
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

							<form action="activity/${msg }.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="ACTIVITY_ID" id="ACTIVITY_ID"
									value="${pd.ACTIVITY_ID}" /><input type="hidden"
									name="ACTIVITY_CONTENT" id="ACTIVITY_CONTENT" />
								<code id="testcon" style="display: none;">${pd.ACTIVITY_CONTENT}</code>
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">

										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动标题:</td>
											<td><input type="text" name="ACTIVITY_TITLE"
												id="ACTIVITY_TITLE" value="${pd.ACTIVITY_TITLE}"
												maxlength="100" placeholder="这里输入活动标题" title="活动标题"
												style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动简介:</td>
											<td>
											<textarea rows="5" name="ACTIVITY_INFO"
												id="ACTIVITY_INFO"
												maxlength="21845" placeholder="这里输入活动简介" title="活动简介"
												style="width: 98%;">${pd.ACTIVITY_INFO}</textarea>
												
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动内容:</td>
											<td>
												<%-- <textarea name="ACTIVITY_CONTENT"
												id="ACTIVITY_CONTENT" value="${pd.ACTIVITY_CONTENT}"
												maxlength="21845" placeholder="这里输入活动内容" title="活动内容"
												style="width: 98%;height:200px;resize: none;">${pd.ACTIVITY_CONTENT}</textarea> --%>
												<script id="editor" type="text/plain"
													style="width: 90%; height: 300px; float: left;"></script>
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动状态:</td>
											<td>
												<select name="ACTIVITY_STATE" id="ACTIVITY_STATE">
													<option value="">请选择</option>
													<option value="0" <c:if test="${pd.ACTIVITY_STATE==0 }">selected</c:if>>正在进行</option>
													<option value="1" <c:if test="${pd.ACTIVITY_STATE==1 }">selected</c:if>>结束</option>
												</select>
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动的标题图片:</td>
											<td>
												<div id="uploader-demo">
													<!--用来存放item-->
													<div id="filePicker" style="float: left;"
														class="uploader-list fileList webuploader-container">选择图片</div>
												</div>
												<div id='zmy'>
													<c:if test="${pd.ACTIVITY_IMGSRC!=null}">
														<img src="<%=basePath%>${pd.ACTIVITY_IMGSRC}"
															class="center-block" width="50" height="50"
															onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null"
															alt="pic" />
													</c:if>
												</div> <input type="hidden" name="ACTIVITY_IMGSRC"
												id="ACTIVITY_IMGSRC" value="${pd.ACTIVITY_IMGSRC}" />
											</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">活动类型:</td>
											<td><select name="ACTIVITY_TYPE_ID"
												id="ACTIVITY_TYPE_ID">
													<option value="">--请选择--</option>
													<c:forEach items="${activityList }" var="va">
														<option value="${va.DICTIONARIES_ID }"
															<c:if test="${va.DICTIONARIES_ID== pd.ACTIVITY_TYPE_ID}">selected</c:if>>${va.NAME }</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
												class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
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
	</div>
	<!-- /.main-container -->

	<!-- tab 切换选项卡 -->
	<c:if test="${pd.ACTIVITY_ID!=null }">
		<div
			style="height: 29px; width: 98%; margin: 0px auto; border-bottom: 1px solid #4F99C6; padding-left: 5px;">
			<button class="mytab active"
				onclick="javascript:mytab.active(this,mytab.activityTakein);">报名用户</button>
			<button class="mytab"
				onclick="mytab.active(this,mytab.activityComment);">所有评论</button>
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
	<script type="text/javascript" charset="utf-8"
		src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="plugins/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	<script type="text/javascript">
	$(function(){
		if(${pd.ACTIVITY_CONTENT!=null}){
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
	
	
	//页面tab初始化
	$(document).ready(function(){
		$(".active").click();
		
	});
	var mytab = {
			activityComment:"<%=basePath%>activitycomment/list.do?ACTIVITY_ID=${pd.ACTIVITY_ID}",
			activityTakein:"<%=basePath%>takein/list.do?ACTIVITY_ID=${pd.ACTIVITY_ID}",
			//productMation:"<%=basePath%>/activity/list.do?ACTIVITY_TYPE_ID=${pd.ACTIVITY_TYPE_ID}",
			//productZiliao:"<%=basePath%>/activity/list.do?ACTIVITY_TITLE=${pd.ACTIVITY_TITLE}",
			//productNews:"<%=basePath%>/news/list.do?NEWS_PRODUCTS_ID=${pd.PRODUCTSINFO_ID}",
			//productAttr:"<%=basePath%>/attribute/goShowAttr.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}",
			//productUsers:"<%=basePath%>/invest/list.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}",
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
	
		$(top.hangge());
		//保存
		function save() {
			if ($("#ACTIVITY_TITLE").val() == "") {
				$("#ACTIVITY_TITLE").tips({
					side : 3,
					msg : '请输入活动标题',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_TITLE").focus();
				return false;
			}
			if ($("#ACTIVITY_INFO").val() == "") {
				$("#ACTIVITY_INFO").tips({
					side : 3,
					msg : '请输入活动简介',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_INFO").focus();
				return false;
			}
			var getall=getAllHtml();
			$("#ACTIVITY_CONTENT").val(getall);
			if ($("#ACTIVITY_CONTENT").val() == "") {
				$("#ACTIVITY_CONTENT").tips({
					side : 3,
					msg : '请输入活动内容',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_CONTENT").focus();
				return false;
			}
			if ($("#ACTIVITY_TIME").val() == "") {
				$("#ACTIVITY_TIME").tips({
					side : 3,
					msg : '请输入活动开始时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_TIME").focus();
				return false;
			}
			if ($("#ACTIVITY_STATE").val() == "") {
				$("#ACTIVITY_STATE").tips({
					side : 3,
					msg : '请输入活动状态',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_STATE").focus();
				return false;
			}
			
			if ($("#ACTIVITY_TYPE_ID").val() == 0) {
				$("#ACTIVITY_TYPE_ID").tips({
					side : 3,
					msg : '请输入活动类型',
					bg : '#AE81FF',
					time : 2
				});
				$("#ACTIVITY_TYPE_ID").focus();
				return false;
			}
			
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});
		});
		
		
	</script>
	<!--图片上传-->
	<script type="text/javascript"
		src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript"
		src="plugins/imguploader/js/uploadActivity.js"></script>
</body>
</html>