<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.entity.User"%>
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
    <li>场次查看</li>
    <li class="active">场次列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">场次列表</h3>

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
              <th>预订数</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${scheduleList != null }" >
            <c:forEach var="schedule" items="${scheduleList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="schedule_cinema">${schedule.cinema.name }</td>
              <td class="schedule_movie">${schedule.movie.name }</td>
              <td class="schedule_startTime"><fmt:formatDate value="${schedule.startTime}" pattern="yyyy-MM-dd|HH:mm"/></td>
              <td class="schedule_seat">${schedule.seat }</td>
              <td class="schedule_reservation">${schedule.reservation }</td>
              <td>
              <%if(session.getAttribute("user") != null){ %>
                <a data-id="${schedule.scheduleId }" class="buy" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#order_modal" data-backdrop="static">
                  <i class="fa fa-trash"></i> 加入购物车</a>
              </td>
              <%} %>
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
<div class="modal fade" id="order_modal" tabindex="-1" role="dialog" aria-labelledby="schedule_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="schedule_update_label">订单信息</h3>
        </div>
        <!-- /.box-header -->
         <form class="form-horizontal" method="post" id="order_form">
          <div class="box-body">
            <input type="hidden" id="order_seat" >
            <input type="hidden" id="order_reservation">
            <input type="hidden" id="order_scheduleId" name="scheduleId">
            <input type="hidden" name="userId" value="${user.userId }">
            <div class="form-group">
              <label for="order_amount" class="col-sm-2 control-label">数量</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="order_amount" name="amount" maxlength="3" required>
              </div>
            </div>
            <div class="form-group">
              <label for="order_email" class="col-sm-2 control-label">地址</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="order_adress" name="address" maxlength="40" required>
              </div>
            </div>
            <div class="form-group">
              <label for="order_mobile" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
                <input type="text" class="form-control pull-right" id="order_mobile" name="mobile" maxlength="20" required>
              </div>
            </div>
          </div>
            <div class="form-group">
              <label for="movie_introduce" class="col-sm-2 control-label">备注</label>
              <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="order_extra" name="extra" maxlength="100" required></textarea>
              </div>
            </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="order_btn" data-loading-text="更新中...">更新</button>
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
        $(".buy").click(function () {
            $("#order_scheduleId").val($(this).data("id"));
            $("#order_seat").val($(this).parent().prevAll(".schedule_seat").text());
            $("#order_reservation").val($(this).parent().prevAll(".schedule_reservation").text());
      })
      
      var $order_form = $("#order_form");
        $order_form.submit(function () {
        	var amount = $("#order_amount").val();
        	var pattern = /^[0-9]{1,3}$/;
        	if(!pattern.test(amount)){
        		alert("输入不合法");
        		return false;
        	}
        	if(amount*1+$("#order_reservation").val()*1>$("#order_seat").val()*1){
        		alert("没票了");
        		return false;
        	}
        	
        	$order_btn = $("#order_btn");
            $.ajax({
                url: "order/insert",
                type: "POST",
                data: $("#order_form").serialize(),
                dataType: "json",
                beforeSend: function () {
                    $order_btn.button("loading");
                },
                complete: function () {
                    $order_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        window.location.href="user/scheduleList";
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (textStatus === "timeout") {
                        alert("超时！");
                    } else {
                        alert("失败！");
                    }
                }
            });
            return false;
    });
   })
</script>
</body>
</html>