<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-home</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<!-- Favicons -->
	<link href="assets/img/favicon.png" rel="icon">
	<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Vendor CSS Files -->
	<link href="assets/vendor/aos/aos.css" rel="stylesheet">
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- =======================================================
	* Template Name: Day - v4.9.1
	* Template URL: https://bootstrapmade.com/day-multipurpose-html-template-for-free/
	* Author: BootstrapMade.com
	* License: https://bootstrapmade.com/license/
	======================================================== -->
	<style>
	a {
		text-decoration:none;
	}
	</style>
	
	<!-- ======= Top Bar ======= -->
	<section id="topbar" class="d-flex align-items-center">
		<div class="container d-flex justify-content-center justify-content-md-between">
			<div class="contact-info d-flex align-items-center">
				<i class="bi bi-envelope-fill"></i><a href="mailto:contact@example.com">oasis0530@naver.com</a>
				<i class="bi bi-phone-fill phone-icon"></i> +82 010 2973 0973
			</div>
			<div class="social-links d-none d-md-block">
				<%
					if(session.getAttribute("loginMember") == null){ // 로그인 되어있지 않을 때, LOG-IN 출력
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-warning">LOG-IN</a>
				<%
					} else { // 로그인 되어있는 경우, LOG-OUT 출력
						Member loginMember = (Member)session.getAttribute("loginMember");
				%>
						<%=loginMember.getMemberId()%>님
						<a href="<%=request.getContextPath()%>/logout.jsp" class="text-warning">LOG-OUT</a>
				<%
					}
				%>
				<a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
				<a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
				<a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
				<a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
			</div>
		</div>
	</section>
	
	<!-- ======= Header ======= -->
	<header id="header" class="d-flex align-items-center">
		<div class="container d-flex align-items-center justify-content-between">        
			<h1 class="logo"><a href="<%=request.getContextPath()%>/index.jsp">구디 가계부</a></h1>
			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      		<nav id="navbar" class="navbar">
				<ul>
					<li><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li><a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">내 가계부</a></li>
					<li><a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a></li>
					<li class="dropdown active"><a href=""><span class="text-primary">마이 페이지</span> <i class="bi bi-chevron-down"></i></a>
						<ul>
							<li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/updateMemberForm.jsp">내 정보수정</a></li>
							<li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a></li>
						</ul>
					</li>
					<%
						if(session.getAttribute("loginMember") != null){ // 로그인되어있는경우
							Member loginMember = (Member)session.getAttribute("loginMember");
							if(loginMember.getMemberLevel() == 1){ // 관리자로 로그인 시에만 출력
					%>
								<li class="dropdown"><a href="<%=request.getContextPath()%>/admin/adminMain.jsp"><span class="text-danger">관리자모드</span> <i class="bi bi-chevron-down"></i></a>
									<ul>
										<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice Management</a></li>
										<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">Category Management</a></li>
										<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">Member Management</a></li>
										<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Customer Service Management</a></li>
									</ul>
								</li>
					<%			
							}
						}
					%>
					<li><a class="nav-link scrollto" href="#contact">Contact</a></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav><!-- .navbar -->
		</div>
	</header><!-- End Header -->