<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%> 
<%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%
	/* 
		
insert into movie_info (movie_num,
movie_title_kr ,
movie_title_eng ,
movie_story,
movie_character,
movie_year,
movie_genre,
movie_company,
movie_image,
movie_trailer,
movie_time,
movie_rating)
 values 
(movie_info_seq.nextval,
'테스트05',
'test05',
'테스트스토리내용',
'테스트등장인물',
'20210705',
'스릴러',
'테스트영화사03',
'',
'유튜브링크',
'140',
'6')
	*/
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <a href="index.jsp">인덱스로</a>

    <div class="insertDB">
      <button id="btn">db에 데이터 넣기</button>
    </div>
    <script>

      let apikey = "2332fdffb0b8e2f723ce1f01999d42e9"

      let moviename = "&movieNm="
      let director = "&directorNm="
      
      let box = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=" + apikey
      
      let movieListApi =
        "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=" +
        apikey
        
        
        
      let resultdata


      const insertDb = (data) => {
        console.log(JSON.stringify(data))
        fetch("getMovieList.jsp", {
          method: "post",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
          },
          body: JSON.stringify(data),
        })
          .then((res) => {
            return res.json()
          })
          .then((d) => {
            console.log(d)
          })
      }
      
      
      const movieList = () => {
        let ajaxReq =
          movieListApi + "&openStartDt=2000&openEndDt=2021&itemPerPage=100&curPage=20"
        console.log(ajaxReq)
        fetch(ajaxReq)
          .then((res) => {
            return res.json()
          })
          .then((data) => {
            resultdata = data.movieListResult.movieList
            insertDb(resultdata)
            console.log(data.movieListResult.movieList[0].movieNmEn)
          })
      }

      document.querySelector("#btn").addEventListener("click", () => {
        movieList()
      })
    </script>
  </body>
</html>
