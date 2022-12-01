<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 1 Controller
	request.setCharacterEncoding("utf-8");
	
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("cashNo")==null || request.getParameter("cashNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	}
	
	System.out.println(request.getParameter("cashNo"));
	System.out.println(request.getParameter("year"));
	// 데이터 request
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String memberId = loginMember.getMemberId();
	
	// 2 Model
	
	// Cash 1개의 데이터값 불러오기
	Cash paramCash = new Cash();
	paramCash.setCashNo(cashNo);
	paramCash.setMemberId(memberId);

	CashDao cashDao = new CashDao();
	Cash resultCash = cashDao.oneCash(paramCash);
	
	// Category 정보 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-financial ledger-Calendar</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<!-- Favicons -->
	<link href="../assets/img/favicon.png" rel="icon">
	<link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
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
	<link href="../assets/css/style.css" rel="stylesheet">
	
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
</head>
<body id="snow">
	
	<!-- ======= Top Bar ======= -->
	<section id="topbar" class="d-flex align-items-center">
		<div class="container d-flex justify-content-center justify-content-md-between">
			<div class="contact-info d-flex align-items-center">
				<i class="bi bi-envelope-fill"></i><a href="mailto:contact@example.com">oasis0530@naver.com</a>
				<i class="bi bi-phone-fill phone-icon"></i> +82 010 2973 0973
			</div>
			<div class="social-links d-none d-md-block">
				<%
					if(session.getAttribute("loginMember") == null){ // 로그인 되어있지 않을 때, LOG-IN 출력
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-warning">LOG-IN</a>
				<%
					} else { // 로그인 되어있는 경우, LOG-OUT 출력
				%>
						<%=loginMember.getMemberId()%>님
						<a href="<%=request.getContextPath()%>/logout.jsp" class="text-warning">LOG-OUT</a>
				<%
					}
				%>
				<a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
				<a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
				<a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
				<a href="#" class="linkedin"><i class="bi bi-linkedin"></i></i></a>
			</div>
		</div>
	</section>
	
	<!-- ======= Header ======= -->
	<header id="header" class="d-flex align-items-center">
		<div class="container d-flex align-items-center justify-content-between">        
			<h1 class="logo"><a href="<%=request.getContextPath()%>/index.jsp">구디 가계부</a></h1>
			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      		<nav id="navbar" class="navbar">
				<ul>
					<li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li><a class="nav-link scrollto active" href="<%=request.getContextPath()%>/cash/cashList.jsp">내 가계부</a></li>
					<li><a class="nav-link scrollto " href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a></li>
					<li class="dropdown"><a href=""><span class="text-primary">마이 페이지</span> <i class="bi bi-chevron-down"></i></a>
						<ul>
							<li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/updateMemberForm.jsp">내 정보수정</a></li>
							<li><a class="nav-link scrollto" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a></li>
						</ul>
					</li>
					<%
						if(loginMember.getMemberLevel() == 1){ // 관리자로 로그인 시에만 출력
					%>
					<li class="dropdown"><a href="<%=request.getContextPath()%>/admin/adminMain.jsp"><span class="text-danger">관리자모드</span> <i class="bi bi-chevron-down"></i></a>
						<ul>
							<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice Management</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">Category Management</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">Member Management</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Customer Service Management</a></li>
						</ul>
					</li>
					<%
						}
					%>
					<li><a class="nav-link scrollto" href="#contact">Contact</a></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav><!-- .navbar -->
		</div>
	</header><!-- End Header -->
	
	<!-- cash 수정 폼 -->
	<section id="contact" class="contact py-1">
		<div class="container pt-5 col-lg-6 text-center">
		<h3 class="text-secondary"><%=year%>년 <%=month%>월 <%=date%>일 가계부 수정</h3>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post" role="form" class="php-email-form">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			<div>
				<div class="form-group mt-3">
					<select name="categoryNo" class="form-control" required>
					<%
					for(Category c : categoryList){
					%>
					<option value="<%=c.getCategoryNo()%>">
					<%=c.getCategoryKind()%> <%=c.getCategoryName()%> 
					</option>
					<%
					}						
					%>			
					</select>
				</div>
				<div class="form-group mt-3">
					<input type="date" name="cashDate" class="form-control" id="cashDate" value="<%=resultCash.getCashDate()%>" style="width:200px" required >
				</div>
				<div class="form-group mt-3 mt-md-4">
					<input type="number" class="form-control" name="cashPrice" id="cashPrice" value="<%=resultCash.getCashPrice()%>" placeholder="금액을 입력하세요" required>
				</div>
				<div class="form-group mt-3 mt-md-4">
					<textarea rows="3" cols="50" class="form-control" name="cashMemo" placeholder="Memo"><%=resultCash.getCashMemo()%></textarea>
				</div>
			</div>
			<div class="text-center mt-5"><button type="submit">수정</button></div>
		</form>
		</div>
	</section>
</body>
</html>