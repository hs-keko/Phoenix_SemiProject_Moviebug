<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

   //1. 폼 전송되는 글 제목과 내용을 읽어와서 
   String movie_title_kr=request.getParameter("movie_title_kr");
   String movie_title_eng=request.getParameter("movie_title_eng");
   String movie_story=request.getParameter("movie_story");
   String movie_character=request.getParameter("movie_character");
   String movie_year=request.getParameter("movie_year");
   String movie_genre=request.getParameter("movie_genre");
   String movie_company=request.getParameter("movie_company");
   String movie_image=request.getParameter("movie_image");
   String movie_trailer=request.getParameter("movie_trailer");
   String movie_time=request.getParameter("movie_time");
   String movie_rating=request.getParameter("movie_rating");
   String movie_nation=request.getParameter("movie_nation");
   String movie_director=request.getParameter("movie_director");
   //2. DB 에 저장하고
   MovieDto dto=new MovieDto();
   dto.setMovie_title_kr(movie_title_kr);
   dto.setMovie_title_eng(movie_title_eng);
   dto.setMovie_story(movie_story);
   dto.setMovie_character(movie_character);
   dto.setMovie_year(movie_year);
   dto.setMovie_genre(movie_genre);
   dto.setMovie_company(movie_company);
   dto.setMovie_image(movie_image);
   dto.setMovie_trailer(movie_trailer);
   dto.setMovie_time(movie_time);
   dto.setMovie_rating(movie_rating);
   dto.setMovie_nation(movie_nation);
   dto.setMovie_director(movie_director);
   
   boolean isSuccess=MovieDao.getInstance().insert(dto);
   //3. 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/movie_info_insert/insert.jsp</title>
</head>
<body>
<div class="container">
   <%if(isSuccess){ %>
   <script>
      alert("새 영화 정보가 저장되었습니다.")
      location.href="${pageContext.request.contextPath}/movie_info_insert/insertform.jsp";
   </script>
   <%}else{ %>
   <script>
      alert("영화 정보 저장 실패");
      location.href="${pageContext.request.contextPath}/movie_info_insert/insertform.jsp";
   </script>
   <%} %>

	//1. 폼 전송되는 글 제목과 내용을 읽어와서 
	String movie_title_kr=request.getParameter("movie_title_kr");
	String movie_title_eng=request.getParameter("movie_title_eng");
	String movie_story=request.getParameter("movie_story");
	String movie_character=request.getParameter("movie_character");
	String movie_year=request.getParameter("movie_year");
	String movie_genre=request.getParameter("movie_genre");
	String movie_company=request.getParameter("movie_company");
	String movie_image=request.getParameter("movie_image");
	String movie_trailer=request.getParameter("movie_trailer");
	String movie_time=request.getParameter("movie_time");
	String movie_rating=request.getParameter("movie_rating");
	String movie_nation=request.getParameter("movie_nation");
	String movie_director=request.getParameter("movie_director");
	//2. DB 에 저장하고
	MovieDto dto=new MovieDto();
	dto.setMovie_title_kr(movie_title_kr);
	dto.setMovie_title_eng(movie_title_eng);
	dto.setMovie_story(movie_story);
	dto.setMovie_character(movie_character);
	dto.setMovie_year(movie_year);
	dto.setMovie_genre(movie_genre);
	dto.setMovie_company(movie_company);
	dto.setMovie_image(movie_image);
	dto.setMovie_trailer(movie_trailer);
	dto.setMovie_time(movie_time);
	dto.setMovie_rating(movie_rating);
	dto.setMovie_nation(movie_nation);
	dto.setMovie_director(movie_director);
	
	boolean isSuccess=MovieDao.getInstance().insert(dto);
	//3. 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/movie_info_insert/insert.jsp</title>
</head>
<body>
<div class="container">
	<%if(isSuccess){ %>
	<script>
		alert("새 영화 정보가 저장되었습니다.")
		location.href="${pageContext.request.contextPath}/movie_info_insert/insertform.jsp";
	</script>
	<%}else{ %>
	<script>
		alert("영화 정보 저장 실패");
		location.href="${pageContext.request.contextPath}/movie_info_insert/insertform.jsp";
	</script>
	<%} %>

</div>
</body>
</html>