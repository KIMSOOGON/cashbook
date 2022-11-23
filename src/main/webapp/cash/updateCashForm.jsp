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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>[수정]</h1>
	<form method="post" action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<div>
			<%
				String msg = request.getParameter("msg");
				if(msg!=null){
			%>		
					<%=msg%>	
			<%		
				}
			%>
		</div>
		<table>
			<tr>
				<th>CategoryNo</th>
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
				<th>cashDate</th>
				<td>
					<input type="date" name="cashDate" value="<%=resultCash.getCashDate()%>">
				</td>
			</tr>
			<tr>
				<th>cashPrice</th>
				<td>
					<input type="number" name="cashPrice" value="<%=resultCash.getCashPrice()%>">
				</td>
			</tr>
			<tr>
				<th>cashMemo</th>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"><%=resultCash.getCashMemo()%></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">수정</button></td>
			</tr>
		</table>
	</form>
</body>
</html>