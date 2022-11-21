package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import util.DBUtil;

public class CashDao {
	
	/*
	SELECT
	c.cash_no cashNo
	, c.cash_date cashDate
	, c.cash_price cashPrice
	, c.category_no categoryNo
	, ct.category_kind categoryKind
	, ct.category_name categoryName
	FROM cash c INNER JOIN category ct
	ON c.category_no = ct.category_no
	WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date ASC;
	*/
	
	public ArrayList<HashMap<String,Object>> selectCashListByMonth(int year, int month) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2,  month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("year", rs.getString("year"));
			m.put("year", rs.getString("month"));
			list.add(m);
		}
		
		rs.close();
		conn.close();
		return list;
	}
}
