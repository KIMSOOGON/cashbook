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
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
</head>
<body id="ice">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="inc/myMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpList Insert -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>Edit My Info</span>
				<h1>Edit My Info</h1>
				<p class="text-light">내 정보 수정 (이름 및 비밀번호)</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center bg-light w-75" data-aos="zoom-out" data-aos-delay="600" data-aos-duration="1000">
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post" id="updateMemberForm">
			<table class="table table-hover">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="memberPw" name="memberPw"></td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td><input type="password" id="newMemberPw" name="newMemberPw"></td>
				</tr>
				<tr>
					<th>새 비밀번호 확인</th>
					<td><input type="password" id="newMemberPwCheck" name="newMemberPwCheck"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" id="memberName" name="memberName" value="<%=loginMember.getMemberName()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><button type="button" class="btn btn-lg btn-danger" id="updateMemberBtn">수정</button></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- js 유효성검사 -->
	<script>
	let updateMemberBtn = document.querySelector('#updateMemberBtn');
	updateMemberBtn.addEventListener('click', function(){
		// 디버깅
		console.log('updateMemberBtn clik!');
		
		// PW 폼 유효성 검사
		let memberPw = document.querySelector('#memberPw');
		if(memberPw.value == ''){
			alert('패스워드를 입력하세요');
			memberPw.focus();
			return;
		}
		
		// 새 PW 폼 유효성 검사
		let newMemberPw = document.querySelector('#newMemberPw');
		let newMemberPwCheck = document.querySelector('#newMemberPwCheck');
		if(newMemberPw.value == '' || newMemberPw.value != newMemberPwCheck.value){
			alert('새 패스워드를 다시 확인바랍니다');
			newMemberPw.focus();
			return;
		}
		
		// NAME 폼 유효성 검사
		let memberName = document.querySelector('#memberName');
		if(memberName.value == ''){
			alert('이름을 입력하세요');
			memberName.focus();
			return;
		}
		
		let updateMemberForm = document.querySelector('#updateMemberForm');
		updateMemberForm.submit();
	});
	
	<% // 기존 패스워드 다를 시 출력
		if(request.getParameter("falseMsg") != null){
	%>
			alert('패스워드가 다릅니다.');
	<%
		}
	%>
	</script>
</body>
</html>