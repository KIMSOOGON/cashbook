<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 1 Controller
	// 페이징 작업
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 2 Model
	NoticeDao noticeDao = new NoticeDao();
	
	// 공문 총 갯수 구하기
	int countNotice = noticeDao.countNotice();
	System.out.println("loginForm 총 공문 갯수 : "+countNotice);
	
	// 마지막 페이지 구하기
	int lastPage = countNotice / rowPerPage;
	if(countNotice % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	System.out.println("loginForm 공문 마지막 페이지 : "+lastPage);
	
	// 공문 목록 5개씩 정렬 불러오기
	ArrayList<Notice>list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<!-- 공지(5개)목록 페이징 -->
	<div>
		<h1>공문목록</h1>
		<table border="1">
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list){
			%>		
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%		
				}
			%>
		</table>
		<hr>
		<!-- 공문 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
			<%
				if(currentPage>1){
			%>		
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">◀</a>	
			<%		
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage<lastPage){
			%>		
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">▶</a>	
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">끝</a>
		</div>
	</div>
	<hr>
	<!-- 로그인 폼 -->
	<h1>로그인</h1>
	<div>
		<%	// 회원탈퇴 시, 메세지 출력
			String dtMsg = request.getParameter("dtMsg");
			if(dtMsg!=null){
		%>
				<%=dtMsg%>
		<%
			}
		%>
	</div>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">로그인</button>
				</td>
			</tr>
		</table>
	</form>
	<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">
		회원가입
	</a>
</body>
</html>