<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	System.out.println("[helpListAllDeleteAction 진입]");
	// parameter값 받기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));

	CommentDao commentDao = new CommentDao();
	int deleteRow = commentDao.deleteComment(helpNo);
	
	if(deleteRow == 1){
		System.out.println("답변 삭제 完");
		String tgtUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("답변 삭제 실패");
	}
%>