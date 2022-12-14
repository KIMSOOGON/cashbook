<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	System.out.println("[updateHelpListAciont 진입]");
	
	// parameter값 받아오기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	int updateRow = helpDao.updateHelp(help);
	
	if(updateRow==1){
		System.out.println("문의내용 수정 完");
		String tgtUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>