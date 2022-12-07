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
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-deleteAccount</title>
	
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
				<span>Delete My Account</span>
				<h1>Delete My Account</h1>
				<p>회원 탈퇴</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center bg-light py-4 w-75 rounded">
		<div class="container py-3 rounded">
			<ul>
				<li>사용하고 계신 아이디는 탈퇴할 경우 <span class="text-danger">재사용 및 복구가 불가능</span>합니다.</li>
				<br>
				<li>탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</li>
				<br>
				<li>모든 내용을 확인하셨으며 탈퇴를 진행하고자 하시면 비밀번호를 입력해주세요.</li>
			</ul>
		</div>
		<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
			<div>
				<%	
					String pwMsg = request.getParameter("pwMsg");
					String ckMsg = request.getParameter("ckMsg");
					if(pwMsg!=null){ // 공백 입력 시 출력
				%>		
						<%=pwMsg%>
				<%		
					}
					if(ckMsg!=null){ // 패스워드 다를 시 출력
				%>
						<%=ckMsg%>			
				<%
					}
				%>
			</div>
			<table class="table table-hover">
				<tr>
					<th>패스워드</th>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<td colspan="2" class="container py-3"><button type="submit" class="btn btn-lg btn-danger">확인</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>