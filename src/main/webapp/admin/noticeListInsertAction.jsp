<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	request.setCharacterEncoding("utf-8"); // 한글인코딩

	// request 받아와서 notice 클래스로 저장하기
	String noticeMemo = request.getParameter("noticeMemo");
	System.out.println("(1)추가된 공문내용 : "+noticeMemo);
	
	String tgtUrl = "/admin/noticeList.jsp";
	String rtnUrl = "/admin/noticeListInsertForm.jsp";
	
	// parameter값 공백일 경우 되돌리기
	if(noticeMemo==null||noticeMemo.equals("")){
		System.out.println("공문내용 입력 바랍니다.");
		String msg = URLEncoder.encode("내용 입력 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+rtnUrl+"?msg="+msg);
		return;
	}
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);

	// 2 Model
	NoticeDao noticeDao = new NoticeDao();
	int insertRow = noticeDao.insertNotice(notice);
	
	if(insertRow==1){ // 공지 추가 완료된 경우
		System.out.println("(2)공지 추가 完");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("(2)공지 추가 실패");
	}
%>