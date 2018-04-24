(function(floor){
	floor.createMenu=function(){
		var navCode=`<a class="mui-tab-item" href="#popover_study" style="color:#C99766";>
				<img src="../static/wx/images/about_24.png" class="tabbar-icon" /><div style="font-size: 90%;">我的课程</div></a>
			<a class="mui-tab-item" style="color:#C99766"; href="#popover_act"><img src="../static/wx/images/about_19.png" class="tabbar-icon" /><div style="font-size: 90%;">最新活动</div></a>
			<a class="mui-tab-item" style="color:#C99766"; href="#popover_about"><img src="../static/wx/images/about_22.png" class="tabbar-icon" /><div style="font-size: 90%;">关于我们</div></a>
			`;
		
		var popover_study_code=`
		<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="../course/goStudy"><img src="../static/wx/images/about_19.png" class="submenu_icon" />今日学习</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../course/goDaily"><img src="../static/wx/images/about_19.png" class="submenu_icon" />家长日报</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../course/goMyCount"><img src="../static/wx/images/about_19.png" class="submenu_icon" />我的积分</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../gotye/findGotyeUrl"><img src="../static/wx/images/about_19.png" class="submenu_icon" />实时查看</a>
				</li></ul>
				
		`;
		
		
		var popover_act_Code=`<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="../activity/goActivity?activity_type_id=0"><img src="../static/wx/images/about_19.png" class="submenu_icon" />趣味英语</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../activity/goActivity?activity_type_id=1"><img src="../static/wx/images/about_19.png" class="submenu_icon" />一周体验</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../activity/goActivity?activity_type_id=2"><img src="../static/wx/images/about_19.png" class="submenu_icon" />活动预告</a>
				</li>
			</ul>`;
		var popover_about_Code1=`<li class="mui-table-view-cell">
			<a href="../teacherin/toindex"><img src="../static/wx/images/about_19.png" class="submenu_icon showisth" />教室入口</a>
			</li>`;
		var popover_about_Code=`<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="../about/goAbout?type=1"><img src="../static/wx/images/about_19.png" class="submenu_icon" />品牌入驻</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../about/goAbout?type=0"><img src="../static/wx/images/about_19.png" class="submenu_icon" />关于我们</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../about/goContent"><img src="../static/wx/images/about_19.png" class="submenu_icon" />联系我们</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="../activity/goActivity"><img src="../static/wx/images/about_19.png" class="submenu_icon" />活动集锦</a>
				</li>
				
			`;
		var ul="</ul>";
		var flag=true;
		$.ajax({
			url:"../teacherin/findTeacherOpenId",
			dataType:"json",
			type:"post",
			async:false,
			success:function(msg){
				if(msg.COUNT>0){
					flag=false;
				}
			}
		})
		if(!flag){
			popover_about_Code+=popover_about_Code1;
		}
		popover_about_Code+=ul;
		create("nav",navCode,"mui-bar mui-bar-tab");
		create("div",popover_study_code,"mui-popover","popover_study");
		create("div",popover_act_Code,"mui-popover","popover_act");
		create("div",popover_about_Code,"mui-popover","popover_about");
		function create(type,HTMLCode,className,IdName){
		var possible=document.createElement(type);
		possible.innerHTML=HTMLCode;
		if(className!=null){
		possible.className=className;
		}
		if(IdName!=null){
		possible.id=IdName;
		}
		//此内容被遮罩层遮盖，适应侧滑，放在主页面容器上，需在该容器添加adapt_to_offcanvas
		if(type=='nav'){
			document.getElementsByClassName('adapt_to_offcanvas')[0].appendChild(possible);
		}else{
			//此内容不被遮罩层遮盖
			document.body.appendChild(possible);
		}
		// document.body.appendChild(possible);
		}
	}
})(window)