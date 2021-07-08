package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class CafeDao {
   private static CafeDao dao;
   private CafeDao() {}
   public static CafeDao getInstance() {
      if(dao==null) {
         dao=new CafeDao();
      }
      return dao;
   }
   		public CafeDto getDataTC(CafeDto dto) {
	      CafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT qna_idx,qna_title,qna_writer,qna_content,qna_file,qna_regdate" + 
	               "   LAG(num, 1, 0) OVER(ORDER BY qna_idx DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY qna_idx DESC) nextNum" + 
	               "   FROM board_qna"+ 
	               "   WHERE qna_title LIKE '%'||?||'%' OR qna_content LIKE '%'||?||'%'" + 
	               "   ORDER BY qna_idx DESC)" + 
	               " WHERE qna_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getQna_title());
	         pstmt.setString(2, dto.getQna_content());
	         pstmt.setInt(3, dto.getQna_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	        	 dto2=new CafeDto();
		         dto2.setQna_idx(rs.getInt("qna_idx"));
		         dto2.setQna_writer(rs.getString("qna_writer"));
		         dto2.setQna_title(rs.getString("qna_title"));
		         dto2.setQna_content(rs.getString("qna_content"));
		         dto2.setQna_file(rs.getString("qna_file"));
		         dto2.setQna_regdate(rs.getString("qna_regdate"));
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
   		public CafeDto getDataW(CafeDto dto) {
	      CafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT qna_idx,qna_title,qna_writer,qna_content,qna_file,qna_regdate" + 
	               "   LAG(num, 1, 0) OVER(ORDER BY qna_idx DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY qna_idx DESC) nextNum" + 
	               "   FROM board_qna"+ 
	               "   WHERE qna_writer LIKE '%'||?||'%'" + 
	               "   ORDER BY qna_idx DESC)" + 
	               " WHERE qna_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getQna_writer());
	         pstmt.setInt(2, dto.getQna_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	        	 dto2=new CafeDto();
		         dto2.setQna_idx(rs.getInt("qna_idx"));
		         dto2.setQna_writer(rs.getString("qna_writer"));
		         dto2.setQna_title(rs.getString("qna_title"));
		         dto2.setQna_content(rs.getString("qna_content"));
		         dto2.setQna_file(rs.getString("qna_file"));
		         dto2.setQna_regdate(rs.getString("qna_regdate"));
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
  		public CafeDto getDataT(CafeDto dto) {
	      CafeDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT qna_idx,qna_title,qna_writer,qna_content,qna_file,qna_regdate" + 
	               "   LAG(num, 1, 0) OVER(ORDER BY qna_idx DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY qna_idx DESC) nextNum" + 
	               "   FROM board_qna" +
	               "   WHERE qna_title LIKE '%'||?||'%'" +
	               "   ORDER BY qna_idx DESC)" + 
	               " WHERE qna_idx=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getQna_title());
	         pstmt.setInt(2, dto.getQna_idx());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	            dto2=new CafeDto();
	            dto2.setQna_idx(rs.getInt("qna_idx"));
	            dto2.setQna_writer(rs.getString("qna_writer"));
	            dto2.setQna_title(rs.getString("qna_title"));
	            dto2.setQna_content(rs.getString("qna_content"));
	            dto2.setQna_file(rs.getString("qna_file"));
	            dto2.setQna_regdate(rs.getString("qna_regdate"));
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
	    public int getCountTC(CafeDto dto) {
	 	 //글의 갯수를 담을 지역변수 
 	      int count=0;
 	      Connection conn = null;
 	      PreparedStatement pstmt = null;
 	      ResultSet rs = null;
 	      try {
 	         conn = new DbcpBean().getConn();
 	         //select 문 작성
 	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS qna_idx "
 	               + " FROM board_qna"
 	               + " WHERE qna_title LIKE '%'||?||'%' OR qna_content LIKE '%'||?||'%'";
 	         pstmt = conn.prepareStatement(sql);
 	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
 	         pstmt.setString(1, dto.getQna_title());
 	         pstmt.setString(2, dto.getQna_content());
 	         //select 문 수행하고 ResultSet 받아오기
 	         rs = pstmt.executeQuery();
 	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
 	         if (rs.next()) {
 	            count=rs.getInt("qna_idx");
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
	   public int getCountW(CafeDto dto) {
		 //글의 갯수를 담을 지역변수 
	      int count=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = new DbcpBean().getConn();
	         //select 문 작성
	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS qna_idx "
	               + " FROM board_qna"
	               + " WHERE qna_writer LIKE '%'||?||'%' ";
	         pstmt = conn.prepareStatement(sql);
	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
	         pstmt.setString(1, dto.getQna_writer());
	         //select 문 수행하고 ResultSet 받아오기
	         rs = pstmt.executeQuery();
	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
	         if (rs.next()) {
	            count=rs.getInt("qna_idx");
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
	   public int getCountT(CafeDto dto) {
		 //글의 갯수를 담을 지역변수 
	      int count=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = new DbcpBean().getConn();
	         //select 문 작성
	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS qna_idx "
	               + " FROM board_qna"
	               + " WHERE qna_title LIKE '%'||?||'%' ";
	         pstmt = conn.prepareStatement(sql);
	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
	         pstmt.setString(1, dto.getQna_title());
	         //select 문 수행하고 ResultSet 받아오기
	         rs = pstmt.executeQuery();
	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
	         if (rs.next()) {
	            count=rs.getInt("qna_idx");
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
   	 public List<CafeDto> getListT(CafeDto dto){
		 //글목록을 담을 ArrayList 객체 생성
		      List<CafeDto> list=new ArrayList<CafeDto>();
		      
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
		               "              (SELECT qna_idx,qna_writer,qna_title,qna_file,qna_regdate" + 
		               "              FROM board_qna" + 
		               "			  WHERE qna_title LIKE '%'||?||'%'" +
		               "              ORDER BY qna_idx DESC) result1)" + 
		               "      WHERE rnum BETWEEN ? AND ?";
		         pstmt = conn.prepareStatement(sql);
		         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
		         pstmt.setString(1, dto.getQna_title());
		         pstmt.setInt(2, dto.getStartRowNum());
		         pstmt.setInt(3, dto.getEndRowNum());
		         //select 문 수행하고 ResultSet 받아오기
		         rs = pstmt.executeQuery();
		         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
		         while (rs.next()) {
		            CafeDto dto2=new CafeDto();
		            dto2.setQna_idx(rs.getInt("qna_idx"));
		            dto2.setQna_writer(rs.getString("qna_writer"));
		            dto2.setQna_title(rs.getString("qna_title"));
		            dto2.setQna_file(rs.getString("qna_file"));
		            dto2.setQna_regdate(rs.getString("qna_regdate"));
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
   	   public List<CafeDto> getListW(CafeDto dto){
	   //글목록을 담을 ArrayList 객체 생성
		      List<CafeDto> list=new ArrayList<CafeDto>();
		      
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
		               "              (SELECT qna_idx,qna_writer,qna_title,qna_file,qna_regdate" + 
		               "              FROM board_qna" + 
		               "			  WHERE qna_writer LIKE '%'||?||'%'" +
		               "              ORDER BY qna_idx DESC) result1)" + 
		               "      WHERE rnum BETWEEN ? AND ?";
		         pstmt = conn.prepareStatement(sql);
		         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
		         pstmt.setString(1, dto.getQna_writer());
		         pstmt.setInt(2, dto.getStartRowNum());
		         pstmt.setInt(3, dto.getEndRowNum());
		         //select 문 수행하고 ResultSet 받아오기
		         rs = pstmt.executeQuery();
		         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
		         while (rs.next()) {
		            CafeDto dto2=new CafeDto();
		            dto2.setQna_idx(rs.getInt("qna_idx"));
		            dto2.setQna_writer(rs.getString("qna_writer"));
		            dto2.setQna_title(rs.getString("qna_title"));
		            dto2.setQna_file(rs.getString("qna_file"));
		            dto2.setQna_regdate(rs.getString("qna_regdate"));
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
   	   public List<CafeDto> getListTC(CafeDto dto){
       //글목록을 담을 ArrayList 객체 생성
   	      List<CafeDto> list=new ArrayList<CafeDto>();
   	      
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
   	               "              (SELECT qna_idx,qna_writer,qna_title,qna_file,qna_regdate" + 
   	               "              FROM board_qna" + 
   	               "			  WHERE qna_title LIKE '%'||?||'%' OR qna_content LIKE '%'||?||'%'" +
   	               "              ORDER BY qna_idx DESC) result1)" + 
   	               "      WHERE rnum BETWEEN ? AND ?";
   	         pstmt = conn.prepareStatement(sql);
   	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
   	         pstmt.setString(1, dto.getQna_title());
   	         pstmt.setString(2, dto.getQna_content());
   	         pstmt.setInt(3, dto.getStartRowNum());
   	         pstmt.setInt(4, dto.getEndRowNum());
   	         //select 문 수행하고 ResultSet 받아오기
   	         rs = pstmt.executeQuery();
   	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
   	         while (rs.next()) {
   	            CafeDto dto2=new CafeDto();
   	            dto2.setQna_idx(rs.getInt("qna_idx"));
   	            dto2.setQna_writer(rs.getString("qna_writer"));
   	            dto2.setQna_title(rs.getString("qna_title"));
   	            dto2.setQna_file(rs.getString("qna_file"));
   	            dto2.setQna_regdate(rs.getString("qna_regdate"));
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
	   public boolean update(CafeDto dto) {
		   Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql문 작성
				String sql = "UPDATE board_qna"
						+ " SET qna_title=?, qna_content=?, qna_file=?"
						+ " WHERE qna_idx=?";
				pstmt = conn.prepareStatement(sql);
				//?에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, dto.getQna_title());
				pstmt.setString(2, dto.getQna_content());
				pstmt.setString(3, dto.getQna_file());
				pstmt.setInt(4, dto.getQna_idx());
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
	   public boolean delete(int qna_idx) {
		   Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql문 작성
				String sql = "DELETE FROM board_qna"
						+ " WHERE qna_idx=?";
				pstmt = conn.prepareStatement(sql);
				//?에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, qna_idx);
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
	      public CafeDto getData(int qna_idx) {
	         CafeDto dto2=null;
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         try {
	            //Connection 객체의 참조값 얻어오기 
	            conn = new DbcpBean().getConn();
	            //실행할 sql 문 작성
	            String sql = "SELECT qna_writer,qna_title,qna_content,qna_file,qna_regdate"
	                  + " FROM board_qna"
	                  + " WHERE qna_idx=?";
	            //PreparedStatement 객체의 참조값 얻어오기
	            pstmt = conn.prepareStatement(sql);
	            //? 에 바인딩할 내용이 있으면 여기서 바인딩
	            pstmt.setInt(1, qna_idx);
	            //select 문 수행하고 결과를 ResultSet 으로 받아오기
	            rs = pstmt.executeQuery();
	            //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	            if(rs.next()) {
	               dto2=new CafeDto();
	               dto2.setQna_idx(qna_idx);
	               dto2.setQna_writer(rs.getString("qna_writer"));
	               dto2.setQna_title(rs.getString("qna_title"));
	               dto2.setQna_content(rs.getString("qna_content"));
	               dto2.setQna_file(rs.getString("qna_file"));
	               dto2.setQna_regdate(rs.getString("qna_regdate"));
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
   public boolean insert(CafeDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 sql문 작성
         String sql = "INSERT INTO board_qna"
               + " (qna_idx, qna_writer, qna_title, qna_content, qna_file, qna_regdate)"
               + " VALUES(board_qna_seq.NEXTVAL,?,?,?,?,SYSDATE)";
         pstmt = conn.prepareStatement(sql);
         //?에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setString(1, dto.getQna_writer());
         pstmt.setString(2, dto.getQna_title());
         pstmt.setString(3, dto.getQna_content());
         pstmt.setString(4, dto.getQna_file());
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
		public CafeDto getData(CafeDto dto) {
			CafeDto dto2=null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				//Connection 객체의 참조값 얻어오기 
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "SELECT *" + 
						" FROM" + 
						"	(SELECT qna_idx,qna_title,qna_writer,qna_content,qna_file,qna_regdate," + 
						"	LAG(qna_idx, 1, 0) OVER(ORDER BY qna_idx DESC) AS prevNum," + 
						"	LEAD(qna_idx, 1, 0) OVER(ORDER BY qna_idx DESC) nextNum" + 
						"	FROM board_qna" + 
						"	ORDER BY qna_idx DESC)" + 
						" WHERE qna_idx=?";
				
				//PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, dto.getQna_idx());
				//select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
				if(rs.next()) {
					dto2=new CafeDto();
					dto2.setQna_idx(rs.getInt("qna_idx"));
					dto2.setQna_writer(rs.getString("qna_writer"));
					dto2.setQna_title(rs.getString("qna_title"));
					dto2.setQna_content(rs.getString("qna_content"));
					dto2.setQna_file(rs.getString("qna_file"));
					dto2.setQna_regdate(rs.getString("qna_regdate"));
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
   public List<CafeDto> getList(CafeDto dto){
      List<CafeDto> list=new ArrayList<CafeDto>();
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
                 "              (SELECT qna_idx,qna_writer,qna_title,qna_file,qna_regdate" + 
                 "              FROM board_qna" + 
                 "              ORDER BY qna_idx DESC) result1)" + 
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
            CafeDto dto2=new CafeDto();
            dto2.setQna_idx(rs.getInt("qna_idx"));
            dto2.setQna_writer(rs.getString("qna_writer"));
            dto2.setQna_title(rs.getString("qna_title"));
            dto2.setQna_file(rs.getString("qna_file"));
            dto2.setQna_regdate(rs.getString("qna_regdate"));
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
         String sql = "SELECT NVL(MAX(ROWNUM),0) AS qna_idx"
               + " FROM board_qna";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩

         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         if (rs.next()) {
        	 count=rs.getInt("qna_idx");
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