<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Controller	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[helpListAllUpdateForm 진입]");
	
	// parameter값 불러오기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	Help paramHelp = new Help();
	paramHelp.setHelpNo(helpNo);
	
	// 하나의 help값 불러오기
	HelpDao helpDao = new HelpDao();
	Help oneHelp = helpDao.oneHelp(paramHelp);
	String helpMemo = oneHelp.getHelpMemo();
	String memberId = oneHelp.getMemberId();
	String createdate = oneHelp.getCreatedate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>-답변수정-</h1>
	<hr>
	<h3>[문의내용]</h3>
	<table border="1">
		<tr>
			<th>문의내용</th>
			<td><textarea rows="10" cols="50" readonly="readonly"><%=helpMemo%></textarea></td>
		</tr>
		<tr>
			<th>회원ID</th>
			<td><%=memberId%></td>
		</tr>
		<tr>
			<th>문의시각</th>
			<td><%=createdate%></td>
		</tr>
	</table>
	<hr>
	<h3>[답변내용수정]</h3>
	<form action="<%=request.getContextPath()%>/admin/helpListAllUpdateAction.jsp" method="post">
		<div>
			<input type="hidden" name="helpNo" value="<%=helpNo%>">
		</div>
		<table border="1">
			<tr>
				<th>답변</th>
				<td><textarea rows="10" cols="50" name="commentMemo" placeholder="답변을 입력하세요"><%=commentMemo%></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">edit</button></td>
			</tr>
		</table>
	</form>
</body>
</html>