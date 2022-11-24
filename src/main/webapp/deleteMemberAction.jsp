<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	
	//session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");

	// log-in 상태가 아닐경우 loginForm으로 돌려보내기
	if(loginMember == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	String memberPwCheck = loginMember.getMemberPw();
	System.out.println("deleteMemberForm에서 입력한 패스워드값 : "+memberPw);
	
	String tgtUrl = "/deleteMemberForm.jsp";
	String sccUrl = "/loginForm.jsp";
	
	// Pw값이 공백일 경우 돌려보내기
	if(memberPw==null || memberPw.equals("")){
		System.out.println("패스워드를 입력하세요");
		String pwMsg = URLEncoder.encode("패스워드를 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+tgtUrl+"?pwMsg="+pwMsg);
		return;
	}
	
	// PW값이 일치하지 않을 경우 돌려보내기
	if(!memberPw.equals(memberPwCheck)){
		System.out.println("패스워드가 다릅니다");
		String ckMsg = URLEncoder.encode("패스워드가 다릅니다","utf-8");
		response.sendRedirect(request.getContextPath()+tgtUrl+"?ckMsg="+ckMsg);
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.deleteMember(paramMember);
	if(resultRow == 1){
		System.out.println("회원탈퇴 성공");
		response.sendRedirect(request.getContextPath()+sccUrl);
		return;
	} else {
		System.out.println("회원탈퇴 실패");
	}
	
	
%>