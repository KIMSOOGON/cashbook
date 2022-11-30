<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	System.out.println("[deleteHelpAdminAction 진입]");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println("삭제할 문의 번호 : "+helpNo);
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	int deleteRow = helpDao.deleteHelp(help);
	
	if(deleteRow==1){
		System.out.println("삭제 完");
		String tgtUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>