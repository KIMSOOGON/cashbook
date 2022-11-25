<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Controller
	// 관리자 session
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	System.out.println("관리자모드-멤버관리");
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("현재페이지:"+currentPage);	
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;

	// Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 회원 총원 및 끝페이지 구하기
	int cntMember = memberDao.selectMemberCount();
	int lastPage = cntMember / rowPerPage;
	if((cntMember % rowPerPage) != 0){
		lastPage = lastPage + 1;
	}
	
	ArrayList<Member>list = memberDao.selectMemberListByPage(beginRow,rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- memberList Content -->
		<h1>멤버목록</h1>
		<table>
			<tr>
				<th>멤버변호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>최신수정일자</th>
				<th>가입일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list){
			%>	
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td>
							<a href="">레벨수정</a>
						</td>
						<td><a href="<%=request.getContextPath()%>/admin/memberListDeleteAction.jsp?memberNo=<%=m.getMemberNo()%>">강제탈퇴</a></td>
					</tr>
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage>1){
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage<lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">끝</a>
		</div>
	</div>
</body>
</html>