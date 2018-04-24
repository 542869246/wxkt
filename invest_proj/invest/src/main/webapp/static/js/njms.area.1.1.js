var mySelect;
	mySelect = {
			basePath:null,
			setCountyForParent:function(county_id){
				if(null==county_id||$.trim(county_id)==''){
					return false;
				}
				var my = this;
				var city_id;
				my.ajax1(county_id,function(data){
					city_id = data.DICTIONARIES_ID;
				});
				my.ajaxAreaById(county_id, function(data){
					if(data){
						$("#province").val(data.DICTIONARIES_ID);
					}
					my.setCity(data.DICTIONARIES_ID,function(city_res){
						$("#city").val(city_id);
					});
				});
			},
			/**初始化*/
			init:function(call){
				this.cityInit();
//				this.countyInit();
				this.provinceInit(function(data){
					if(call&&data){
						if(call){
							call(true);
						}
					}else{
						if(call){
							call(false);
						}
					}
				});
			},
			/**省份初始化*/
			provinceInit:function(call){
				$("#province").empty();
				this.ajax('8e94b3e7b4274a8984747024771145d0', function(data){
					if(null!=data){
						var options;
						for (var i = 0; i < data.length; i++) {
							options+="<option data-info='"+data[i].BIANMA+"' value='"+data[i].DICTIONARIES_ID+"'>"+data[i].NAME+"</option>";
						}
						$("#province").append("<option value=''>请选择</option>"+options);
						if(call){
							call(true);
						}
					}else{
						if(call){
							call(false);
						}
					}
				});
			},
			/**城市初始化*/
			cityInit:function(){
				$("#city").empty(); 
				$("#city").hide();
			},
			/**区县初始化*/
			countyInit:function(){
				$("#county").empty(); 
				$("#county").hide();
			},
			/**获取省份下面所有的市*/
			setCity:function(province_id,call){
				if(null==province_id){
					return false;
				}
				
				$("#city").empty(); 
				$("#county").empty();
				$("#city").show();
				$("#city").show();
				
				this.ajax(province_id, function(data){
					if(null!=data&&data.length>0){
						var options;
						for (var i = 0; i < data.length; i++) {
							options+="<option data-info='"+data[i].BIANMA+"' value='"+data[i].DICTIONARIES_ID+"'>"+data[i].NAME+"</option>";
						}
						$("#city").append(options);
						if(call){
							call(true);
						}else{//如果没有回调,则继续级联区县
							//初始化第一个市下的所有区县
//							mySelect.setCounty(data[0].ID);
							call(true);
						}
					}else{
						if(call){
							call(false);
						}
					}
				});
			},
			/**ajax请求*/
			ajax:function(id,call){
				$.ajax({
					type: "POST",
					url: mySelect.basePath+'product/getChan.do',
			    	data: {PARENT_ID:id},
					dataType:'json',
					cache: false,
					success: function(data){
						 //查询得到结果
						 call(data);
					}
				});
			},
			/**ajax请求*/
			ajax1:function(id,call){
				$.ajax({
					type: "POST",
					url: mySelect.basePath+'product/getTwo.do',
			    	data: {BIANMA:id},
					dataType:'json',
					cache: false,
					success: function(data){
						 //查询得到结果
						 call(data);
					}
				});
			},
			/**
			 * ajax根据类型查询上级
			 */
			ajaxAreaById:function(area_id,call){
				if(null==area_id||$.trim(area_id)==''){
					call(false);
				}
				$.ajax({
					type: "POST",
					url: mySelect.basePath+'product/getHui.do',
			    	data: {DICTIONARIES_ID:area_id},
					dataType:'json',
					cache: false,
					success: function(data){
						 //查询得到结果
						 call(data);
					}
				});
			},
			/**省份切换,联动市*/
			changeByProvince:function(province_id){
				if(null==province_id||""==$.trim(province_id)){
					mySelect.cityInit();
					mySelect.countyInit();
					return;
				}
				mySelect.setCity(province_id);
			},
			/**市切换,联运到区县*/
			changeByCity:function(city_id){
				if(null==city_id||""==$.trim(city_id)){
					mySelect.countyInit();
					return;
				}
				mySelect.setCounty(city_id);
			},
			/**区县切换*/
			changeByCounty:function(obj){
				if(!obj){
					return false;
				}
				var _val = $(obj).find("option:selected").val();
				if(null==_val||$.trim(_val)==''){
					$("#area_name").val('');
					return true;
				}
				var _text = $(obj).find("option:selected").text();
				$("#area_name").val(_text);
				return true;
			}
	};