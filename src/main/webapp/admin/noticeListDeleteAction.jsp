<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("[noticeListDeleteAction 실행]");
	
	// 2 M
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println("(1)삭제할 공문번호 : "+noticeNo);
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	NoticeDao noticeDao = new NoticeDao();
	int deleteNotice = noticeDao.deleteNotice(notice);
	if(deleteNotice==1){
		System.out.println("(2)공문삭제 完");
		String tgtUrl ="/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>