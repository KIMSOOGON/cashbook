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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의하기</h1>
	<form action="<%=request.getContextPath()%>/help/insertHelpListAction.jsp">
		<table>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" cols="50" name="helpMemo" placeholder="문의내용을 입력하세요"></textarea>
				</td>
			</tr>		
			<tr>
				<th>작성자</th>
				<td><%=memberId%></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">확인</button></td>
			</tr>
		</table>	
	</form>
</body>
</html>