<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">로그인</button>
				</td>
			</tr>
		</table>
	</form>
	<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">
		회원가입
	</a>
</body>
</html>