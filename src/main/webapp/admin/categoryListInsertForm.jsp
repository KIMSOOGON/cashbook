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
			<form action="<%=request.getContextPath()%>/admin/categoryListInsertAction.jsp" method="post" role="form" class="php-email-form" id="categoryForm">
				<div>
					<div class="form-group mt-3 row">
						<div class="col">categoryKind</div>
						<div class="col">
							<input type="radio" name="categoryKind" value="수입" class="categoryKind">수입
							<input type="radio" name="categoryKind" value="지출" class="categoryKind">지출
						</div>
					</div>
					<div class="form-group mt-3 row">
						<div class="col">categoryName</div>
						<div class="col">
							<input type="text" name="categoryName" id="categoryName">
						</div>
					</div>
				</div>
				<div class="text-center mt-5"><button type="button" id="categoryBtn">ADD</button></div>
			</form>
		</div>
	</section>
	
	<!-- js로 유효성검사 -->
	<script>
	let categoryBtn = document.querySelector('#categoryBtn');
	categoryBtn.addEventListener('click', function(){
		// 디버깅
		console.log('categoryBtn clik!');
		
		// 카테고리종류 라디오 유효성검사
		let categoryKind = document.querySelectorAll('.categoryKind:checked'); // querySelectorAll의 반환타입은 배열(태그의 배열)
		console.log(categoryKind.length); // 1
		if(categoryKind.length != 1) {
			alert('수입/지출을 선택하세요');
			categoryKind.focus();
			return;
		}
 
		// 카테고리내용 유효성 검사
		let categoryName = document.querySelector('#categoryName');
		if(categoryName.value == ''){
			alert('카테고리 내용을 입력하세요');
			categoryName.focus();
			return;
		}
		
		let categoryForm = document.querySelector('#categoryForm');
		categoryForm.submit();
	})
	</script>
</body>
</html>