<%@page import="java.util.ArrayList"%>
<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 상태 확인
	boolean isLogin = false;
	String email = (String)session.getAttribute("email"); 
	if(email != null) isLogin = true;
	// 메인 carousel 최신 영화 3개 리스트 가져오기
	List<MovieDto> NewMovieList = MovieDao.getInstance().getNewMovies();
	
	// 평점순위 4개 영화 리스트 가져오기
	List<MovieDto> Top4List = MovieDao.getInstance().getTop4ResList();
	
	// 최신 공포,액션 영화 4개 리스트
	List<MovieDto> NewHAmovies = MovieDao.getInstance().getNewHAList();
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>MovieBug</title>
    
    <!-- navbar 필수 import -->
    <jsp:include page="include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    
    <!-- import css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/index.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/footer.css" />
    
  
  </head>
  <body>

	<!-- navbar 필수 import -->
    <jsp:include page="include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
    
    <!-- search modal -->
      <div class="row index_content01">
        <div
          id="carouselExampleCaptions"
          class="carousel slide carousel-fade carousel_wrapper"
          data-bs-ride="carousel" >
          <div class="carousel-indicators">
            <button
              type="button"
              data-bs-target="#carouselExampleCaptions"
              data-bs-slide-to="0"
              class="active"
              aria-current="true"
              aria-label="Slide 1"
            ></button>
            <button
              type="button"
              data-bs-target="#carouselExampleCaptions"
              data-bs-slide-to="1"
              aria-label="Slide 2"
            ></button>
            <button
              type="button"
              data-bs-target="#carouselExampleCaptions"
              data-bs-slide-to="2"
              aria-label="Slide 3"
            ></button>
          </div>
          
          
          <!-- ////////////////// -->
          
          <div class="carousel-inner">
          
          <%for(int i = 0; i < NewMovieList.size(); i++) {
          	MovieDto dto = NewMovieList.get(i);
          %>
            <div class="carousel-item  border-0 <%= i == 0 ?  "active" : ""%>" data-bs-interval="10000">
            	<div class="card border-0">
              <img src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>" class="d-block" alt="..." />
              <div class="carousel-caption d-none d-md-block">
              <button type="button" class="btn btn-white rounded-pill index_carousel_btn">
	              <a href="<%=request.getContextPath() %>/movieinfo/movieinfo.jsp?movie_num=<%=dto.getMovie_num() %>">
	                <h5><%=dto.getMovie_title_kr() %></h5>
	                <p>
	                  	정보보기
	                </p>
                </a>
              </button>
              </div>
            </div>
              
            </div>
            <%} %>
            
          </div>
          <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#carouselExampleCaptions"
            data-bs-slide="prev"
          >
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#carouselExampleCaptions"
            data-bs-slide="next"
          >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>

 <div class="container-xl index_content">
      <div class="row index_content02">
      	 <div class="row">
	        <div class="col flex_box index_category">
	      		최신 인기
	        </div>
      	</div>
        <div class="row">
          <div class="col">
            <div class="row" >
              		 <%for(MovieDto dto: Top4List){ %>
		              <div class="col-6 col-lg-3 movie_list">
              		 	<a href="<%=request.getContextPath() %>/movieinfo/movieinfo.jsp?movie_num=<%=dto.getMovie_num() %>" class="poster_link">
		                <div class="card border-0">
		                  <div class="card-body poster_info">
		                    <h5 class="card-title"><%=dto.getMovie_title_kr() %></h5>
		                    <p class="card-text"><small class="text-muted"><%=dto.getMovie_nation() %> | <%=dto.getMovie_genre() %></small></p>
		                    <p class="card-text">
		                      <%=dto.getMovie_story().length() >= 120 ? dto.getMovie_story()+"...":dto.getMovie_story() %>
		                    </p>
		                    <p class="card-text"><small class="text-danger">평점 <%=dto.getMovie_rating() %></small></p>
		                  </div>
		                  <img
		                    src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>"
		                    class="rounded card-img-top"
		                    alt="<%=dto.getMovie_title_kr() %>"/>
		                </div>
              		 		</a>
		              </div>
		              <%} %>
             
            </div>
          </div>
        </div>
        <div class="row align-self-center justify-content-center morewrapper">
          <a href="<%=request.getContextPath() %>/more.jsp?category=resent" title="" class="moreanchor">더보기</a>
        </div>
      </div>

      <div class="row index_content03">
        <div class="row">
	        <div class="col flex_box index_category">
	      		여름 추천
	        </div>
      	</div>
        <div class="row">
          <div class="col">
            <div class="row movie_list">
              		 <%for(MovieDto dto: NewHAmovies){ %>
		              <div class="col-6 col-lg-3 movie_list">
              		 		<a href="<%=request.getContextPath() %>/movieinfo/movieinfo.jsp?movie_num=<%=dto.getMovie_num() %>" class="poster_link">
		                <div class="card border-0">
		                  <div class="card-body poster_info">
		                    <h5 class="card-title"><%=dto.getMovie_title_kr() %></h5>
		                    <p class="card-text"><small class="text-muted"><%=dto.getMovie_nation() %> | <%=dto.getMovie_genre() %></small></p>
		                    <p class="card-text">
		                      <%=dto.getMovie_story().length() >= 120 ? dto.getMovie_story()+"...":dto.getMovie_story() %>
		                    </p>
		                    <p class="card-text"><small class="text-danger">평점 <%=dto.getMovie_rating() %></small></p>
		                  </div>
		                  <img
		                    src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>"
		                    class="rounded card-img-top"
		                    alt="<%=dto.getMovie_title_kr() %>"/>
		                </div>
              		 		</a>
		              </div>
		              <%} %>
            </div>
          </div>
        </div>
        <div class="row align-self-center justify-content-center morewrapper">
          <a href="<%=request.getContextPath() %>/more.jsp?category=classic" title="" class="moreanchor">더보기</a>
        </div>
      </div>

      <div class="row index_content04">
        <div class="col">
          
        </div>
      </div>

    </div>

      
      <script src="<%= request.getContextPath()%>/js/index.js"></script>

      <!-- navbar 필수 import -->
      <!-- import navbar.js -->
      <script src="<%= request.getContextPath()%>/js/navbar.js"></script>

		<!-- import footer.jsp -->
      	<jsp:include page="include/footer.jsp"></jsp:include>
  </body>
</html>