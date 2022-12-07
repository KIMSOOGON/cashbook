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

	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
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