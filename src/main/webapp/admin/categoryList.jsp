<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	String url = "manager";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-Admin-CategoryList</title>
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
<body id="winter">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- categoryList Content -->
	<section id="pricing" class="pricing">
		<div class="container shadow-lg">
			
			<div class="section-title">
				<span>Category Management</span>
				<h1>Category Management</h1>
				<p>카테고리 추가,수정,삭제</p>
			</div>
			
			<div>
				<div class="text-center my-3">
					<a href="<%=request.getContextPath()%>/admin/categoryListInsertForm.jsp" class="btn btn-warning font-weight-bold">ADD Category</a>
				</div>
				<table class="container shadow table text-center relative w-75 bg-light table-hover table-bordered rounded">
					<thead class="text-primary">
						<tr>
							<th>번호</th>
							<th>수입(+)/지출(-)</th>
							<th>상세</th>
							<th>update</th>
							<th>create</th>
							<th>Edit <img src="<%=request.getContextPath()%>/assets/img/edit.png" style="width:25px"></th>
							<th>Delete <img src="<%=request.getContextPath()%>/assets/img/delete2.png" style="width:25px"></th>
						</tr>
					</thead>
					<tbody>
						<!-- 모델데이터 categoryList 출력 -->
						<%
							for(Category c:categoryList){
						%>
								<tr>
									<td><%=c.getCategoryNo()%></td>
									<td><%=c.getCategoryKind()%></td>
									<td><%=c.getCategoryName()%></td>
									<td><%=c.getUpdatedate()%></td>
									<td><%=c.getCreatedate()%></td>
									<td><a href="<%=request.getContextPath()%>/admin/categoryListUpdateForm.jsp?categoryNo=<%=c.getCategoryNo()%>" class="btn btn-sm btn-dark">수정</a></td>
									<td><a href="<%=request.getContextPath()%>/admin/categoryListDeleteAction.jsp?categoryNo=<%=c.getCategoryNo()%>" class="btn btn-sm btn-dark">삭제</a></td>
								</tr>			
						<%
							}
						%>
					</tbody>
				</table>
			</div>
			
		</div>
	</section>
</body>
</html>