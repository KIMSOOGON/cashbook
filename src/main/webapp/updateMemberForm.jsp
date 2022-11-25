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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원정보수정</h1>
	<hr>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
		<div>
			<%	// 빈항목 제출 시, 문구출력
				String msg = request.getParameter("msg");
				if(msg!=null){
			%>		
					<%=msg%>					
			<%		
				}
			%>
		</div>
		<table border="1">
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
				<td colspan="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>