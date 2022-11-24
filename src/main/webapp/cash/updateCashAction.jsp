<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 C
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
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// 공백, 돌려보내기
	if(request.getParameter("categoryNo")==null||request.getParameter("cashDate")==null || request.getParameter("cashPrice")==null || request.getParameter("cashMemo")==null
		||request.getParameter("categoryNo").equals("")||request.getParameter("cashDate").equals("")||request.getParameter("cashPrice").equals("")){
		String msg = URLEncoder.encode("비용을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date+"&cashNo="+cashNo);
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	Cash paramCash = new Cash();
	paramCash.setCashNo(cashNo);
	paramCash.setCategoryNo(categoryNo);
	paramCash.setCashDate(cashDate);
	paramCash.setCashPrice(cashPrice);
	paramCash.setCashMemo(cashMemo);
	
	// 2 M
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.updateCash(paramCash);
	System.out.println("resultRow: "+resultRow);
	if(resultRow==1){
		System.out.println("cash 수정완료");
		String tgtUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl+"?year="+year+"&month="+month+"&date="+date+"&cashNo="+cashNo);
		return;
	} else {
		System.out.println("cash 수정에러");
	}
%>