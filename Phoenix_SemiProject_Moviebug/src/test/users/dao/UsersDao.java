package test.users.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.users.dto.UsersDto;
import test.util.DbcpBean;

public class UsersDao {
	private static UsersDao dao;
	private UsersDao() {}
	public static UsersDao getInstance() {
		if(dao==null) {
			dao=new UsersDao();
		}
		return dao;
	}
	//회원 정보를 DB 에 저장하는 메소드
	   public boolean insert(UsersDto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "INSERT INTO users"
	               + " (name, pwd, email, addr, profile, regdate)"
	               + " VALUES( ?, ?, ?, ?, ?, SYSDATE)";
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getName());
	         pstmt.setString(2, dto.getPwd());
	         pstmt.setString(3, dto.getEmail());
	         pstmt.setString(4, dto.getAddr());
	         pstmt.setString(5, dto.getProfile());
	         //insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
	 //인자로 전달된 회원정보(id, pwd) 가 유효한 정보인지 여부를 리턴하는 메소드
	   public boolean isValid(UsersDto dto) {
	      //아이디 비밀번호가 유효한 정보인지 여부를 담을 지역변수 만들고 초기값 부여
	      boolean isValid=false;
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT email"
	               + " FROM users"
	               + " WHERE email=? AND pwd=?";
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getEmail());
	         pstmt.setString(2, dto.getPwd());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //만일 select 된 row 가 있다면 
	         if (rs.next()) {
	            isValid=true;
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
	      //isValid 에 들어 있는 값을 리턴해 준다. 
	      return isValid;
	   }
	}

