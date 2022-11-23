<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 C
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 입력정보 받아오기
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String newMemberPw = request.getParameter("newMemberPw");
	String newMemberPwCheck = request.getParameter("newMemberPwCheck");
	String memberName = request.getParameter("memberName");

	// 누락항목여부 확인 후 돌려보내기
	if
	
	// 새 비밀번호 확인 일치여부
	if(!newMemberPw.equals(newMemberPwCheck)){
		System.out.println("새 비밀번호가 일치하지 않습니다.");
		String ckMsg = URLEncoder.encode("새 비밀번호가 일치하지 않습니다","utf-8");
		String tgtUrl = "/updateMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
	} 
	
	// 2 M
%>