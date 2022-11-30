package dao;

import java.util.*;
import vo.*;
import util.*;
import java.sql.*;

public class HelpDao {
	
	// 관리자 고객센터목록 총 개수 (호출 : helpListAll.jsp)
	public int countHelp() throws Exception {
		int countHelp = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) FROM help";
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			countHelp = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		return countHelp;
	}
	
	// 관리자 고객센터목록 selectHelpList 오버로딩 (호출 : helpListAll.jsp)
	public ArrayList<HashMap<String,Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT"
					+ " h.help_no helpNo"
					+ ", h.help_Memo helpMemo"
					+ ", h.member_id memberId"
					+ ", h.createdate helpCreatedate"
					+ ", c.comment_no commentNo"
					+ ", c.comment_memo commentMemo"
					+ ", c.createdate commCreatedate"
					+ " FROM help h LEFT OUTER JOIN comment c"
					+ " ON h.help_no = c. help_no"
					+ " ORDER BY h.createdate DESC"
					+ " LIMIT ?,?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> h = new HashMap<String,Object>();
			h.put("helpNo", rs.getInt("helpNo"));
			h.put("helpMemo", rs.getString("helpMemo"));
			h.put("memberId", rs.getString("memberId"));
			h.put("helpCreatedate", rs.getString("helpCreatedate"));
			h.put("commentMemo", rs.getString("commentMemo"));
			h.put("commCreatedate", rs.getString("commCreatedate"));
			list.add(h);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 고객센터 목록 select (호출 : helpList.jsp)
	public ArrayList<HashMap<String,Object>> selectHelpList(String memberId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		# 1) 답변확인:본인이 올린 문의에 대해서만 
		SELECT h.* , c.*
		FROM help h
			LEFT OUTER JOIN comment c ON h.help_no = c.help_no
		WHERE h.member_id = 'goodee';
		# --> 답변없는 글 -> 수정/삭제 가능하게끔
		*/
		String sql = "SELECT"
					+ " h.help_no helpNo"
					+ ", h.help_Memo helpMemo"
					+ ", h.member_id MemberId"
					+ ", h.updatedate helpUpdatedate"
					+ ", h.createdate helpCreatedate"
					+ ", c.comment_no commentNo"
					+ ", c.comment_memo commentMemo"
					+ ", c.member_id adminId"
					+ ", c.updatedate commUpdatedate"
					+ ", c.createdate commCreatedate"
					+ " FROM help h LEFT OUTER JOIN comment c"
					+ " ON h.help_no = c. help_no"
					+ " WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> h = new HashMap<String,Object>();
			h.put("helpNo", rs.getInt("helpNo"));
			h.put("helpMemo", rs.getString("helpMemo"));
			h.put("helpCreatedate", rs.getString("helpCreatedate"));
			h.put("commentMemo", rs.getString("commentMemo"));
			h.put("commCreatedate", rs.getString("commCreatedate"));
			list.add(h);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// HelpList 문의등록insert (호출 : insertHelpListAction.jsp)
	public int insertHelp(Help help)throws Exception{
		int insertRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		/*
		# 2) help 입력 : member_id는 세션데이터 
		INSERT INTO help(help_memo,memeber_id,updatedate,createdate)
		VALUES(?,?,NOW(),NOW());
		*/
		
		String sql = "INSERT INTO help("
					+"help_memo,member_id,updatedate,createdate"
					+")VALUES(?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		insertRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return insertRow;
	}
	
	// 하나의 문의내용 불러오기 select (호출 : updateHelpListForm.jsp)
	public Help oneHelp(Help paramHelp) throws Exception{
		Help oneHelp = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "SELECT"
					+ " help_memo helpMemo"
					+ ", member_id memberId"
					+ ", createdate"
					+ " FROM help"
					+ " WHERE help_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramHelp.getHelpNo());
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			oneHelp = new Help();
			oneHelp.setHelpMemo(rs.getString("helpMemo"));
			oneHelp.setMemberId(rs.getString("memberId"));
			oneHelp.setCreatedate(rs.getString("createdate"));
		}
		dbUtil.close(rs, stmt, conn);
		return oneHelp;
	}
	
	// 문의수정하기 update (호출 : updateHelpListAction.jsp)
	public int updateHelp(Help help) throws Exception {
		int updateRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "UPDATE help SET help_memo = ? WHERE help_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
		updateRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return updateRow;
	}
	
	// 문의삭제하기 delete (호출 : deleteHelpListAction.jsp)
	public int deleteHelp(Help help) throws Exception{
		int deleteRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM help WHERE help_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, help.getHelpNo());
		deleteRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteRow;
	}
}
