package moviebug.movieinfo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import moviebug.movieinfo.dto.MovieCommentDto;
import test.util.DbcpBean;

public class MovieCommentDao {
	private static MovieCommentDao dao;
		static {
			dao=new MovieCommentDao();
		}
		private MovieCommentDao() {}
		public static MovieCommentDao getInstance() {
			return dao;
		}
		
		//전체 댓글의 갯수를 리턴하는 메소드
		   public int getCount(int comment_ref_group) {
			   int count=0;
			   Connection conn = null;
			   PreparedStatement pstmt = null;
			   ResultSet rs = null;
			   try {
				   //Connection 객체의 참조값 얻어오기 
				   conn = new DbcpBean().getConn();
				   //실행할 sql 문 작성
				   String sql = "SELECT NVL(MAX(ROWNUM), 0) AS count"
				   		+ " FROM board_comment"
				   		+ " WHERE comment_ref_group=?";
				   //PreparedStatement 객체의 참조값 얻어오기
				   pstmt = conn.prepareStatement(sql);
				   //? 에 바인딩할 내용이 있으면 여기서 바인딩
				   pstmt.setInt(1, comment_ref_group);
				   //select 문 수행하고 결과를 ResultSet 으로 받아오기
				   rs = pstmt.executeQuery();
				   //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
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
		
		//댓글 내용을 수정하는 메소드
		   public boolean update(MovieCommentDto dto) {
			    Connection conn = null;
				PreparedStatement pstmt = null;
				int flag = 0;
				try {
					conn = new DbcpBean().getConn();
					// 실행할 sql 문 작성
					String sql = "UPDATE board_comment"
							+ " SET comment_content=?"
							+ " WHERE comment_idx=?";
					pstmt = conn.prepareStatement(sql);
					// ? 에 바인딩할 내용이 있으면 여기서 바인딩
					pstmt.setString(1, dto.getComment_content());
					pstmt.setInt(2, dto.getComment_idx());
					// insert of update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
		   public boolean delete(int num) {
			    Connection conn = null;
				PreparedStatement pstmt = null;
				int flag = 0;
				try {
					conn = new DbcpBean().getConn();
					// 실행할 sql 문 작성
					String sql = "UPDATE board_comment"
							+ " SET comment_deleted='yes'"
							+ " WHERE comment_idx=?";
					pstmt = conn.prepareStatement(sql);
					// ? 에 바인딩할 내용이 있으면 여기서 바인딩
					pstmt.setInt(1, num);
					// insert of update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
		
		//댓글 목록을 리턴하는 메소드
		   public List<MovieCommentDto> getList(MovieCommentDto dto2){
		      List<MovieCommentDto> list=new ArrayList<>();
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT result1.*, ROWNUM AS rnum" + 
		               "    FROM" + 
		               "      (SELECT comment_idx, comment_writer, comment_content, comment_target_id, comment_ref_group," + 
		               "      comment_group, comment_deleted, comment_regdate, profile" + 
		               "      FROM board_comment" + 
		               "      INNER JOIN users" + 
		               "      ON board_comment.comment_writer = users.email" + 
		               "      WHERE comment_ref_group=?" + 
		               "      ORDER BY comment_group DESC, comment_idx ASC) result1)" + 
		               " WHERE rnum BETWEEN ? AND ?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setInt(1, dto2.getComment_ref_group());
		         pstmt.setInt(2, dto2.getStartRowNum());
		         pstmt.setInt(3, dto2.getEndRowNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         while (rs.next()) {
		            MovieCommentDto dto=new MovieCommentDto();
		            dto.setComment_idx(rs.getInt("comment_idx"));
		            dto.setComment_writer(rs.getString("comment_writer"));
		            dto.setComment_content(rs.getString("comment_content"));
		            dto.setComment_target_id(rs.getString("comment_target_id"));
		            dto.setComment_ref_group(rs.getInt("comment_ref_group"));
		            dto.setComment_group(rs.getInt("comment_group"));
		            dto.setComment_deleted(rs.getString("comment_deleted"));
		            dto.setComment_regdate(rs.getString("comment_regdate"));
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
					String sql = "SELECT board_comment_seq.NEXTVAL AS seq"
							+ " FROM DUAL";
					//PreparedStatement 객체의 참조값 얻어오기
					pstmt = conn.prepareStatement(sql);
					//? 에 바인딩할 내용이 있으면 여기서 바인딩
					//select 문 수행하고 결과를 ResultSet 으로 받아오기
					rs = pstmt.executeQuery();
					//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
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
		public boolean insert(MovieCommentDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				// 실행할 sql 문 작성
				String sql = "INSERT INTO board_comment"
						+ " (comment_idx, comment_writer, comment_content, comment_target_id, comment_ref_group, comment_group, comment_regdate)"
						+ " VALUES(?, ?, ?, ?, ?, ?, SYSDATE)";
				pstmt = conn.prepareStatement(sql);
				// ? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, dto.getComment_idx());
				pstmt.setString(2, dto.getComment_writer());
				pstmt.setString(3, dto.getComment_content());
				pstmt.setString(4, dto.getComment_target_id());
				pstmt.setInt(5, dto.getComment_ref_group());
				pstmt.setInt(6, dto.getComment_group());
				// insert of update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
