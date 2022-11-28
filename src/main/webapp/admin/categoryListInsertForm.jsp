<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "<%=request.getContextPath()%>/admin/categoryListInsertAction.jsp" method="post">
		<!--  -->
		<div>categoryKind
			<input type="radio" name="categoryKind" value="수입">수입
			<input type="radio" name="categoryKind" value="지출">지출
		</div>
		<div>
			categoryName
			<input type="text" name="categoryName">
		</div>
		<div>
			<button type="submit">등록</button> 
		</div>
	</form>
</body>
</html>