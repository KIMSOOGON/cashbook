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
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-NoticeList-Update</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body id="winter">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- Notice Update -->
	<section id="pricing" class="pricing">
		<div class="container shadow-lg">
			<div class="section-title">
				<span>Update Notice</span>
				<h1>Update Notice</h1>
				<p>[<%=noticeNo%>번] 공문 수정</p>
			</div>
		</div>
	</section>
	
	<section id="contact" class="contact py-1">
		<div class="container pt-5 col-lg-6 text-center bg-light">
			<form action="<%=request.getContextPath()%>/admin/noticeListUpdateAction.jsp" method="post">
				<div><input type="hidden" name="noticeNo" value="<%=noticeNo%>"></div>
				<div>
					<textarea rows="10" cols="70" name="noticeMemo"><%=noticeMemo%></textarea>
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
		</div>
	</section>
</body>
</html>