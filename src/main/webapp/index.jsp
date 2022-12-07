<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 1 Controller

	// 페이징 작업
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 2 Model
	NoticeDao noticeDao = new NoticeDao();
	
	// 공문 총 갯수 구하기
	int countNotice = noticeDao.countNotice();
	System.out.println("loginForm 총 공문 갯수 : "+countNotice);
	
	// 마지막 페이지 구하기
	int lastPage = countNotice / rowPerPage;
	if(countNotice % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	System.out.println("loginForm 공문 마지막 페이지 : "+lastPage);
	
	// 공문 목록 5개씩 정렬 불러오기
	ArrayList<Notice>list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-home</title>

	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
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

<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="inc/homeMenu.jsp"></jsp:include>
	</div>
	
	<!-- ======= 홈화면 Section ======= -->
	<section id="hero" class="d-flex align-items-center">
		<div class="container position-relative text-center" data-aos="fade-up" data-aos-delay="500">
			<div class="card shadow mb-4" style="background-color:rgb(30,30,30)">
				<div class="card-header py-3">
				<h3 class="m-0 font-weight-bold text-white">Offical Notice</h3>
					<div class="card-body">
						<div class="table-responsive">
							<table class="container table table-bordered bg-white w-75" id="dataTable">
								<thead class="text-primary">
									<tr>
										<th>NOTICE</th>
										<th>DATE</th>
									</tr>
								</thead>
								<tbody>
									<%
									for(Notice n : list){
									%>		
										<tr>
											<td><%=n.getNoticeMemo()%></td>
											<td><%=n.getCreatedate()%></td>
										</tr>
									<%		
									}
									%>
								</tbody>
							</table>
						</div>
						<div class="text-center text-secondary">
							<a href="<%=request.getContextPath()%>/index.jsp?currentPage=1" class="btn-get-started">처음</a>
							<%
							if(currentPage>1){
							%>		
								<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>" class="btn-get-started">◀</a>	
							<%		
							}
							%>
							<span><%=currentPage%>/<%=lastPage%></span>
							<%
							if(currentPage<lastPage){
							%>		
								<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>" class="btn-get-started">▶</a>	
							<%		
							}
							%>
							<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>" class="btn-get-started">끝</a>	      
						</div>
					</div>
				</div>  
			</div>
		</div>
	</section><!-- End Hero -->

	<!-- footer partial jsp 구성 -->
	<div>
		<jsp:include page="inc/footer.jsp"></jsp:include>
	</div>
	
	<!-- Vendor JS Files -->
	<script src="assets/vendor/aos/aos.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>
	
	<!-- Template Main JS File -->
	<script src="assets/js/main.js"></script>

</body>

</html>