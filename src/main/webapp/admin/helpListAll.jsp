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
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
</head>
<body id="winter">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- Notice Insert -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container shadow-lg">
			<div class="section-title">
				<span>Help Management</span>
				<h1>Help Management</h1>
				<p>고객센터 관리</p>
			</div>
		</div>
	</section>
	
	<div class="container shadow" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<table class="container table table-bordered table-hover bg-light text-center rounded">
			<tr class="text-primary">
				<th>No</th>
				<th>문의내용</th>
				<th>회원ID</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
				<th>Edit Comment</th>
				<th>Delete Help</th>
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
									<a href="<%=request.getContextPath()%>/admin/helpListAllUpdateForm.jsp?helpNo=<%=m.get("helpNo")%>&commentMemo=<%=m.get("commentMemo")%>"><img src="<%=request.getContextPath()%>/assets/img/edit2.png" style="width:25px"></a>
									<a href="<%=request.getContextPath()%>/admin/helpListAllDeleteAction.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/assets/img/delete3.png" style="width:25px"></a>
								</td>	
						<%		
							} else {
						%>		
								<td colspan="2">(답변 등록 필요)</td>
								<td><a href="<%=request.getContextPath()%>/admin/helpListAllInsertForm.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/assets/img/answer.png" style="width:25px"></a></td>	
						<%		
							}
						%>
						<td><a href="<%=request.getContextPath()%>/admin/deleteHelpAdminAction.jsp?helpNo=<%=m.get("helpNo")%>"><img src="<%=request.getContextPath()%>/assets/img/delete.png" style="width:20px"></a></td>
					</tr>	
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
		<div class="container text-center">
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a></li>
				<%
					if(currentPage>1){
				%>		
						<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					}
				%>
						<li class="page-item"><span class="page-link text-warning bg-dark"><%=currentPage%>/<%=lastPage%></span>
				<%
					if(currentPage<lastPage){
				%>
						<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%		
					}
				%>
				<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">끝</a></li>
			</ul>
		</div>
	</div>
</body>
</html>