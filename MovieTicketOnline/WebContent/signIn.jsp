<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>电票贩</title>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    <link rel="shortcut icon" href="/MovieTicketOnline/static/dist/img/favicon.png">
    <link rel="stylesheet" href="/MovieTicketOnline/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/MovieTicketOnline/static/dist/css/login.css">
    
    <style>
        body {
            font-family: "Segoe UI", "Lucida Grande", Helvetica, Arial, "Microsoft YaHei", FreeSans, Arimo, "Droid Sans", "wenquanyi micro hei", "Hiragino Sans GB", "Hiragino Sans GB W3", "FontAwesome", sans-serif;
        }
    </style>
</head>
<body>
<div class="container w-xxl w-auto-xs">
    <a href="" class="navbar-brand block m-t m-b-sm">电票贩</a>
    <div class="m-b-xxl">
        <div class="wrapper text-center">
            <strong>Sign in</strong>
        </div>
        <form id="signInForm">
            <div class="text-danger wrapper-xs text-center invisible" id="error_msg">
                	错误信息
            </div>
            <div class="list-group list-group-sm">
                <div class="list-group-item">
                    <input type="text" name="adminName" id="admin_name" placeholder="Username" class="form-control no-border">
                </div>
                <div class="list-group-item">
                    <input type="password" name="password" id="password" placeholder="Password" class="form-control no-border">
                </div>
                <div class="list-group-item">
                    <div class="row">
                        <div class="col-xs-7">
                            <input id="captcha" type="text" name="captcha" size=8 value="${imageCode }" placeholder="Captcha" class="form-control no-border">
                        </div>
                        <div class="col-xs-5">
                            <img id="randImage" name="randImage" style="cursor: pointer;height: 34px;width: 100%" title="点击可更换"
                                 onclick="javascript:loadImage();"src="image.jsp">
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
              <div class="col-xs-4">
            	<span class="left">记住我：</span>
                <input id="checkbox" type="checkbox" name="checkbox"/>
              </div>
              <div class="col-xs-8">
                <select class="form-control select2" id="type" style="width: 100%">
                  <option value="0">用户</option>
                  <option value="1">管理员</option>
                </select>
              </div>
            </div>	
            <button type="submit" class="btn btn-lg btn-primary btn-block" id="signInBtn" data-loading-text="登录中...">立即登录</button>
            <div class="text-center m-t m-b"><a href="javascript:void(0);">Forgot password?</a></div>
            <div class="line line-dashed"></div>
        </form>
    </div>
    <div class="text-center">
        <p>
            <small class="text-muted">
                <a href="#" target="_blank">电票贩</a><br> All Rights Reserved &copy; 2017
            </small>
        </p>
    </div>
</div>
</body>
<!-- jQuery 3.1.1 -->
<script src="${pageContext.request.contextPath}/static/plugins/jQuery/jquery-3.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<script>
$(function () {
    var $error_msg = $("#error_msg");

    var show_error = function (error_msg) {
        $error_msg.text(error_msg).removeClass("invisible");
    };

    $("#signInForm").submit(function () {
        $error_msg.addClass("invisible")
        var adminName = $.trim($("#admin_name").val());
        var password = $.trim($("#password").val());
        var captcha = $.trim($("#captcha").val());
        var u_pattern = /^[a-zA-Z0-9_@]{4,20}$/;
        var c_pattern = /^[a-zA-Z0-9]{4}$/;
        if (!u_pattern.test(adminName)) {
            show_error("请输入正确格式的用户名");
            return false;
        }
        if (password == "") {
            show_error("请输入密码");
            return false;
        }
        if (!u_pattern.test(password)) {
            show_error("请输入正确格式的密码");
            return false;
        }
        if (!c_pattern.test(captcha)) {
            show_error("请输入正确格式的验证码");
            return false;
        }
        var $signInBtn = $("#signInBtn");
        if($("#type").val() == 1){
        	url = "admin/signIn";
        	href = "admin/index";
        }else{
        	url = "user/signIn";
        	href = "index.jsp";
        }
        $.ajax({
            url: url,
            type: "POST",
            data: {
            	adminName: adminName,
                password: password,
                captcha: captcha,
                checkbox: $("#checkbox").prop("checked")
            },
            dataType: "json",
            beforeSend: function () {
                $signInBtn.button("loading");
            },
            complete: function () {
                //重置登录按钮
                $signInBtn.button("reset");
                //重置验证码
                $("#randImage").trigger("click");
            },
            success: function (data) {
            	if(data.result == ""){
            		window.location.href = href;
            	}else{
                    show_error(data.result);
            	}
            },
            error: function (XMLHttpRequest, textStatus) {
                if (textStatus == "timeout") {
                    show_error("登录超时");
                } else {
                    show_error("登录失败");
                }
            }
        });
        return false;
    });
})
    
    
    function loadImage(){
  		$("#randImage").attr("src","image.jsp?"+Math.random());  //document.getElementById("randImage")定义一个img对象     src="image.jsp?"指定对象        +Math.random()为了使每次访问image.jsp的地址不一样，这样浏览器不会取本地缓存的数据。
  	}
</script>
</html>