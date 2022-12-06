package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DBUtil;
import vo.*;

public class CommentDao {
	
	// 답변등록 (호출 : helpListAllInsertAction.jsp)
	public int insertComment(Comment comment) {
		int insertRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO comment("
					+ "help_no,comment_memo,member_id,updatedate,createdate"
					+ ")VALUES(?,?,?,NOW(),NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	
	// 답변수정 (호출 : helpListAllUpdateAction.jsp)
	public int updateComment(Comment comment) {
		int updateRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "UPDATE comment SET comment_memo = ? WHERE help_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getHelpNo());
			updateRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return updateRow;
	}
	
	// 답변삭제 (호출 : helpListAllDeleteAction.jsp)
	public int deleteComment(int helpNo) {
		int deleteRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM comment WHERE help_no=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			deleteRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return deleteRow;
	}
}
