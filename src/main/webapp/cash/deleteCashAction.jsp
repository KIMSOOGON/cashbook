<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	Cash paramCash = new Cash();
	paramCash.setCashNo(cashNo);
	
	// 2 Model
	CashDao cashDao = new CashDao();
	
	int resultRow = cashDao.deleteCash(paramCash);
	if(resultRow==1){
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	}
%>