var myXlsFile;
try {
	myXlsFile = {
			flag:true,
			fileId:null,
			showImg:null,
			imgValue:null,
			input:null,
			basePath:null,
			request:null,
			callback:null,//回调函数
			/***
			 * 文档类型
			 */
			imgType:{'.xls':1}
			,
			/**
			 * ajax异步上传图片
			 * @param fileId:图片文件域ID
			 * @param showImg:图片上传成功后返回的一个图片URL地址,将这将图片显示在ID为showImg的DOM对象内
			 * @param imgValue:图片上传成功后返回的一个图片URL地址,此地址用于保存,即将地址存放到ID为imgValue的DOM对象内
			 * @param input 被触事上传事件的DOM对象
			 * @author tlh
			 * @date 2016年12月8日
			 */
			ajaxFile:function(fileId,params,callback){
				
				var my = this;
				if(!my.flag){
					return false;
				}
				if(!confirm("是否要上传表格，数据将会被覆盖！")){
					return false;
				}
				else if(typeof callback == 'function'){
					my.callback = callback;
				}
				my.fileId = fileId;
				
				var fileObj = document.getElementById(fileId).files[0]; // js 获取文件对象 
				if(null==fileObj){
					$("#"+my.fileId).tips({
						side:2,
			            msg:'文件为空',
			            bg:'#AE81FF',
			            time:5
			        });
					return false;
				}
				//正则验证图片类型
				var re = /\..+$/;
			    var ext = $("#"+fileId).val().match(re);
			    if(!my.imgType[ext[0]]){
			    	$("#"+my.fileId).tips({
						side:2,
			            msg:'图片类型只能为[xls]',
			            bg:'#AE81FF',
			            time:5
			        });
			    	return false;
			    }
				if(fileObj.size>1024*1024*3){
					$("#"+my.fileId).tips({
						side:2,
			            msg:'文件超过3MB,不允许上传!',
			            bg:'#AE81FF',
			            time:5
			        });
					return false;
				}
			    var FileController = my.getBasePath()+"/keepwatch/upload.do?"+new Date().getTime(); // 接收上传文件的后台地址   
			  
			    // FormData 对象  
			    var form = new FormData();  
			    form.append("file", fileObj); // 文件对象  
			    if(params){
			    	form.append("xls_type",params.xls_type);
			    }
			  
			    // XMLHttpRequest 对象  
			    my.request = new XMLHttpRequest();  
			    
			    my.flag = false;//阻塞
			    my.request.open("post", FileController, true);
			    
			    //得到返回结果
			    my.request.onload = function(e){
			    	 my.flag = true;//放开阻塞
			    	my.uploadEnd(e);
			    }
			    
			    //得到上传进度
			    my.request.upload.addEventListener("progress", function(e){
			    	my.progressFunction(e);
			    }, false);  
			    my.request.send(form);
			},
			uploadEnd:function(e){
				//得到返回结果 TODO
				var my = this;
				if(my.request.status=='200'){

					if(e.currentTarget.response){
						var res = eval('(' + e.currentTarget.response + ')');
						if(res.code=='000000'){
							$("."+my.fileId+"_line").find("._the_line_text").text("上传成功!");
							$("#"+my.fileId).tips({
								side:2,
					            msg:'上传成功!',
					            bg:'#AE81FF',
					            time:3
					        });
						}else{
							$(my.fileId).tips({
								side:2,
					            msg:res.msg,
					            bg:'#AE81FF',
					            time:3
					        });
						}
					}
				}else{
					
				}
				//有回调则调用回调
				if(typeof my.callback == 'function'){
					my.callback();
					my.callback = null;
				}
			},
			/***
			 * 上传进度
			 */
			progressFunction:function(e){
				//上传进度 TODO
				var my = this;
				var fileLoaded = e.loaded;
				var fileTotal = e.total;
				if(my.fileId){
					var bfb = Math.round(fileLoaded / fileTotal * 100);
					var line_width = $("."+my.fileId+"_line").find(".upload_time_line").width();
					console.log(line_width);
					if(bfb>=100){
						$("."+my.fileId+"_line").find("._the_line").css("width","100%");
						$("."+my.fileId+"_line").find("._the_line_text").text("上传完成,正在处理!");
					}else{
						$("."+my.fileId+"_line").find("._the_line_text").text('上传进度:'+bfb+"%");
						$("."+my.fileId+"_line").find("._the_line").css("width",fileLoaded / fileTotal *line_width);
					}
				}
			},
			/***
			 * 获取访问路径
			 */
			getBasePath:function(){
				var location = (window.location+'').split('/');  
				this.basePath = location[0]+'//'+location[2]+'/'+location[3];
				return this.basePath;
			}
	};

	//加载外部样式
	$("<link>")
	.attr({ rel: "stylesheet",
	type: "text/css",
	href: "static/ace/css/ajaxfile.css"
	})
	.appendTo("head");
} catch (e) {
	alert("文件上传出错");
}