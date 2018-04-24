(function(floor){
	floor.createMenu=function(){
		var navCode=`<a class="mui-tab-item" href="#" id="leave" style="color:#C99766";">
				<div style="font-size: 90%;">请假管理</div></a>
			<a class="mui-tab-item" style="color:#C99766"; href="#"><div style="font-size: 90%;">日报管理</div></a>
			<a class="mui-tab-item" style="color:#C99766"; href="#"><div style="font-size: 90%;">学生评价</div></a>
			<a class="mui-tab-item" style="color:#C99766"; href="#"><div style="font-size: 90%;">能力值</div></a>
			`;
		
		var popover_study_code=`
				
		`;
		
		
		var popover_act_Code=`
		`;
		var popover_about_Code1=``;
		var popover_about_Code=`
				
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
//		if(!flag){
//			popover_about_Code+=popover_about_Code1;
//		}
		popover_about_Code+=ul;
		create("nav",navCode,"mui-bar mui-bar-tab");
//		create("div",popover_study_code,"mui-popover","popover_study");
//		create("div",popover_act_Code,"mui-popover","popover_act");
//		create("div",popover_about_Code,"mui-popover","popover_about");
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
		}
		}
	}
	
})(window)