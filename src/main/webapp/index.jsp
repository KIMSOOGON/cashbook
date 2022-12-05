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
	<link href="assets/css/style.css" rel="stylesheet">
	
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

  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-4 col-md-6">
            <div class="footer-info">
              <h3>Day</h3>
              <p>
                A108 Adam Street <br>
                NY 535022, USA<br><br>
                <strong>Phone:</strong> +1 5589 55488 55<br>
                <strong>Email:</strong> info@example.com<br>
              </p>
              <div class="social-links mt-3">
                <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
                <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
                <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
                <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
                <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
              </div>
            </div>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
            </ul>
          </div>

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>Our Newsletter</h4>
            <p>Tamen quem nulla quae legam multos aute sint culpa legam noster magna</p>
            <form action="" method="post">
              <input type="email" name="email"><input type="submit" value="Subscribe">
            </form>

          </div>

        </div>
      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>Day</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/day-multipurpose-html-template-for-free/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>

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