<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	
	// parameter값 받아오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	System.out.println("[공문updateAction페이지]-noticeNo : "+noticeNo);
	
	String falseUrl = "/admin/noticeListUpdateForm.jsp";
	String successUrl = "/admin/noticeList.jsp";
	
	// 내용 공백일 시, 돌려보내기
	if(noticeMemo==null||noticeMemo.equals("")){
		System.out.println("(1)내용을 입력하세요");
		String msg = URLEncoder.encode("내용을 입력하세요.","utf-8");
		response.sendRedirect(request.getContextPath()+falseUrl
			+"?msg="+msg+"&noticeNo="+noticeNo+"&noticeMemo="+noticeMemo);
		return;
	}
	
	// parameter값 Notice클래스로 setter하기
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(noticeMemo);
	
	// 2 Model
	// 수정 메서드 불러오기 (NoticeDao)
	NoticeDao noticeDao = new NoticeDao();
	int updateRow = noticeDao.updateNotice(notice);
	
	if(updateRow ==1){ // 수정성공
		System.out.println("(2)공문수정 完");
		response.sendRedirect(request.getContextPath()+successUrl);
		return;
	}
%>