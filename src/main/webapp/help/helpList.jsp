<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//Controller
	// session 로그인 유무 확인
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId); // 로그인 된 memberId 변수에 저장
	
	// 고객센터 문의목록 불러오기
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-HelpList</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<!-- Favicons -->
	<link href="assets/img/favicon.png" rel="icon">
	<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Vendor CSS Files -->
	<link href="assets/vendor/aos/aos.css" rel="stylesheet">
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- =======================================================
	* Template Name: Day - v4.9.1
	* Template URL: https://bootstrapmade.com/day-multipurpose-html-template-for-free/
	* Author: BootstrapMade.com
	* License: https://bootstrapmade.com/license/
	======================================================== -->
	<style>
	a {
		text-decoration:none;
	}
	</style>
</head>
<body id="xMas">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/helpMenu.jsp"></jsp:include>
	</div>
	
	<h1>고객센터</h1>
	<h3>-<%=memberId%>님의 문의내역-</h3>
	<table border="1">
		<tr>
			<td colspan="3">[문의사항]</td>
			<td colspan="2">[답변내역]</td>
		</tr>
		<tr>
			<!-- 문의란 -->
			<th>Q no.</th>
			<th>문의내용</th>
			<th>작성날짜</th>
			<!-- 답변란 -->
			<th>답변내용</th>
			<th>작성날짜</th>
		</tr>
		<%
			for(HashMap<String,Object> h : list){
		%>
				<tr>
					<td><%=h.get("helpNo")%></td>
					<td><%=h.get("helpMemo")%></td>
					<td><%=h.get("helpCreatedate")%></td>
					<%
						if(h.get("commentMemo")==null){
					%>
							<td>(답변 준비중입니다)</td>
							<td>
								<a href="<%=request.getContextPath()%>/help/updateHelpListForm.jsp?helpNo=<%=h.get("helpNo")%>">수정</a>
								<a href="<%=request.getContextPath()%>/help/deleteHelpListAction.jsp?helpNo=<%=h.get("helpNo")%>">삭제</a>	
							</td>
					<%
						} else {
					%>
							<td><%=h.get("commentMemo")%></td>
							<td><%=h.get("commCreatedate")%></td>
					<%
						}
					%>
				</tr>
		<%
			}
		%>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpListForm.jsp">문의하기</a>
	</div>
</body>
</html>