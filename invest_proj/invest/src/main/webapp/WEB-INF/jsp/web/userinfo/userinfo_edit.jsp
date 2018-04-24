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
	
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	
	
	
</head>
<body class="no-skin">

<!-- ztree 下拉列表 -->
<div id="menuContent" class="menuContent" style="margin:0 auto;display:none; position: absolute;z-index:999;background-color:#fff;" >
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:98%;"></ul>
</div>
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="userinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="USERINFO_ID" id="USERINFO_ID" value="${pd.USERINFO_ID}"/>
						
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<c:if test="${msg != 'save' }">
								<tr hidden="hidden" >
									<td style="width:75px;text-align: right;padding-top: 13px;">用户ID:</td>
									<td><input type="text" name="USERINFO_ID" id="USERINFO_ID" value="${pd.USERINFO_ID}" maxlength="40" placeholder="这里输入用户ID" title="用户ID" style="width:98%;"/></td>
								</tr>
							</c:if>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"><p style="line-height: 70px; margin: 0px">头像:</p></td>
								<!-- <td><input type="text" readonly="readonly" name="USER_OPPNID" id="USER_OPPNID" value="${pd.USER_OPPNID}" maxlength="40" placeholder="这里输入微信号" title="微信号" style="width:98%;"/></td> -->
								<td><img  src="${pd.USER_PHOTO }" width="80" height="80"></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">姓名:</td>
								<td><input type="text" name="USER_NICKNAME" id="USER_NICKNAME" value="${pd.USER_NICKNAME}" maxlength="20" placeholder="这里输入昵称" title="昵称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">电话号码:</td>
								<td><input type="text" readonly="readonly"  name="USER_PHONE" id="USER_PHONE" value="${pd.USER_PHONE}" maxlength="20" placeholder="这里输入电话号码" title="电话号码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">等级:</td>
								<!--<td><input type="text" name="USER_ROLE_ID" id="USER_ROLE_ID" value="${pd.LEVEL_NAME}" maxlength="40" placeholder="这里输入等级" title="等级" style="width:98%;"/></td>-->
								<td>
									<select name="USER_ROLE_ID" id="USER_ROLE_ID" style="width:98%;">
										<c:forEach items="${levelList}" var="level" varStatus="vs">
											<option value="${level.LEVEL_ID }" ${pd.USER_ROLE_ID == level.LEVEL_ID?"selected":""}>${level.LEVEL_NAME }</option>		
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">所在组:</td>
								<td>
									<input type="hidden" name="ATTR_TYPEID" id="ATTR_TYPEID" value="${pd.USER_GROUPID}"/>
									<input id="USER_GROUPID" type="text" placeholder="点击选择分组" class="nav-search-input"  autocomplete="off" name="USER_GROUPID" readonly value="" style="width:98%;"  onclick="showMenu();"/>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">注册时间:</td>
								<td><input class="span10 " name="USER_CREATETIME" id="USER_CREATETIME" value="${pd.USER_CREATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="注册时间" title="注册时间" style="width:98%;"/></td>
							</tr>

							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">认证状态:</td>
								<td>
									<div id="">
										<input type="radio" id="USER_ATTESTATION" name="USER_ATTESTATION" class="USER_ATTESTATION" value="1"    ${pd.USER_ATTESTATION == 1?"checked":""}/><label>已认证</label>
										<input type="radio" id="USER_ATTESTATION" name="USER_ATTESTATION" value="0" style="margin-left: 0px 20px;" ${pd.USER_ATTESTATION == 0?"checked":""}/><label style="color: red;">未认证</label>	
									</div>
									
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">总投资:</td>
								<td><input type="text"  name="USER_TOTALE" id="USER_TOTALE" value="${pd.USER_TOTALE}" maxlength="20" placeholder="这里输入总投资" title="总投资" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:95px;text-align: right;padding-top: 13px;">保险:</td>
								<td>
									<textarea id="editor" style="width:89%;height:259px;">${pd.USER_BAOXIAN }</textarea>
									<textarea style="display: none" type="hidden" id="USER_BAOXIAN" name="USER_BAOXIAN">${pd.USER_BAOXIAN }</textarea>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-success" onclick="save()">保存修改</a>
								</td>
							</tr>
							
							
							
							
							
							<tr>
								<td style="text-align: center; padding:0px; margin: 0px;" colspan="10">
								<p style="height: 31px;text-align: left;color:#000; line-height: 31px; padding-left: 20px; margin-bottom: 0px;" >
										我的投资
								</p>
									<iframe name="findProdictsFrame" id="findProdictsFrame" frameborder="0"
									src="<%=basePath%>/userinfo/findProdictsByUserId.do?DICTIONARIES_ID=${'' == DICTIONARIES_ID?'0':DICTIONARIES_ID}&currentPage=${null == pd.dnowPage || '' == pd.dnowPage?'1':pd.dnowPage}"
									style="margin: 0 auto; width: 100%; height: 100%">
									</iframe>
								</td>
							</tr>
							
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a id="dfalkfjlsd" class="btn btn-mini btn-success" onclick="findProducts()">新增产品</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close()">取消</a>
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
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=basePath%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	
		<script type="text/javascript">
			//ueditor-html
		    function getAllHtml() {
		        return UE.getEditor('editor').getContent();
		    }
		    $("#findProdictsFrame").load(function () {
		        var mainheight = $(this).contents().find("body").height();
		        $(this).height(mainheight);
		    });
		
			//当这个下拉框失去焦点的同时把这个复选框修改的值保存到数据库
			$("select[name='DICTIONARIES_ID']").blur(function(){
				var beforeDict = $(this).attr("lang");
				var endDict = $(this).val(); 
				var investId = $(this).parent().siblings().children("input[name='investId']").val();
				if(beforeDict != endDict){
					$.ajax({
						type:"post",
						data:{
							"INVEST_DICTIONARIESID":endDict,
							"INVEST_ID":investId
						},
						dataType:"JSON",
						url:"<%=basePath%>userinfo/updateEndDict.do"
					});
				}
			});
		
		// 把复选框更改为单选框
		$("input[name='DICTIONARIES_ID']").change(function(){
			if($(this).is(":checked")){
				$(this).siblings("input[name='DICTIONARIES_ID']").prop("checked",false);
			}
		});
		
		function DropDown(el) {
			this.dd = el;
			this.initEvents();

		}
		DropDown.prototype = {
			initEvents : function() {
				var obj = this;

				obj.dd.on('click', function(event){
					$(this).toggleClass('active');
					event.stopPropagation();
				});	
			}
		}
		
		
		//添加 产品
		function findProducts(){
			
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="给用户添加产品";
			 diag.URL = '<%=basePath%>userProduct/listAllDict.do?';
			 diag.Width = 1500;
			 diag.Height = 650;
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
		};
		
		
		
		// 拼接'添加产品' 代码
		function parentDict(obj){
			var str = "";
			$.each(obj,function(index,data){
				str+="<div class='panel panel-default'>"
					+"<div class='panel-heading parentDicName' data-toggle='collapse' lang='"
					+data.DICTIONARIES_ID
					+"' data-parent='#productsAccordion'href='#"
					+data.DICTIONARIES_ID
					+"'>"
					+"<h4 class='panel-title'>"
					+data.NAME
					+"</h4></div><div id='"
					+data.DICTIONARIES_ID
					+"' class='panel-collapse collapse'>"
					+"<div class='panel-body'>"
					+"</div></div></div>";
			});
			return str;
		}
		
		// 给删除用户已购产品添加绑定事件
		$("#products").on("click",".delProducts",function(){
			$.messager.confirm('删除提醒', '</br>确定删除这这条产品记录吗?</br></br>',function(r){ 
				if(!r) return false;
				var userAndProd = $(this).attr("lang");
				$.ajax({
					type:"post",
					url:"<%=basePath%>userinfo/delProducts.do",
					data:{"userAndProd":userAndProd},
					dataType:'JSON',
					success:function(res){
						console.log(res);
						$("#products").empty();
						var str=appendData(res);
						$("#products").html(str);
					}
				});
			});
			
		})
		
		function formatDate(date){
				var time=new Date(date);
				return time.getFullYear()+"-"+("0"+(time.getMonth()+1)).slice(-2)+"-"+("0"+time.getDate()).slice(-2)+" "+
				(time.getHours() < 10 ? "0" + time.getHours() : time.getHours())+":"+
				(time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())+":"+
				(time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds());
		}
		
		
		function DropDown(el) {
			this.dd = el;
			this.initEvents();
		
		};
		DropDown.prototype = {
			initEvents: function() {
				var obj = this;
		
				obj.dd.on('click', function(event) {
					$(this).toggleClass('active');
					event.stopPropagation();
				});
			}
		};
		$(top.hangge());
		//保存
		function save(){
			$("#USER_BAOXIAN").val(getAllHtml());
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		};
		
		
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
		$(function() {
			//日期框
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			console.log(zn);
			$.fn.zTree.init($("#treeDemo"), setting, zTreeNodes);
			//修改时默认显示属性的类型 
			if( ${msg eq 'edit'}){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				selectTypeName(treeObj);//调用回显方法
			}
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			$("#USER_BAOXIAN").val(getAllHtml());
		});

		//function beforeClick(treeId, treeNode) {
		//	var check = (treeNode && !treeNode.isParent);
		//	if (!check) alert("只能选择城市...");
		//	return check;
		//}
		
		var oldv;
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
			saveValue(v,id);
		}
		
		
		<!-- 保存下拉列表的值 -->
		function saveValue(v,id){
			var cityObj = $("#USER_GROUPID");
			var type = $("#ATTR_TYPEID");
			if(oldv != v){
				cityObj.attr("value", v);
				type.attr("value", id);
				oldv =v;
			}
		}

		function showMenu() {
			var cityObj = $("#USER_GROUPID");
			var cityOffset = $("#USER_GROUPID").offset();
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
		
		//回显属性类型
		function selectTypeName(treeObj){
				var nodes = treeObj.getNodes();
				var node = treeObj.getNodeByParam("id", "${pd.USER_GROUPID}");//根据ID获取节点
				treeObj.selectNode(node);//显示选中节点
				$("#USER_GROUPID").val(node.name);//给类型赋值
				$("#ATTR_TYPEID").val(node.id);
		}
		 //批量修改默认值
		function batchUpdate (attrList){
			for(var i = 0;i < i<attrList.length; i++) {
				alert(attrList[i]+",");
			}		 
		 }
	
	</script>
</body>
</html>