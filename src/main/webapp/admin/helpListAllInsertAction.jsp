<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%	// Controller	
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	
	// 로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[helpListAllInsertAction 진입]");
	
	// insert하기위해 필요한 값 3개 (helpNo, CommentMemo, MemberId)
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");
	String memberId = loginMember.getMemberId();
	System.out.println("helpNo : "+helpNo);
	System.out.println("commentMemo : "+commentMemo);
	System.out.println("memberId(답변자) : "+memberId);
	
	// 답변 미입력 시, 되돌아가기
	if(commentMemo==null||commentMemo.equals("")){
		System.out.println("답변내용을 입력해주세요");
		String rtnUrl = "/admin/helpListAllInsertForm.jsp";
		response.sendRedirect(request.getContextPath()+rtnUrl+"?helpNo="+helpNo);
		return;
	}
	
	// Comment 클래스에 넣어주기
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	
	// CommentDao에서 insert 메서드 불러오기
	CommentDao commentDao = new CommentDao();
	int insertRow = commentDao.insertComment(comment);
	
	if(insertRow==1){ // 디버깅
		System.out.println("답변 추가 完");
		String tgtUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("답변 추가 실패");
	}
%>