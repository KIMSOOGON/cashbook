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
	System.out.println("deleteMemberForm에서 입력한 패스워드값 : "+memberPw);
	
	String tgtUrl = "/deleteMemberForm.jsp";
	String sccUrl = "/loginForm.jsp";
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.deleteMember(paramMember);
	if(resultRow == 1){
		System.out.println("회원탈퇴 성공");
		String dtMsg = URLEncoder.encode("회원탈퇴되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+sccUrl+"?dtMsg="+dtMsg);
		return;
	} else {
		System.out.println("회원탈퇴 실패, 비밀번호 불일치");
		String ckMsg = URLEncoder.encode("패스워드가 다릅니다","utf-8");
		response.sendRedirect(request.getContextPath()+tgtUrl+"?ckMsg="+ckMsg);
		return;
	}
%>