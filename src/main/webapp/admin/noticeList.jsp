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
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-NoticeList</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	a {
		text-decoration:none;
	}
	</style>
</head>
<body id="winter">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- memberList Content -->
	<section id="pricing" class="pricing">
		<div class="container shadow-lg">
			<div class="section-title">
				<span>Notice Management</span>
				<h1>Notice Management</h1>
				<p>공문 관리 (수정/추가/삭제)</p>
			</div>
		</div>
	</section>
	
	<div class="container shadow">
		<div class="text-center my-3">
			<a href="<%=request.getContextPath()%>/admin/noticeListInsertForm.jsp" class="btn btn-warning font-weight-bold">ADD Notice</a>
		</div>
		<table class="container table table-hover bg-light text-center rounded">
			<tr class="text-primary">
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
					<td><a href="<%=request.getContextPath()%>/admin/noticeListUpdateForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>" class="btn btn-sm btn-dark">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/noticeListDeleteAction.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-sm btn-dark">삭제</a></td>
				</tr>	
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
		<div class="container text-center">
			<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a></li>
				<%
					if(currentPage>1){
				%>
							<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					}
				%>
					<li class="page-item"><span class="page-link text-warning bg-dark"><%=currentPage%></span>
				<%
					if(currentPage<lastPage){
				%>
							<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
					<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">끝</a></li>
			</ul>
		</div>
	</div>
</body>
</html>