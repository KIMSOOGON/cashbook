<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
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
		<span class="text-danger container px-4">Manager Page</span>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-sm text-primary">내 가계부</a>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-sm text-secondary">공지관리</a>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-sm text-secondary">고객센터관리</a>
		<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-sm text-secondary">카테고리관리</a>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-sm text-secondary">멤버관리(목록, 레벨수정, 강퇴)</a>
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-sm text-warning">LOG-OUT</a>
	</div>
</div>