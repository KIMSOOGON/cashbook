<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 관리자 session
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("관리자모드-멤버관리");
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("현재페이지:"+currentPage);	
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;

	// Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 회원 총원 및 끝페이지 구하기
	int cntMember = memberDao.selectMemberCount();
	int lastPage = cntMember / rowPerPage;
	if((cntMember % rowPerPage) != 0){
		lastPage = lastPage + 1;
	}
	
	ArrayList<Member>list = memberDao.selectMemberListByPage(beginRow,rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-MemberList</title>

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
	
	<!-- memberList Content -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container shadow-lg">
			<div class="section-title">
				<span>Member Management</span>
				<h1>Member Management</h1>
				<p>구디가계부 회원 승급/강등/강제탈퇴</p>
			</div>
		</div>
	</section>
	
	<div class="container shadow" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<table class="container table table-hover bg-light text-center rounded">
			<tr class="text-primary">
				<th>멤버변호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>최신수정일자</th>
				<th>가입일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list){
			%>	
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td>
							<form method="post" action="<%=request.getContextPath()%>/admin/memberListUpdateLevelAction.jsp">
								<input type="hidden" name="memberNo" value="<%=m.getMemberNo()%>">
								<select name="memberLevel">
									<option value="">=선택=</option>
									<option value="0">일반회원(0)</option>
									<option value="1">관리자(1)</option>
								</select>
								<button type="submit" class="btn btn-sm btn-dark">수정</button>
							</form>
						</td>
						<td><a href="<%=request.getContextPath()%>/admin/memberListDeleteAction.jsp?memberNo=<%=m.getMemberNo()%>" class="btn btn-sm btn-dark">BAN</a></td>
					</tr>
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
		<div class="container text-center">
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a></li>
				<%
					if(currentPage>1){
				%>
					<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					}
				%>
				<li class="page-item"><span class="page-link text-warning bg-dark"><%=currentPage%></span></li>
				<%
					if(currentPage<lastPage){
				%>
						<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
				<li class="page-item"><a class="page-link bg-secondary text-light" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">끝</a></li>
			</ul>
		</div>
	</div>
</body>
</html>