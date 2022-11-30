<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//Controller
	// session 로그인 유무 확인
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(memberId); // 로그인 된 memberId 변수에 저장
	
	// 고객센터 문의목록 불러오기
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(memberId);
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
		<jsp:include page="../inc/menu.jsp"></jsp:include>
	</div>
	<h1>고객센터</h1>
	<h3>-<%=memberId%>님의 문의내역-</h3>
	<table border="1">
		<tr>
			<td colspan="3">[문의사항]</td>
			<td colspan="2">[답변내역]</td>
		</tr>
		<tr>
			<!-- 문의란 -->
			<th>Q no.</th>
			<th>문의내용</th>
			<th>작성날짜</th>
			<!-- 답변란 -->
			<th>답변내용</th>
			<th>작성날짜</th>
		</tr>
		<%
			for(HashMap<String,Object> h : list){
		%>
				<tr>
					<td><%=h.get("helpNo")%></td>
					<td><%=h.get("helpMemo")%></td>
					<td><%=h.get("helpCreatedate")%></td>
					<%
						if(h.get("commentMemo")==null){
					%>
							<td>(답변 준비중입니다)</td>
							<td>
								<a href="<%=request.getContextPath()%>/help/updateHelpListForm.jsp?helpNo=<%=h.get("helpNo")%>">수정</a>
								<a href="<%=request.getContextPath()%>/help/deleteHelpListAction.jsp?helpNo=<%=h.get("helpNo")%>">삭제</a>	
							</td>
					<%
						} else {
					%>
							<td><%=h.get("commentMemo")%></td>
							<td><%=h.get("commCreatedate")%></td>
					<%
						}
					%>
				</tr>
		<%
			}
		%>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpListForm.jsp">문의하기</a>
	</div>
</body>
</html>