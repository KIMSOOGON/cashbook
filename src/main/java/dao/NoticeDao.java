package dao;

import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// 공지목록 정렬 (호출 : loginForm.jsp)
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,  beginRow);
		stmt.setInt(2,  rowPerPage);		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// Notice Count 공문갯수 구하기 (호출 : loginForm.jsp)
	public int countNotice() throws Exception {
		int countNotice = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			countNotice = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		return countNotice;
	}
	
	// 삭제 (호출 : noticeListDeleteAction.jsp)
	public int deleteNotice(Notice notice) throws Exception{
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		
		int deleteRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteRow;
	}
	
	//  수정 (호출 : noticeListUpdateAction.jsp)
	public int updateNotice(Notice notice) throws Exception{
		int updateRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		
		updateRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return updateRow;
	}
	
	// 삽입 (호출 : noticeListInsertAction.jsp)
	public int insertNotice(Notice notice) throws Exception{
		int insertRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		
		insertRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return insertRow;
	}
}
