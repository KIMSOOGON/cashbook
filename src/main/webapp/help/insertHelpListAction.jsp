<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//1 Controller
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	System.out.println("[insertHelpListAction 진입]");	

	//session 로그인 유무 확인
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId); // 로그인 된 memberId 변수에 저장
	
	// parameter값 받아오기
	String helpMemo = request.getParameter("helpMemo");
	String rtnUrl = "/help/insertHelpListForm.jsp";
	String tgtUrl = "/help/helpList.jsp";
	
	// 문의내용 미입력시, 문구출력 및 재입력하게끔 돌려보내기
	if(helpMemo==null||helpMemo.equals("")){
		System.out.println("문의내용이 비었습니다");
		response.sendRedirect(request.getContextPath()+rtnUrl);
		return;
	}
	
	// Help클래스 'help'를 선언 후, 받아온 memo 넣어주기
	Help help = new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	
	// 2 Model 
	// HelpDao에 저장된 insert메서드 실행
	HelpDao helpDao = new HelpDao();
	int insertRow = helpDao.insertHelp(help);
	if(insertRow==1){ // 디버깅
		System.out.println("문의내역 추가 完");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("문의내역 추가 실패");
	}
%>