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
	
	<title>GooDee-helpListAll-update</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Vendor CSS Files -->
	<link href="<%=request.getContextPath()%>/assets/vendor/aos/aos.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
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
		<jsp:include page="../inc/helpMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpList -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="500" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>HelpList</span>
				<h1>HelpList</h1>
				<p class="text-white">-<%=memberId%>님의 문의내역-</p>
			</div>
		</div>
	</section>
	
	<div class="row box mx-4 rounded bg-light" data-aos="fade-up" data-aos-delay="500" data-aos-duration="1000">
		<table class="table table-hover shadow-lg table-bordered">
			<tr class="text-center text-primary" style="background-color:rgb(240,235,250)">
				<th colspan="3">문의사항</th>
				<th colspan="2">답변내역</th>
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
								<td class="text-danger">(답변 준비중입니다)</td>
								<td>
									수정<a href="<%=request.getContextPath()%>/help/updateHelpListForm.jsp?helpNo=<%=h.get("helpNo")%>"><img src="<%=request.getContextPath()%>/assets/img/edit2.png" style="width:25px"></a>
									 / 
									삭제<a href="<%=request.getContextPath()%>/help/deleteHelpListAction.jsp?helpNo=<%=h.get("helpNo")%>"><img src="<%=request.getContextPath()%>/assets/img/delete3.png" style="width:25px"></a>	
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
		<div class="text-center py-2">
			<a href="<%=request.getContextPath()%>/help/insertHelpListForm.jsp" class="btn btn-lg btn-warning">ADD</a>
		</div>
	</div>
	
	<!-- Vendor JS Files -->
	<script src="<%=request.getContextPath()%>/assets/vendor/aos/aos.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/vendor/php-email-form/validate.js"></script>
	
	<!-- Template Main JS File -->
	<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
	
</body>
</html>