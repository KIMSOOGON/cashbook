<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	// 양식 미충족시, 돌려보내기
	if(memberId==null||memberPw==null||memberName==null||memberId.equals("")||memberPw.equals("")||memberName.equals("")){
		String msg = URLEncoder.encode("누락된 항목이 있습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	// 2 Model
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.insertMember(paramMember);
	// int idCheck = memberDao.insertMember(paramMember);
	System.out.println("resultRow="+resultRow);
	// System.out.println("idCheck="+idCheck);
	/*
	if(idCheck == 0){ // 아이디가 중복되지 않고
		if(resultRow == 1){
			System.out.println("회원가입 성공");
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} 
	} else {
		System.out.println("ID 중복");
		String checkId = URLEncoder.encode("이미 등록된 아이디 입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?checkId="+checkId);
		return;
	}
	*/
	if(resultRow == 1){
		System.out.println("회원가입 성공");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		System.out.println("중복된ID");
		String checkId = URLEncoder.encode("이미 등록된 아이디 입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?checkId="+checkId);
		return;
	}
%>