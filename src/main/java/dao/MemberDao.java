package dao;

import vo.Member;
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
			resultMember.setMemberPw(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
		}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		return resultRow;
	}
}
