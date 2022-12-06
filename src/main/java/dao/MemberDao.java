package dao;

import vo.Member;

import java.net.URLEncoder;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
public class MemberDao {
	// 관리자 : 멤버 레벨수정
	public int updateMemberLevel(Member member) {
		int updateLevelRow = 0;
		
		String sql = "UPDATE member"
					+ " SET member_level = ?"
					+ " WHERE member_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null; 
		
		conn = dbUtil.getConnection();
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			
			updateLevelRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return updateLevelRow; 
	}
	
	// 관리자 멤버수 (호출 : memberList.jsp)
	public int selectMemberCount() {
		int cntMember = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM member";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				cntMember = rs.getInt("COUNT(*)");
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
		return cntMember;
	}
	
	// 관리자 멤버 리스트 (호출 : memberList.jsp)
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate"
					+ " FROM member ORDER BY createdate DESC"
					+ " LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
				list.add(m);
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
		return list;
	}
	// 관리자 멤버 강퇴 (호출 : memberListDeleteAction.jsp)
	public int deleteMemberByAdmin(Member member) {
		int deleteRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM member WHERE member_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
			
			deleteRow = stmt.executeUpdate();
		} catch (SQLException e) {
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
	
	public Member login(Member paramMember) { // 예외처리
		Member resultMember = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 로그인 쿼리 (id 및 pw 검증) (호출 : loginAction.jsp)
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName, createdate FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);stmt.setString(1, paramMember.getMemberId()); // 매개변수(paramMember)로 들어온 id
			stmt.setString(2, paramMember.getMemberPw()); // 매개변수로 들어온 pw
			rs = stmt.executeQuery();
			if(rs.next()) { // id와 pw 일치한 경우 리턴값 returnMember
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setCreatedate(rs.getString("createdate"));
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
		return resultMember;
		}
	
	// 회원가입 1) id중복확인 2) 회원가입
	
	// 반환값 t : 이미존재, f : 사용가능
	// id 중복체크 (호출 : insertMemberAction.jsp)
	public boolean checkId(String memberId) {
		boolean result = false;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement idStmt = null;
		ResultSet idRs = null;
		try {
			idStmt = conn.prepareStatement(idSql);
			idStmt.setString(1, memberId);
			
			idRs = idStmt.executeQuery();
			
			if(idRs.next()) { // 중복이 있을 시,
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(idRs, idStmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 회원가입 (호출 : insertMemberAction.jsp)
	public int insertMember(Member paramMember) {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// INSERT 쿼리문
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate)"
						+ "VALUES(?,PASSWORD(?),?,curdate(),curdate())";
		PreparedStatement memberStmt = null;
		try {
			memberStmt = conn.prepareStatement(memberSql);
			memberStmt.setString(1, paramMember.getMemberId());
			memberStmt.setString(2, paramMember.getMemberPw());
			memberStmt.setString(3, paramMember.getMemberName());
			
			resultRow = memberStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, memberStmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 회원정보수정하기 (1) id & pw 확인 (호출 : updateMemberAction.jsp)
	public boolean checkMember(Member paramMember) {
		boolean result = false;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String idSql = "SELECT member_id FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement idStmt = null;
		ResultSet idRs = null;
		try {
			idStmt = conn.prepareStatement(idSql);
			idStmt.setString(1, paramMember.getMemberId());
			idStmt.setString(2, paramMember.getMemberPw());
			
			idRs = idStmt.executeQuery();
			
			if(idRs.next()) { // 중복이 있을 시,
				result = true;
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(idRs, idStmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
		
	
	// 회원정보수정하기 (2) pw 및 이름 바꾸기 (호출 : updateMemberAction.jsp)
	public int updateMember(Member paramMember) {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String upSql = "UPDATE member set member_pw=PASSWORD(?), member_name=? WHERE member_id=?";
		PreparedStatement upStmt = null;
		try {
			upStmt = conn.prepareStatement(upSql);
			upStmt.setString(1,  paramMember.getMemberPw());
			upStmt.setString(2,  paramMember.getMemberName());
			upStmt.setString(3,  paramMember.getMemberId());
			
			resultRow = upStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, upStmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 회원탈퇴하기 (호출 : deleteMemberAction.jsp)
	public int deleteMember(Member paramMember) {
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String dtSql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement dtStmt = null;
		try {
			dtStmt = conn.prepareStatement(dtSql);
			dtStmt.setString(1, paramMember.getMemberId());
			dtStmt.setString(2, paramMember.getMemberPw());
			
			resultRow = dtStmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, dtStmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return resultRow;
	}
}