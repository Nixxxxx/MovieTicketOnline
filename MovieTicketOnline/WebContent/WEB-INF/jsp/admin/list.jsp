<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>电票贩</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <base href="<%=basePath%>">
  
  <!--  jQuery 3.1.1 -->
  <script src="/MovieTicketOnline/static/dist/jQuery/jquery-3.1.1.min.js"></script>
  <!--  Bootstrap 3.3.6  -->
  <link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
  <script src="/MovieTicketOnline/static/bootstrap/js/bootstrap.min.js"></script>
  <!--  Font Awesome  -->
  <link rel="stylesheet" href="static/plugins/font-awesome/css/font-awesome.min.css">
  <!--  Select2  -->
  <link rel="stylesheet" href="static/plugins/select2/select2.min.css">
  <script src="/MovieTicketOnline/static/plugins/select2/select2.full.min.js"></script>
  <!--  bootstrap datepicker  -->
  <link rel="stylesheet" href="/MovieTicketOnline/static/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css">
  <script src="/MovieTicketOnline/static/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  <script src="/MovieTicketOnline/static/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
  <!--  Slimscroll  -->
  <script src="/MovieTicketOnline/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
  <!--  Theme style  -->
  <link rel="stylesheet" href="/MovieTicketOnline/static/dist/css/AdminLTE.css">
  
  <style>
    body,button, input, select, textarea,h1 ,h2, h3, h4, h5, h6 {
      font-family: Microsoft YaHei,"宋体" , Tahoma, Helvetica, Arial, "\5b8b\4f53", sans-serif;
    }
    .content-header > .breadcrumb {
      position: relative;
      margin-top: 5px;
      top: 0;
      right: 0;
      float: none;
      background: #d2d6de;
      padding-left: 10px;
    }
    .content-header > .breadcrumb li:before {
      color: #97a0b3;
    }
  </style>
</head>
<body>
<!-- Content Header (Page header) -->
<section class="content-header">
  <ol class="breadcrumb">
    <li><a href="order/info"><i class="fa fa-dashboard"></i> 首页</a></li>
    <li>系统设置</li>
    <li class="active">管理员列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">管理员列表</h3>

          <div class="box-tools">
            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-remote="false" data-target="#admin_add_modal" data-backdrop="static">添加管理员</button>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body table-responsive no-padding">
          <table class="table table-hover table-bordered text-center">
            <thead>
            <tr>
              <th>序号</th>
              <th>管理员名</th>
              <th>邮箱</th>
              <th>手机</th>
              <th>备注</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${adminList!=null }">
            <c:forEach var="admin" items="${adminList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="admin_name">${admin.adminName }</td>
              <td class="admin_email">${admin.email }</td>
              <td class="admin_mobile">${admin.mobile }</td>
              <td class="admin_extra">${admin.extra }</td>
              <td>
                <a data-id="${admin.adminId }" class="update" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#admin_update_modal" data-backdrop="static">
                  <i class="fa fa-edit"></i> 编辑</a>
                <a data-id="${admin.adminId }" class="change_password" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#admin_change_password_modal" data-backdrop="static">
                  <i class="fa fa-pencil"></i> 修改密码</a>
                <a data-id="${admin.adminId }" class="del" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 删除</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${adminList == null }">
            	<tr><td colspan="7">无记录！</td></tr>
            </c:if>
          </table>
        </div>
        <!-- /.box-body -->
        <div class="box-footer clearfix">
          <div class="pull-right">
            <nav aria-label="Page navigation">
   			  <ul class="pagination">
                  ${pageCode }
			 </ul>
			</nav>
          </div>
        </div>
      </div>
      <!-- /.box -->
    </div>
  </div>
</section>
<!-- /.content -->

<!-- Modal -->
<div class="modal fade" id="admin_update_modal" tabindex="-1" role="dialog" aria-labelledby="admin_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="admin_update_label">编辑人员</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="admin_update_form">
          <div class="box-body">
            <input type="hidden" id="admin_id" name="adminId">
            <div class="form-group">
              <label for="admin_name" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="admin_name" name="adminName" maxlength="20" placeholder="请输入用户名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="admin_mobile" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="admin_mobile" name="mobile" maxlength="20" placeholder="请输入手机" required>
              </div>
            </div>
            <div class="form-group">
              <label for="admin_email" class="col-sm-2 control-label">Email</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="admin_email" name="email" maxlength="20" placeholder="请输入Email" required>
              </div>
            </div>
            <div class="form-group">
              <label for="admin_extra" class="col-sm-2 control-label">备注</label>
              <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="admin_extra" name="extra" maxlength="100" placeholder="请输入备注，100字以内" required></textarea>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="admin_update_button" data-loading-text="更新中...">更新</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="admin_add_modal" tabindex="-1" role="dialog" aria-labelledby="admin_add_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="admin_add_label">添加管理员</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="admin_add_form">
          <div class="text-danger wrapper-xs text-center invisible" id="error_msg1">
                	错误信息
          </div>
          <div class="box-body">
            <div class="form-group">
              <label for="add_admin_name" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="add_admin_name" name="adminName" maxlength="20" placeholder="请输入用户名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_password" class="col-sm-2 control-label">密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" id="add_admin_password" name="password" maxlength="20" placeholder="请输入密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_confirm_password" class="col-sm-2 control-label">确认密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" id="add_confirm_password" name="confirm_password" maxlength="20" placeholder="请再次输入密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_mobile" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="add_admin_mobile" name="mobile" maxlength="20" placeholder="请输入手机" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_email" class="col-sm-2 control-label">Email</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="add_admin_email" name="email" maxlength="20" placeholder="请输入Email" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_extra" class="col-sm-2 control-label">备注</label>
              <div class="col-sm-10">
                <textarea class="form-control" id="add_admin_extra" rows="3" name="extra" maxlength="100" placeholder="请输入备注，100字以内，选填"></textarea>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="admin_add_button" data-loading-text="添加中...">添加</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="admin_change_password_modal" tabindex="-1" role="dialog" aria-labelledby="admin_change_password_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="admin_change_password_label">修改密码</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="admin_change_password_form">
          <div class="text-danger wrapper-xs text-center invisible" id="error_msg2">
                	错误信息
          </div>
          <div class="box-body">
            <input type="hidden" id="change_admin_id" name="adminId">
            <div class="form-group">
              <label for="admin_name" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <p class="form-control-static" id="change_admin_name"></p>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_password" class="col-sm-2 control-label">原密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="old_password" placeholder="请输入原密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_admin_password" class="col-sm-2 control-label">新密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="new_password" placeholder="请输入新密码" required>
              </div>
            </div>
            <div class="form-group">
              <label for="add_confirm_password" class="col-sm-2 control-label">确认密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" name="confirm_password" placeholder="请再次输入新密码" required>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="admin_change_button" data-loading-text="修改中...">修改</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>

<script>
    $(function(){

        //删除
        $(".del").click(function () {

            if (confirm("确认要删除吗？")) {
                var adminId = $(this).data("id");
                $.ajax({
                    url: "admin/del",
                    type: "POST",
                    data: {adminId: adminId},
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
                        if (data.success) {
                            //菜单栏当前选中
                        	window.location.href="admin/list";
                            $now_selected = $("ul.treeview-menu>li.active>a");
                            $now_selected.trigger("click");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus) {
                        if (textStatus === "timeout") {
                            alert("删除超时！");
                        } else {
                            alert("删除失败！");
                        }
                    }
                })
            }
        });

        //更新modal
        $(".update").click(function () {
            $("#admin_id").val($(this).data("id"));
            $("#admin_name").val($(this).parent().prevAll(".admin_name").text());
            $("#admin_mobile").val($(this).parent().prevAll(".admin_mobile").text());
            $("#admin_email").val($(this).parent().prevAll(".admin_email").text());
            $("#admin_extra").val($(this).parent().prevAll(".admin_extra").text());
        });

        //更新
        var $admin_update_form = $("#admin_update_form");
        $admin_update_form.submit(function () {

            var $update_btn = $("#admin_update_button");

            $.ajax({
                url: "admin/update",
                type: "POST",
                dataType: "json",
                data: $admin_update_form.serialize(),
                beforeSend: function () {
                    $update_btn.button("loading");
                },
                complete: function () {
                    $update_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        //菜单栏当前选中
                        window.location.href="admin/list";
                        $now_selected = $("ul.treeview-menu>li.active>a");
                        $now_selected.trigger("click");
                        $("#admin_update_modal").modal("hide");
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

        //添加
        var $admin_add_form = $("#admin_add_form");
        $admin_add_form.submit(function () {
        	var $error_msg = $("#error_msg1");

            var show_error = function (error_msg) {
                $error_msg.text(error_msg).removeClass("invisible");
            };
        	$error_msg.addClass("invisible");
            var userName = $.trim($("#admin_add_form input[name=adminName]").val());
            var password = $.trim($("#admin_add_form input[name=password]").val());
            var confirm_password = $.trim($("#admin_add_form input[name=confirm_password]").val());
            var u_pattern = /^[a-zA-Z0-9_@]{4,20}$/;
            if (!u_pattern.test(userName)) {
                show_error("请输入正确格式的用户名");
                return false;
            }
            if(password.localeCompare(confirm_password)!=0){
            	show_error("密码不一致");
            	return false;
            }
            if (!u_pattern.test(password)) {
                show_error("请输入正确格式的密码");
                return false;
            }
            
            
            var $add_btn = $("#admin_add_button");

            $.ajax({
                url: "admin/insert",
                type: "POST",
                dataType: "json",
                data: $admin_add_form.serialize(),
                beforeSend: function () {
                    $add_btn.button("loading");
                },
                complete: function () {
                    $add_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        //菜单栏当前选中
                        window.location.href="admin/list";
                        $now_selected = $("ul.treeview-menu>li.active>a");
                        $now_selected.trigger("click");
                        $("#admin_add_modal").modal("hide");
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (textStatus === "timeout") {
                        alert("添加超时！");
                    } else {
                        alert("添加失败！");
                    }
                }
            });
            return false;
        });


        //更新modal
        $(".change_password").click(function () {
            $("#change_admin_id").val($(this).data("id"));
            $("#change_admin_name").text($(this).parent().prevAll(".admin_name").text());
        });

        //修改密码
        var $admin_change_form = $("#admin_change_password_form");
        $admin_change_form.submit(function () {
        	var $error_msg = $("#error_msg2");

            var show_error = function (error_msg) {
                $error_msg.text(error_msg).removeClass("invisible");
            };
        	$error_msg.addClass("invisible");
            var old_password = $.trim($("#admin_change_password_form input[name=old_password]").val());
            var new_password = $.trim($("#admin_change_password_form input[name=new_password]").val());
            var confirm_password = $.trim($("#admin_change_password_form input[name=confirm_password]").val());
            var u_pattern = /^[a-zA-Z0-9_@]{4,20}$/;
            if (old_password==""||new_password == ""||confirm_password=="") {
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

            var $change_btn = $("#admin_change_button");

            $.ajax({
                url: "admin/changePassword",
                type: "POST",
                dataType: "json",
                data: $admin_change_form.serialize(),
                beforeSend: function () {
                    $change_btn.button("loading");
                },
                complete: function () {
                    $change_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        //菜单栏当前选中
                        window.location.href="admin/list";
                        $now_selected = $("ul.treeview-menu>li.active>a");
                        $now_selected.trigger("click");
                        $("#admin_change_password_modal").modal("hide");
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