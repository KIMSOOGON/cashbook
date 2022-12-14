<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1
	request.setCharacterEncoding("utf-8");

	System.out.println("[카테고리 insert Action]");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	System.out.println("categoryKind : "+categoryKind);
	System.out.println("categoryName : "+categoryName);
	
	String rtnUrl = "/admin/categoryListInsertForm.jsp";
	String tgtUrl = "/admin/categoryList.jsp";
	
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	int insertRow = categoryDao.insertCategory(category);
	
	if(insertRow==1){
		System.out.println("카테고리 추가 완료");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("카테고리 추가 실패");
	}
	// 2
%>