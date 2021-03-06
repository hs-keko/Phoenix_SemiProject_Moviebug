package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeCommentDto;
import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class CafeCommentDao {
	private static CafeCommentDao dao;
	/*
	 *  [ static 초기화 블럭 ]
	 *  이 클래스가 최초 사용될때 한번만 수행되는 블럭
	 */
	static {
		dao=new CafeCommentDao();
	}
	private CafeCommentDao() {
		
	}
	public static CafeCommentDao getInstance() {
		if(dao==null) {
			dao=new CafeCommentDao() ;
		}
		return dao;
	}
	
	// 특정유저가 쓴 댓글 전체 row의 갯수 리턴
	   public int userCommentCount(CafeCommentDto dto) {
		 //글의 갯수를 담을 지역변수 
	      int count=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = new DbcpBean().getConn();
	         //select 문 작성
	         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS qna_comment_idx "
	               + " FROM board_qna_comment"
	               + " WHERE qna_comment_writer = ?";
	         pstmt = conn.prepareStatement(sql);
	         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
	         pstmt.setString(1, dto.getQna_comment_writer());
	         //select 문 수행하고 ResultSet 받아오기
	         rs = pstmt.executeQuery();
	         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
	         if (rs.next()) {
	            count=rs.getInt("qna_comment_idx");
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
	
	// 특정 유저 댓글목록을 리턴하는 메소드
	   public List<CafeCommentDto> userCommentList(CafeCommentDto dto){
	      List<CafeCommentDto> list=new ArrayList<CafeCommentDto>();
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	         		" FROM" + 
	         		" (SELECT result1.*, ROWNUM AS rnum" + 
	         		" FROM" + 
	         		" (SELECT qna_comment_writer, qna_comment_content, qna_comment_ref_group," + 
	         		" board_qna_comment.qna_comment_regdate" + 
	         		" FROM board_qna_comment" + 
	         		" INNER JOIN users" + 
	         		" ON board_qna_comment.qna_comment_writer = users.email" + 
	         		" WHERE board_qna_comment.qna_comment_writer = ? " + 
	         		" ORDER BY qna_comment_ref_group DESC) result1)" + 
	         		" WHERE rnum BETWEEN ? AND ?";
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getQna_comment_writer());
	         pstmt.setInt(2, dto.getStartRowNum());
	         pstmt.setInt(3, dto.getEndRowNum());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         while (rs.next()) {
	        	 CafeCommentDto dto2=new CafeCommentDto();
		            dto2.setQna_comment_writer(rs.getString("qna_comment_writer"));
		            dto2.setQna_comment_content(rs.getString("qna_comment_content"));
		            dto2.setQna_comment_ref_group(rs.getInt("qna_comment_ref_group"));
		            dto2.setQna_comment_regdate(rs.getString("qna_comment_regdate"));
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
	
	
	//댓글 내용을 수정하는 메소드
		public boolean update(CafeCommentDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "UPDATE board_qna_comment"
						+ " SET qna_comment_content=?"
						+ " WHERE qna_comment_idx=?";
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setString(1, dto.getQna_comment_content());
				pstmt.setInt(2, dto.getQna_comment_idx());
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
	//댓글을 삭제하는 메소드
		public boolean delete(int qna_comment_idx) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "UPDATE board_qna_comment"
						+ " SET qna_comment_deleted='yes'"
						+ " WHERE qna_comment_idx=?";
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, qna_comment_idx);
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

	//댓글 갯수를 리턴해주는 메소드
	   public int getCount(int qna_comment_ref_group) {
		    int count=0;
		    Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				//Connection 객체의 참조값 얻어오기 
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "SELECT NVL(MAX(ROWNUM), 0) AS count "
						+ " FROM board_qna_comment"
						+ " WHERE qna_comment_ref_group=?";
				//PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, qna_comment_ref_group);
				//select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
				if (rs.next()) {
					count=rs.getInt("count");
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
	//댓글 목록을 리턴하는 메소드
	   public List<CafeCommentDto> getList(CafeCommentDto dto2){
	      List<CafeCommentDto> list=new ArrayList<>();
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" +
	                 " FROM" +
	                 "    (SELECT result1.*, ROWNUM AS rnum" +
	                 "    FROM" +
	                 "       (SELECT qna_comment_idx, qna_comment_writer, qna_comment_content, qna_comment_target_id, qna_comment_ref_group," + 
	                 "       qna_comment_group, qna_comment_deleted, board_qna_comment.qna_comment_regdate, profile" + 
	                 "       FROM board_qna_comment" + 
	                 "       INNER JOIN users" + 
	                 "       ON board_qna_comment.qna_comment_writer = users.email" +
	                 "       WHERE qna_comment_ref_group=?" +
	                 "       ORDER BY qna_comment_group ASC, qna_comment_idx ASC) result1)" +
	                 " WHERE rnum BETWEEN ? AND ?";
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setInt(1, dto2.getQna_comment_ref_group());
	         pstmt.setInt(2, dto2.getStartRowNum());
	         pstmt.setInt(3, dto2.getEndRowNum());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         while (rs.next()) {
	            CafeCommentDto dto=new CafeCommentDto();
	            dto.setQna_comment_idx(rs.getInt("qna_comment_idx"));
	            dto.setQna_comment_writer(rs.getString("qna_comment_writer"));
	            dto.setQna_comment_content(rs.getString("qna_comment_content"));
	            dto.setQna_comment_target_id(rs.getString("qna_comment_target_id"));
	            dto.setQna_comment_ref_group(rs.getInt("qna_comment_ref_group"));
	            dto.setQna_comment_group(rs.getInt("qna_comment_group"));
	            dto.setQna_comment_deleted(rs.getString("qna_comment_deleted"));
	            dto.setQna_comment_regdate(rs.getString("qna_comment_regdate"));
	            dto.setProfile(rs.getString("profile"));
	            list.add(dto);
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
	
	//댓글의 시퀀스값을 미리 리턴해주는 메소드
	   public int getSequence() {
	      int seq=0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT board_qna_comment_seq.NEXTVAL AS seq"
	               + " FROM DUAL";
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if (rs.next()) {
	            seq=rs.getInt("seq");
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
	      return seq;
	   }
	
	//댓글 추가
	   public boolean insert(CafeCommentDto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "INSERT INTO board_qna_comment"
	               + " (qna_comment_idx, qna_comment_writer, qna_comment_content, qna_comment_target_id, qna_comment_ref_group, qna_comment_group, qna_comment_regdate)"
	               + " VALUES(?, ?, ?, ?, ?, ?, SYSDATE)";
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setInt(1, dto.getQna_comment_idx());
	         pstmt.setString(2, dto.getQna_comment_writer());
	         pstmt.setString(3, dto.getQna_comment_content());
	         pstmt.setString(4, dto.getQna_comment_target_id());
	         pstmt.setInt(5, dto.getQna_comment_ref_group());
	         pstmt.setInt(6, dto.getQna_comment_group());
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
	   
}