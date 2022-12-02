<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	System.out.println("<관리자모드 진입>");
	// Controller	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	
	// 공지 5개, 멤버 5명 (최신업데이트)
	ArrayList<Notice> NoticeList = noticeDao.selectNoticeListByPage(0,5);
	ArrayList<Member> MemberList = memberDao.selectMemberListByPage(0,5);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-Calendar</title>
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
<body id="lf">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- adminMain Content -->
	<section id="team" class="team">
	<h1 class="container py-4 my-2 text-center text-warning"><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)님의 관리자 페이지</h1>
		<div class="container row">
			<div class="text-center bg-white rounded mx-4 px-4 section-title col">
			<!-- 공지 -->
			<span>Latest Notice</span>
			<h2>Latest Notice</h2>
			<table class="table table-bordered" style="background-color:rgb(235,235,250)">
				<tr>
					<th>번호</th>
					<th>공지내용</th>
					<th>공지날짜</th>
				</tr>
				<%
					for(Notice n : NoticeList){
				%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
				<%
					}
				%>
			</table>
			</div>
			<!-- 멤버 -->
			<div class="text-center bg-white rounded mx-4 px-4 section-title col">
			<span>Latest Member</span>
			<h2>Latest Member</h2>
			<table class="table table-bordered" style="background-color:rgb(235,235,250)">
				<tr>
					<th>아이디</th>
					<th>레벨</th>
					<th>이름</th>
					<th>가입일자</th>
				</tr>
				<%
					for(Member m : MemberList){
				%>
					<tr>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getCreatedate()%></td>
					</tr>
				<%
					}
				%>
			</table>
			</div>
			</div>
	</section>
</body>
</html>