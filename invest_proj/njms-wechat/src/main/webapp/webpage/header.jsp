<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.8.3.min.js"></script>
<title>Insert title here</title>
</head>
<body>
    <!--header 开始-->
	<form action="<%=request.getContextPath()%>/information/searchList" id="form" method="post">
    <div id="header" class="header-wrapper clearfix">
        <div class="fl logo"><img src="images/logo.png"/> </div>
        <div class="header-right fr">
            <p class="header-link"><a href="javascript:;">旧站回顾</a>|<a onclick="AddFavorite(window.location,document.title)" href="javascript:void(0)">加入收藏</a></p>
            
            <div class="search-wrap clearfix">
					<input type="text" name="keywords" class="search" style="color:white;" value="${pd.keywords}" placeholder="请输入关键字"/>
	                <input type="hidden" name="currentPage" id="pageIndex" value="1"/>
	                <a href="javascript:void(0);" class="search-btn"></a>
	                <a href="javascript:document.getElementById('form').submit();" class="search-jq">站内搜索</a>
            </div>
        </div>
    </div>
	</form>

    <!--nav 开始-->
    <div id="nav" class="nav-top-wrapper">
        <ul class="nav-small clearfix">
            <li><a href="<%=request.getContextPath()%>?category_code=10001" class="sn-01"><em>首页</em></a> </li>
            <li  class="active"><a href="<%=request.getContextPath()%>?category_code=10002" class="sn-02"><em>警务</em></a> </li>
            <li><a href="<%=request.getContextPath()%>?category_code=10003" class="sn-03"><em>服务</em></a> </li>
            <li><a href="<%=request.getContextPath()%>?category_code=10004" class="sn-04"><em>办公</em></a> </li>
            <li><a href="<%=request.getContextPath()%>?category_code=10005" class="sn-05"><em>文化</em></a> </li>
            <li><a href="<%=request.getContextPath()%>?category_code=10006" class="sn-06"><em>导航</em></a> </li>
        </ul>
    </div>
    <!--nav 开始-->
    <script type="text/javascript">
    $(function(){
		var code = "${category_first.CATEGORY_CODE}";
		$("#nav li").removeClass("active");
		if(code == "10001"){
			$("#nav li:eq(0)").addClass("active");
		} else if(code == "10002"){
			$("#nav li:eq(1)").addClass("active");
		} else if(code == "10003"){
			$("#nav li:eq(2)").addClass("active");
		} else if(code == "10004"){
			$("#nav li:eq(3)").addClass("active");
		} else if(code == "10005"){
			$("#nav li:eq(4)").addClass("active");
		} else if(code == "10006"){
			$("#nav li:eq(5)").addClass("active");
		} else{
			$("#nav li:eq(1)").addClass("active");
		}
		
		
	});
    function addFavorite() {
        var url = window.location;
        var title = document.title;
        var ua = navigator.userAgent.toLowerCase();
        if (ua.indexOf("360se") > -1) {
            alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
        }
        else if (ua.indexOf("msie 8") > -1) {
            window.external.AddToFavoritesBar(url, title); //IE8
        }
        else if (document.all) {
      try{
       window.external.addFavorite(url, title);
      }catch(e){
       alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
      }
        }
        else if (window.sidebar) {
            window.sidebar.addPanel(title, url, "");
        }
        else {
      alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
        }
    }
/*     //加入收藏
    
    function AddFavorite(sURL, sTitle) {

        sURL = encodeURI(sURL); 
    try{   
        window.external.addFavorite(sURL, sTitle);   
    }catch(e) {   
        try{   
            window.sidebar.addPanel(sTitle, sURL, "");   
        }catch (e) {   
            alert("加入收藏失败，请使用Ctrl+D进行添加,或手动在浏览器里进行设置.");
        }   
    }
} */
    
    $(".search-jq").click(function(){
		$("form").submit();
	});
	
	
    </script>
</body>
</html>