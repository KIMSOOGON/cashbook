<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%	
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[관리자모드 공지 INSERT FORM 진입]");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지 추가</h1>
	<form method="post" action="<%=request.getContextPath()%>/admin/noticeListInsertAction.jsp">
		<table>
			<tr>
				<td><textarea rows="5" cols="50" name="noticeMemo" placeholder="공문을 작성해주세요"></textarea><td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">추가</button></td>
			</tr>
		</table>
	</form>
	<div>
		<%	// 공백 입력 시, 출력문구
			String msg = request.getParameter("msg");
			if(msg!=null){
		%>		
				<%=msg%>
		<%		
			}
		%>
	</div>
</body>
</html>