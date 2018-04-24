<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>播放视频</title>
</head>
<body>
	<div id="player" class="player">
		<object width="640" height="320" id="f4Player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"> 
		<param name="movie" value="player.swf" /> 
		<param name="quality" value="high" /> 
		<param name="menu" value="true" /> 
		<param name="allowFullScreen" value="true" /> 
		<param name="scale" value="noscale" /> 
		<param name="allowScriptAccess" value="always" />
		<param name="swLiveConnect" value="true" />
		<param name="flashVars" value="
			skin=skins%2Fdefault.swf
			&thumbnail=video-thumbnail.jpg
			&video=${param.src }
			&autoplay=0
			"/>
		<!--[if !IE]> <--> 
		<object width="640" height="320" data="player.swf" type="application/x-shockwave-flash" id="f4Player">
		<param name="quality" value="high" /> 
		<param name="menu" value="true" /> 
		<param name="allowFullScreen" value="true" /> 
		<param name="scale" value="noscale" />
		<param name="allowScriptAccess" value="always" />
		<param name="swLiveConnect" value="true" />
		<param name="flashVars" value="
			skin=skins%2Fdefault.swf
			&thumbnail=video-thumbnail.jpg
			&video=${param.src }
			&autoplay=0
			"/>
		</object> 
		 <![endif]--> 
		</object>
	</div>
</body>
</html>