<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller : session, request
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	CashDao cashDao = new CashDao();
	HashMap<String,Object> map = cashDao.selectMaxMinYear();
	int minYear = (Integer)map.get("minYear");
	int maxYear = (Integer)map.get("maxYear");
	System.out.println("minYear : "+minYear);
	System.out.println("maxYear : "+maxYear);

	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	if(request.getParameter("year") != null) {
		year = Integer.parseInt(request.getParameter("year"));
	}

	ArrayList<HashMap<String,Object>> yearList = cashDao.selectCashListByYear(loginMember.getMemberId());
	ArrayList<HashMap<String,Object>> monthList = cashDao.selectCashListByMonth(loginMember.getMemberId(),year);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-Detail Cash</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	
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
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css"> 
</head>
<body id="snow">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	
		<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/cashMenu.jsp"></jsp:include>
	</div>
	
	<!-- ======= Services Section ======= -->
	<section id="services" class="services" data-aos="fade-up" data-aos-delay="500" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>Financial ledger statistics</span>
				<h2>Financial ledger statistics</h2>
				<p><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)님의 가계부 분석 통계</p>
			</div>
		</div>
	</section>
	
	

	<div class="container bg-light pt-2" data-aos="fade-up" data-aos-delay="500" data-aos-duration="1000">
		<div class="container rounded m-2">
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-sm" style="background-color:rgb(200,240,245)">
				<img src="<%=request.getContextPath()%>/assets/img/calendar.png" style="width:25px">내 가계부 작성하기
			</a>
		</div>
		<h5 class="container pt-3">연도별 총 지출 및 수입 통계</h5>
		<div class="text-end">단위 : ￦</div>
		<table class="table table-hover">
			<tr style="background-color:rgb(240,235,250)">
				<th>년도</th>
				<th>수입횟수</th>
				<th>총 수입</th>
				<th>수입 평균</th>
				<th>지출횟수</th>
				<th>총 지출</th>
				<th>지출 평균</th>
			</tr>
			<%
				for(HashMap<String,Object> m : yearList){
			%>
					<tr>
						<td><a href="<%=request.getContextPath()%>/cash/cashDetailList.jsp?year=<%=m.get("year")%>"><%=m.get("year")%></a></td>
						<td><%=m.get("importCnt")%></td>
						<td><%=m.get("importSum")%></td>
						<td><%=m.get("importAvg")%></td>
						<td><%=m.get("exportCnt")%></td>
						<td><%=m.get("exportSum")%></td>
						<td><%=m.get("exportAvg")%></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<div class="container my-5 pt-2 bg-light" data-aos="fade-up" data-aos-delay="500" data-aos-duration="1000">
		<h5 class="container pt-2"><%=year%>년 월별 총 지출 및 수입 통계</h5>
		<div class="text-end">
			<form action="<%=request.getContextPath()%>/cash/cashDetailList.jsp">
			<select name="year" class="rounded">
				<%
					for(int i=minYear; i<=maxYear; i++){
				%>		
						<option value="<%=i%>"><%=i%></option>	
				<%		
					}
				%>
			</select>
			<button type="submit" class="btn btn-sm btn-outline-dark">이동</button>
			</form>
		</div>
		<div class="text-end">단위 : ￦</div>
		<table class="table table-hover">
			<tr style="background-color:rgb(240,235,250)">
				<th>월(月)</th>
				<th>수입횟수</th>
				<th>총 수입</th>
				<th>수입 평균</th>
				<th>지출횟수</th>
				<th>총 지출</th>
				<th>지출 평균</th>
			</tr>
			<%
				for(HashMap<String,Object> m : monthList){
			%>
					<tr>
						<td><%=m.get("month")%></td>
						<td><%=m.get("importCnt")%></td>
						<td><%=m.get("importSum")%></td>
						<td><%=m.get("importAvg")%></td>
						<td><%=m.get("exportCnt")%></td>
						<td><%=m.get("exportSum")%></td>
						<td><%=m.get("exportAvg")%></td>
					</tr>
			<%
				}
			%>
		</table>
		
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