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
  <title>无线巡更管理中心</title>
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
    <li>地点管理</li>
    <li class="active">地点列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">地点列表</h3>

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
              <th>用户</th>
              <th>场次</th>
              <th>数量</th>
              <th>地址</th>
              <th>手机</th>
              <th>状态</th>
              <th>备注</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${orderList != null }" >
            <c:forEach var="order" items="${orderList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="order_user">
	              <input class="user_userName" type="hidden" value="${order.user.userName }">
	              <input class="user_email" type="hidden" value="${order.user.email }">
	              <input class="user_mobile" type="hidden" value="${order.user.mobile }">
	              <a class="user" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#user_modal" data-backdrop="static">
	                  <i class="fa fa-edit"></i>查看用户</a></td>
              <td class="order_schedule">
	              <input class="cinemaName" type="hidden" value="${order.schedule.cinema.name }">
	              <input class="movieName" type="hidden" value="${order.schedule.movie.name }">
	              <input class="startTime" type="hidden" value="${order.schedule.startTime }">
	              <input class="seat" type="hidden" value="${order.schedule.seat }">
	              <input class="reservation" type="hidden" value="${order.schedule.reservation }">
	              <a class="schedule" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#schedule_modal" data-backdrop="static">
	                  <i class="fa fa-edit"></i>查看场次</a></td>
              <td class="order_amount">${order.amount }</td>
              <td class="order_address">${order.address }</td>
              <td class="order_mobile">${order.mobile }</td>
              <td class="order_status">
              	<c:if test="${order.status == 0}" >
              		<span class="text-yellow">已取消</span>
              	</c:if>
              	<c:if test="${order.status == 1}" >
              		<span class="text-green">待处理</span>
              	</c:if>
              	<c:if test="${order.status == 2}" >
              		<span class="text-bule">已确认</span>
              	</c:if>
              	<c:if test="${order.status == 3}" >
              		<span class="text-light-blue">已完成</span>
              	</c:if>
	          </td>
              <td class="order_extra">${order.extra }</td>
              <td>
                <a data-id="${order.orderId }" class="" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 确认订单</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${orderList == null }" >
            	<tr><td colspan="9">无记录！</td></tr>
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
<div class="modal fade" id="user_modal" tabindex="-1" role="dialog" aria-labelledby="schedule_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="schedule_update_label">用户信息</h3>
        </div>
        <!-- /.box-header -->
          <div class="box-body">
            <div class="form-group">
              <label for="user_userName" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="user_userName" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="user_email" class="col-sm-2 control-label">email</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="user_email" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="user_mobile" class="col-sm-2 control-label">mobile</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="user_mobile" readonly>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          </div>
          <!-- /.box-footer -->
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="schedule_modal" tabindex="-1" role="dialog" aria-labelledby="schedule_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="schedule_update_label">场次信息</h3>
        </div>
        <!-- /.box-header -->
          <div class="box-body">
            <div class="form-group">
              <label for="cinemaName" class="col-sm-2 control-label">影院名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="cinemaName" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="movieName" class="col-sm-2 control-label">电影名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="movieName" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="startTime" class="col-sm-2 control-label">开始时间</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="startTime" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="seat" class="col-sm-2 control-label">座位数</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="seat" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="reservation" class="col-sm-2 control-label">预定数</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="reservation" readonly>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          </div>
          <!-- /.box-footer -->
      </div>
      <!-- /.box -->
    </div>
  </div>
</div>

<script>
    $(function(){
    	$(".user").click(function () {
            $("#user_userName").val($(this).prevAll(".user_userName").val());
            $("#user_email").val($(this).prevAll(".user_email").val());
            $("#user_mobile").val($(this).prevAll(".user_mobile").val());
        });
    	
    	$(".schedule").click(function () {
            $("#cinemaName").val($(this).prevAll(".cinemaName").val());
            $("#movieName").val($(this).prevAll(".movieName").val());
            $("#startTime").val($(this).prevAll(".startTime").val());
            $("#seat").val($(this).prevAll(".seat").val());
            $("#reservation").val($(this).prevAll(".reservation").val());
        });

    })
</script>
</body>
</html>