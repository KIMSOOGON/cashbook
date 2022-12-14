<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	System.out.println("[insertHelpListForm 진입]");

	//session 로그인 유무 확인
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId); // 로그인 된 memberId 변수에 저장
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-helpListAll-update</title>
	
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
<body id="xMas">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpList Insert -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>Add Help</span>
				<h1>Add Help</h1>
				<p>문의 추가</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center bg-light w-75" data-aos="fade-out" data-aos-delay="600" data-aos-duration="1000">
		<form action="<%=request.getContextPath()%>/help/insertHelpListAction.jsp" id="insertHelpForm">
			<table class="table table-hover">
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="50" name="helpMemo" id="helpMemo" placeholder="문의내용을 입력하세요"></textarea>
					</td>
				</tr>		
				<tr>
					<th>작성자</th>
					<td><%=memberId%></td>
				</tr>
				<tr>
					<td colspan="2"><button type="button" id="insertHelpBtn" class="btn btn-lg btn-danger">확인</button></td>
				</tr>
			</table>	
		</form>
	</div>
	
	<!-- js로 유효성검사 -->
	<script>
	let insertHelpBtn = document.querySelector('#insertHelpBtn');
	insertHelpBtn.addEventListener('click', function(){
		// 디버깅
		console.log('insertHelpBtn clik!');
		
		// 문의내용 유효성 검사
		let helpMemo = document.querySelector('#helpMemo');
		if(helpMemo.value == ''){
			alert('문의내용을 입력하세요');
			helpMemo.focus();
			return;
		}
		
		let insertHelpForm = document.querySelector('#insertHelpForm');
		insertHelpForm.submit();
	})
	
	</script>
</body>
</html>