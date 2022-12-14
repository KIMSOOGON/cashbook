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
		<div class="container pt-5 col-lg-6 text-center bg-light">
			<h1 class="text-secondary">회원가입 <img src="<%=request.getContextPath()%>/assets/img/signin.png" style="width:60px"></h1>
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" id="signinForm" method="post" role="form" class="php-email-form">
			  	<div class="box row">
				    <div class="box col text-center">
						<div class="form-group mt-3">
				        	<input type="text" name="memberId" style="width:400px" class="form-control" id="memberId" placeholder="Your Id" required>
				      	</div>
				      	<div class="form-group mt-3 mt-md-4">
							<input type="password" class="form-control" style="width:400px" name="memberPw" id="memberPw" placeholder="Your Password" required>
				      	</div>
				      	<div class="form-group mt-3 mt-md-4">
							<input type="text" class="form-control" style="width:400px" name="memberName" id="memberName" placeholder="Your Name" required>
				      	</div>
				    </div>
				    <div class="box col pt-2 pb-2 mt-2 mb-2" style="background-color:rgb(232,218,179)">
				    	<p class="box">
				    		구디가계부 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다.
				    		개인정보 수집 및 이용, 위치기반서비스 이용약관, 프로모션 정보수신에
				    		모두 동의하십니까?
				    	</p>
				    	<hr>
				    	<div class="form-check">
				    		<label class="form-check-label" for="ck">동의합니다</label>
					    	<input type="checkbox" class="ck" name="ck">
				    	</div>
				    </div>
			    </div>
				<div class="text-center mt-5"><button type="button" id="signinBtn" class="btn btn-outline-danger">회원가입</button></div>
			</form>
		</div>
	</section>

	<script>
	let signinBtn = document.querySelector('#signinBtn');
	signinBtn.addEventListener('click', function(){
		// 디버깅
		console.log('signinBtn clik!');
		
		// ID 폼 유효성 검사
		let memberId = document.querySelector('#memberId');
		if(memberId.value == ''){
			alert('아이디를 입력하세요');
			memberId.focus();
			return;
		}
		
		// PW 폼 유효성 검사
		let memberPw = document.querySelector('#memberPw');
		if(memberPw.value == ''){
			alert('패스워드를 입력하세요');
			memberPw.focus();
			return;
		}
		
		// NAME 폼 유효성 검사
		let memberName = document.querySelector('#memberName');
		if(memberName.value == ''){
			alert('이름을 입력하세요');
			memberName.focus();
			return;
		}
		
		// 동의 checkbox 유효성검사
		let ck = document.querySelectorAll('.ck:checked');
		console.log(ck.length);
		if(ck.length != 1){
			console.log(document.querySelectorAll('.ck.checked').length);
			alert('약관에 동의하세요');
			ck.focus();
			return;
		}
		
		let signinForm = document.querySelector('#signinForm');
		signinForm.submit();
	});
	
	<%
		if(request.getParameter("idMsg") != null){
	%>
			alert('중복된 아이디입니다.');
	<%
		}
	%>
	</script>
</body>
</html>