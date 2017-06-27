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
    <li>电影管理</li>
    <li class="active">电影列表</li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row">
    <div class="col-xs-12">
      <div class="box">
        <div class="box-header">
          <h3 class="box-title">电影列表</h3>

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
              <th>电影编号</th>
              <th>电影名称</th>
              <th>时长/min</th>
              <th>状态</th>
              <th>简介</th>
              <th>操作</th>
            </tr>
            </thead>
            <c:if test="${movieList != null }" >
            <c:forEach var="movie" items="${movieList }" varStatus="status">
            <tr>
              <td>${status.index+1 }</td>
              <td class="movie_number">${movie.number }</td>
              <td class="movie_name">${movie.name }</td>
              <td class="movie_time">${movie.time }</td>
              <td class="movie_status">
                <input type="hidden" value="${movie.status }">
              	<c:if test="${movie.status == 0}" >
              		<span class="text-light-blue">未上映</span>
              	</c:if>
              	<c:if test="${movie.status == 1}" >
              		<span class="text-green">正在上映</span>
              	</c:if>
              	<c:if test="${movie.status == 2}" >
              		<span class="text-yellow">已下线</span>
              	</c:if>
              </td>
              <td class="movie_introduce">${movie.introduce }</td>
              <td>
                <a data-id="${movie.movieId }" class="update" href="javascript:void(0)" data-toggle="modal" data-remote="false" data-target="#movie_update_modal" data-backdrop="static">
                  <i class="fa fa-edit"></i>编辑</a> |
                <a data-id="${movie.movieId }" class="del" href="javascript:void(0)">
                  <i class="fa fa-trash"></i> 删除</a>
              </td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${movieList == null }" >
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
<div class="modal fade" id="movie_update_modal" tabindex="-1" role="dialog" aria-labelledby="movie_update_label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- Horizontal Form -->
      <div class="box box-info">
        <div class="box-header with-border">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
          <h3 class="box-title" id="movie_update_label">编辑地点</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form class="form-horizontal" method="post" id="movie_update_form">
          <div class="box-body">
            <input type="hidden" id="movie_id" name="movieId">
            <div class="form-group">
              <label for="movie_number" class="col-sm-2 control-label">编号</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="movie_number" name="number" placeholder="请输入电影编号" required>
              </div>
            </div>
            <div class="form-group">
              <label for="movie_name" class="col-sm-2 control-label">电影名</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="movie_name" name="name" maxlength="10" placeholder="请输入电影名" required>
              </div>
            </div>
            <div class="form-group">
              <label for="movie_time" class="col-sm-2 control-label">时长/min</label>
              <div class="col-sm-4">
                <input type="text" class="form-control" id="movie_time" name="time" maxlength="4" placeholder="请输入时长" required>
              </div>
              <label for="movie_status" class="col-sm-2 control-label">状态</label>
              <div class="col-sm-4">
                <select id="movie_status" name="status" >
                  <option value="0">未上映</option>
                  <option value="1">正在上映</option>
                  <option value="2">已下线</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="movie_introduce" class="col-sm-2 control-label">简介</label>
              <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="movie_introduce" name="introduce" placeholder="请输入备注，100字以内"></textarea>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="submit" class="btn btn-info pull-right" id="movie_update_button" data-loading-text="更新中...">更新</button>
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
                var movieId = $(this).data("id");
                $.ajax({
                    url: "movie/del",
                    type: "POST",
                    data: {movieId: movieId},
                    dataType: "json",
                    success: function (data) {
                        alert(data.msg);
						if (data.success) {
                            //菜单栏当前选中
                            window.location.href="movie/list";
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
            $("#movie_id").val($(this).data("id"));
            $("#movie_number").val($(this).parent().prevAll(".movie_number").text());
            $("#movie_name").val($(this).parent().prevAll(".movie_name").text());
            $("#movie_time").val($(this).parent().prevAll(".movie_time").text());
            $("#movie_status").val($(this).parent().prevAll(".movie_status").children("input").val());
            $("#movie_introduce").val($(this).parent().prevAll(".movie_introduce").text());
        });

        //更新
        var $movie_update_form = $("#movie_update_form");
        $movie_update_form.submit(function () {

            var $update_btn = $("#movie_update_button");

            $.ajax({
                url: "movie/update",
                type: "POST",
                dataType: "json",
                data: $movie_update_form.serialize(),
                beforeSend: function () {
                    $update_btn.button("loading");
                },
                complete: function () {
                    $update_btn.button("reset");
                },
                success: function (data) {
                    alert(data.msg);
                    if (data.success) {
                        window.location.href="movie/list";
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