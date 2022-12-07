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
				<span>Edit My Info</span>
				<h1>Edit My Info</h1>
				<p>내 정보 수정 (이름 및 비밀번호)</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center bg-light w-75">
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
			<div>
				<%	// 빈항목 제출 시, 문구출력
					String msg = request.getParameter("msg");
					if(msg!=null){
				%>		
						<%=msg%>					
				<%		
					}
					// 비밀번호 확인 일치여부, 문구출력
					String ckMsg = request.getParameter("ckMsg");
					if(ckMsg!=null){
				%>		
						<%=ckMsg%>					
				<%		
					}
				%>
			</div>
			<table class="table table-hover">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td><input type="password" name="newMemberPw"></td>
				</tr>
				<tr>
					<th>새 비밀번호 확인</th>
					<td><input type="password" name="newMemberPwCheck"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="memberName" value="<%=loginMember.getMemberName()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit" class="btn btn-lg btn-danger">수정</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>