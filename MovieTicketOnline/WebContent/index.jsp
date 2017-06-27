<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>电票贩</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<base href="<%=basePath%>">

<link rel="shortcut icon"
	href="/MovieTicketOnline/static/dist/img/favicon.png">
<!--  Bootstrap 3.3.6  -->
<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
<!--  Font Awesome  -->
<link rel="stylesheet"
	href="static/plugins/font-awesome/css/font-awesome.min.css">
<!--  Select2  -->
<link rel="stylesheet" href="static/plugins/select2/select2.min.css">
<script
	src="/MovieTicketOnline/static/plugins/select2/select2.full.min.js"></script>
<!--  bootstrap datepicker  -->
<link rel="stylesheet"
	href="/MovieTicketOnline/static/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css">
<script
	src="/MovieTicketOnline/static/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script
	src="/MovieTicketOnline/static/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<!--  Slimscroll  -->
<script
	src="/MovieTicketOnline/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!--  Theme style  -->
<link rel="stylesheet"
	href="/MovieTicketOnline/static/dist/css/AdminLTE.css">




</head>
<nav class="navbar navbar-invers">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">电票贩</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Link <span class="sr-only"></span></a></li>
        <li><a href="#">Link</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-check"></span></a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.userName } <span class="caret"></span></a>
          <c:if test="${user != null }">
          <ul class="dropdown-menu">
            <li><a href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#user_update_modal" data-backdrop="static">个人信息</a></li>
            <li><a href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#user_change_password_modal" data-backdrop="static">修改密码</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="user/orderList?userId=${user.userId }" target="container">订单信息</a></li>
          </ul>
          </c:if>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

  <div class="content-wrapper">
    <iframe name="container" style="zoom: 1;" height="650px;" src="user/scheduleList" frameBorder="0" width="100%"></iframe>
  </div>

<!-- Modal -->
<div class="modal fade" id="user_update_modal" tabindex="-1" role="dialog" aria-labelledby="user_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="user_update_label">用户列表</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="user_update_form">
          <div class="box-body">
            <input type="hidden" id="user_id" name="userId" value="${user.userId }">
            <div class="form-group">
              <label for="user_userName" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_userName" name="userName" value="${user.userName }" maxlength="20" placeholder="请输入用户名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="user_email" class="col-sm-2 control-label">邮箱</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_email" name="email" value="${user.email }" placeholder="请输入邮箱" required>
              </div>
            </div>
            <div class="form-group">
              <label for="user_mobile" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_mobile" name="mobile" value="${user.mobile }" placeholder="请输入手机" required>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="user_update_button" data-loading-text="更新中...">更新</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="user_change_password_modal" tabindex="-1" role="dialog" aria-labelledby="user_change_password_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="user_change_password_label">修改密码</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="user_change_password_form">
          <div class="text-danger wrapper-xs text-center invisible" id="error_msg2">
                	错误信息
          </div>
          <div class="box-body">
            <input type="hidden" id="change_user_id" name="userId" value="${user.userId }">
            <div class="form-group">
              <label for="user_name" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <p class="form-control-static" id="change_user_name">${user.userName }</p>
              </div>
            </div>
            <div class="form-group">
              <label for="change_user_password" class="col-sm-2 control-label">原密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="oldPassword" placeholder="请输入原密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="change_user_password" class="col-sm-2 control-label">新密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="newPassword" placeholder="请输入新密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="change_confirm_password" class="col-sm-2 control-label">确认密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="confirmPassword" placeholder="请再次输入新密码" required>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="user_change_button" data-loading-text="修改中...">修改</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>



	<!-- jQuery 3.1.1 -->
	<script
		src="/MovieTicketOnline/static/plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/MovieTicketOnline/static/bootstrap/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="/MovieTicketOnline/static/dist/js/app.min.js"></script>
<script>
    $(function(){
        //更新
        var $user_update_form = $("#user_update_form");
        $user_update_form.submit(function () {
            var $update_btn = $("#user_update_button");
            $.ajax({
                url: "user/update",
                type: "POST",
                dataType: "json",
                data: $user_update_form.serialize(),
                beforeSend: function () {
                    $update_btn.button("loading");
                },
                complete: function () {
                    $update_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        window.location.href="signIn.jsp";
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (textStatus === "timeout") {
                        alert("更新超时！");
                    } else {
                        alert("更新失败！");
                    }
                }
            });
            return false;
        });
        
        
        //修改密码
        var $user_change_form = $("#user_change_password_form");
        $user_change_form.submit(function () {
        	var $error_msg = $("#error_msg2");

            var show_error = function (error_msg) {
                $error_msg.text(error_msg).removeClass("invisible");
            };
        	$error_msg.addClass("invisible");
            var old_password = $.trim($("#user_change_password_form input[name=oldPassword]").val());
            var new_password = $.trim($("#user_change_password_form input[name=newPassword]").val());
            var confirm_password = $.trim($("#user_change_password_form input[name=confirmPassword]").val());
            var u_pattern = /^[a-zA-Z0-9_@]{4,20}$/;
            if (old_password=="" || new_password == ""|| confirm_password == "") {
                show_error("请填写完整");	
                return false;
            }
            if (!u_pattern.test(old_password)) {
                show_error("请输入正确格式的原密码");
                return false;
            }
            if(new_password.localeCompare(confirm_password)!=0){
            	show_error("密码不一致");
            	return false;
            }
            if (!u_pattern.test(new_password)) {
                show_error("请输入正确格式的新密码");
                return false;
            }

            var $change_btn = $("#user_change_button");

            $.ajax({
                url: "user/changePassword",
                type: "POST",
                dataType: "json",
                data: $user_change_form.serialize(),
                beforeSend: function () {
                    $change_btn.button("loading");
                },
                complete: function () {
                    $change_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        window.location.href="signIn.jsp";
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (textStatus === "timeout") {
                        alert("修改超时！");
                    } else {
                        alert("修改失败！");
                    }
                }
            });
            return false;
        });
    })
</script>
</body>
</html>
