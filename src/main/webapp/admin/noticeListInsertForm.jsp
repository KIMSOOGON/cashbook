<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%	
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[관리자모드 공지 INSERT FORM 진입]");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-NoticeList-Insert</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
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
				<span>ADD Notice</span>
				<h1>ADD Notice</h1>
				<p>공문 추가</p>
			</div>
		</div>
	</section>
	
	<section id="contact" class="contact py-1" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container pt-5 col-lg-6 text-center bg-light">
			<form method="post" action="<%=request.getContextPath()%>/admin/noticeListInsertAction.jsp">
				<table class="table table-hover shadow-lg">
					<tr>
						<td><textarea rows="5" cols="50" name="noticeMemo" placeholder="공문을 작성해주세요"></textarea><td>
					</tr>
					<tr>
						<td colspan="2"><button type="submit" class="btn btn-lg btn-danger">ADD</button></td>
					</tr>
				</table>
			</form>
			<div>
				<%	// 공백 입력 시, 출력문구
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