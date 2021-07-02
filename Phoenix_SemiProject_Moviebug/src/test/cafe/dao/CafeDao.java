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
	//새 글 저장하는 메소드
	public boolean insert(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "INSERT INTO board_qna"
					+ " (qna_idx, qna_writer, qna_title, qna_content, qna_file, qna_regdate"
					+ " VALUES(board_qua.seq.NEXTVAL,?,?,?,?,SYSDATE)";
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
			String sql = "SELECT *"
					+ " FROM"
					+ " SELECT result1.*, ROWNUM AS rnum"
					+ " FROM"
					+ " (SELECT qua_idx,qua_writer,qua_title,qua_content,qua_file,qua_regdate"
					+ " FROM board_qna"
					+ " ORDER BY qna_idx DESC) result1"
					+ " WHERE rnum BETWEEN ? AND ?";
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
				dto2.setQna_idx(rs.getInt("qun_idx"));
				dto2.setQna_writer(rs.getString("qna_writer"));
				dto2.setQna_title(rs.getString("qna_title"));
				dto2.setQna_content(rs.getString("qna_content"));
				dto2.setQna_file(rs.getString("qua_file"));
				dto2.setQna_regdate(rs.getString("qna_regdate"));
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
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num "
					+ " FROM board_qna";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 바인딩

			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {

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
