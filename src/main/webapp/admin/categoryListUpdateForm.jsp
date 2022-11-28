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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카테고리 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/categoryListUpdateAction.jsp">
		<table>
			<tr>
				<th>카테고리 번호</th>
				<td><input type="text" name="categoryNo" value="<%=categoryNo%>" readonly="readonly">
			</tr>
			<tr>
				<th>카테고리 종류</th>
				<td>
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
				</td>
			</tr>
			<tr>
				<th>카테고리 이름</th>
				<td>
					<input type="text" name="categoryName" value="<%=category.getCategoryName()%>">
					<%	// 공백 입력 시, 문장 출력 ("카테고리명을 입력해주세요")
						String msg = request.getParameter("msg");
						if(msg!=null){
					%>
							<%=msg%>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>