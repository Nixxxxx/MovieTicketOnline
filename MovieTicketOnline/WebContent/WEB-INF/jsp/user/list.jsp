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
  <script src="/MovieTicketOnline/static/plugins/jQuery/jquery-3.1.1.min.js"></script>
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
    <li>用户管理</li>
    <li class="active">用户列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">用户列表</h3>

          <div class="box-tools">
            <div class="input-group input-group-sm" style="width: 150px;">
              <input type="text" name="table_search" class="form-control pull-right" placeholder="Search">

              <div class="input-group-btn">
                <button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button>
              </div>
            </div>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body table-responsive no-padding">
          <table class="table table-hover table-bordered text-center">
            <thead>
            <tr>
              <th>序号</th>
              <th>用户名</th>
              <th>邮箱</th>
              <th>手机</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${userList!=null }" >
            <c:forEach var="user" items="${userList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="user_userName">${user.userName }</td>
              <td class="user_email">${user.email }</td>
              <td class="user_mobile">${user.mobile }</td>
              <td>
                <a data-id="${user.userId }" class="update" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#user_update_modal" data-backdrop="static">
                  <i class="fa fa-edit"></i>编辑</a> |
                <a data-id="${user.userId }" class="del" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 删除</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${userList==null }" >
            	<tr><td colspan="6">无记录！</td></tr>
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
            <input type="hidden" id="user_id" name="userId">
            <div class="form-group">
              <label for="user_userName" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_userName" name="userName" maxlength="20" placeholder="请输入用户名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="user_email" class="col-sm-2 control-label">邮箱</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_email" name="email" placeholder="请输入邮箱" required>
              </div>
            </div>
            <div class="form-group">
              <label for="user_mobile" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="user_mobile" name="mobile" placeholder="请输入手机" required>
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

<script>
    $(function(){
        //删除
        $(".del").click(function () {
            if (confirm("确认要删除吗？")) {
                var userId = $(this).data("id");
                $.ajax({
                    url: "user/del",
                    type: "POST",
                    data: {userId: userId},
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
                        if (data.success) {
                            //菜单栏当前选中
                            window.location.href="user/list";
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
            $("#user_id").val($(this).data("id"));
            $("#user_userName").val($(this).parent().prevAll(".user_userName").text());
            $("#user_email").val($(this).parent().prevAll(".user_email").text());
            $("#user_mobile").val($(this).parent().prevAll(".user_mobile").text());
        });
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
                        //菜单栏当前选中
                        window.location.href="user/list";
                        $("#user_update_modal").modal("hide");
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
    })
</script>
</body>
</html>