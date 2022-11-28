<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	System.out.println("<관리자모드 진입>");
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	
	// 공지 5개, 멤버 5명 (최신업데이트)
	ArrayList<Notice> NoticeList = noticeDao.selectNoticeListByPage(0,5);
	ArrayList<Member> MemberList = memberDao.selectMemberListByPage(0,5);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>

	<div>
		<!-- adminMain Content -->
		<!-- 공지 -->
		<h2>[최근 공지 5개]</h2>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>공지내용</th>
				<th>공지날짜</th>
			</tr>
			<%
				for(Notice n : NoticeList){
			%>
				<tr>
					<td><%=n.getNoticeNo()%></td>
					<td><%=n.getNoticeMemo()%></td>
					<td><%=n.getCreatedate()%></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
	<div>
		<!-- 멤버 -->
		<h2>[최근 가입회원 5명]</h2>
		<table border="1">
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>최신수정일자</th>
				<th>가입일자</th>
			</tr>
			<%
				for(Member m : MemberList){
			%>
				<tr>
					<td><%=m.getMemberNo()%></td>
					<td><%=m.getMemberId()%></td>
					<td><%=m.getMemberLevel()%></td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getUpdatedate()%></td>
					<td><%=m.getCreatedate()%></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>