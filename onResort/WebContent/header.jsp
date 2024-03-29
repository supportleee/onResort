<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a id='logo' class="navbar-brand" href="index.html">ON</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li id='first' class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownPortfolio" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 리조트소개 </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownPortfolio">
							<a id='main' class="dropdown-item" href="main.html">온리조트</a> <a
								id='about_firstClassRoom' class="dropdown-item"
								href="about_firstClassRoom.html">퍼스트클래스룸</a> <a
								id='about_businessRoom' class="dropdown-item"
								href="about_businessRoom.html">비즈니스룸</a> <a
								id='about_economyRoom' class="dropdown-item"
								href="about_economyRoom.html">이코노미룸</a>
						</div></li>
					<li id='second' class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownPortfolio" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">찾아오기</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownPortfolio">
							<a id='access' class="dropdown-item" href="access_map.html">찾아오는길</a>
							<a id='access_with_public' class="dropdown-item"
								href="access_publicTransport.html">대중교통이용</a> <a
								id='access_with_private' class="dropdown-item"
								href="access_privateCar.html">자가용이용</a>
						</div></li>
					<li id='third' class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownPortfolio" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 주변여행지 </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownPortfolio">
							<a id='mountain' class="dropdown-item" href="spot_mountain.html">높아산</a>
							<a id='beach' class="dropdown-item" href="spot_beach.html">온해수욕장</a>
							<a id='hotspring' class="dropdown-item"
								href="spot_hotSpring.html">따끈온천</a>
						</div></li>
					<li id='fourth' class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							예약하기 </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownBlog">
							<a id='reservation_view' class="dropdown-item"
								href="reservation_view.jsp">예약상황</a> <a id='reservation_reserve'
								class="dropdown-item" href="reservation_reserve.jsp">예약하기</a> <a
								id='admin_allview' class="dropdown-item"
								href="reservation_admin_allview.jsp">관리자페이지</a>
							<%
								// 세션 체크해서 있으면 관리자 로그아웃 메뉴 보이기
								String loginOK = null;

								loginOK = (String) session.getAttribute("login_ok");
								if (loginOK != null && loginOK.equals("yes")) {
							%>
							<a id='admin_logout' class="dropdown-item"
								href="admin_logout.jsp">관리자로그아웃</a>
							<%
								}
							%>

						</div></li>
					<li id='fifth' class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							펜션소식 </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownBlog">
							<a id='notice' class="dropdown-item" href="board_notice_list.jsp">펜션소식</a>
							<a id='review' class="dropdown-item" href="board_review_list.jsp">이용후기</a>
						</div></li>
				</ul>
			</div>
		</div>
	</nav>
</body>
</html>