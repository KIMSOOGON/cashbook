<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.*"%>
<%@ page import="java.sql.*"%>
<%
	// 1 Controller
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryPrice = request.getParameter("categoryPrice");
	String categoryMemo = request.getParameter("categoryMemo");
	
	// 2 Model
	// db 접속
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// INSERT 쿼리
	String cashSql = "INSERT INTO cash(category_no, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?,?,?,?,curdate(),curdate())";
	PreparedStatement stmt = conn.prepareStatement(cashSql);
	
	stmt.setInt(1, categoryNo);
	stmt.setInt(2, categoryNo);
	stmt.setInt(3, categoryNo);
	stmt.setInt(4, categoryNo);
%>

