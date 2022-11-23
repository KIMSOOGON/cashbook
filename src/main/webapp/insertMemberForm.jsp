<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp">
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
				<th>이름</th>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">회원가입</button>
				</td>
			</tr>
		</table>
		<div>
			<%
				String msg = request.getParameter("msg");
				if(msg!=null){
			%>
					<%=msg%>
			<%
				}
			%>
		</div>
		<div>
			<%
				String idMsg = request.getParameter("idMsg");
				if(idMsg!=null){
			%>
					<%=idMsg%>
			<%
				}
			%>
		</div>
	</form>
</body>
</html>