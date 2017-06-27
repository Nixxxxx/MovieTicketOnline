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
<section class="content-header background: #d2d6de;">
  <ol class="breadcrumb">
    <li><a href="order/info"><i class="fa fa-dashboard"></i> 首页</a></li>
    <li>时段管理</li>
    <li class="active">时段列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">时段列表</h3>

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
              <th>影院</th>
              <th>电影</th>
              <th>开始时间</th>
              <th>座位数</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${scheduleList!=null }" >
            <c:forEach var="schedule" items="${scheduleList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="schedule_cinema">${schedule.cinema.name }</td>
              <td class="schedule_movie">${schedule.movie.name }</td>
              <td class="schedule_startTime"><fmt:formatDate value="${schedule.startTime}" pattern="yyyy-MM-dd|HH:mm"/></td>
              <td class="schedule_seat">${schedule.seat }</td>
              <td>
                <a data-id="${schedule.scheduleId }" class="update" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#schedule_update_modal" data-backdrop="static">
                  <i class="fa fa-edit"></i>编辑</a>
                <a data-id="${schedule.scheduleId }" class="del" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 删除</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${scheduleList==null }" >
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
<div class="modal fade" id="schedule_update_modal" tabindex="-1" role="dialog" aria-labelledby="schedule_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="schedule_update_label">编辑场次</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="schedule_update_form">
          <div class="box-body">
            <input type="hidden" id="schedule_id" name="scheduleId">
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
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="schedule_update_button" data-loading-text="更新中...">更新</button>
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
                var scheduleId = $(this).data("id");
                $.ajax({
                    url: "schedule/del",
                    type: "POST",
                    data: {scheduleId: scheduleId},
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
                        if (data.success) {
                            window.location.href="schedule/list";
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
        	
        	//设置小时的option
            $("#schedule_hour").html(function () {
                var str = "";
                for (var i = 0; i < 24; i++) {
                    str += "<option value=\"" + i + "\">" + i + "</option>";
                }
                return str;
            });

            //设置分钟的option
            $("#schedule_minute").html(function () {
                var str = "";
                for (var i = 0; i < 60; i += 5) {
                    str += "<option value=\"" + i + "\">" + i + "</option>";
                }
                return str;
            });

            
            $("#schedule_id").val($(this).data("id"));

            //解析时间范围
            var schedule_startTime = $(this).parent().prevAll(".schedule_startTime").text();
            var schedule_arr = schedule_startTime.split("|");
            //去除 如01前边的0
            var hour = ~~schedule_arr[1].split(":")[0];//~是按位取反运算，~~是取反两次 经过位运算的会自动变成整数 同parseInt()
            var minute = ~~schedule_arr[1].split(":")[1];
            
            $("#schedule_hour").val(hour);
            $("#schedule_minute").val(minute);
            $("#schedule_seat").val($(this).parent().prevAll(".schedule_seat").text());

            var todaya = schedule_arr[0].split("-");
            var today = (new Date(parseInt(todaya[0]),parseInt(todaya[1])-1,parseInt(todaya[2]))).toDateString();

            //Date picker
            $("#schedule_date").datepicker({
                language: "zh-CN",
                startDate: today,
                format: "yyyy-mm-dd",
                todayHighlight: true,
                todayBtn: "linked",
                autoclose: true
            }).datepicker("setDate", new Date().toDateString());

            

	        //更新
        var $schedule_update_form = $("#schedule_update_form");
        $schedule_update_form.submit(function () {

            var $update_btn = $("#schedule_update_button");

            $.ajax({
                url: "schedule/update",
                type: "POST",
                dataType: "json",
                data: $schedule_update_form.serialize(),
                beforeSend: function () {
                    $update_btn.button("loading");
                },
                complete: function () {
                    $update_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
						window.location.href="schedule/list";
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
      });
   })
</script>
</body>
</html>