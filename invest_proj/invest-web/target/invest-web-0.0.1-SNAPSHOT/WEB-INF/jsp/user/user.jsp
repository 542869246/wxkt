<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/top.jsp"%>
<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" href="static/css/paging.css" />
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/pagedown.css" />
		<title>个人中心</title>
		<script>
            $first=$.cookie('first_vist');
            if(!$first||$first=='null'||$first==null){
                $.cookie('first_vist','1',{ expires: 7 });
            }else{
                $.cookie('first_vist',null);
                location.reload(true);
            }
	</script>
	</head>
	<body>
		<div class="wrapper">
			<div class="user">
				<header>
					<div class="img">
						<img class="head" src="${loginuser.USER_PHOTO }" onerror="this.src='static/img/error.jpg';this.onerror=null" />
						<!-- onerror="this.src='static/img/error.jpg';this.onerror=null" -->
						<div class="lv">
							<c:if test="${loginuser.LEVEL_NAME=='黄金会员' }">
								<!--黄金-->
								<img class="show"  src="static/img/gold.png" />
							</c:if>
							<c:if test="${loginuser.LEVEL_NAME=='铂金会员' }">
								<!--铂金-->
								<img class="show" src="static/img/platinum.png" />
							</c:if>
							<c:if test="${loginuser.LEVEL_NAME=='钻石会员' }">
								<!--钻石-->
								<img class="show" src="static/img/jewel.png" />
							</c:if>
						</div>
					</div>
					<h1>${loginuser.USER_NICKNAME }</h1>
					<p>${loginuser.USER_PHONE }</p>
					
						<c:if test="${loginuser.LEVEL_NAME=='黄金会员' }">
							<a href="level/list">
								<label class="gold">
									<!--黄金-->
									<img class="show" src="static/img/gold.png" />
									<span>${loginuser.LEVEL_NAME }</span>
								</label>
							</a>
						</c:if>
						<c:if test="${loginuser.LEVEL_NAME=='铂金会员' }">
							<a href="level/list">
								<label class="platinum">
									<!--铂金-->
									<img class="show"  src="static/img/platinum.png" />
									<span>${loginuser.LEVEL_NAME }</span>
								</label>
								</a>
						</c:if>
						<c:if test="${loginuser.LEVEL_NAME=='钻石会员' }">
							<a href="level/list">
								<label class="jewel">
									<!--钻石-->
									<img class="show" src="static/img/jewel.png" />
									<span>${loginuser.LEVEL_NAME }</span>
								</label>
							</a>
						</c:if>
				</header>
				<!--main-->
				<div class="user_main">
					<ul>
						<li>
							<a href="message/xianshi">
								<img src="static/img/user_nav1.png" />
								消息中心
								<label id="count">26</label>
							</a>
						</li>
						<li>
							<a href="investMain/userProdctsinfoMain">
								<img src="static/img/user_nav2.png" />
								我的投资
							</a>
						</li>
						<li>
							<a href="about/list">
								<img src="static/img/user_nav3.png" />
								联系我们
							</a>
						</li>
						<li>
							<a href="newsinfo/toNewsList?whereCome=user_collect">
								<img src="static/img/user_nav4.png" />
								我的收藏
							</a>
						</li>
						<li>
							<a href="userinfo/toSetting">
								<img src="static/img/user_nav5.png" />
								设置
							</a>
						</li>
					</ul>
				</div>
				<footer>
					<ul>
						<li>
							<a href="index/toindex">首页</a>
						</li>
						<li>
							<a href="dictionaries/findProperty">资产配置</a>
						</li>
						<li>
							<a href="newsinfo/toTypeNews">实时资讯</a>
						</li>
						<li class="cur">
							<a href="userinfo/toUserCentre">个人中心</a>
						</li>
					</ul>
				</footer>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/basedao.js" ></script>
	<script type="text/javascript">
		$(function(){
			messagecount();
		});
		//获取未读消息数量
		function messagecount(){
			var j=0;
			var setting={url:'messageinfo/selectall'};
			var dao = new BaseDao(setting);
			var data=dao.getResponseData();
			if(data.loginuser.USER_ATTESTATION==1){
				$.each(data.varList, function(i) {
					if(data.varList[i].readCount==0){
						j++;
					}
				});
			}
			$.each(data.sysdata, function(k){
				if(data.sysdata[k].readcount==0){
					j++;
				}
			});
			$("#count").text(j);
		}
	</script>
</html>
