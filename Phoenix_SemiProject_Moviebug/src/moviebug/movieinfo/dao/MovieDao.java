package moviebug.movieinfo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import moviebug.movieinfo.dto.MovieDto;
import test.util.DbcpBean;

public class MovieDao {

   private static MovieDao dao;
   private MovieDao() {}
   public static MovieDao getInstance() {
      if(dao==null) {
         dao=new MovieDao();
      }
      return dao;
   }
   
   
   //영화 하나의 정보를 리턴하는 메소드
   public MovieDto getData(int num) {
      MovieDto dto=null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT movie_num,movie_title_kr ,movie_title_eng ,movie_story,movie_character,movie_year,movie_genre,movie_company,movie_image,movie_trailer,movie_time,movie_rating,movie_nation,movie_director,movie_writer"
               + " FROM movie_info"
               + " WHERE movie_num=?";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setInt(1, num);
         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         if (rs.next()) {
            dto = new MovieDto();
            dto.setMovie_num(num);
            dto.setMovie_title_kr(rs.getString("movie_title_kr"));
            dto.setMovie_title_eng(rs.getString("movie_title_eng"));
            dto.setMovie_story(rs.getString("movie_story"));
            dto.setMovie_character(rs.getString("movie_character"));
            dto.setMovie_year(rs.getString("movie_year"));
            dto.setMovie_genre(rs.getString("movie_genre"));
            dto.setMovie_company(rs.getString("movie_company"));
            dto.setMovie_image(rs.getString("movie_image"));
            dto.setMovie_trailer(rs.getString("movie_trailer"));
            dto.setMovie_time(rs.getString("movie_time"));
            dto.setMovie_rating(rs.getString("movie_rating"));
            dto.setMovie_nation(rs.getString("movie_nation"));
            dto.setMovie_director(rs.getString("movie_director"));
            dto.setMovie_writer(rs.getString("movie_writer"));
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
   
   // 한달이내 평점이 가장 높음 4개의 영화 리스트 구하기
   public List<MovieDto> getTop4ResList(){
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<MovieDto> list = new ArrayList<>();
      try {
         conn = new DbcpBean().getConn();
         // 실행할 sql 문 작성
         
         String sql = "select result01.*,rownum from " + 
               "(select movie_title_kr, movie_story, movie_genre,movie_image,movie_rating, movie_year, to_char(sysdate,'yyyymmdd') \"오늘날짜\"" + 
               " from movie_info where sysdate-30 <= movie_year order by movie_year desc) result01" + 
               " where rownum < 5" + 
               " order by movie_rating desc";
         System.out.println(sql);
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            MovieDto dto = new MovieDto();
            dto.setMovie_genre(rs.getString("movie_genre"));
            /* dto.setMovie_image(rs.getString("movie_image")); */
            dto.setMovie_title_kr(rs.getString("movie_title_kr"));
            dto.setMovie_story(rs.getString("movie_story"));
            dto.setMovie_rating(rs.getString("movie_rating"));
            dto.setMovie_year(rs.getString("movie_year"));
            list.add(dto);
         }
         
         
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
            if(rs != null) rs.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      return list;
   }
   
   public boolean insert(MovieDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         // 실행할 sql 문 작성

         String sql = "insert into movie_info ("+
               "movie_num,movie_title_kr ,movie_title_eng ,movie_story,movie_character,movie_year,movie_genre,movie_company,movie_image,movie_trailer,movie_time,movie_rating,movie_nation,movie_director,movie_writer" 
               + ") values (movie_info_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,'admin@admin.com')";
         pstmt = conn.prepareStatement(sql);
         // 바인딩
         pstmt.setString(1,dto.getMovie_title_kr());
         pstmt.setString(2, dto.getMovie_title_eng());
         pstmt.setString(3, dto.getMovie_story());
         pstmt.setString(4, dto.getMovie_character());
         pstmt.setString(5, dto.getMovie_year());
         pstmt.setString(6, dto.getMovie_genre());
         pstmt.setString(7, dto.getMovie_company());
         pstmt.setString(8, dto.getMovie_image());
         pstmt.setString(9, dto.getMovie_trailer());
         pstmt.setString(10, dto.getMovie_time());
         pstmt.setString(11, dto.getMovie_rating());
         pstmt.setString(12, dto.getMovie_nation());
         pstmt.setString(13, dto.getMovie_director());
         
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
            e.printStackTrace();
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
   
   
   public boolean Testinsert(MovieDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         // 실행할 sql 문 작성

         String sql = "insert into movie_info ("+
               "movie_num,movie_title_kr ,movie_year,movie_genre,movie_company" 
               + ") values (movie_info_seq.nextval,?,?,?,?)";
         pstmt = conn.prepareStatement(sql);
         // 바인딩
         pstmt.setString(1, dto.getMovie_title_kr());
         pstmt.setString(2, dto.getMovie_year());
         pstmt.setString(3, dto.getMovie_genre());
         pstmt.setString(4, dto.getMovie_company());
         
         
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
            e.printStackTrace();
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
   
   
   
   public List<MovieDto> getNewMovies(){
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<MovieDto> list = new ArrayList<>();
      try {
         conn = new DbcpBean().getConn();
         // 실행할 sql 문 작성

         String sql = "select result.* from "
               + "(select movie_num,movie_title_kr,movie_title_eng,movie_year,"
               + "movie_genre from movie_info order by movie_year desc) result "
               + "where rownum <= 3";
         pstmt = conn.prepareStatement(sql);
         // 바인딩

          rs = pstmt.executeQuery();
          
          while(rs.next()) {
             MovieDto tmp = new MovieDto();
             tmp.setMovie_num(rs.getInt("movie_num"));
             tmp.setMovie_title_eng(rs.getString("movie_title_eng"));
             tmp.setMovie_title_kr(rs.getString("movie_title_kr"));
             tmp.setMovie_year(rs.getString("movie_year"));
             tmp.setMovie_genre(rs.getString("movie_genre"));
             list.add(tmp);
          }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if(rs != null) rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      
      return list;
      
   }
   
}