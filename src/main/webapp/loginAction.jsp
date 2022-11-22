<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
			
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao(); // 모델 메서드
	Member resultMember = memberDao.login(paramMember);
	String redirectUrl = "/loginForm.jsp";

	if(resultMember != null){ // 로그인 성공
		System.out.println("로그인 성공!");
		session.setAttribute("loginMember",resultMember); // session안에 로그인 ID,PW,이름 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl); // 로그인 실패
%>