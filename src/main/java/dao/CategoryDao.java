package dao;

import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception{
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category ORDER BY category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryKind(rs.getString("categoryKind"));
			categoryList.add(c);
		}
		
		// ORDER BY kind
		return categoryList;
	}
}
