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
</head>
<body id="winter">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- Notice Insert -->
	<section id="pricing" class="pricing">
		<div class="container shadow-lg">
			<div class="section-title">
				<span>ADD Notice</span>
				<h1>ADD Notice</h1>
				<p>공문 추가</p>
			</div>
		</div>
	</section>
	
	<section id="contact" class="contact py-1">
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