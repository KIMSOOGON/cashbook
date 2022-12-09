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
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-helpList-update</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
</head>
<body id="xMas">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpList Update -->
	<section id="pricing" class="pricing" data-aos="zoom-in" data-aos-delay="600" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>Edit Help</span>
				<h1>Edit Help</h1>
				<p>문의 수정</p>
			</div>
		</div>
	</section>
	
	<div class="container text-center bg-light w-75" data-aos="zoom-in" data-aos-delay="600" data-aos-duration="1000">
		<form action="<%=request.getContextPath()%>/help/updateHelpListAction.jsp" method="post">
			<table class="table table-hover">
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
					<td colspan="2"><button type="submit" class="btn btn-lg btn-danger">수정</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>