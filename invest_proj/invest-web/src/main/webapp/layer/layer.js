/*! layer mobile-v1.7 弹层组件移动版 License LGPL http://layer.layui.com/mobile By 贤心 */ ;
! function(a) {
    "use strict";
    var b = document,
        c = "querySelectorAll",
        d = "getElementsByClassName",
        e = function(a) {
            return b[c](a)
        },
        f = {
            type: 0,
            shade: !0,
            shadeClose: !0,
            fixed: !0,
            anim: !0
        },
        g = {
            extend: function(a) {
                var b = JSON.parse(JSON.stringify(f));
                for(var c in a) b[c] = a[c];
                return b
            },
            timer: {},
            end: {}
        };
    g.touch = function(a, b) {
        var c;
        return /Android|iPhone|SymbianOS|Windows Phone|iPad|iPod/.test(navigator.userAgent) ? (a.addEventListener("touchmove", function() {
            c = !0
        }, !1), void a.addEventListener("touchend", function(a) {
            a.preventDefault(), c || b.call(this, a), c = !1
        }, !1)) : a.addEventListener("click", function(a) {
            b.call(this, a)
        }, !1)
    };
    var h = 0,
        i = ["layermbox"],
        j = function(a) {
            var b = this;
            b.config = g.extend(a), b.view()
        };
    j.prototype.view = function() {
        var a = this,
            c = a.config,
            f = b.createElement("div");
        a.id = f.id = i[0] + h, f.setAttribute("class", i[0] + " " + i[0] + (c.type || 0)), f.setAttribute("index", h);
        var g = function() {
                var a = "object" == typeof c.title;
                return c.title ? '<h3 style="' + (a ? c.title[1] : "") + '">' + (a ? c.title[0] : c.title) + '</h3><button class="layermend"></button>' : ""
            }(),
            j = function() {
                var a, b = (c.btn || []).length;
                return 0 !== b && c.btn ? (a = '<span type="1" class="Determine">' + c.btn[0] + "</span>", 2 === b && (a = '<span type="0">' + c.btn[1] + "</span>" + a), '<div class="layermbtn">' + a + "</div>") : ""
            }();
        if(c.fixed || (c.top = c.hasOwnProperty("top") ? c.top : 100, c.style = c.style || "", c.style += " top:" + (b.body.scrollTop + c.top) + "px"), 2 === c.type && (c.content = '<i></i><i class="laymloadtwo"></i><i></i>'), f.innerHTML = (c.shade ? "<div " + ("string" == typeof c.shade ? 'style="' + c.shade + '"' : "") + ' class="laymshade"></div>' : "") + '<div class="layermmain" ' + (c.fixed ? "" : 'style="position:static;"') + '><div class="section"><div class="layermchild ' + (c.className ? c.className : "") + " " + (c.type || c.shade ? "" : "layermborder ") + (c.anim ? "layermanim" : "") + '" ' + (c.style ? 'style="' + c.style + '"' : "") + ">" + g + '<div class="layermcont">' + c.content + "</div>" + j + "</div></div></div>", !c.type || 2 === c.type) {
            var k = b[d](i[0] + c.type),
                l = k.length;
            l >= 1 && layer.close(k[0].getAttribute("index"))
        }
        document.body.appendChild(f);
        var m = a.elem = e("#" + a.id)[0];
        c.success && c.success(m), a.index = h++, a.action(c, m)
    }, j.prototype.action = function(a, b) {
        var c = this;
        if(a.time && (g.timer[c.index] = setTimeout(function() {
                layer.close(c.index)
            }, 1e3 * a.time)), a.title) {
            var e = b[d]("layermend")[0],
                f = function() {
                    a.cancel && a.cancel(), layer.close(c.index)
                };
            g.touch(e, f)
        }
        var h = function() {
            var b = this.getAttribute("type");
            0 == b ? (a.no && a.no(), layer.close(c.index)) : a.yes ? a.yes(c.index) : layer.close(c.index)
        };
        if(a.btn)
            for(var i = b[d]("layermbtn")[0].children, j = i.length, k = 0; j > k; k++) g.touch(i[k], h);
        if(a.shade && a.shadeClose) {
            var l = b[d]("laymshade")[0];
            g.touch(l, function() {
                layer.close(c.index, a.end)
            })
        }
        a.end && (g.end[c.index] = a.end)
    }, a.layer = {
        v: "1.7",
        index: h,
        open: function(a) {
            var b = new j(a || {});
            return b.index
        },
        close: function(a) {
            var c = e("#" + i[0] + a)[0];
            c && (c.innerHTML = "", b.body.removeChild(c), clearTimeout(g.timer[a]), delete g.timer[a], "function" == typeof g.end[a] && g.end[a](), delete g.end[a])
        },
        closeAll: function() {
            for(var a = b[d](i[0]), c = 0, e = a.length; e > c; c++) layer.close(0 | a[0].getAttribute("index"))
        }
    }, "function" == typeof define ? define(function() {
        return layer
    }) : function() {
        var a = document.scripts,
            c = a[a.length - 1],
            d = c.src,
            e = d.substring(0, d.lastIndexOf("/") + 1);
        c.getAttribute("merge") || document.head.appendChild(function() {
            var a = b.createElement("link");
            return a.href = e + "need/layer.css", a.type = "text/css", a.rel = "styleSheet", a.id = "layermcss", a
        }())
    }()
}(window);

layerInput=function (title,hint,call,maxLength,colspan,rows) {
    if(!maxLength){
        maxLength = 600;
    }
    if(!colspan){
        colspan = 30;
    }
    if(!rows){
        rows = 4;
    }
    //页面层
    layer.open({
        title:["　"+title+"　", "font-size:14px;"],
        content: '<textarea placeholder='+hint+' type="text" maxlength='+maxLength+' cols='+colspan+' class="textarea_no_border" rows='+rows+' id="layerInputx"></textarea>',
        btn: ['确认', '取消'],
        area: ['400px', '300px'],
        yes: function(index) {
            var data= $("#layerInputx").val();
            layer.close(index);
            if(call) {
                call(true,data);
            }
        },
        no: function(index) {
            var data= $("#layerInputx").val();
            if(call) {
                call(false,data);
            }
        }
    });
}
/**
 * layer 提示框
 * <br/>layerAlert("hello world!");
 * @param content ->提示信息
 * @param call ->回调方法
 */
layerAlert = function(content, call) {
    if(!content) {
        return null;
    }
    layer.open({
        title: ["　提示　", "font-size:12px;"],
        content: content,
        btn: ['确定'],
        end: function(e) {
            if(call) {
                call(e);
            }
        }
    });
};


/**
 * layer遮照层
 */
layerLoader = function(content) {
    if(!content) {
        layer.open({
            type: 2,
            shadeClose: false
        });
    } else {
        layer.open({
            type: 2,
            content: content,
            shadeClose: false,
        });
    }
}

/**
 * 关闭layer遮照层
 * @param index　->关闭层编号　如果不提供此参数则关闭全的层
 */
layerClose = function(index) {
    if(!index) {
        layer.closeAll();
    } else {
        layer.close(index);
    }
}

/**
 * layer询问框，弹出提示信息
 * <br/>
 * @param content
 * @param call ->回调方法，返回{true/false}=>true：点击了"确认"；false:点了取消
 */
layerConfirm = function(content, call) {
    layer.open({
        title: ["　提示　", "font-size:12px;"],
        btn: ['确认', '取消'],
        shadeClose: false,
        content: content,
        yes: function(index) {
            layer.close(index);
            if(call) {
                call(true);
            }
        },
        no: function(index) {
            if(call) {
                call(false);
            }
        }
    });
}

/**
 * layer询问框，弹出提示信息
 * <br/>
 * @param title ->标题
 * @param content ->正文
 * @param call ->回调方法，返回{true/false}=>true：点击了"确认"；false:点了取消
 */
layerConfirmThree = function(content, call, title) {
	title = (typeof title=='undefined'||title==null||title=='')?'提示':title;
    layer.open({
        title: ["　"+title+"　", "font-size:12px;"],
        btn: ['确认'],
        shadeClose: false,
        content: content,
        yes: function(index) {
            layer.close(index);
            if(call) {
                call(true);
            }
        },
        no: function(index) {
            if(call) {
                call(false);
            }
        }
    });
}

layerConfirmTwo = function(content, call) {
    layer.open({
        title: ["　提示　", "font-size:12px;"],
        btn: ['审核通过', '审核不通过'],
        shadeClose: false,
        content: content,
        yes: function(index) {
            layer.close(index);
            if(call) {
                call(true);
            }
        },
        no: function(index) {
            if(call) {
                call(false);
            }
        }
    });
}


/**
 * layer询问框，弹出提示信息
 * <br/>
 * @param content
 * @param call ->回调方法，返回{true/false}=>true：点击了"是"；false:点了否
 */
layerConfirmYesNo = function(content, call) {
    layer.open({
        title: ["　提示　", "font-size:12px;"],
        btn: ['是', '否'],
        shadeClose: false,
        content: content,
        yes: function(index) {
            layer.close(index);
            if(call) {
                call(true);
            }
        },
        no: function(index) {
            if(call) {
                call(false);
            }
        }
    });
}