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
	<h1>회원탈퇴</h1>
	<hr>
	<div>비밀번호를 입력하여 탈퇴하세요.</div>
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
		<table>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">확인</button></td>
			</tr>
		</table>
	</form>
</body>
</html>