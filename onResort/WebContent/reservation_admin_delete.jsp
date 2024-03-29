<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='onResort.service.ReservationService'%>
<%@ page import='onResort.service.ReservationServiceImpl'%>
<%@ page import='onResort.dto.*'%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import='java.util.TimeZone'%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	$(document).ready(function() {
		$('#header').load('header.html');
		$('#footer').load('footer.html');
	});
</script>
</head>
<body>
	<!-- Navigation -->
	<div id='header'></div>

	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<h1 class="mt-4 mb-3">
			예약하기 <small>삭제</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
			<li class="breadcrumb-item active">삭제</li>
		</ol>
		<!-- Item Row -->
		<div class="row">
			<div class='col-md-12 mb-4'>
				<%
					try {
						ReservationService resvService = new ReservationServiceImpl();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						sdf.setTimeZone(TimeZone.getTimeZone("UTC")); // KST -> UTC로 타임존 변경하기

						String resv_date_before = request.getParameter("resvDate_before");
						Date date2 = sdf.parse(resv_date_before);
						String room_before = request.getParameter("room_before");
						int ret = resvService.delete(date2, Integer.parseInt(room_before));
						if (ret == -1) {
				%>
				<div class='mb-4'>삭제 처리에 오류가 발생했습니다. 다시 시도해주세요.</div>
				<div class='mb-4'>
					<input type='button' class='btn btn-primary' value='뒤로가기'
						onclick="history.back(-1);">
				</div>
				<%
					} else {
				%>
				<div class='mb-4'>삭제가 완료되었습니다.</div>
				<div class='mb-4'>
					<input type='button' class='btn btn-primary' value='예약상황'
						onclick="location.href='reservation_admin_allview.jsp'">
				</div>
				<%
					}
					} catch (Exception e) {
						e.getStackTrace();
						System.out.println(e);
					}
				%>
			</div>
		</div>
	</div>
	<!-- /.container -->
	<!-- Footer -->
	<footer class="py-5 bg-dark" id='footer'>
		<!-- /.container -->
	</footer>
	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>