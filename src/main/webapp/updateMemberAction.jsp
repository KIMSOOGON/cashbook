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
	
	// 입력정보 받아오기
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String newMemberPw = request.getParameter("newMemberPw");
	String newMemberPwCheck = request.getParameter("newMemberPwCheck");
	String memberName = request.getParameter("memberName");
	System.out.println("memberId : "+memberId);
	System.out.println("memberPw : "+memberPw);
	System.out.println("newMemberPw : "+newMemberPw);
	System.out.println("newMemberPwCheck : "+newMemberPwCheck);
	System.out.println("memberName : "+memberName);
	
	String tgtUrl = "/updateMemberForm.jsp";
	String clUrl = "/cash/cashList.jsp";
	
	// 누락항목여부 확인 후 돌려보내기
	if(memberPw==null||newMemberPw==null||newMemberPwCheck==null||memberName==null
		||memberPw.equals("")||newMemberPw.equals("")||newMemberPwCheck.equals("")||memberName.equals("")){
		System.out.println("누락된 항목이 있습니다");
		String msg = URLEncoder.encode("빈 항목을 채워주세요","utf-8");
		response.sendRedirect(request.getContextPath()+tgtUrl+"?msg="+msg);
		return;
	}
	
	// 새 비밀번호 확인 일치여부
	if(!newMemberPw.equals(newMemberPwCheck)){
		System.out.println("새 비밀번호가 일치하지 않습니다.");
		String ckMsg = URLEncoder.encode("새 비밀번호가 일치하지 않습니다","utf-8");
		response.sendRedirect(request.getContextPath()+tgtUrl);
	} 
	
	// 2 Model
	
	// 아이디 및 비밀번호 확인 여부를 위한 member 객체 생성
	// paramMemberX에 입력된 memberId, memberPw를 넣어주기
	Member paramMemberX = new Member();
	paramMemberX.setMemberId(memberId);
	paramMemberX.setMemberPw(memberPw);
	
	// 비밀번호 및 이름 변경을 위한 member 객체 생성 (새로운 비밀번호 대입)
	Member paramMemberY = new Member();
	paramMemberY.setMemberId(memberId);
	paramMemberY.setMemberPw(newMemberPw);
	paramMemberY.setMemberName(memberName);
	
	// MemberDao에서 계정확인 및 수정 메서드 불러오기
	// 계정확인 (id 및 pw 확인)
	MemberDao memberDao = new MemberDao();
	boolean checkMember = memberDao.checkMember(paramMemberX);
	System.out.println(checkMember);
	if(checkMember){ // 계정 일치 시(true), Pw 및 Name 수정 메서드 진행
		int resultRow = memberDao.updateMember(paramMemberY);
		if(resultRow==1){
			System.out.println("수정성공");
			loginMember.setMemberName(memberName);
			response.sendRedirect(request.getContextPath()+clUrl);
			return;
		} else {
			System.out.println("수정실패");
			return;
		}
	} else { // 계정 불일치, 아이디 및 패스워드 재확인 바람문구 리턴
		System.out.println("아이디 및 패스워드 불일치");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>