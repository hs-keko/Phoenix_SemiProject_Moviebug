package test.free_cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import moviebug.users.dto.UsersDto;
import test.free_cafe.dto.FreeCafeDto;
import test.util.DbcpBean;

public class FreeCafeDao {
   private static FreeCafeDao dao;
   private FreeCafeDao() {}
   public static FreeCafeDao getInstance() {
      if(dao==null) {
         dao=new FreeCafeDao();
      }
      return dao;
   }
   
 //글 목록을 리턴하는 메소드
   public List<FreeCafeDto> userGetList(FreeCafeDto dto){
      List<FreeCafeDto> list=new ArrayList<FreeCafeDto>();
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT *"
         		+ " FROM "
         		+ " (SELECT result1.*, ROWNUM as rnum"
         		+ " FROM"
         		+ " (SELECT free_idx, free_writer, free_title, free_file, free_regdate" + 
         		" FROM board_free" + 
         		" WHERE free_writer = ? " +
         		" ORDER BY board_free.free_idx DESC) result1)"
         		+ " WHERE rnum BETWEEN ? AND ?";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setString(1, dto.getFree_writer());
         pstmt.setInt(2, dto.getStartRowNum());
         pstmt.setInt(3, dto.getEndRowNum());
         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         while (rs.next()) {
            FreeCafeDto dto2=new FreeCafeDto();
            dto2.setFree_idx(rs.getInt("free_idx"));
            dto2.setFree_writer(rs.getString("free_writer"));
            dto2.setFree_title(rs.getString("free_title"));
            dto2.setFree_file(rs.getString("free_file"));
            dto2.setFree_regdate(rs.getString("free_regdate"));
            list.add(dto2);
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
      return list;
   }
   
// 특정유저가 쓴 게시글 전체 row의 갯수 리턴
   public int userGetCount(FreeCafeDto dto) {
	 //글의 갯수를 담을 지역변수 
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS free_idx "
               + " FROM board_free"
               + " WHERE free_writer = ?";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getFree_writer());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         if (rs.next()) {
            count=rs.getInt("free_idx");
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
      return count;
}
   
   		public FreeCafeDto getDataTC(FreeCafeDto dto) {
	      FreeCafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT free_idx,free_title,free_writer,free_content,free_file,free_regdate" + 
	               "   LAG(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) AS prevNum," + 
	               "   LEAD(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) nextNum" + 
	               "   FROM board_free"+ 
	               "   WHERE free_title LIKE '%'||?||'%' OR free_content LIKE '%'||?||'%'" + 
	               "   ORDER BY free_idx DESC)" + 
	               " WHERE free_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getFree_title());
	         pstmt.setString(2, dto.getFree_content());
	         pstmt.setInt(3, dto.getFree_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	        	 dto2=new FreeCafeDto();
		         dto2.setFree_idx(rs.getInt("free_idx"));
		         dto2.setFree_writer(rs.getString("free_writer"));
		         dto2.setFree_title(rs.getString("free_title"));
		         dto2.setFree_content(rs.getString("free_content"));
		         dto2.setFree_file(rs.getString("free_file"));
		         dto2.setFree_regdate(rs.getString("free_regdate"));
		         dto2.setPrevNum(rs.getInt("PrevNum"));
		         dto2.setNextNum(rs.getInt("NextNum"));
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
	      return dto2;
	   }
   		public FreeCafeDto getDataW(FreeCafeDto dto) {
	      FreeCafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT free_idx,free_title,free_writer,free_content,free_file,free_regdate" + 
	               "   LAG(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) AS prevNum," + 
	               "   LEAD(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) nextNum" + 
	               "   FROM board_free"+ 
	               "   WHERE free_writer LIKE '%'||?||'%'" + 
	               "   ORDER BY free_idx DESC)" + 
	               " WHERE free_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getFree_writer());
	         pstmt.setInt(2, dto.getFree_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	        	 dto2=new FreeCafeDto();
		         dto2.setFree_idx(rs.getInt("free_idx"));
		         dto2.setFree_writer(rs.getString("free_writer"));
		         dto2.setFree_title(rs.getString("free_title"));
		         dto2.setFree_content(rs.getString("free_content"));
		         dto2.setFree_file(rs.getString("free_file"));
		         dto2.setFree_regdate(rs.getString("free_regdate"));
		         dto2.setPrevNum(rs.getInt("PrevNum"));
		         dto2.setNextNum(rs.getInt("NextNum"));
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
	      return dto2;
	   }
  		public FreeCafeDto getDataT(FreeCafeDto dto) {
	      FreeCafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT free_idx,free_title,free_writer,free_content,free_file,free_regdate" + 
	               "   LAG(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) AS prevNum," + 
	               "   LEAD(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) nextNum" + 
	               "   FROM board_free" +
	               "   WHERE free_title LIKE '%'||?||'%'" +
	               "   ORDER BY free_idx DESC)" + 
	               " WHERE free_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getFree_title());
	         pstmt.setInt(2, dto.getFree_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	            dto2=new FreeCafeDto();
	            dto2.setFree_idx(rs.getInt("free_idx"));
	            dto2.setFree_writer(rs.getString("free_writer"));
	            dto2.setFree_title(rs.getString("free_title"));
	            dto2.setFree_content(rs.getString("free_content"));
	            dto2.setFree_file(rs.getString("free_file"));
	            dto2.setFree_regdate(rs.getString("free_regdate"));
	            dto2.setPrevNum(rs.getInt("PrevNum"));
	            dto2.setNextNum(rs.getInt("NextNum"));
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
	      return dto2;
}

	 //제목,내용 검색했을때 전체 row의 갯수 리턴
	    public int getCountTC(FreeCafeDto dto) {
	 	 //글의 갯수를 담을 지역변수 
 	      int count=0;
 	      Connection conn = null;
 	      PreparedStatement pstmt = null;
 	      ResultSet rs = null;
 	      try {
 	         conn = new DbcpBean().getConn();
 	         //select 문 작성
 	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS free_idx "
 	               + " FROM board_free"
 	               + " WHERE free_title LIKE '%'||?||'%' OR free_content LIKE '%'||?||'%'";
 	         pstmt = conn.prepareStatement(sql);
 	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
 	         pstmt.setString(1, dto.getFree_title());
 	         pstmt.setString(2, dto.getFree_content());
 	         //select 문 수행하고 ResultSet 받아오기
 	         rs = pstmt.executeQuery();
 	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
 	         if (rs.next()) {
 	            count=rs.getInt("free_idx");
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
 	      return count;
    }
	 //작성자 검색했을때 전체 row의 갯수 리턴
	   public int getCountW(FreeCafeDto dto) {
		 //글의 갯수를 담을 지역변수 
	      int count=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = new DbcpBean().getConn();
	         //select 문 작성
	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS free_idx "
	               + " FROM board_free"
	               + " WHERE free_writer LIKE '%'||?||'%' ";
	         pstmt = conn.prepareStatement(sql);
	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
	         pstmt.setString(1, dto.getFree_writer());
	         //select 문 수행하고 ResultSet 받아오기
	         rs = pstmt.executeQuery();
	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
	         if (rs.next()) {
	            count=rs.getInt("free_idx");
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
	      return count;
   }
	 //제목 검색했을때 전체 row의 갯수 리턴
	   public int getCountT(FreeCafeDto dto) {
		 //글의 갯수를 담을 지역변수 
	      int count=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = new DbcpBean().getConn();
	         //select 문 작성
	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS free_idx "
	               + " FROM board_free"
	               + " WHERE free_title LIKE '%'||?||'%' ";
	         pstmt = conn.prepareStatement(sql);
	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
	         pstmt.setString(1, dto.getFree_title());
	         //select 문 수행하고 ResultSet 받아오기
	         rs = pstmt.executeQuery();
	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
	         if (rs.next()) {
	            count=rs.getInt("free_idx");
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
	      return count;
   }
   	 //title 검색
   	 public List<FreeCafeDto> getListT(FreeCafeDto dto){
		 //글목록을 담을 ArrayList 객체 생성
		      List<FreeCafeDto> list=new ArrayList<FreeCafeDto>();
		      
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         conn = new DbcpBean().getConn();
		         //select 문 작성
		         String sql = "SELECT *" + 
		               "      FROM" + 
		               "          (SELECT result1.*, ROWNUM AS rnum" + 
		               "          FROM" + 
		               "              (SELECT free_idx,free_writer,free_title,free_file,free_regdate" + 
		               "              FROM board_free" + 
		               "			  WHERE free_title LIKE '%'||?||'%'" +
		               "              ORDER BY free_idx DESC) result1)" + 
		               "      WHERE rnum BETWEEN ? AND ?";
		         pstmt = conn.prepareStatement(sql);
		         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
		         pstmt.setString(1, dto.getFree_title());
		         pstmt.setInt(2, dto.getStartRowNum());
		         pstmt.setInt(3, dto.getEndRowNum());
		         //select 문 수행하고 ResultSet 받아오기
		         rs = pstmt.executeQuery();
		         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
		         while (rs.next()) {
		            FreeCafeDto dto2=new FreeCafeDto();
		            dto2.setFree_idx(rs.getInt("free_idx"));
		            dto2.setFree_writer(rs.getString("free_writer"));
		            dto2.setFree_title(rs.getString("free_title"));
		            dto2.setFree_file(rs.getString("free_file"));
		            dto2.setFree_regdate(rs.getString("free_regdate"));
		            list.add(dto2);
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
		      return list;
	   }
       //writer 검색
   	   public List<FreeCafeDto> getListW(FreeCafeDto dto){
	   //글목록을 담을 ArrayList 객체 생성
		      List<FreeCafeDto> list=new ArrayList<FreeCafeDto>();
		      
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         conn = new DbcpBean().getConn();
		         //select 문 작성
		         String sql = "SELECT *" + 
		               "      FROM" + 
		               "          (SELECT result1.*, ROWNUM AS rnum" + 
		               "          FROM" + 
		               "              (SELECT free_idx,free_writer,free_title,free_file,free_regdate" + 
		               "              FROM board_free" + 
		               "			  WHERE free_writer LIKE '%'||?||'%'" +
		               "              ORDER BY free_idx DESC) result1)" + 
		               "      WHERE rnum BETWEEN ? AND ?";
		         pstmt = conn.prepareStatement(sql);
		         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
		         pstmt.setString(1, dto.getFree_writer());
		         pstmt.setInt(2, dto.getStartRowNum());
		         pstmt.setInt(3, dto.getEndRowNum());
		         //select 문 수행하고 ResultSet 받아오기
		         rs = pstmt.executeQuery();
		         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
		         while (rs.next()) {
		            FreeCafeDto dto2=new FreeCafeDto();
		            dto2.setFree_idx(rs.getInt("free_idx"));
		            dto2.setFree_writer(rs.getString("free_writer"));
		            dto2.setFree_title(rs.getString("free_title"));
		            dto2.setFree_file(rs.getString("free_file"));
		            dto2.setFree_regdate(rs.getString("free_regdate"));
		            list.add(dto2);
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
		      return list;
	}
       //title, content검색
   	   public List<FreeCafeDto> getListTC(FreeCafeDto dto){
       //글목록을 담을 ArrayList 객체 생성
   	      List<FreeCafeDto> list=new ArrayList<FreeCafeDto>();
   	      
   	      Connection conn = null;
   	      PreparedStatement pstmt = null;
   	      ResultSet rs = null;
   	      try {
   	         conn = new DbcpBean().getConn();
   	         //select 문 작성
   	         String sql = "SELECT *" + 
   	               "      FROM" + 
   	               "          (SELECT result1.*, ROWNUM AS rnum" + 
   	               "          FROM" + 
   	               "              (SELECT free_idx,free_writer,free_title,free_file,free_regdate" + 
   	               "              FROM board_free" + 
   	               "			  WHERE free_title LIKE '%'||?||'%' OR free_content LIKE '%'||?||'%'" +
   	               "              ORDER BY free_idx DESC) result1)" + 
   	               "      WHERE rnum BETWEEN ? AND ?";
   	         pstmt = conn.prepareStatement(sql);
   	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
   	         pstmt.setString(1, dto.getFree_title());
   	         pstmt.setString(2, dto.getFree_content());
   	         pstmt.setInt(3, dto.getStartRowNum());
   	         pstmt.setInt(4, dto.getEndRowNum());
   	         //select 문 수행하고 ResultSet 받아오기
   	         rs = pstmt.executeQuery();
   	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
   	         while (rs.next()) {
   	            FreeCafeDto dto2=new FreeCafeDto();
   	            dto2.setFree_idx(rs.getInt("free_idx"));
   	            dto2.setFree_writer(rs.getString("free_writer"));
   	            dto2.setFree_title(rs.getString("free_title"));
   	            dto2.setFree_file(rs.getString("free_file"));
   	            dto2.setFree_regdate(rs.getString("free_regdate"));
   	            list.add(dto2);
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
   	      return list;
      
   }
       //글 하나의 정보를 수정하는 메소드
	   public boolean update(FreeCafeDto dto) {
		   Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql문 작성
				String sql = "UPDATE board_free"
						+ " SET free_title=?, free_content=?, free_file=?"
						+ " WHERE free_idx=?";
				pstmt = conn.prepareStatement(sql);
				//?에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, dto.getFree_title());
				pstmt.setString(2, dto.getFree_content());
				pstmt.setString(3, dto.getFree_file());
				pstmt.setInt(4, dto.getFree_idx());
				//insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
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
   
	 //글하나의 정보를 삭제하는 메소드
	   public boolean delete(int free_idx) {
		   Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql문 작성
				String sql = "DELETE FROM board_free"
						+ " WHERE free_idx=?";
				pstmt = conn.prepareStatement(sql);
				//?에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, free_idx);
				//insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
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
 
	   //글하나의 정보를 리턴하는 메소드
	      public FreeCafeDto getData(int free_idx) {
	         FreeCafeDto dto2=null;
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         try {
	            //Connection 객체의 참조값 얻어오기 
	            conn = new DbcpBean().getConn();
	            //실행할 sql 문 작성
	            String sql = "SELECT free_writer,free_title,free_content,free_file,free_regdate"
	                  + " FROM board_free"
	                  + " WHERE free_idx=?";
	            //PreparedStatement 객체의 참조값 얻어오기
	            pstmt = conn.prepareStatement(sql);
	            //? 에 바인딩할 내용이 있으면 여기서 바인딩
	            pstmt.setInt(1, free_idx);
	            //select 문 수행하고 결과를 ResultSet 으로 받아오기
	            rs = pstmt.executeQuery();
	            //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	            if(rs.next()) {
	               dto2=new FreeCafeDto();
	               dto2.setFree_idx(free_idx);
	               dto2.setFree_writer(rs.getString("free_writer"));
	               dto2.setFree_title(rs.getString("free_title"));
	               dto2.setFree_content(rs.getString("free_content"));
	               dto2.setFree_file(rs.getString("free_file"));
	               dto2.setFree_regdate(rs.getString("free_regdate"));
	               dto2.setPrevNum(rs.getInt("prevNum"));
	               dto2.setNextNum(rs.getInt("nextNum"));
	               
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
	         return dto2;
	      }

   //새 글 저장하는 메소드
   public boolean insert(FreeCafeDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 sql문 작성
         String sql = "INSERT INTO board_free"
               + " (free_idx, free_writer, free_title, free_content, free_file, free_regdate)"
               + " VALUES(board_free_seq.NEXTVAL,?,?,?,?,SYSDATE)";
         pstmt = conn.prepareStatement(sql);
         //?에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setString(1, dto.getFree_writer());
         pstmt.setString(2, dto.getFree_title());
         pstmt.setString(3, dto.getFree_content());
         pstmt.setString(4, dto.getFree_file());
         //insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
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
	 //글하나의 정보를 리턴하는 메소드
		public FreeCafeDto getData(FreeCafeDto dto) {
			FreeCafeDto dto2=null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				//Connection 객체의 참조값 얻어오기 
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "SELECT *" + 
						" FROM" + 
						"	(SELECT free_idx,free_title,free_writer,free_content,free_file,free_regdate," + 
						"	LAG(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) AS prevNum," + 
						"	LEAD(free_idx, 1, 0) OVER(ORDER BY free_idx DESC) nextNum" + 
						"	FROM board_free" + 
						"	ORDER BY free_idx DESC)" + 
						" WHERE free_idx=?";
				
				//PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, dto.getFree_idx());
				//select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
				if(rs.next()) {
					dto2=new FreeCafeDto();
					dto2.setFree_idx(rs.getInt("free_idx"));
					dto2.setFree_writer(rs.getString("free_writer"));
					dto2.setFree_title(rs.getString("free_title"));
					dto2.setFree_content(rs.getString("free_content"));
					dto2.setFree_file(rs.getString("free_file"));
					dto2.setFree_regdate(rs.getString("free_regdate"));
					dto2.setPrevNum(rs.getInt("prevNum"));
					dto2.setNextNum(rs.getInt("nextNum"));
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
			return dto2;
		}
   //글 목록을 리턴하는 메소드
   public List<FreeCafeDto> getList(FreeCafeDto dto){
      List<FreeCafeDto> list=new ArrayList<FreeCafeDto>();
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT *" + 
                 "      FROM" + 
                 "          (SELECT result1.*, ROWNUM AS rnum" + 
                 "          FROM" + 
                 "              (SELECT free_idx,free_writer,free_title,free_file,free_regdate" + 
                 "              FROM board_free" + 
                 "              ORDER BY free_idx DESC) result1)" + 
                 "      WHERE rnum BETWEEN ? AND ?";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setInt(1, dto.getStartRowNum());
         pstmt.setInt(2, dto.getEndRowNum());
         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         while (rs.next()) {
            FreeCafeDto dto2=new FreeCafeDto();
            dto2.setFree_idx(rs.getInt("free_idx"));
            dto2.setFree_writer(rs.getString("free_writer"));
            dto2.setFree_title(rs.getString("free_title"));
            dto2.setFree_file(rs.getString("free_file"));
            dto2.setFree_regdate(rs.getString("free_regdate"));
            list.add(dto2);
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
      return list;
   }
   //전체 글의 갯수를 리턴하는 메소드
   public int getCount() {
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM),0) AS free_idx"
               + " FROM board_free";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩

         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         if (rs.next()) {
        	 count=rs.getInt("free_idx");
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
      return count;
   }
}