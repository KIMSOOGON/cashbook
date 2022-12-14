<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%	
	// Controller	
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	
	// 로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[helpListAllUpdateAction 진입]");
	
	// parameter값 받아오기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");

	// Comment class에 넣어주기
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	
	// update 메서드 불러오기
	CommentDao commentDao = new CommentDao();
	int updateRow = commentDao.updateComment(comment);
	
	if(updateRow == 1){ // 디버깅
		System.out.println("답변 수정 完");
		String tgtUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>