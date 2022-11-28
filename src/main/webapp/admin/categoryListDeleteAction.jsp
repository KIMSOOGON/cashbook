<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 1 Controller
	System.out.println("[카테고리 Delete Action]");
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));	
	
	String tgtUrl = "/admin/categoryList.jsp";
	
	// 2 Model
	CategoryDao categoryDao = new CategoryDao();
	int deleteRow = categoryDao.deleteCategory(category.getCategoryNo());
	
	if(deleteRow == 1){
		System.out.println("카테고리 삭제 完");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	}
%>