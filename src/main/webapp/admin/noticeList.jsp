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
	System.out.println("[관리자모드 공지관리페이지 진입]");
	
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 페이징 작업
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	} 
	System.out.println("currentPage: "+currentPage);
	int rowPerPage = 5; // 페이지 당 출력 공문갯수 (행)
	int beginRow = (currentPage-1) * rowPerPage;
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	
	// 공문 총갯수 및 마지막페이지 구하기
	int countNotice = noticeDao.countNotice(); // 공문 총 갯수 (행)
	int lastPage = countNotice / rowPerPage;
	if(countNotice % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	System.out.println("(1)공지관리페이지 공지 총 갯수 : "+countNotice);
	System.out.println("(2)공지관리페이지 lastPage : "+lastPage);
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoticeList</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- noticeList Content -->
		<h1>공지</h1>
		<a href="<%=request.getContextPath()%>/admin/noticeListInsertForm.jsp">공지입력</a>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list){
			%>	
				<tr>	
					<td><%=n.getNoticeNo()%></td>
					<td><%=n.getNoticeMemo()%></td>
					<td><%=n.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/noticeListUpdateForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/noticeListDeleteAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
				</tr>	
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage>1){
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage<lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">끝</a>
		</div>
	</div>
</body>
</html>