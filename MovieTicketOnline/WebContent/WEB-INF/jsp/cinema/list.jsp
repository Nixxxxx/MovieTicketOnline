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
    <li>影院管理</li>
    <li class="active">影院列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">影院列表</h3>

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
              <th>影院编号</th>
              <th>影院名</th>
              <th>地址</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${cinemaList != null }" >
            <c:forEach var="cinema" items="${cinemaList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="cinema_number">${cinema.number }</td>
              <td class="cinema_name">${cinema.name }</td>
              <td class="cinema_address">${cinema.address }</td>
              <td>
                <a data-id="${cinema.cinemaId }" class="update" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#cinema_update_modal" data-backdrop="static">
                  <i class="fa fa-edit"></i>编辑</a> |
                <a data-id="${cinema.cinemaId }" class="del" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 删除</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${cinemaList == null }" >
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
<div class="modal fade" id="cinema_update_modal" tabindex="-1" role="dialog" aria-labelledby="cinema_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="cinema_update_label">编辑地点</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="cinema_update_form">
          <div class="box-body">
            <input type="hidden" id="cinema_id" name="cinemaId">
            <div class="form-group">
              <label for="cinema_number" class="col-sm-2 control-label">影院编号</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="cinema_number" name="number" placeholder="请输入影院编号" required>
              </div>
            </div>
            <div class="form-group">
              <label for="cinema_name" class="col-sm-2 control-label">影院名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="cinema_name" name="name" maxlength="20" placeholder="请输入影院名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="cinema_address" class="col-sm-2 control-label">地址</label>
              <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="cinema_address" name="address" maxlength="100" placeholder="请输入地址，100字以内" required></textarea>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="cinema_update_button" data-loading-text="更新中...">更新</button>
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
                var cinemaId = $(this).data("id");
                $.ajax({
                    url: "cinema/del",
                    type: "POST",
                    data: {cinemaId: cinemaId},
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
                        if (data.success) {
                            //菜单栏当前选中
                            window.location.href="cinema/list";
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
            $("#cinema_id").val($(this).data("id"));
            $("#cinema_number").val($(this).parent().prevAll(".cinema_number").text());
            $("#cinema_name").val($(this).parent().prevAll(".cinema_name").text());
            $("#cinema_address").val($(this).parent().prevAll(".cinema_address").text());
        });

        //更新
        var $cinema_update_form = $("#cinema_update_form");
        $cinema_update_form.submit(function () {

            var $update_btn = $("#cinema_update_button");

            $.ajax({
                url: "cinema/update",
                type: "POST",
                dataType: "json",
                data: $cinema_update_form.serialize(),
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
                        window.location.href="cinema/list";
                        $now_selected = $("ul.treeview-menu>li.active>a");
                        $now_selected.trigger("click");
                        $("#cinema_update_modal").modal("hide");
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