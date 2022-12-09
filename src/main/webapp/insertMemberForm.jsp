<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertMemberForm</title>
	
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
	
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">

</head>
<body id="lf">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	
	<!-- 로그인 폼 -->
	<section id="contact" class="contact" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
	<div class="container pt-5 col-lg-6 text-center">
	<h1 class="text-secondary">회원가입</h1>
	  <form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" role="form" class="php-email-form">
	    <div>
	      <div class="form-group mt-3">
	        <input type="text" name="memberId" class="form-control" id="memberId" placeholder="Your Id" required>
	      </div>
	      <div class="form-group mt-3 mt-md-4">
	        <input type="password" class="form-control" name="memberPw" id="memberPw" placeholder="Your Password" required>
	      </div>
	      <div class="form-group mt-3 mt-md-4">
	        <input type="text" class="form-control" name="memberName" id="memberName" placeholder="Your Name" required>
	      </div>
	    </div>
	    <div class="text-center mt-5"><button type="submit">회원가입</button></div>
	  </form>
	</div>
	</section>
	<div>
		<%
			String msg = request.getParameter("msg");
			if(msg!=null){
		%>
				<%=msg%>
		<%
			}
		%>
	</div>
	<div>
		<%
			String idMsg = request.getParameter("idMsg");
			if(idMsg!=null){
		%>
				<%=idMsg%>
		<%
			}
		%>
	</div>
</body>
</html>