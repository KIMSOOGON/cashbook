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

	// request 년 + 월
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null){ // 입력값 없을 시, 오늘기준
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else { // 연,월 입력값 있을 경우 받아오기
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12일 경우
		if(month == -1){ // 올해 1월에서 작년 12월로 넘어가기
			month = 11;
			year -= 1;
		} 
		if(month == 12){ // 올해 12월에서 내년 1월로 넘어가기
			month = 0;
			year += 1;
		}
	}
	// 출력하고자 하는 월과 월의 1일의 요일(일~토, 1~7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다
	if((beginBlank + lastDate) % 7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력출력 + 일별 cash 목록
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-Calendar</title>
	
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
	<section id="services" class="services" data-aos="fade-up" data-aos-delay="500">
		<div class="container">
			<div class="section-title">
				<span>Financial ledger Calendar</span>
				<h2>Financial ledger Calendar</h2>
				<p><%=loginMember.getMemberId()%>(<%=loginMember.getMemberName()%>)님의 가계부캘린더</p>
			</div>
			<div class="text-dark row py-2" style="background-color:rgb(240,235,250)">
				<div class="col text-center"><!-- Year이동 -->
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year-1%>&month=<%=month%>" class="btn btn-lg">&#8701;</a>
					<span>Year</span>
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year+1%>&month=<%=month%>" class="btn btn-lg">&#8702;</a>
				</div>
				<div class="col text-center">
					<span id="Calendar"><%=year%>년 <%=month+1%>월</span>
				</div>
				<div class="col text-center"><!-- Month이동 -->
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-lg">&#8701;</a>
					<span>Month</span>
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-lg">&#8702;</a>
				</div>
				<!-- Calendar 출력 -->
				<table class="container table table-hover text-dark bg-white shadow">
					<tr class="text-center">
						<th style="color:red">일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th style="color:blue">토</th>
					</tr>
					<tr>
						<!-- 달력 -->
						<%
							for(int i=1; i<=totalTd; i++){ // 해당 월 1~말일까지 출력
						%>
								<td>
						<%
									int date = i-beginBlank;
									if(date>0 && date<=lastDate){
						%>				
										<div>
											<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>" class="btn btn-sm text-black">
												<%=date%>
											</a>	
										</div>
										<div>
											<% // 일별 가계부 출력
												for(HashMap<String, Object> m : list){
													String cashDate = (String)(m.get("cashDate"));
													int cashOneDate = Integer.parseInt(cashDate.substring(8)); 
													if(cashOneDate == date){
											%>
														[<%=(String)(m.get("categoryKind"))%>]
														<%=(String)(m.get("categoryName"))%>										
														<%=(long)(m.get("cashPrice"))%>원
														<br>
											<%	
													}		
												}
											%>
										</div>
						<%				
									}
						%>	
								</td>
						<%
								if(i%7==0){
						%>
									</tr><tr><!-- td 7개 만들고 줄바꿈 -->
						<%
								}
							}
						%>
					</tr>
				</table>
			</div>
		</div>
	</section>
		
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