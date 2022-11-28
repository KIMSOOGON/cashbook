<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	System.out.println("[멤버등급변경 Action]");
	String tgtUrl = "/admin/memberList.jsp";
	
	// 등급 미선택 시, 돌려보내기
	if(request.getParameter("memberLevel")==null||request.getParameter("memberLevel").equals("")){
		System.out.println("멤버등급을 선택하세요");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	System.out.println("수정될 멤버 번호 : "+memberNo);
	System.out.println("수정될 멤버 등급 : "+memberLevel);
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	MemberDao memberDao = new MemberDao();
	int updateLevelRow = memberDao.updateMemberLevel(member);
	
	if(updateLevelRow == 1){
		System.out.println("멤버 등급 수정 完");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("멤버 등급 수정 실패");
	}
%>