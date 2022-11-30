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
	<h1>[카테고리 추가]</h1>
	<form action = "<%=request.getContextPath()%>/admin/categoryListInsertAction.jsp" method="post">
		<!--  -->
		<div>categoryKind
			<input type="radio" name="categoryKind" value="수입">수입
			<input type="radio" name="categoryKind" value="지출">지출
		</div>
		<div>
			categoryName
			<input type="text" name="categoryName">
			<%	// 공백 입력 시, 문장 출력 "카테고리 이름을 입력하세요"
				String msg = request.getParameter("msg");
				if(msg!=null){
			%>		
					<%=msg%>	
			<%		
				}
			%>
		</div>
		<div>
			<button type="submit">등록</button> 
		</div>
	</form>
</body>
</html>