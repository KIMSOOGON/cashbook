package dao;

import vo.Member;

import java.net.URLEncoder;
import util.DBUtil;
import java.sql.*;
public class MemberDao {
	public Member login(Member paramMember) throws Exception { // 예외처리
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 로그인 쿼리 (id 및 pw 검증)
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId()); // 매개변수(paramMember)로 들어온 id
		stmt.setString(2, paramMember.getMemberPw()); // 매개변수로 들어온 pw
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // id와 pw 일치한 경우 리턴값 returnMember
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			rs.close();
			stmt.close();
			conn.close();
			return resultMember;
		}
		rs.close();
		stmt.close();
		conn.close();
		return null;
		}
	
	// id 중복체크
	public boolean checkId(String memberId) throws Exception{
		
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, memberId);
		
		ResultSet idRs = idStmt.executeQuery();
		
		if(idRs.next()) { // 중복이 있을 시,
			idRs.close();
			idStmt.close();
			conn.close();
			return true;
		} else {
			idRs.close();
			idStmt.close();
			conn.close();
			return false;
		}
	}
	
	// 회원가입 호출 : insertMemberForm.jsp
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// INSERT 쿼리문
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,?,?,curdate(),curdate())";
		PreparedStatement memberStmt = conn.prepareStatement(memberSql);
		memberStmt.setString(1, paramMember.getMemberId());
		memberStmt.setString(2, paramMember.getMemberPw());
		memberStmt.setString(3, paramMember.getMemberName());
		
		resultRow = memberStmt.executeUpdate();
		return resultRow;
	}
}
