package moviebug.users.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import moviebug.users.dto.UsersDto;
import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class UsersDao {
	private static UsersDao dao;
	private UsersDao() {}
	public static UsersDao getInstance() {
		if(dao==null) {
			dao = new UsersDao();
		}
		return dao;
	}
	   
		// 사용자 정보 가져오기
		public UsersDto getUser(String email) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			UsersDto dto = new UsersDto();
			
			try {
				conn = new DbcpBean().getConn();
				// 실행할 sql 문 작성

				String sql = "select name,email,addr,profile,regdate "
						+ " from users "
						+ " where email = ?";
				pstmt = conn.prepareStatement(sql);
				// 바인딩
				pstmt.setString(1, email);

				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setEmail(rs.getString("email"));
					dto.setName(rs.getString("name"));
					dto.setProfile(rs.getString("profile"));
					dto.setRegdate(rs.getString("regdate"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			
			return dto;
		}
		
	public boolean delete(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "DELETE FROM users"
					+ " WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 비밀번호를 수정하는 메소드
		public boolean updatePwd(UsersDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				String sql = "UPDATE users"
						+ " SET pwd=?"
						+ " WHERE email=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getPwd());
				pstmt.setString(2, dto.getEmail());
				flag = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}
			if (flag > 0) {
				return true;
			} else {
				return false;
			}
		}
	
	public boolean updateAddr(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "UPDATE users"
					+ " SET addr=?"
					+ " WHERE email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getAddr());
			pstmt.setString(2, dto.getEmail());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean updateProfile(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "UPDATE users"
					+ "	SET profile = ?"
					+ " WHERE email = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getProfile());
			pstmt.setString(2, dto.getEmail());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean updateName(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "UPDATE users"
					+ " SET name=?"
					+ " WHERE email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 인자로 전달된 아이디에 해당하는 정보를 리턴하는 메소드
		public UsersDto getData(String email) {
			UsersDto dto = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				// Connection 객체의 참조값 얻어오기
				conn = new DbcpBean().getConn();
				// 실행할 sql 문 작성
				String sql = "SELECT pwd, name, addr, profile, regdate"
						+ " FROM users"
						+ " WHERE email = ?";
				// PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				// ? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, email);
				// select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				// 반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
				while (rs.next()) {
					dto = new UsersDto();
					dto.setName(rs.getString("name"));
					dto.setPwd(rs.getString("pwd"));
					dto.setEmail(email);
					dto.setAddr(rs.getString("addr"));
					dto.setProfile(rs.getString("profile"));
					dto.setRegdate(rs.getString("regdate"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}
			return dto;
		}
	
	// 인자로 전달된 회원정보(email, pwd) 가 유효한 정보인지 여부를 리턴하는 메소드
		public boolean isValid(UsersDto dto) {
			// 아이디 비밀번호가 유효한 정보인지 여부를 담을 지역변수 만들기
			boolean isValid = false;
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				// Connection 객체의 참조값 얻어오기
				conn = new DbcpBean().getConn();
				// 실행할 sql 문 작성
				String sql = "SELECT email"
						+ " FROM users"
						+ " WHERE email=? AND pwd=?";
				// PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				// ? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, dto.getEmail());
				pstmt.setString(2, dto.getPwd());
				// select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				// 반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
				while (rs.next()) {
					isValid = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}
			return isValid;
		}
	
		public boolean isNameExist(String name) {
			boolean isExist = false;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				// Connection 객체의 참조값 얻어오기
				conn = new DbcpBean().getConn();
				// 실행할 sql 문 작성
				String sql = "SELECT name"
						+ " FROM users"
						+ " WHERE name = ?";
				// PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				// ? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, name);
				// select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				// 반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
				if (rs.next()) {
					isExist = true; // 이미 존재한다고 표시
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {}
			}
			return isExist;
		}	
		
	public boolean isExist(String email) {
		boolean isExist = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = "SELECT email"
					+ " FROM users"
					+ " WHERE email = ?";
			// PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, email);
			// select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				isExist = true; // 이미 존재한다고 표시
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {}
		}
		return isExist;
	}
	
	
	public boolean insert(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "INSERT INTO users"
					+ " (name, pwd, email, addr, regdate)"
					+ " VALUES(?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getAddr());
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}