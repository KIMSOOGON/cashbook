<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	// 양식 하나라도 미충족시, 돌려보내기
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
	boolean checkId = memberDao.checkId(paramMember.getMemberId());
	
	// id 중복체크
	if(checkId){ // id 중복일경우 (true인경우)
		String idMsg = URLEncoder.encode("이미 존재하는 아이디입니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idMsg="+idMsg);
		return;
	} else {
		int resultRow = memberDao.insertMember(paramMember);
		if(resultRow == 1){
			System.out.println("회원가입 성공");
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else {
			System.out.println("회원가입 실패");
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
			return;
		}
	}
%>