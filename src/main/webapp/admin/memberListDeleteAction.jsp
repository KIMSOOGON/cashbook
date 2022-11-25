<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//Controller
	// 관리자 session
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("관리자모드-[멤버탈퇴]");
	
	// 2 model
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println("탈퇴시키려는 회원의 번호 : "+memberNo);
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	int deleteRow = memberDao.deleteMemberByAdmin(member);
	if(deleteRow==1){
		System.out.println("해당 회원 탈퇴 完");
		String tgtUrl = "/admin/memberList.jsp";
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>
