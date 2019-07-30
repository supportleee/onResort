<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="onResort.service.Review_boardService"%>
<%@ page import="onResort.service.Review_boardServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<%@ page import="java.util.List"%>
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
			펜션소식 <small>이용후기</small>
		</h1>

		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">메인</a></li>
			<li class="breadcrumb-item active">이용후기</li>
		</ol>
		<div class='row'>
			<div class='col-md-12'>
				<%
					String key = request.getParameter("key");
					Review_boardService reviewService = new Review_boardServiceImpl();
					reviewService.updateViewcnt(Integer.parseInt(key));
					Review_boardDto reviewdto = reviewService.selectOne(Integer.parseInt(key));
				%>
				<form method='post' enctype='multipart/form-data'>
					<table class='table'>
						<tr>
							<td>번호</td>
							<td class='two'><input type='text' name='key' id='key'
								style='border: 0' value='<%=reviewdto.getId()%>' readonly></td>
						</tr>
						<tr>
							<td>제목</td>
							<td class='two'><%=reviewdto.getTitle()%></td>
						</tr>
						<tr>
							<td>일자</td>
							<td class='two'><%=reviewdto.getDayOfRegister()%></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td class='two'><%=reviewdto.getViewcnt()%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td class='two'><%=reviewdto.getContent()%></td>
						</tr>
						<tr>
							<td>파일</td>
							<td class='two'>
								<%
									if (reviewdto.getImgname() != null) {
								%> <a href="upload/<%=reviewdto.getImgname()%>" download><%=reviewdto.getOrgimgname()%></a>
								<%
									} else {
								%> 파일 없음 <%
									}
								%>
							</td>
						</tr>
						<tr>
							<td class='two' colspan='2' id='button' style='text-align: right'><input
								type='button' class='btn btn-outline-primary' value='목록'
								onclick="location.href='board_review_list.jsp'"> <input
								class='btn btn-outline-primary' type='submit' value='수정'
								formaction='board_review_update.jsp'> <input
								class='btn btn-outline-primary' type='button' value='삭제'
								onclick="location.href='board_review_delete.jsp?key=<%=reviewdto.getId()%>'">
								<input class='btn btn-outline-primary' type='submit' value='답글' formaction='board_review_reinsert.jsp'>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer class="py-5 bg-dark" id='footer'>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>