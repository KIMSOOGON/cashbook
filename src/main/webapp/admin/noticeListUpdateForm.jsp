<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// 1 Controller
	// 관리자모드 로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("[관리자모드 공지UpdateForm 진입]");
	
	// parameter 받아오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	
	System.out.println("[공문수정페이지] 공문넘버 : "+noticeNo);
	System.out.println("[공문수정페이지] 공문내용 : "+noticeMemo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지수정</h1>
	<form action="<%=request.getContextPath()%>/admin/noticeListUpdateAction.jsp" method="post">
		<div><input type="hidden" name="noticeNo" value="<%=noticeNo%>"></div>
		<div>
			<textarea rows="10" cols="300" name="noticeMemo"><%=noticeMemo%></textarea>
		</div>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
	<div>
		<%	// 공백 입력 시, 문구 출력
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