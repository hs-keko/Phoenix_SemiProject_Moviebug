<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/movie_info_insert/insertform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
   <div class="container">
      <h1>영화 정보 저장 폼</h1>
      <form action="insert.jsp" method="post" id="insertForm">
         <div class="mb-3">
            <label class="form-label" for="movie_title_kr">영화제목(한글)</label>
            <input class="form-control" type="text" name="movie_title_kr" id="movie_title_kr" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_title_eng">영화제목(영문)</label>
            <input class="form-control" type="text" name="movie_title_eng" id="movie_title_eng" />
         </div>
         <div>
            <label class="form-label" for="movie_story">줄거리</label>
            <input class="form-control" type="text" name="movie_story" id="movie_story"></input>
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_character">영화 출연진</label>
            <input class="form-control" type="text" name="movie_character" id="movie_character" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_director">영화 감독</label>
            <input class="form-control" type="text" name="movie_director" id="movie_director" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_nation">영화 제작 국가</label>
            <input class="form-control" type="text" name="movie_nation" id="movie_nation" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_year">영화 제작년도</label>
            <input class="form-control" type="text" name="movie_year" id="movie_year" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_genre">영화 장르</label>
            <input class="form-control" type="text" name="movie_genre" id="movie_genre" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_company">영화 제작사</label>
            <input class="form-control" type="text" name="movie_company" id="movie_company" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_image">영화 이미지 경로</label>
            <input class="form-control" type="text" name="movie_image" id="movie_image" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_trailer">영화 트레일러 경로</label>
            <input class="form-control" type="text" name="movie_trailer" id="movie_trailer" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_time">영화 러닝타임</label>
            <input class="form-control" type="text" name="movie_time" id="movie_time" />
         </div>
         <div class="mb-3">
            <label class="form-label" for="movie_rating">영화 평점</label>
            <input class="form-control" type="text" name="movie_rating" id="movie_rating" />
         </div>
         
         
         <button class="btn btn-primary" type="submit">저장</button>
      </form>
   </div>
</body>
</html>