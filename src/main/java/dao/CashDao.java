package dao;

import vo.*;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import util.DBUtil;

public class CashDao {	
	
	// 호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC; ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			// System.out.println("★"+m.get("cashNo"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String,Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC; ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}	
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : insertCashAction.jsp (cash테이블 추가)
	public int insertCash(Cash paramCash) throws Exception {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String inSql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,curdate(),curdate())";
		PreparedStatement inStmt = conn.prepareStatement(inSql);
		inStmt.setInt(1, paramCash.getCategoryNo());
		inStmt.setString(2, paramCash.getMemberId());
		inStmt.setString(3, paramCash.getCashDate());
		inStmt.setLong(4, paramCash.getCashPrice());
		inStmt.setString(5, paramCash.getCashMemo());
		
		resultRow = inStmt.executeUpdate();
		
		inStmt.close();
		conn.close();
		return resultRow;
	}
	
	// 호출 : deleteCashAction.jsp (cash테이블 삭제)
	public int deleteCash(Cash paramCash) throws Exception{
		int resultRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String dtSql = "DELETE FROM cash WHERE cash_no = ?";
		PreparedStatement dtStmt = conn.prepareStatement(dtSql);
		dtStmt.setInt(1, paramCash.getCashNo());
		
		resultRow = dtStmt.executeUpdate();
		
		dtStmt.close();
		conn.close();
		return resultRow;
	}
	
	// 호출 : updateCashForm.jsp (수정을 위한 하나의 cash값 불러오기)
	public Cash oneCash(Cash paramCash) throws Exception{
		Cash resultCash = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramCash.getCashNo());
		stmt.setString(2, paramCash.getMemberId());

		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultCash = new Cash();
			resultCash.setCashNo(rs.getInt("cashNo"));
			resultCash.setCategoryNo(rs.getInt("categoryNo"));
			resultCash.setCashDate(rs.getString("cashDate"));
			resultCash.setCashPrice(rs.getLong("cashPrice"));
			resultCash.setCashMemo(rs.getString("cashMemo"));
			rs.close();
			stmt.close();
			conn.close();
			return resultCash;
		}
		rs.close();
		stmt.close();
		conn.close();
		return null;
	}
	
	// 호출 : updateCashAction.jsp (cash값 수정하기)
	public int updateCash(Cash paramCash) throws Exception{
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String upSql = "UPDATE cash set category_no=?, cash_date=?, cash_price=?, cash_memo=? WHERE cash_no = ?";
		PreparedStatement upStmt = conn.prepareStatement(upSql);
		upStmt.setInt(1, paramCash.getCategoryNo());
		upStmt.setString(2, paramCash.getCashDate());
		upStmt.setLong(3, paramCash.getCashPrice());
		upStmt.setString(4, paramCash.getCashMemo());
		upStmt.setInt(5, paramCash.getCashNo());
		
		resultRow = upStmt.executeUpdate();
		upStmt.close();
		conn.close();
		return resultRow;
	}
}








