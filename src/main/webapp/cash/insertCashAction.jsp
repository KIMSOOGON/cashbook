<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 controller
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	
	// 공백, 돌려보내기
	if(request.getParameter("categoryNo")==null||request.getParameter("cashDate")==null || request.getParameter("cashPrice")==null || request.getParameter("cashMemo")==null
		||request.getParameter("categoryNo").equals("")||request.getParameter("cashDate").equals("")||request.getParameter("cashPrice").equals("")){
		String msg = URLEncoder.encode("비용을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
		
	// 입력값 request로 받아오기
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String memberId = loginMember.getMemberId();
	String cashDate = request.getParameter("cashDate");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	// request로 받아온 값들 Cash클래스로 읽기
	Cash paramCash = new Cash();
	paramCash.setCategoryNo(categoryNo);
	paramCash.setMemberId(memberId);
	paramCash.setCashDate(cashDate);
	paramCash.setCashPrice(cashPrice);
	paramCash.setCashMemo(cashMemo);
	
	// 2 model
	// CashDao 불러오기
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.insertCash(paramCash);
	if(resultRow==1){
		System.out.println("가계부 추가 완료");
		String tgtUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl+"?year="+year+"&month="+month+"&date="+date);
		return;
	} else {
		System.out.println("가계부 추가 에러");
	}
%>