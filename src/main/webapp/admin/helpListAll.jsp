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
	System.out.println("[helpListAll 진입]");
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("현재페이지 : "+currentPage);
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	
	int ttlHelp = helpDao.countHelp(); // 문의사항 총 개수
	int lastPage = ttlHelp / rowPerPage;
	if(ttlHelp % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	System.out.println("마지막페이지 : "+lastPage);
	System.out.println("고객문의 총 개수 : "+ttlHelp);
	
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>문의목록</h1>
	<table border="1">
		<tr>
			<th>No</th>
			<th>문의내용</th>
			<th>작성회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가/수정/삭제</th>
			<th>문의내역삭제</th>
		</tr>
		<%
			for(HashMap<String,Object> m : list){
		%>		
				<tr>
					<td><%=m.get("helpNo")%></td>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<%
						if(m.get("commentMemo")!=null){
					%>		
							<td><%=m.get("commentMemo")%></td>
							<td><%=m.get("commCreatedate")%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/helpListAllUpdateForm.jsp?helpNo=<%=m.get("helpNo")%>&commentMemo=<%=m.get("commentMemo")%>"><img src="<%=request.getContextPath()%>/img/edit2.png" style="width:25px"></a>
								<a href="<%=request.getContextPath()%>/admin/helpListAllDeleteAction.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/img/delete3.png" style="width:25px"></a>
							</td>	
					<%		
						} else {
					%>		
							<td colspan="2">(답변 등록 필요)</td>
							<td><a href="<%=request.getContextPath()%>/admin/helpListAllInsertForm.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/img/answer.png" style="width:25px"></a></td>	
					<%		
						}
					%>
					<td><a href="<%=request.getContextPath()%>/admin/deleteHelpAdminAction.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/img/delete.png" style="width:20px"></a></td>
				</tr>	
		<%		
			}
		%>
	</table>
	<!-- 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
		<%
			if(currentPage>1){
		%>		
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
				<span><%=currentPage%>/<%=lastPage%></span>
		<%
			if(currentPage<lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">끝</a>
	</div>
</body>
</html>