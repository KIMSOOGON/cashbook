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
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-HelpListAll</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<!-- Favicons -->
	<link href="../assets/img/favicon.png" rel="icon">
	<link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Vendor CSS Files -->
	<link href="../assets/vendor/aos/aos.css" rel="stylesheet">
	<link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="../assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="../assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	<link href="../assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	#Calendar {
		font-size:30px;
		font-weight:bold;
	}
	a {
		text-decoration:none;
	}
	</style>
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