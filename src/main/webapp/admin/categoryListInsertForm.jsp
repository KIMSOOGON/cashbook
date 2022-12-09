<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-CategoryList-insert</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
</head>
<body id="winter">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- categoryList Insert -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>ADD Category</span>
				<h1>ADD Category</h1>
				<p>카테고리 추가</p>
			</div>
		</div>
	</section>
	
	<!-- category 입력 폼 -->
	<section id="contact" class="contact py-1" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container pt-5 col-lg-6 text-center bg-light">
			<form action="<%=request.getContextPath()%>/admin/categoryListInsertAction.jsp" method="post" role="form" class="php-email-form">
				<div>
					<div class="form-group mt-3 row">
						<div class="col">categoryKind</div>
						<div class="col">
							<input type="radio" name="categoryKind" value="수입">수입
							<input type="radio" name="categoryKind" value="지출">지출
						</div>
					</div>
					<div class="form-group mt-3 row">
						<div class="col">categoryName</div>
						<div class="col">
							<input type="text" name="categoryName">
							<%	// 공백 입력 시, 문장 출력 "카테고리 이름을 입력하세요"
								String msg = request.getParameter("msg");
								if(msg!=null){
							%>		
									<%=msg%>	
							<%		
								}
							%>
						</div>
					</div>
				</div>
				<div class="text-center mt-5"><button type="submit">ADD</button></div>
			</form>
		</div>
	</section>
</body>
</html>