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
		
		// 로그인 쿼리 (id 및 pw 검증) (호출 : loginAction.jsp)
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId()); // 매개변수(paramMember)로 들어온 id
		stmt.setString(2, paramMember.getMemberPw()); // 매개변수로 들어온 pw
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // id와 pw 일치한 경우 리턴값 returnMember
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
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
	
	// 회원가입 1) id중복확인 2) 회원가입
	
	// 반환값 t : 이미존재, f : 사용가능
	// id 중복체크 (호출 : insertMemberAction.jsp)
	public boolean checkId(String memberId) throws Exception{
		boolean result = false;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, memberId);
		
		ResultSet idRs = idStmt.executeQuery();
		
		if(idRs.next()) { // 중복이 있을 시,
			result = true;
		}
		dbUtil.close(idRs, idStmt, conn);
		return result;
	}
	
	// 회원가입 (호출 : insertMemberAction.jsp)
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// INSERT 쿼리문
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate)"
						+ "VALUES(?,PASSWORD(?),?,curdate(),curdate())";
		PreparedStatement memberStmt = conn.prepareStatement(memberSql);
		memberStmt.setString(1, paramMember.getMemberId());
		memberStmt.setString(2, paramMember.getMemberPw());
		memberStmt.setString(3, paramMember.getMemberName());
		
		resultRow = memberStmt.executeUpdate();
		
		dbUtil.close(null, memberStmt, conn);
		return resultRow;
	}
	
	// 회원정보수정하기 (1) id & pw 확인 (호출 : updateMemberAction.jsp)
	public boolean checkMember(Member paramMember) throws Exception{
		boolean result = false;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String idSql = "SELECT member_id FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, paramMember.getMemberId());
		idStmt.setString(2, paramMember.getMemberPw());
		
		ResultSet idRs = idStmt.executeQuery();
		
		if(idRs.next()) { // 중복이 있을 시,
			result = true;
		} 
		idRs.close();
		idStmt.close();
		conn.close();
		return result;
	}
		
	
	// 회원정보수정하기 (2) pw 및 이름 바꾸기 (호출 : updateMemberAction.jsp)
	public int updateMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String upSql = "UPDATE member set member_pw=PASSWORD(?), member_name=? WHERE member_id=?";
		PreparedStatement upStmt = conn.prepareStatement(upSql);
		upStmt.setString(1,  paramMember.getMemberPw());
		upStmt.setString(2,  paramMember.getMemberName());
		upStmt.setString(3,  paramMember.getMemberId());
		
		resultRow = upStmt.executeUpdate();
		upStmt.close();
		conn.close();
		return resultRow;
	}
	
	// 회원탈퇴하기 (호출 : deleteMemberAction.jsp)
	public int deleteMember(Member paramMember) throws Exception{
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String dtSql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement dtStmt = conn.prepareStatement(dtSql);
		dtStmt.setString(1, paramMember.getMemberId());
		dtStmt.setString(2, paramMember.getMemberPw());
		
		resultRow = dtStmt.executeUpdate();
		
		dbUtil.close(null, dtStmt, conn);
		return resultRow;
	}
}