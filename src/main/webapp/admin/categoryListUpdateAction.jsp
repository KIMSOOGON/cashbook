<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 1 Controller
	System.out.println("[카테고리 update Action]");

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	System.out.println("수정된 카테고리이름 : "+categoryName);
	
	String rtnUrl = "/admin/categoryListUpdateForm.jsp";
	String tgtUrl = "/admin/categoryList.jsp";
	
	// 카테고리 이름 미입력 시, 돌려보내기
	if(categoryName==null||categoryName.equals("")){
		System.out.println("카테고리 이름을 입력하세요");
		String msg = URLEncoder.encode("카테고리명을 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+rtnUrl+"?categoryNo="+categoryNo+"&msg="+msg);
		return;
	}
	
	// 2 Model
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	category.setCategoryKind(categoryKind);
	
	CategoryDao categoryDao = new CategoryDao();
	
	int updateRow = categoryDao.updateCategoryName(category);
	if(updateRow == 1){
		System.out.println("카테고리 수정 完");
		response.sendRedirect(request.getContextPath()+tgtUrl);
		return;
	} else {
		System.out.println("카테고리 수정 실패");
	}
	
%>