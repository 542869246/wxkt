<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
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
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	
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
			//	beforeClick: beforeClick,
				onClick: onClick
			}
		};


		//function beforeClick(treeId, treeNode) {
		//	var check = (treeNode && !treeNode.isParent);
		//	if (!check) alert("只能选择城市...");
		//	return check;
		//}
		var oldv="-1";
		function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			id="";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id=nodes[i].id;
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			saveValue(v);
		}
		<!-- 保存下拉列表的值 -->
		function saveValue(v){
			var cityObj = $("#citySel");
			var type = $("#ATTR_TYPEID");
			if(oldv != v ){
				type.attr("value", id);
				cityObj.attr("value", v);
				oldv=v;
			}
		}

		function showMenu() {
			var cityObj = $("#citySel");
			var cityOffset = $("#citySel").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		
		//回显产品属性
		 function selectAttr(as){
			as.each(function(){ 
				$(this).parent().next().remove();
			}); 
		} 
		
		//判断是否包含
		 function indexStr(strs,str){ 
			 var s = strs.indexOf(str); 
			 return s; 
		}
		
		
		//全选
		  function allCheck(fn){
			 var strs =$("#atrs").val();
			if($(fn).is(':checked')){
				var as = $("input[name=ids]");
				 $.each(as,function(i,a){
					 if(indexStr(strs,a.value) == '-1'){
						 var str =$("#atrs").val();
							 str+=a.value+",";
							 $("#atrs").val(str);
					 }else{
						 return ture;
					 }
					 
				});
			}else{
				 $.each(as,function(i,a){
					 var str =$("#atrs").val();
					 sr = a.value+",";
					 str=str.replace(sr,"");
					 $("#atrs").val(str);
				 });
			}
		 } 
		
		function attrAjax(fn){
			//勾选 true 关联该属性
			
			//alert(fn);
			 if($(fn).is(':checked')){
				 var str =$("#atrs").val();
				  /* alert(str); */
				 str+=$(fn).val()+",";
				 $("#atrs").val(str);
				 // alert(str); 
				 /*  $.ajax({
					type:"post",
					url:"attribute/ajaxEdit.do",
					data:{"ATTRIBUTE_ID":$(fn).val(),"PRODUCTSINFO_ID":$("#PRODUCTSINFO_ID").val()},
					dataType:'JSON',
					success:function  (obj) {
						console.log(obj);
					},
					error:function  (obj) {
						console.log(obj);
					}
				});   */
			}else{
				 var str =$("#atrs").val();
				 sr = $(fn).val()+",";
				 /* alert(sr); */
				 str=str.replace(sr,"");
				 $("#atrs").val(str);
				  //alert(str); 
				//取消勾选 false 取消关联该属性
				   /* $.ajax({
					type:"post",
					url:"attribute/ajaxEdit.do",
					data:{"ATTRIBUTE_ID":$(fn).val()},
					dataType:'JSON',
					success:function  (obj) {
						console.log(obj);
					},
					error:function  (obj) {
						console.log(obj);
					}
					7cf5da7c86aa4999aaba3494b6294b2c,94d3688d976a4cd8a307f730836cb1f3,1f4adbe7fe4d4fa284dc25ac0cd3b6d4,249ac0012129401296df31a2b3f6bde3,
				});    */
			}
		}
		
		//勾选已有属性
		function initAttr(){
			var attrList = eval('${pd.attrList}');
			//alert(attrList);
			var s = "";
			if(attrList.length != 0){
				for(var i=0; i<attrList.length; i++)  
				  {  
				    s+= attrList[i].ATTRIBUTE_ID+",";  
				  }  
				
				//全选则 全选按钮选中
				 var falg=true;
				 $.each($("input[name='ids']"),function(index,ids){
					if(!ids.checked){
						falg=false;
						return;
					}				 
				 })
				$("#zcheckbox")[0].checked=falg;
			}
			return s;
		}
		
		
		
		
		var str ;
		$(document).ready(function(){
			
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
			
			//initAttr(attrList);
			//调用回显属方法
			var as = $("input[name=ids]:checked");
			selectAttr(as);
			var successFlag =  "${success}";
			if(successFlag != "Y"){
				if($("#atrs").val()==""){
					str = initAttr();
					$("#atrs").val(str);
				}
			}
			
		});
		
	</SCRIPT>
	
	
	
</head>
<body class="no-skin">
<div id="zhongxin" style="padding-top: 13px;">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
				
				
					<div id="menuContent" class="menuContent" style="width:150px;display:none; position: absolute;z-index:999;background-color:#fff;" >
						<ul id="treeDemo" class="ztree" style="margin-top:0; width:150px;"></ul>
					</div>
					
					<div class="row">
						<div class="col-xs-12">
						<!-- 检索  -->
						<form action="attribute/guanlianAttrlist.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.ATTR_TYPEID}"/>
							<input type="hidden" name ="oldAttr" value="${oldAttr }"/>
							<tr>
							<td style="vertical-align:top;padding-left:2px;">
								 	<div class="nav-search">
										<span class="input-icon"><strong>类型:</strong>
											<input id="citySel" type="text" placeholder="点击选择类型"  class="nav-search-input"  autocomplete="off" name="attrType" readonly="readonly"  value="${pd.attrType}"   onclick="showMenu();"/>
											<a onclick="document.getElementById('citySel').value='';" style="cursor:pointer;">清空</a>
										</span>
									</div>
								</td>
								<td style="padding-left:15px;">
									<div class="nav-search">
										<span class="input-icon"><strong>属性:</strong>
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
										</span>
									</div>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
						<input type="hidden" name="PRODUCTSINFO_ID" id="PRODUCTSINFO_ID" value="${pd.PRODUCTSINFO_ID}"/>
						<%-- <textarea rows="5" cols="100" name="ppd">${pd}</textarea> --%>
						 <input type="hidden" name="atrs" id="atrs" value="${pd.atrs }"/> 
							<%-- <textarea rows=5 cols=100 name="atrs" id="atrs" >${pd.atrs }</textarea> --%>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
										 <label class="pos-rel"><input type="checkbox" disabled="disabled" class="ace" onClick="allCheck(this);" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center" style="display:none;">编号</th>
									<th class="center">属性名</th>
									<th class="center">默认值</th>
									<th class="center">类型</th>
									<th class="center" style="display:none">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										
										<tr>
										
											<td class='center'>
											<c:forEach var="at" items="${pd.attrList}">
													<c:if test="${var.ATTRIBUTE_ID eq at.ATTRIBUTE_ID }">
														<label class="pos-rel"><input type='checkbox' checked="checked" name='ids' value="${var.ATTRIBUTE_ID}" onClick="attrAjax(this);" class="ace" /><span class="lbl"></span></label>
													</c:if>
											</c:forEach>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ATTRIBUTE_ID}" class="ace" onClick="attrAjax(this);" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center' style="display:none;">${var.ATTRIBUTE_ID}</td>
											<td class='center'>${var.ATTR_NAME}</td>
											<td class='center'>${var.ATTR_VALUE}</td>
											<td class='center'>${var.NAME}</td>
											<td class="center" style="display:none">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.ATTRIBUTE_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.ATTRIBUTE_ID}');">
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
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.ATTRIBUTE_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ATTRIBUTE_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="guanlian();">关联</a>
									</c:if>
									<%-- <c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if> --%>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").attr("action","attribute/guanlianAttrlist.do");
			$("#Form").submit();
		}
		function guanlian(){
			//top.jzts();
			$("#Form").attr("action","attribute/glEdit.do");
			$("#Form").submit();
			//top.Dialog.close();
			//$(top.hangge());//关闭加载状态
			//window.opener.location.href=window.opener.location.href
			//window.close();
		}
		$(function() {
			var successFlag =  "${success}";
			if(successFlag == "Y"){
				parent.parent.$("#_DialogFrame_0").contents().find("#myFrame").attr("src","<%=basePath%>/attribute/goShowAttr.do?PRODUCTSINFO_ID=${pd.PRODUCTSINFO_ID}");	
				top.Dialog.close();
				$(top.hangge());//关闭加载状态
			}
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
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
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
			 diag.URL = '<%=basePath%>attribute/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
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
					var url = "<%=basePath%>attribute/delete.do?ATTRIBUTE_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>attribute/goEdit.do?ATTRIBUTE_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
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
		function makeAll(msg){
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
								url: '<%=basePath%>attribute/deleteAll.do?tm='+new Date().getTime(),
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
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>attribute/excel.do';
		}
	</script>


</body>
</html>