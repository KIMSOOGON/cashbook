<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
%>
	<div>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		</ul>
	</div>