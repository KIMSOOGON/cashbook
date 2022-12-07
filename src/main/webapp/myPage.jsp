<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// 1 Controller
	
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-MyPage</title>

	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body id="ice">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="inc/myMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpList Insert -->
	<section id="pricing" class="pricing">
		<div class="container">
			<div class="section-title">
				<span>My Page</span>
				<h1>My Page</h1>
				<p><%=memberId%>님의 정보</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center w-75">
		<div class="box text-center bg-light shadow row">
			<div class="col-6 p-2">이름</div>
			<div class="col-6 p-2"><%=loginMember.getMemberName()%></div>
			<div class="col-6 p-2">권한</div>
			<div class="col-6 p-2">
				<%
					if(loginMember.getMemberLevel() < 1){ // 일반회원
				%>
						일반회원
				<%
					} else {
				%>		
						관리자	
				<%		
					}
				%>
			</div>
			<div class="col-6 p-2">가입날짜</div>
			<div class="col-6 p-2">
				<%=loginMember.getCreatedate()%>
			</div>
		</div>
	</div>
	
	
	<!-- Vendor JS Files -->
	<script src="<%=request.getContextPath()%>/assets/vendor/aos/aos.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/php-email-form/validate.js"></script>
	
	<!-- Template Main JS File -->
	<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
</body>
</html>