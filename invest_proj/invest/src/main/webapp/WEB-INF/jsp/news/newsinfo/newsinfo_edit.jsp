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
	<link rel="stylesheet" href="plugins/datetimepicker/css/jquery.datetimepicker.css" />
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="plugins/imguploader/tool/webuploader/webuploader.css">
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
					
					<form action="newsinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="THUMBNAIL" id="THUMBNAIL"/>
						<input type="hidden" name="NEWINFO_CONTENT" id="NEWINFO_CONTENT"/>
						<input type="hidden" name="NEWSINFO_ID" id="NEWSINFO_ID" value="${pd.NEWSINFO_ID}"/>
						<code id="testcon" style="display:none;">${pd.NEWINFO_CONTENT}</code>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻标题:</td>
								<td><input type="text" name="NEWINFO_TITLE" id="NEWINFO_TITLE" value="${pd.NEWINFO_TITLE}" maxlength="100" placeholder="这里输入新闻标题" title="新闻标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">摘要:</td>
								<td>
								<textarea style="resize: none"   cols="112" rows="4" maxlength="100" name="NEWINFO_SECONDTITLE" id="NEWINFO_SECONDTITLE"  >${pd.NEWINFO_SECONDTITLE}</textarea>  
								
								<!-- <input type="text" name="NEWINFO_SECONDTITLE" id="NEWINFO_SECONDTITLE" value="${pd.NEWINFO_SECONDTITLE}" maxlength="100" placeholder="这里输入摘要" title="摘要" style="width:98%;"/> -->
								
								
								</td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">缩略图:</td>
								<td>
								<!--  <input type="text" name="THUMBNAIL" id="THUMBNAIL" value="${pd.THUMBNAIL}" maxlength="200" placeholder="这里输入缩略图" title="缩略图" style="width:98%;"/>-->
											<!--dom结构部分-->
											<div id="uploader-demo">
												<!--用来存放item-->
												<div id="filePicker" style="float: left;"  class="uploader-list fileList">选择图片</div>
											</div>
											<div id="zjt">
											<c:if test="${not empty pd.THUMBNAIL}">
												<img src="<%=basePath%>${pd.THUMBNAIL}" class="center-block" width="100" height="100" onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null"  />
												<input type="hidden" name="THUMBNAIL" id="THUMBNAIL" value="${pd.THUMBNAIL}"/>
											</c:if>
											</div>
								</td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻类型编号:</td>
								<td>
								<!--  <input type="text" name="NEWINFO_TYPE_ID" id="NEWINFO_TYPE_ID" value="${pd.NEWINFO_TYPE_ID}" maxlength="40" placeholder="这里输入新闻类型编号" title="新闻类型编号" style="width:98%;"/>-->
								<select class="chosen-select form-control" name="NEWINFO_TYPE_ID" id="NEWINFO_TYPE_ID" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
								 	<option value="">请选择</option>
								 	<c:if test="${not empty dicList}">
									<c:forEach items="${dicList }" var="dic">
										<option value="${dic.DICTIONARIES_ID}"  <c:if test="${pd.NEWINFO_TYPE_ID==dic.DICTIONARIES_ID}">selected</c:if> >${dic.NAME}</option>
									</c:forEach>
									</c:if>
								 </select>
								</td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻状态:</td>
								<td>
									<input name="NEWINFO_STATE" type="radio" value="0" <c:if test="${pd.NEWINFO_STATE==0}">checked</c:if> />实时资讯 
									<input name="NEWINFO_STATE" type="radio" value="1" <c:if test="${pd.NEWINFO_STATE==1}">checked</c:if> />过往资讯 
								</td>
								<!--<td><input type="text" name="NEWINFO_STATE" id="NEWINFO_STATE" value="${pd.NEWINFO_STATE}" maxlength="10" placeholder="这里输入新闻状态" title="新闻状态" style="width:98%;"/> --> 
							</tr>
							<!-- 
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻创建人:</td>
								<td><input type="text" name="NEWINFO_CREATEBY" id="NEWINFO_CREATEBY" value="${pd.NEWINFO_CREATEBY}" maxlength="20" placeholder="这里输入新闻创建人" title="新闻创建人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻创建时间:</td>
								<td>
								<input type="text" id="datetimepicker6" name="NEWINFO_CREATETIME"   value="<fmt:formatDate value="${pd.NEWINFO_CREATETIME}" pattern="yyyy-MM-dd HH:mm" /> "   placeholder="新闻创建时间" title="新闻创建时间" style="width:98%;" />
								</td>
							</tr>
							 -->
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">新闻内容:</td>
								<td>
								 <script id="editor" type="text/plain" style="width:800px;height:259px;"></script>
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
	<script type="text/javascript" src="plugins/datetimepicker/jquery.js" ></script>
	<script type="text/javascript" src="plugins/datetimepicker/build/jquery.datetimepicker.full.js" ></script>
	<script>
	   $('#datetimepicker6').datetimepicker({lang:'ch'});
	</script>	
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 图片上传 js-->
	<script type="text/javascript" src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/imguploader/js/upload.js"></script>
	
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!-- 编辑框-->
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	
	<script type="text/javascript">
		
	if(${pd.NEWINFO_CONTENT!=null}){
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
		//保存
		function save(){
			if($("#NEWINFO_TITLE").val()==""){
				$("#NEWINFO_TITLE").tips({
					side:3,
		            msg:'请输入新闻标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_TITLE").focus();
			return false;
			}
			/*if($("#NEWINFO_CONTENT").val()==""){
				$("#NEWINFO_CONTENT").tips({
					side:3,
		            msg:'请输入新闻内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_CONTENT").focus();
			return false;
			}*/
			if($("#NEWINFO_SECONDTITLE").val()==""){
				$("#NEWINFO_SECONDTITLE").tips({
					side:3,
		            msg:'请输入摘要',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_SECONDTITLE").focus();
			return false;
			}
			/*if($("#THUMBNAIL").val()==""){
				$("#THUMBNAIL").tips({
					side:3,
		            msg:'请输入缩略图',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#THUMBNAIL").focus();
			return false;
			}*/
			if($("#NEWINFO_TYPE_ID").val()==""){
				$("#NEWINFO_TYPE_ID").tips({
					side:3,
		            msg:'请输入新闻类型编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_TYPE_ID").focus();
			return false;
			}
			if($("#NEWINFO_STATE").val()==""){
				$("#NEWINFO_STATE").tips({
					side:3,
		            msg:'请输入新闻状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_STATE").focus();
			return false;
			}
			/*if($("#NEWINFO_CREATEBY").val()==""){
				$("#NEWINFO_CREATEBY").tips({
					side:3,
		            msg:'请输入新闻创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_CREATEBY").focus();
			return false;
			}*/
			/*if($("#NEWINFO_CREATETIME").val()==""){
				$("#NEWINFO_CREATETIME").tips({
					side:3,
		            msg:'请输入新闻创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEWINFO_CREATETIME").focus();
			return false;
			}*/
			var getall=getAllHtml();
			console.info(getall);
			$("#NEWINFO_CONTENT").val(getall);

			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		</script>
		
</body>
</html>