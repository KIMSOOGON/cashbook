<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
	// 1 controller
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");

	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 데이터 request
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// 2 model 
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(),year,month,date);
	
	// 3 view
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

		<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/cashMenu.jsp"></jsp:include>
	</div>
	
	<!-- Services Section 상세페이지 -->
	<section id="services" class="services">
		<div class="container">
			<div class="section-title">
				<span>Financial Ledger Detail</span>
				<h2>Financial Ledger Detail</h2>
				<p>
					
				</p>
			</div>
			
			<!-- cash 목록 출력 -->
			<div>
				<h3><%=year%>년 <%=month%>월 <%=date%>일 수입 및 지출 내역</h3>
				<table class="table table-hover rounded bg-white">
					<tr>
						<th>수입(+)/지출(-)</th>
						<th>종류</th>
						<th>금액</th>
						<th>내용</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				<%
					for(HashMap<String,Object> m : list){
				%>		
						<tr>
							<td><%=(String)m.get("categoryKind")%></td>
							<td><%=m.get("categoryName")%></td>
							<td><%=m.get("cashPrice")%></td>
							<td><%=m.get("cashMemo")%></td>
						 	<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>"><img src="<%=request.getContextPath()%>/assets/img/edit2.png" style="width:25px"></a></td>
							<td><a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>"><img src="<%=request.getContextPath()%>/assets/img/delete3.png" style="width:25px"></a></td>
						</tr>	
				<%		
					}
				%>
				</table>
			</div>
		</div>
	</section>
			
	<!-- cash 입력 폼 -->
	<section id="contact" class="contact py-1">
		<div class="container pt-5 col-lg-6 text-center">
		<h3 class="text-secondary">가계부 추가</h3>
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post" role="form" class="php-email-form">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
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
					<input type="text" name="cashDate" class="form-control" id="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly" style="width:200px" required >
				</div>
				<div class="form-group mt-3 mt-md-4">
					<input type="number" class="form-control" name="cashPrice" id="cashPrice" placeholder="금액을 입력하세요" required>
				</div>
				<div class="form-group mt-3 mt-md-4">
					<textarea rows="3" cols="50" class="form-control" name="cashMemo" placeholder="Memo"></textarea>
				</div>
			</div>
			<div class="text-center mt-5"><button type="submit">ADD</button></div>
		</form>
		</div>
	</section>
</body>
</html>