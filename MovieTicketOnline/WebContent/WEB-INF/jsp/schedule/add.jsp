<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
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
  <meta content="width=movie-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
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
    <li>场次管理</li>
    <li class="active">添加场次</li>
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
          <h3 class="box-title">添加场次</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="schedule_add_form">
          <div class="box-body">
            <div class="form-group">
              <label for="schedule_cinema" class="col-sm-2 control-label">影院</label>
              <div class="col-sm-10">
                <select class="form-control select2" name="cinemaId" id="schedule_cinemaId" style="width: 100%">
                  <c:if test="${cinemas != null }">
                    <option value="">请选择影院</option>
                    <c:forEach var="cinema" items="${cinemas }">
                    <option value="${cinema.cinemaId }">
                    	${cinema.number }-${cinema.name }
                    </option>
					</c:forEach>
				  </c:if>
                  <c:if test="${cinemas == null }">
                    <option>请添加影院</option>
                  </c:if>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="schedule_movie" class="col-sm-2 control-label">电影</label>
              <div class="col-sm-10">
                <select class="form-control select2" name="movieId" id="schedule_movieId" style="width: 100%">
                  <c:if test="${movies != null }">
                    <option value="">请选择电影</option>
                    <c:forEach var="movie" items="${movies }">
                    <option value="${movie.movieId }">
                      ${movie.number }-${movie.name }
                    </option>
                    </c:forEach>
                  </c:if>
                  <c:if test="${movies == null }">
                    <option>请添加电影</option>
                  </c:if>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="schedule_date" class="col-sm-2 control-label">日期</label>
              <div class="col-sm-3">
                <input type="text" class="form-control pull-right" id="schedule_date" name="date">
              </div>
              <label class="col-sm-2 control-label">开始时间</label>
              <div class="col-sm-5">
                <div class="row">
                  <div class="col-sm-6">
                    <select class="form-control hour" id="schedule_hour" name="hour" title="时"></select>
                  </div>
                  <div class="col-sm-6">
                    <select class="form-control minute" id="schedule_minute" name="minute" title="分"></select>
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
              <label for="schedule_seat" class="col-sm-2 control-label">座位数</label>
              <div class="col-sm-10">
                <input class="form-control" id="schedule_seat" name="seat" maxlength="4" placeholder="请输入座位数" required>
              </div>
            </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="reset" class="btn btn-default">重置</button>
            <button type="submit" class="btn btn-info pull-right" id="schedule_add_button" data-loading-text="添加中...">添加</button>
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
        //设置小时的option
        $(".hour").html(function () {
            var str = "";
            for (var i = 0; i < 24; i++) {
                str += "<option value=\"" + i + "\">" + i + "</option>";
            }
            return str;
        });

        //设置分钟的option
        $(".minute").html(function () {
            var str = "";
            for (var i = 0; i < 60; i += 5) {
                str += "<option value=\"" + i + "\">" + i + "</option>";
            }
            return str;
        });

        //Initialize Select2 Elements
        $(".select2").select2();

        var date_obj = new Date();
        var today = date_obj.toDateString();
        //Date picker
        $("#schedule_date").datepicker({
            language: "zh-CN",
            startDate: today,
            format: "yyyy-mm-dd",
            todayHighlight: true,
            todayBtn: "linked",
            autoclose: true
        }).datepicker("setDate", today);
        



        var $schedule_add_form = $("#schedule_add_form");
        $schedule_add_form.submit(function () {

            var $add_btn = $("#schedule_add_button");

            $.ajax({
                url: "schedule/insert",
                type: "POST",
                dataType: "json",
                data: $schedule_add_form.serialize(),
                beforeSend: function () {
                    $add_btn.button("loading");
                },
                complete: function () {
                    $add_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        window.location.href = "schedule/add";
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