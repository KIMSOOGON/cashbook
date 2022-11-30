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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	<div>
		<!-- categoryList Content -->
		<h1>카테고리 목록</h1>
		<a href="<%=request.getContextPath()%>/admin/categoryListInsertForm.jsp">카테고리 추가</a>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>수입/지출</th>
				<th>이름</th>
				<th>최신수정날짜</th>
				<th>생성날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
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
						<td><a href="<%=request.getContextPath()%>/admin/categoryListUpdateForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/categoryListDeleteAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
					</tr>			
			<%
				}
			%>
		</table>
	</div>
</body>
</html>