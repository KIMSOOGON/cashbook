<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%	// Controller : session, request
	if(session.getAttribute("loginMember") == null){ // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
	a {
		text-decoration : none; 
	}
</style>
<div style="background-color:rgb(30,35,40)">
	<div class="container text-start rounded py-2 px-2" style="background-color:rgb(40,40,35)">
		<span class="text-white container px-4">INDEX</span>
		<%
			if(loginMember.getMemberLevel()>0){
		%>		
				<a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="btn btn text-danger">관리자 페이지</a>	
		<%		
			}
		%>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-sm text-secondary">가계부 캘린더</a>
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp" class="btn btn-sm text-secondary">회원정보수정</a>
		<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="btn btn-sm text-secondary">고객센터</a>
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-sm text-warning">LOG-OUT</a>
		<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp" class="btn btn-sm text-warning">회원탈퇴</a>
	</div>
</div>