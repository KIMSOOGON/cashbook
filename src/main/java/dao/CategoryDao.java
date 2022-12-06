package dao;

import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// admin -> 카테고리 수정액션 (호출 : categoryListUpdateAction.jsp)
	public int updateCategoryName(Category category) {
		int row = 0;
		
		String sql = "UPDATE category"
					+ " SET category_name = ?, category_kind = ?"
					+ " WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setString(2, category.getCategoryKind());
			stmt.setInt(3, category.getCategoryNo());
			
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// admin -> 카테고리 수정폼 (호출 : categoryListUpdateForm.jsp)
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind"
					+ " FROM category"
					+ " WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryKind(rs.getString("categoryKind"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return category;
	}
	
	// admin -> 카테고리삭제 (호출 : categoryListDeleteAction.jsp)
	public int deleteCategory(int categoryNo) {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// admin -> 카테고리추가 (호출 : categoryListInsertAction.jsp)
	public int insertCategory(Category category) {
		int insertRow = 0;
		
		String sql = "INSERT INTO category ("
					+ " category_kind"
					+ ", category_name"
					+ ", updatedate"
					+ ", createdate"
					+ ") VALUES (?,?,CURDATE(),CURDATE())";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			insertRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return insertRow;
	}
	
	// admin -> 카테고리관리 -> 카테고리목록 불러오기 (호출 : categoryList.jsp)
	public ArrayList<Category> selectCategoryListByAdmin() {
		ArrayList<Category> categoryList = null;
		categoryList = new ArrayList<Category>();
		
		
		
		String sql = "SELECT"
					+ "	 category_no categoryNo"
					+ "	, category_kind categoryKind"
					+ "	, category_name categoryName"
					+ "	, updatedate"
					+ "	, createdate"
					+ " FROM category";
	
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 절의 순서
				c.setCategoryName(rs.getString("categoryName"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setUpdatedate(rs.getString("updatedate")); // db날짜 타입이지만 자바에선 문자열 타입
				c.setCreatedate(rs.getString("createdate"));
				categoryList.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return categoryList;
	}
	
	// cash 입력시 (호출 : cashDateList.jsp)
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category ORDER BY category_kind ASC";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setCategoryKind(rs.getString("categoryKind"));
				categoryList.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return categoryList;
	}
}
