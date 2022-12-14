package dao;

import vo.*;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import util.DBUtil;

public class CashDao {	
	
	// 회원별 월별, sum/avg/count 호출하기
		public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year) {
			ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 1차, cash테이블과 category테이블 조인시켜서 필요항목 불러오기
			String t1 = "SELECT"
						+ " cs.cash_no cashNo"
						+ ", cs.member_id memberId"
						+ ", cs.cash_date cashDate"
						+ ", cs.cash_price cashPrice"
						+ ", cg.category_kind categoryKind"
						+ " FROM cash cs"
						+ " INNER JOIN category cg"
						+ " ON cs.category_no = cg.category_no";
			
			// 2차, 수입과 지출에 따라 나누기
			String t2 = "SELECT"
						+ " memberId, cashNo, cashDate"
						+ ", if(categoryKind = '수입', cashPrice, NULL) importCash"
						+ ", if(categoryKind = '지출', cashPrice, NULL) exportCash"
						+ " FROM (" + t1 + ") t1";
			
			// 3차, 집계함수 사용하여 월별 총합/평균/횟수 구하기
			String sql = "SELECT"
						+ " MONTH(t2.cashDate) month"
						+ ", COUNT(t2.importCash) importCnt"
						+ ", IFNULL(SUM(t2.importCash),0) importSum"
						+ ", IFNULL(AVG(t2.importCash),0) importAvg"
						+ ", COUNT(t2.exportCash) exportCnt"
						+ ", IFNULL(SUM(t2.exportCash),0) exportSum"
						+ ", IFNULL(AVG(t2.exportCash),0) exportAvg"
						+ " FROM (" + t2 + ") t2"
						+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
						+ " GROUP BY MONTH(t2.cashDate)"
						+ " ORDER BY MONTH(t2.cashDate)";
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, memberId);
				stmt.setInt(2, year);
				rs = stmt.executeQuery();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("month", rs.getInt("month"));
					m.put("importCnt", rs.getInt("importCnt"));
					m.put("importSum", rs.getInt("importSum"));
					m.put("importAvg", rs.getInt("importAvg"));
					m.put("exportCnt", rs.getInt("exportCnt"));
					m.put("exportSum", rs.getInt("exportSum"));
					m.put("exportAvg", rs.getInt("exportAvg"));
					list.add(m);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					conn.close();
					stmt.close();
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}
	
	
	// 회원별 년도별, sum/avg/count 호출하기
	public ArrayList<HashMap<String, Object>> selectCashListByYear(String memberId) {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 1차, cash테이블과 category테이블 조인시켜서 필요항목 불러오기
		String t1 = "SELECT"
					+ " cs.cash_no cashNo"
					+ ", cs.member_id memberId"
					+ ", cs.cash_date cashDate"
					+ ", cs.cash_price cashPrice"
					+ ", cg.category_kind categoryKind"
					+ " FROM cash cs"
					+ " INNER JOIN category cg"
					+ " ON cs.category_no = cg.category_no";
		
		// 2차, 수입과 지출에 따라 나누기
		String t2 = "SELECT"
					+ " memberId, cashNo, cashDate"
					+ ", if(categoryKind = '수입', cashPrice, NULL) importCash"
					+ ", if(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ " FROM (" + t1 + ") t1";
		
		// 3차, 집계함수 사용하여 년도별 총합/평균/횟수 구하기
		String sql = "SELECT"
					+ " YEAR(t2.cashDate) year"
					+ ", COUNT(t2.importCash) importCnt"
					+ ", IFNULL(SUM(t2.importCash),0) importSum"
					+ ", IFNULL(AVG(t2.importCash),0) importAvg"
					+ ", COUNT(t2.exportCash) exportCnt"
					+ ", IFNULL(SUM(t2.exportCash),0) exportSum"
					+ ", IFNULL(AVG(t2.exportCash),0) exportAvg"
					+ " FROM (" + t2 + ") t2"
					+ " WHERE t2.memberId = ?"
					+ " GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) DESC";
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("importCnt", rs.getInt("importCnt"));
				m.put("importSum", rs.getInt("importSum"));
				m.put("importAvg", rs.getInt("importAvg"));
				m.put("exportCnt", rs.getInt("exportCnt"));
				m.put("exportSum", rs.getInt("exportSum"));
				m.put("exportAvg", rs.getInt("exportAvg"));
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				stmt.close();
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// Min & Max 년도값 호출하기
	public HashMap<String, Object> selectMaxMinYear() {
		HashMap<String, Object> map = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "SELECT"
					+ " (SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
					+ " , (SELECT MAX(YEAR(cash_date)) FROM cash) maxYear"
					+ " FROM DUAL";
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				conn.close();
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	// 호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC; ";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String,Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC; ";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 호출 : insertCashAction.jsp (cash테이블 추가)
	public int insertCash(Cash paramCash) {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String inSql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,curdate(),curdate())";
		PreparedStatement inStmt = null;
		try {
			inStmt = conn.prepareStatement(inSql);
			inStmt.setInt(1, paramCash.getCategoryNo());
			inStmt.setString(2, paramCash.getMemberId());
			inStmt.setString(3, paramCash.getCashDate());
			inStmt.setLong(4, paramCash.getCashPrice());
			inStmt.setString(5, paramCash.getCashMemo());
			
			resultRow = inStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				inStmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 호출 : deleteCashAction.jsp (cash테이블 삭제)
	public int deleteCash(Cash paramCash) {
		int resultRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String dtSql = "DELETE FROM cash WHERE cash_no = ?";
		PreparedStatement dtStmt = null;
		try {
			dtStmt = conn.prepareStatement(dtSql);
			dtStmt.setInt(1, paramCash.getCashNo());
			
			resultRow = dtStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dtStmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 호출 : updateCashForm.jsp (수정을 위한 하나의 cash값 불러오기)
	public Cash oneCash(Cash paramCash) {
		Cash resultCash = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCash.getCashNo());
			stmt.setString(2, paramCash.getMemberId());

			rs = stmt.executeQuery();
			
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultCash;
	}
	
	// 호출 : updateCashAction.jsp (cash값 수정하기)
	public int updateCash(Cash paramCash) {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String upSql = "UPDATE cash set category_no=?, cash_date=?, cash_price=?, cash_memo=? WHERE cash_no = ?";
		PreparedStatement upStmt = null;
		try {
			upStmt = conn.prepareStatement(upSql);
			upStmt.setInt(1, paramCash.getCategoryNo());
			upStmt.setString(2, paramCash.getCashDate());
			upStmt.setLong(3, paramCash.getCashPrice());
			upStmt.setString(4, paramCash.getCashMemo());
			upStmt.setInt(5, paramCash.getCashNo());
			
			resultRow = upStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				upStmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
}