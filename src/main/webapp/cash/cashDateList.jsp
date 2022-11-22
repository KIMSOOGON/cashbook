<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%
	// 1 controller
	// log-in session
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// 2 model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = new ArrayList<Category>();

	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(),year,month,date);
	
	// 3 view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
</head>
<body>
	<h1><%=year%>년 <%=month%>월 <%=date%>일 상세페이지</h1>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<td>categoryNo</td>
				<td>
					<select name="categoryNo">
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
				</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td>
					<input type="date" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	<hr>
	<!-- cash 목록 출력 -->
	<table border="1">
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>
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
				<td><a href="">수정</a></td>
				<td><a href="">삭제</a></td>
			</tr>	
	<%		
		}
	%>
	</table>
	<hr>
</body>
</html>