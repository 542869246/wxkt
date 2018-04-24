<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="static/layui-v2.2.45/layui/css/layui.css">
<c:if test="${pd.COURSES_ID!=null && pd.COURSES_ID!='' }">
	<style>
#simple-table1>tbody td {
	border-radius: 10px !important;
}

/* #simple-table1 {
	border-collapse: none !important;
	border-spacing: none !important;
} */
table {
	border-collapse: separate;
	border-spacing: 2.5px;
}

.zyf_click_td {
	border: 1px solid #D1D1D1 !important;
	background-color: #D1D1D1
}

.zfy_copy_selected {
	background-color: #FF8247 !important;
}
.zyf_leave_conf{
width:100%;

}
.popover{
	max-width:none;!important
}
</style>
</c:if>

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

							<!-- 检索  -->
							<form action="schedule/list.do" method="post" name="Form"
								id="Form">
								<input type="hidden" name="COURSES_ID" id="COURSES_ID"
									value="${pd.COURSES_ID }" /> <input type="hidden"
									name="CLASSROOM_ID" id="CLASSROOM_ID"
									value="${pd.CLASSROOM_ID }" /> <input type="hidden"
									name="LESSON_TIME_TYPE" id="LESSON_TIME_TYPE"
									value="${pd.LESSON_TIME_TYPE }" />
								<!-- 当是课程下的课表展现的页面 -->
								<c:if test="${pd.COURSES_ID!=null && pd.COURSES_ID!='' }">
									<div style="width: 800px; margin: 10px auto;">
										<div class="layui-btn layui-btn-sm ${pd.isselected==null?'':'zfy_copy_selected'}" id="zyf_copy"
											style="background-color:#438eb9"
											isselected='${pd.isselected==null?false:pd.isselected}'>复制</div>
										<!-- <div class="layui-btn layui-btn-sm" id="" style="background-color: #438eb9">粘贴</div> -->
										<div class="layui-btn layui-btn-sm" id="zyf_delete"
											style="background-color: #438eb9">删除</div>
										<div class="layui-btn layui-btn-sm" id="zyf_leave"
											style="background-color: #438eb9; margin-right: 50px">请假</div>
											
										<div class="layui-btn layui-btn-sm prework"
											style="background-color: #438eb9;">
											<i class="layui-icon"></i>
										</div>
										<input class="span10 date-picker" name="nowDate" id="nowDate"
											value="<fmt:formatDate value='${pd.nowDate }' pattern='yyyy-MM-dd'/>"
											type="text" data-date-format="yyyy-mm-dd" readonly="readonly"
											style="width: 150px; text-align: center; margin: 0 10px;"
											placeholder="日期" title="日期" />

										<div class="layui-btn layui-btn-sm nextwork"
											style="background-color: #438eb9;">
											<i class="layui-icon"></i>
										</div>
										<div class="layui-btn layui-btn-sm" id="copyschedule"
											style="float: right; background-color: #438eb9; position: absolute; margin-left: 15em;">复制上一周课表</div>
									</div>

									<table id="simple-table1" class="table table-bordered"
										style="margin-top: 5px;" cellspacing="3" cellpadding="3">
										<thead>
											<tr>
												<th class="center" style="width:163px;">时间/日期</th>
												<th class="center" style="width:146px;">${weekList[0] }<br />星期一
												</th>
												<th class="center" style="width:146px;">${weekList[1] }<br />星期二
												</th>
												<th class="center" style="width:146px;">${weekList[2] }<br />星期三
												</th>
												<th class="center" style="width:147px;">${weekList[3] }<br />星期四
												</th>
												<th class="center" style="width:147px;">${weekList[4] }<br />星期五
												</th>
												<th class="center" style="width:147px;">${weekList[5] }<br />星期六
												</th>
												<th class="center" style="width:147px;">${weekList[6] }<br />星期日
												</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${lessontimeList }" var="var"
												varStatus="status">
												<tr bgcolor="${colorList[status.index] }" height="50px"
													id="123">
													<td class="center"
														style="background-color: #F2F2F2; vertical-align: middle;"><fmt:formatDate
															value="${var.LESSON_STARTTIME }" pattern="HH:mm" /> - <fmt:formatDate
															value="${var.LESSON_ENDTIME }" pattern="HH:mm" /></td>
													<td 
														ondblclick="toEditSchedule('${weekList[0]}'+' '+'${var.LESSON_STARTTIME }','${weekList[0]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;" bgcolor=""
														startdate='${weekList[0]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[0]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[0] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td
														ondblclick="toEditSchedule('${weekList[1]}'+' '+'${var.LESSON_STARTTIME }','${weekList[1]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[1]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[1]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[1] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td
														ondblclick="toEditSchedule('${weekList[2]}'+' '+'${var.LESSON_STARTTIME }','${weekList[2]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[2]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[2]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[2] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td
														ondblclick="toEditSchedule('${weekList[3]}'+' '+'${var.LESSON_STARTTIME }','${weekList[3]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[3]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[3]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[3] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td placement="left"
														ondblclick="toEditSchedule('${weekList[4]}'+' '+'${var.LESSON_STARTTIME }','${weekList[4]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[4]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[4]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[4] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td placement="left"
														ondblclick="toEditSchedule('${weekList[5]}'+' '+'${var.LESSON_STARTTIME }','${weekList[5]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[5]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[5]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[5] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="font-size: 10px; display: inline-block; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp;${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
													<td placement="left"
														ondblclick="toEditSchedule('${weekList[6]}'+' '+'${var.LESSON_STARTTIME }','${weekList[6]}'+' '+'${var.LESSON_ENDTIME }',this)"
														class="center" style="vertical-align: middle;"
														startdate='${weekList[6]} ${var.LESSON_STARTTIME }'
														enddate='${weekList[6]} ${var.LESSON_ENDTIME }'><c:forEach
															var="schelist" items="${varList }">
															<c:if test="${weekList[6] == schelist.lesson_time}">
																<c:if
																	test="${var.LESSON_STARTTIME == schelist.starttime}">
																	<span title="${schelist.LESSON_NAME }"
																		class="schecolor"
																		style="display: inline-block; font-size: 10px; width: 10.5em; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
																		scheColor="${schelist.SUBJECT_COLOR }">[${schelist.SUBJECT_NAME}]
																		${schelist.LESSON_NAME }</span>
																	<br />
																	${schelist.teachername }&nbsp;/&nbsp; ${schelist.classname }<span
																		class='zyf_clone' tid='${schelist.USER_ID }'
																		cid="${schelist.CLASSROOM_ID }"
																		sid="${schelist.SUBJECT_ID }"
																		lid="${schelist.LESSONS_ID }"></span>
																	<input type="hidden" id="schedule_id"
																		value="${schelist.LESSONS_ID }" />
																</c:if>
															</c:if>
														</c:forEach></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:if>
								<!-- 当不是课程下的课表展现的页面 -->
								<c:if test="${pd.COURSES_ID==null || pd.COURSES_ID==''}">
									<table style="margin-top: 5px;">
										<tr>
											<td>
												<div class="nav-search">
													<span class="input-icon"> <input type="text"
														placeholder="这里输入老师姓名" class="nav-search-input"
														id="nav-search-input" autocomplete="off" name="keywords"
														value="${pd.keywords }" placeholder="这里输入老师姓名" /> <i
														class="ace-icon fa fa-search nav-search-icon"></i>
													</span>
												</div>
											</td>
											<td style="padding-left: 2px;"><input
												class="span10 date-picker" name="lastStart" id="lastStart"
												value="${pd.lastStart }" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												style="width: 88px;" placeholder="开始日期" title="开始日期" /></td>
											<td style="padding-left: 2px;"><input
												class="span10 date-picker" name="lastEnd" id="lastEnd"
												value="${pd.lastEnd }" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												style="width: 88px;" placeholder="结束日期" title="结束日期" /></td>
											<c:if test="${QX.cha == 1 }">
												<td style="vertical-align: top; padding-left: 2px"><a
													class="btn btn-light btn-xs" onclick="tosearch();"
													title="检索"><i id="nav-search-icon"
														class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
											</c:if>
											<c:if test="${pd.COURSES_ID==null || pd.COURSES_ID=='' }">
												<c:if test="${QX.toExcel == 1 }">
													<td style="vertical-align: top; padding-left: 2px;"><a
														class="btn btn-light btn-xs" onclick="toExcel();"
														title="导出到EXCEL"><i id="nav-search-icon"
															class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
												</c:if>
											</c:if>
										</tr>
									</table>

									<!-- 检索  -->

									<table id="simple-table"
										class="table table-striped table-bordered table-hover"
										style="margin-top: 5px;">
										<thead>
											<tr>
												<c:if test="${pd.COURSES_ID==null || pd.COURSES_ID=='' }">
													<th class="center" style="width: 35px;"><label
														class="pos-rel"><input type="checkbox" class="ace"
															id="zcheckbox" /><span class="lbl"></span></label></th>
												</c:if>
												<th class="center" style="width: 50px;">序号</th>
												<th class="center">开始时间</th>
												<th class="center">结束时间</th>
												<th class="center">课程名称</th>
												<th class="center">老师姓名</th>
												<th class="center">科目名称</th>
												<th class="center">教室</th>
												<th class="center">备注</th>
												<!-- <th class="center">修改人</th>
									<th class="center">修改时间</th>
									<th class="center">创建人</th>
									<th class="center">创建时间</th> -->
												<c:if test="${pd.COURSES_ID==null || pd.COURSES_ID=='' }">
													<th class="center">操作</th>
												</c:if>
											</tr>
										</thead>

										<tbody>
											<!-- 开始循环 -->
											<c:choose>
												<c:when test="${not empty varList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${varList}" var="var" varStatus="vs">
															<tr>
																<c:if
																	test="${pd.COURSES_ID==null || pd.COURSES_ID=='' }">
																	<td class='center'><label class="pos-rel"><input
																			type='checkbox' name='ids' value="${var.LESSONS_ID}"
																			class="ace" /><span class="lbl"></span></label></td>
																</c:if>
																<td class='center' style="width: 30px;">${vs.index+1}</td>

																<td class='center'><fmt:formatDate
																		value="${var.LESSON_STARTTIME}"
																		pattern="yyyy-MM-dd HH:mm:ss" /></td>
																<td class='center'><fmt:formatDate
																		value="${var.LESSON_ENDTIME}"
																		pattern="yyyy-MM-dd HH:mm:ss" /></td>
																<td style='display: none;' class='center'>${var.COURSE_ID}</td>
																<td class='center'>${var.coursesname}</td>
																<td style='display: none;' class='center'>${var.TEACHERS_ID}</td>
																<td class='center'>${var.teachername}</td>
																<td class='center'>${var.SUBJECT_NAME}</td>
																<td style='display: none;' class='center'>${var.CLASSROOM_ID}</td>
																<td class='center'>${var.classname}</td>
																<td class='center'>${var.LESSON_NAME}</td>
																<%-- <td class='center'>${var.MODIFYBY}</td>
											<td class='center'>${var.MODIFYDATE}</td>
											<td class='center'>${var.CREATEBY}</td>
											<td class='center'>${var.CREATEDATE}</td> --%>
																<c:if
																	test="${pd.COURSES_ID==null || pd.COURSES_ID=='' }">
																	<td class="center"><c:if
																			test="${QX.edit != 1 && QX.del != 1 }">
																			<span
																				class="label label-large label-grey arrowed-in-right arrowed-in"><i
																				class="ace-icon fa fa-lock" title="无权限"></i></span>
																		</c:if>
																		<div class="hidden-sm hidden-xs btn-group">
																			<%-- <c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.LESSONS_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if> --%>
																			<c:if test="${QX.del == 1 }">
																				<a class="btn btn-xs btn-danger"
																					onclick="del('${var.LESSONS_ID}');"> <i
																					class="ace-icon fa fa-trash-o bigger-120"
																					title="删除"></i>
																				</a>
																			</c:if>
																		</div>
																		<div class="hidden-md hidden-lg">
																			<div class="inline pos-rel">
																				<button
																					class="btn btn-minier btn-primary dropdown-toggle"
																					data-toggle="dropdown" data-position="auto">
																					<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																				</button>

																				<ul
																					class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																					<%-- <c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.LESSONS_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if> --%>
																					<c:if test="${QX.del == 1 }">
																						<li><a style="cursor: pointer;"
																							onclick="del('${var.LESSONS_ID}');"
																							class="tooltip-error" data-rel="tooltip"
																							title="删除"> <span class="red"> <i
																									class="ace-icon fa fa-trash-o bigger-120"></i>
																							</span>
																						</a></li>
																					</c:if>
																				</ul>
																			</div>
																		</div></td>
																</c:if>
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
														<td colspan="100" class="center">没有相关数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									<div class="page-header position-relative">
										<table style="width: 100%;">
											<tr>
												<c:if
													test="${pd.CLASSROOM_ID==null || pd.CLASSROOM_ID=='' || pd.COURSES_ID==null || pd.COURSES_ID=='' }">
													<td style="vertical-align: top;">
														<%-- <c:if
														test="${QX.add == 1 }">
														<a class="btn btn-mini btn-success" onclick="add();">新增</a>
													</c:if> --%> <c:if test="${QX.del == 1 }">
															<a class="btn btn-mini btn-danger"
																onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除"><i
																class='ace-icon fa fa-trash-o bigger-120'></i></a>
														</c:if>
													</td>
												</c:if>
												<td style="vertical-align: top;"><div
														class="pagination"
														style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
											</tr>
										</table>
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
		</c:if>
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	
		//双击修改或增加课表
		function toEditSchedule(starttime,endtime,aaa){
           //var c=$(aaa).parent().attr('bgcolor');
          // var color=c.replace('#','');
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = "<%=basePath%>schedule/goEdit.do?LESSONS_ID="+$(aaa).find("input").val()+"&LESSON_STARTTIME="+starttime+"&LESSON_ENDTIME="+endtime+"&COURSES_ID="+$("#COURSES_ID").val()+"&LESSON_TIME_TYPE="+$("#LESSON_TIME_TYPE").val();
			 diag.Width = 450;
			 diag.Height = 420;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					//nextPage(${page.currentPage});
					$("Form").submit();
				}
				diag.close();
			 };
			 diag.show();
		}
		
	
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
			
			
			//获得所有课程节点
			var subjectList=$("tbody").children().children("[ondblclick]")
			
			var obj={}
			var selectedTd
			
			if('${pd.cid}'!=''&&'${pd.sid}'!=''&&'${pd.tid}'!=''){
				obj.cid='${pd.cid}';
				obj.sid='${pd.sid}';
				obj.tid='${pd.tid}';
			}
			
			$(subjectList).click(function(){
				if($('#zyf_copy').attr('isselected')=='true'){
					console.log(obj)
					var startdate = $(this).attr('startdate')
					var enddate=$(this).attr('enddate')
					var lid=$(this).find('.zyf_clone').attr("lid");
					
					if(typeof lid=='undefined'){
						lid="";
					}
					//去后台修改请求  判断新增还是修改
					<%-- window.location='<%=basePath%>schedule/edit?LESSON_ID='+obj.lid+'&CLASSROOM_ID='+obj.cid+'&TEACHERS_ID='+obj.tid+'&SUBJECT_ID='+obj.sid+'&LESSON_STARTTIME='+startdate+'&LESSON_ENDTIME='+enddate+'&LESSON_TIME_TYPE='+$("#LESSON_TIME_TYPE").val()+'&COURSE_ID='+$("#COURSES_ID").val(); --%>
					$.ajax({
						url:'<%=basePath%>schedule/edit?LESSONS_ID='+lid+'&CLASSROOM_ID='+obj.cid+'&TEACHERS_ID='+obj.tid+'&SUBJECT_ID='+obj.sid+'&LESSON_STARTTIME='+startdate+'&LESSON_ENDTIME='+enddate+'&LESSON_TIME_TYPE='+$("#LESSON_TIME_TYPE").val()+'&COURSE_ID='+$("#COURSES_ID").val(),
						data:{},
						type:"POST",
						success:function(data){
							//console.log($('#myFrame').attr('src'))
							//console.log('<%=basePath%>')
							//console.log($(window.parent.document.getElementById("myFrame")).attr('src'))
							$(window.parent.document.getElementById("myFrame")).attr('src','<%=basePath%>schedule/list.do?&COURSES_ID='+$("#COURSES_ID").val()+'&isselected=true&color=%23438eb9&cid='+obj.cid+'&sid='+obj.sid+'&tid='+obj.tid)
							
							//$("Form").submit();
							
						}
					});
				}else{
					//遍历改变选中样式
					$(subjectList).each(function(index,item){
						if($(item).hasClass("zyf_click_td")){
							$(item).removeClass("zyf_click_td")
						}
					})  
					$(this).addClass("zyf_click_td")
					selectedTd=$(this)
				}
			})
			//复制按钮操作
			$("#zyf_copy").click(function(){

					/* console.log(typeof obj.cid)
					console.log(typeof obj.cid=='undefined') */
					if(selectedTd==null&&typeof obj.cid=='undefined')return alert("请选择有效内容!!!!")
					
					if(selectedTd!=null){
						//赋值当前选择节点给obj
						obj.cid=selectedTd.find('.zyf_clone').attr('cid')
						obj.sid=selectedTd.find('.zyf_clone').attr('sid')
						obj.tid=selectedTd.find('.zyf_clone').attr('tid')
						obj.lid=selectedTd.find('.zyf_clone').attr('lid')
					}
					
					//判断选中节点是否有效
					if(($(this).attr('isselected')=='false')&&(obj.cid==null||obj.tid==null||obj.sid==null||obj.lid==null)){
						/* if($(this).attr('isselected')=='true'){
							
						}else{ */
							alert("请选择有效内容")
						/* } */
					}else{
						
						$(this).toggleClass('zfy_copy_selected')
						//$(this).css("background-color","#FF8247")
	/* 					console.log($(this).attr('isselected'))
						console.log(!$(this).attr('isselected'))
						console.log(Boolean($(this).attr('isselected'))) */
						$(this).attr('isselected',$(this).attr('isselected')=="false"?true:false)
						
						if($(this).attr('isselected')=='false'){
							alert("取消复制成功")
						}else{
							alert('复制成功')
						}
					}
			})
			//删除按钮操作
			$("#zyf_delete").click(function(){
					if(selectedTd==null)return alert("请选择有效内容")
					//赋值当前选择节点给obj
					/* obj.cid=selectedTd.find('.zyf_clone').attr('cid')
					obj.sid=selectedTd.find('.zyf_clone').attr('sid')
					obj.tid=selectedTd.find('.zyf_clone').attr('tid') */
					obj.lid=selectedTd.find('.zyf_clone').attr('lid')
					//判断选中节点是否有效
					if($(this).attr('isselected')=='false'&&(obj.lid==null)){
						alert("请选择有效内容")
					}else{
						/* $(this).toggleClass('zfy_copy_selected')
						$(this).attr('isselected',$(this).attr('isselected')=="false"?true:false)
						if($(this).attr('isselected')=='false'){
							alert("取消复制成功")
						}else{
							alert('复制成功')
						} */
						$.ajax({
							url:'<%=basePath%>schedule/delete.do?LESSONS_ID='+obj.lid,
							data:{},
							type:"POST",
							success:function(data){
								$("Form").submit();
							}
						});
						
					}
			})
			
			
			
			//请假
			$('#zyf_leave').click(function(){
				if(selectedTd==null&&typeof obj.cid=='undefined')return alert("请选择有效内容!!!!")
				obj.lid=selectedTd.find('.zyf_clone').attr('lid')
				if(obj.lid==null){
						alert("请选择有效内容")
						return
				}
				var tb="<table id='simple-table2' class='table table-striped table-bordered table-hover'><thead>"+
				"<tr>"+
					"<th class='center' style='width: 30px;'><label class='pos-rel'><input type='checkbox' class='ace' id='zcheckbox' /><span class='lbl'></span></label></th>"+
					"<th style='width:20%;text-align: center;' class='bitianxiang'>学生姓名</th>"+
					"<th style='width:50%;text-align: center;' class=''>请假理由(30字内)</th>"+
					"<th style='width:20%;text-align: center;' class=''>请假日期</th>"+
				"</tr></thead><tbody>"
				$.ajax({
				url:'<%=basePath%>arrange/lessonsNoLeaveList.do?COURSES_ID='+$("#COURSES_ID").val()+'&lessons_id='+obj.lid,
				async: false,
				success:function(data){
					$(data.leaveList).each(function(index,item){
						tb+="<tr>"+
						"<td class='center'><label class='pos-rel'><input type='checkbox' name='ids' value="+item.STUDENT_ID+" class='ace' /><span class='lbl'></span></label></td>"+
						"<td class='center'>"+item.STUDENT_NAME+"</td>"+
						"<td class='center'><input name='cause' class='cause' type='text' style='width:98%;' value='' maxlength=30/></td>"+
						"<td class='center'><input class='span10 date-picker' name='leavedate' type='text' data-date-format='yyyy-mm-dd' placeholder='请假时间' title='请假时间' style='width:98%;'/></td>"+
						"</tr>"
						
					})
				}
				
			})	
			tb+="</tbody></table><script>"
			tb+="$('.date-picker').datepicker({autoclose: true,todayHighlight: true});"
			tb+="$('.cause').change(function(){"+
				"console.log($(this).val());"+
				'var reg=/["]+/;'+
				"if(reg.test($(this).val())){"+
					"$(this).tips({side:3,msg:'禁止输入\"',bg:'#AE81FF',time:2});"+
					"$(this).focus();"+
				"}"+
			"})"
			tb+="<\/script>"
			
			bootbox.confirm({ 
					title:"选择需要请假的学生",  
					size: "big",
					  message: tb,
					  backdrop: true,
					  animate:true,
					  html:true,
					  className:'zyf_leave_conf',
					  callback: function(result){ 
					  	//成功回调
					  	if(result){
					  		var reg=/["]+/
					  		console.log(reg.test('asdasd'))
					  		
					  		var str = '';
					  		var cause='';
					  		var model='{"leaves":[';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
						  
						  if(model=='{"leaves":[') model += '{"student_id":"'+document.getElementsByName('ids')[i].value+'","lessons_id":"'+obj.lid+'","leavecause":"'+$('.cause').eq(i).val()+'","leavedate":"'+$('.date-picker').eq(1+i).val()+'"}'
					  	else model += ',' + '{"student_id":"'+document.getElementsByName('ids')[i].value+'","lessons_id":"'+obj.lid+'","leavecause":"'+$('.cause').eq(i).val()+'","leavedate":"'+$('.date-picker').eq(1+i).val()+'"}'
					  	
					  }
					}
							model+=']}'
							console.log(model)
 							if(model!='{"leaves":[]}'){
								
								$.ajax({
									type: "POST",
									url: '<%=basePath%>leave/addLeaveAll.do?tm='+new Date().getTime(),
							    	data: {model:model},
									dataType:'json',
									//beforeSend: validateData,
									cache: false,
									success: function(data){
										$("Form").submit();
									},
									error:function(){
										$("Form").submit();
									}
								}); 
							}else{
								bootbox.dialog({
									message: "<span class='bigger-110'>您没有选择任何内容!</span>",
									buttons: 			
									{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
								});
							}
							
					  		//makeAll('确定要添加选中的数据吗?',model)
					  		
					  	}
					  }
					})
					
					 
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table2 > thead > tr > th > label>input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
			
			/* $('input[name=ids]').click(function(){
				console.log($(this).attr('checked'))
				
			}) */
			
			})
			
			
			
			
			//悬浮显示学生请假信息
			$(subjectList).mouseenter(function(){
				
				obj.lid=$(this).find('.zyf_clone').attr('lid')
				
				if(obj.lid!=null){
					var leaveContent="<table id='simple-table2' class='table table-bordered'><thead>"+
				"<tr>"+
					"<th style='width:30%;text-align: center;' class='bitianxiang'>学生姓名</th>"+
					"<th style='width:70%;text-align: center;' class='bitianxiang'>请假理由</th>"+
				"</tr></thead><tbody>"
				var hasLeave=true
					$.ajax({
						url:'<%=basePath%>arrange/listJSON.do?COURSES_ID='+$("#COURSES_ID").val()+'&lessons_id='+obj.lid,
						async: false,
						success:function(data){
							 if(data.leaveList.length==0){
								 hasLeave=false;
							} 
							$(data.leaveList).each(function(index,item){
								leaveContent+="<tr style=''><td>"+item.student_name+"</td><td>"+item.leavecause+"</td></tr>"
							})
						}
					})
					leaveContent+="</tbody></table>"
					if(hasLeave==false){
						leaveContent="无"
					}
					var placement=$(this).attr('placement')
					
					if(placement==''){
						placement='left'
					}
					
					$(this).popover({
						trigger:'hover',
						title:'请假的学生',
						 placement:placement, 
						 container: 'body',
						 html:true,
						 content:leaveContent
					})
					
					$(this).popover('show')
				}
				
			})
			
			//给包含scheColor属性的父节点的背景色赋值
			$(".schecolor").each(function(index,dom){
				$(dom).parent().attr("bgColor",$(dom).attr("scheColor"));
			})
			// $(".schecolor").parent().attr("bgColor",.attr("scheColor")); 
			//点击复制上一周课表时触发事件
			$("#copyschedule").click(function(){
				$.ajax({
					type: "post",
					url: '<%=basePath%>schedule/copyschedule.do',
			    	data: {nowDate:$("#nowDate").val(),COURSES_ID:$("#COURSES_ID").val()},
			    	dataType:"json",
					success: function(data){
						 if(data==false){//当返回的是false  代表上一周没数据 
							 alert("上一周没数据或时间模版已更改，请重新录入");
							 $("#Form").submit();//重新提交表单
							 return;
						 }else if(data==true){
							 alert("成功复制");
							 $("#Form").submit();//当返回的是true  代表复制上一周数据成功
							 return;
						 }
					}
				});
			});
			
			//时间change事件
			$("#nowDate").change(function(){
				$("#Form").submit();
			});
			
			//点击上一周
			$('.prework').click(function(){
				 	var date1 = $("#nowDate").val();
			        var date2 = new Date(date1);
			        date2.setDate(date2.getDate()-7);
			        var times = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
			        $("#nowDate").val(times);
			        $("#Form").submit();
			}); 
			//点击下一周
			$(".nextwork").click(function(){
				var date1 = $("#nowDate").val();
		        var date2 = new Date(date1);
		        date2.setDate(date2.getDate()+7);
		        var times = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
		        $("#nowDate").val(times);
		        $("#Form").submit();
			});
			
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th > label>input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>schedule/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 420;
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
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>schedule/delete.do?LESSONS_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>schedule/goEdit.do?LESSONS_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 390;
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
		
		//批量操作
		function makeAll(msg,data){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>schedule/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '确定要添加选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>arrange/addLeaveAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str,model:data},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							}); 
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			var keywords = $("#nav-search-input").val();
			var lastStart = $("#lastStart").val();
			var lastEnd = $("#lastEnd").val();
			window.location.href='<%=basePath%>schedule/excel.do?keywords='+keywords+'&lastStart='+lastStart+'&lastEnd='+lastEnd;
		}
	</script>


</body>
</html>