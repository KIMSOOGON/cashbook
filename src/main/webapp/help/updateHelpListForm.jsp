<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	System.out.println("[updateHelpListForm 진입]");

	// session 로그인 유무 확인
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// parameter값 받아오기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help paramHelp = new Help();
	paramHelp.setHelpNo(helpNo);
	
	// 2 Model
	HelpDao helpDao = new HelpDao();
	Help oneHelp = helpDao.oneHelp(paramHelp);
	
	String helpMemo = oneHelp.getHelpMemo();
	String memberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의내역 수정</h1>
	<form action="<%=request.getContextPath()%>/help/updateHelpListAction.jsp" method="post">
		<table>
			<tr>
				<th>문의번호</th>
				<td><input type="hidden" name="helpNo" value="<%=helpNo%>"><%=helpNo%></td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td><textarea rows="10" cols="50" name="helpMemo" placeholder="내용을 입력하세요"><%=helpMemo%></textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=memberId%></td>
			</tr>	
			<tr>
				<td colspan="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>