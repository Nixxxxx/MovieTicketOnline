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
  
<!-- logo -->
  <link rel="shortcut icon" href="/MovieTicketOnline/static/dist/img/favicon.png">
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
  <!--  AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->

  
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
    <li>影院管理</li>
    <li class="active">添加影院</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <!-- Small boxes (Stat box) -->
  <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">添加影院</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="cinema_insert_form">
          <div class="box-body">
            <div class="form-group">
              <label for="location_number" class="col-sm-2 control-label">编号</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="cinema_id" name="number" placeholder="请输入地点编号" required>
              </div>
            </div>
            <div class="form-group">
              <label for="cinemaName" class="col-sm-2 control-label">影院名称</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="cinema_name" name="cinemaName" maxlength="20" placeholder="请输入影院名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="cinema_address" class="col-sm-2 control-label">地址</label>
              <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="cinema_address" name="address" maxlength="100" placeholder="请输入地址，100字以内，必填" required></textarea>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="reset" class="btn btn-default">重置</button>
            <button type="submit" class="btn btn-info pull-right" id="cinema_insert_button" data-loading-text="添加中...">添加</button>
          </div>
          <!-- /.box-footer -->
        </form>
      </div>
      <!-- /.box -->
    </div>
  </div>
</section>
<!-- /.content -->
<script type="text/javascript">
    $(function () {
        var $cinema_insert_form = $("#cinema_insert_form");
        $cinema_insert_form.submit(function () {

            var $insert_btn = $("#cinema_insert_button");

            $.ajax({
                url: "cinema/insert",
                type: "POST",
                dataType: "json",
                data: $cinema_insert_form.serialize(),
                beforeSend: function () {
                    $insert_btn.button("loading");
                },
                complete: function () {
                    $insert_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        $cinema_insert_form[0].reset();
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
    })
</script>
</body>
</html>