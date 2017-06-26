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



<!-- Ionicons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="/MovieTicketOnline/static/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="/MovieTicketOnline/static/dist/css/skins/skin-blue.min.css">
<style>
body, button, input, select, textarea, h1, h2, h3, h4, h5, h6 {
	font-family: Microsoft YaHei, "宋体", Tahoma, Helvetica, Arial,
		"\5b8b\4f53", sans-serif;
}

.content-header>.breadcrumb {
	position: relative;
	margin-top: 5px;
	top: 0;
	right: 0;
	float: none;
	background: #d2d6de;
	padding-left: 10px;
}

.content-header>.breadcrumb li:before {
	color: #97a0b3;
}
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<header class="main-header"> 
		<!-- Header Navbar --> <!-- Logo -->
		<a href="./" class="logo"> 
		<!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini"><b>贩</b></span> 
			<!-- logo for regular state and mobile devices -->
			<span class="logo-lg"><b>电票贩</b></span>
		</a> 
		<nav class="navbar navbar-static-top" role="navigation"> 
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="/MovieTicketOnline/static/dist/img/favicon.png"
						class="user-image" alt="User Image"> <!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs">${user.userName }</span>
				</a>
					<ul class="dropdown-menu">
						<!-- The user image in the menu -->
						<li class="user-header"><img
							src="http://localhost:8080/MovieTicketOnline/index.jsp"
							class="img-circle" alt="User Image"> ${user.userName }</li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<a href="#" class="btn btn-default btn-flat">修改信息</a>
							</div>
							<div class="pull-right">
								<a href="user/signOut" class="btn btn-default btn-flat">退出</a>
							</div>
						</li>
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i></a></li>
			</ul>
		</div>
		</nav> 
		
		</header>

<!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        <li class="treeview">
          <a href="#"> <i class="fa fa-dashboard"></i> <span>总览</span> <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
          </span> </a>
          <ul class="treeview-menu">
            <li><a href="order/info" target="container"><i class="fa fa-circle-o"></i> 系统总览 </a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"> <i class="fa fa-edit"></i> <span>订单管理</span> <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
          </span> </a>
          <ul class="treeview-menu">
            <li><a href="order/list" target="container"><i class="fa fa-circle-o"></i> 订单处理 </a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"> <i class="fa fa-mobile"></i> <span>电影管理</span> <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span> </a>
            <ul class="treeview-menu">
              <c:forEach var="movie" items="${movieList }" varStatus="status">
                <li><a href="movie/add" target="container">${status.index+1 }.<i class="fa fa-circle-o"></i> ${movie.name } </a></li>
              </c:forEach>
            </ul>
        </li>
        <li class="header">THEMES</li>
        <li><a href="javascript:void(0)" data-skin="skin-blue"><i class="fa fa-circle-o text-aqua"></i> <span>Blue</span></a></li>
        <li><a href="javascript:void(0)" data-skin="skin-green"><i class="fa fa-circle-o text-green"></i> <span>Green</span></a></li>
        <!--<li><a href="javascript:void(0)" data-skin="skin-purple"><i class="fa fa-circle-o text-purple"></i> <span>Purple</span></a></li>-->
        <li><a href="javascript:void(0)" data-skin="skin-red"><i class="fa fa-circle-o text-red"></i> <span>Red</span></a></li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>




		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
				<li class="active">Here</li>
			</ol>
			</section>

			<!-- Main content -->
			<section class="content">

			<div class="col-md-6">
				<!-- PRODUCT LIST -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">电影</h3>

						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"
								data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
						</div>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<ul class="products-list product-list-in-box">
								<li class="item">
									<div class="product-img">
										<img src="dist/img/default-50x50.gif" alt="Product Image">
									</div>
									<div class="product-info">
										<a href="javascript:void(0)" class="product-title">
											<span class="label label-warning pull-right"></span>
										</a> <span class="product-description"> </span>
									</div>
								</li>
						</ul>
					</div>
					<!-- /.box-body -->
				</div>
			</div>
			<div class="col-md-6">
				<!-- PRODUCT LIST -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">影院</h3>

						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"
								data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
						</div>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<ul class="products-list product-list-in-box">
							<li class="item">
								<div class="product-img">
									<img src="dist/img/default-50x50.gif" alt="Product Image">
								</div>
								<div class="product-info">
									<a href="javascript:void(0)" class="product-title">Samsung
										TV <span class="label label-warning pull-right">$1800</span>
									</a> <span class="product-description"> Samsung 32" 1080p
										60Hz LED Smart HDTV. </span>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<footer class="main-footer"> <!-- To the right -->
		<div class="pull-right hidden-xs">Anything you want</div>
		<!-- Default to the left --> <strong>Copyright &copy; 2017 <a
			href="#">Company</a>.
		</strong> All rights reserved. </footer>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark"> <!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li class="active"><a href="#control-sidebar-home-tab"
				data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
					class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<!-- Home tab content -->
			<div class="tab-pane active" id="control-sidebar-home-tab">
				<h3 class="control-sidebar-heading">订单</h3>
				<ul class="control-sidebar-menu">
					<li><a href="javascript:;"> <i
							class="menu-icon fa fa-birthday-cake bg-red"></i>

							<div class="menu-info">
								<h4 class="control-sidebar-subheading">${cinemaName }</h4>

								<p>Will be 23 on April 24th</p>
							</div>
					</a></li>
				</ul>
				<!-- /.control-sidebar-menu -->

			</div>
			<!-- /.tab-pane -->
			<!-- Stats tab content -->
			<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
				Content</div>
			<!-- /.tab-pane -->
			<!-- Settings tab content -->
			<div class="tab-pane" id="control-sidebar-settings-tab">
				<form method="post">
					<h3 class="control-sidebar-heading">General Settings</h3>

					<div class="form-group">
						<label class="control-sidebar-subheading"> Report panel
							usage <input type="checkbox" class="pull-right" checked>
						</label>

						<p>Some information about this general settings option</p>
					</div>
					<!-- /.form-group -->
				</form>
			</div>
			<!-- /.tab-pane -->
		</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- jQuery 3.1.1 -->
	<script
		src="/MovieTicketOnline/static/plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/MovieTicketOnline/static/bootstrap/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="/MovieTicketOnline/static/dist/js/app.min.js"></script>

</body>
</html>
