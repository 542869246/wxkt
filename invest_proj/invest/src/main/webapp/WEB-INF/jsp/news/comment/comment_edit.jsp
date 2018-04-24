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
	<!-- 表格内容过长处理 -->
	<link rel="stylesheet" href="static/comment/css/comment.css">
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
			<form action="comment/goEdit.do" name="Form" id="Form" method="post">
				<input type="hidden" name="COMMENT_NEWS_ID" value="${pd.COMMENT_NEWS_ID}" />
				<div id="zhongxin" style="padding-top: 13px;">
				
				<table style="margin-top:5px;">
					<tr>
						<td>
							<div class="nav-search">
								<span class="input-icon">
									<input type="text" placeholder="这里输入用户名" class="nav-search-input" id="nav-search-input" autocomplete="off" name="USER_NICKNAME" value="${pd.USER_NICKNAME }" placeholder="这里输入用户名"/>
									<i class="ace-icon fa fa-search nav-search-icon"></i>
								</span>
							</div>
						</td>
						<td style="padding-left:2px;"><input class="span10 date-picker"value="${pd.lastLoginStart}" name="lastLoginStart" id="lastLoginStart"   type="text" data-date-format="yyyy-mm-dd" readonly="readonly"   style="width:88px;" placeholder="开始时间" title="开始时间"/></td>
							    <td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
						<c:if test="${QX.cha == 1 }">
						<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
						</c:if>
					</tr>
				</table>
				<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
				<thead>
					<tr>
						<th class="center" style="width:10%;">序号</th>
						<!-- <th class="center">评论编号</th> -->
						<!-- <th class="center">新闻标题</th> -->
					   <th class="center" width="20%">评论内容</th>
						<th class="center" width="20%">用户名称</th>
						<th class="center" width="20%">评论时间</th>
						<!--  <th class="center">评论状态</th>-->
						<th class="center" width="10%">点赞数</th>
						<th class="center" width="10%">操作</th>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
							
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<!-- <td class='center'>${var.COMMENT_ID}</td> -->
								<!--  <td class='center'>${var.NEWINFO_TITLE}</td>-->
								<td class='center autocut' title="${var.COMMENT_CONTENT}">
								<c:if test="${fn:length(var.COMMENT_CONTENT)>10 }">
									${fn:substring(var.COMMENT_CONTENT, 0, 11)}··· 
								</c:if>
								<c:if test="${fn:length(var.COMMENT_CONTENT)<=10 }">
									${var.COMMENT_CONTENT}
								</c:if>
								</td>
								<td class='center'>${var.USER_NICKNAME}</td>
								<td class='center'><fmt:formatDate value="${var.COMMENT_CREATETIME}" pattern="yyyy-MM-dd HH:mm"/> </td>
								<!-- <td class='center'>
								<c:if test="${var.COMMENT_STATE==0}">
									显示
								</c:if>
								<c:if test="${var.COMMENT_STATE==1}">
									隐藏
								</c:if>
								</td>
								 -->
								<td class='center'>${var.size}</td>
								<td class="center">
									<c:if test="${QX.del != 1 }">
									<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
									</c:if>
									<div class="hidden-sm hidden-xs btn-group">
										<c:if test="${QX.del == 1 }">
										<a class="btn btn-xs btn-danger" onclick="del('${var.COMMENT_ID}');">
											<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
										</a>
										</c:if>
									</div>
									<div class="hidden-md hidden-lg">
										<div class="inline pos-rel">
											<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
												<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
											</button>
		
											<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
												<c:if test="${QX.del == 1 }">
												<li>
													<a style="cursor:pointer;" onclick="del('${var.COMMENT_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
														<span class="red">
															<i class="ace-icon fa fa-trash-o bigger-120"></i>
														</span>
													</a>
												</li>
												</c:if>
											</ul>
										</div>
									</div>
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<button style="border-radius: 15px;" type="button" class="btn btn-primary btn-lg" onclick="top.Dialog.close()">退出</button>
								</td>
							</tr>
						</table>
						</div>
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
			
			//日期框
			$('#lastLoginStart').datepicker({
				autoclose: true,
				todayHighlight: true,
				onSelect: function( startDate ) {
			        var $startDate = $( "#lastLoginStart" );
			        var $endDate = $('#lastLoginEnd');
			        var endDate = $endDate.datepicker( 'getDate' );
			        if(endDate < startDate){
			            $endDate.datepicker('setDate', startDate - 3600*1000*24);
			        }
			        $endDate.datepicker( "option", "minDate", startDate );
			    }
			}).on('changeDate',function(e){
			    var startTime = e.date;
			    $('#lastLoginEnd').datepicker('setStartDate',startTime);
			});
			$('#lastLoginEnd').datepicker({
				autoclose: true,
				todayHighlight: true,
				onSelect: function( endDate ) {
			        var $startDate = $( "#lastLoginStart" );
			        var $endDate = $('#lastLoginEnd');
			        var startDate = $startDate.datepicker( "getDate" );
			        if(endDate < startDate){
			            $startDate.datepicker('setDate', startDate + 3600*1000*24);
			        }
			        $startDate.datepicker( "option", "maxDate", endDate );
			    }
			}).on('changeDate',function(e){
			    var endTime = e.date;
			    $('#lastLoginStart').datepicker('setEndDate',endTime);
			});
			
			
		});
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>comment/delete.do?COMMENT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		</script>
</body>
</html>