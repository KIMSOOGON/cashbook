<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//Controller	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("[카테고리 update Form]");
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println("카테고리 넘버 : "+categoryNo);
	
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = categoryDao.selectCategoryOne(categoryNo);
	
	System.out.println("카테고리 넘버 : "+category.getCategoryNo());
	System.out.println("카테고리 종류 : "+category.getCategoryKind());
	System.out.println("카테고리 이름 : "+category.getCategoryName());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-CategoryList-update</title>

	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
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
	
	<!-- categoryList Insert -->
	<section id="pricing" class="pricing">
		<div class="container">
			<div class="section-title">
				<span>Update Category</span>
				<h1>Update Category</h1>
				<p>카테고리 수정</p>
			</div>
		</div>
	</section>
	
	<!-- category 수정 폼 -->
	<section id="contact" class="contact py-1">
		<div class="container pt-5 col-lg-6 text-center bg-light shadow">
			<form action="<%=request.getContextPath()%>/admin/categoryListUpdateAction.jsp">
				<div class="shadow">
					<div class="form-group mt-3 row">
						<div class="col">categoryNo</div>
						<div class="col">
							<input type="text" name="categoryNo" value="<%=categoryNo%>" readonly="readonly">
						</div>
					</div>
					<div class="form-group mt-3 row">
						<div class="col">categoryKind</div>
						<div class="col">
							<%
								if((category.getCategoryKind()).equals("지출")){
							%>		
									<input type="radio" name="categoryKind" value="지출" checked>지출
									<input type="radio" name="categoryKind" value="수입">수입	
							<%		
								} else {
							%>		
									<input type="radio" name="categoryKind" value="지출">지출
									<input type="radio" name="categoryKind" value="수입" checked>수입	
							<%		
								}
							%>
						</div>
					</div>
					<div>
						<div class="form-group mt-3 row">
							<div class="col">categoryName</div>
							<div class="col">
								<input type="text" name="categoryName" value="<%=category.getCategoryName()%>">
							</div>
						</div>
						<div>
							<%	// 공백 입력 시, 문장 출력 ("카테고리명을 입력해주세요")
								String msg = request.getParameter("msg");
								if(msg!=null){
							%>
									<%=msg%>
							<%
								}
							%>
						</div>
					</div>
				</div>
				<div class="text-center my-3"><button type="submit" class="my-3 btn btn-lg btn-danger">수정</button></div>
			</form>
		</div>
	</section>
</body>
</html>