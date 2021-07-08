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
	
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>index.jsp</title>
    <jsp:include page="include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/index.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/footer.css" />
    
    <!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">

  </head>
  <body>
    <div class="container-xl index_content">

    <jsp:include page="include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
    
    <!-- search modal -->

      <div class="row index_content01">
        <div
          id="carouselExampleCaptions"
          class="carousel slide"
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
            <div class="carousel-item border-0 <%= i == 0 ?  "active" : ""%>">
            	<div class="card border-0">
              <img src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>" class="d-block w-100" alt="..." />
              <div class="carousel-caption d-none d-md-block">
                <h5><%=dto.getMovie_title_kr() %></h5>
                <p>
                  <%= dto.getMovie_title_eng()%>
                </p>
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

      <div class="row index_content02">
      	 <div class="row">
	        <div class="col flex_box index_category">
	      		카테고리 ( 최근개봉영화(한달이내) 가장 높은 평점 )
	        </div>
      	</div>
        <div class="row">
          <div class="col">
            <div class="row">
        <!-- ****************************************** -->
              		 <%for(MovieDto dto: Top4List){ %>
              		 <a href="#" class="col-6 col-lg-3">
		              <div class="col">
		                <div class="card border-0">
		                  <img
		                    src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>"
		                    class="card-img-top"
		                    alt="<%=dto.getMovie_title_kr() %>"/>
		                  <div class="card-body">
		                    <h5 class="card-title"><%=dto.getMovie_title_kr() %></h5>
		                    <p class="card-text"><small class="text-muted"><%=dto.getMovie_nation() %> | <%=dto.getMovie_genre() %></small></p>
		                    <p class="card-text">
		                      <%=dto.getMovie_story().length() >= 140 ? dto.getMovie_story()+"...":dto.getMovie_story() %>
		                    </p>
		                    <p class="card-text"><small class="text-danger">평점 <%=dto.getMovie_rating() %></small></p>
		                  </div>
		                </div>
		              </div>
              		 </a>
		              <%} %>
      <!-- ********************************************* -->
             
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
	      		고전 명작
	        </div>
      	</div>
        <div class="row">
          <div class="col">
            <div class="row">
              
         <!-- ****************************************** -->
	      <%for(int i = 0 ; i<4; i++){ %>
	      		<a href="#" class="col-6 col-lg-3">
	              <div class="col">
	                <div class="card border-0">
	                  <img
	                    src="images/bigdata.jpg"
	                    class="card-img-top"
	                    alt="..."
	                  />
	                  <div class="card-body">
	                    <h5 class="card-title">Card title 0<%=i %></h5>
	                    <p class="card-text">
	                      This is a longer card with supporting text below as a
	                      natural lead-in to additional c
	                    </p>
	                  </div>
	                </div>
	              </div>
	      		</a>
	              <%} %>
		      <!-- ********************************************* -->
             
            </div>
          </div>
        </div>
        <div class="row align-self-center justify-content-center morewrapper">
          <a href="<%=request.getContextPath() %>/more.jsp?category=classic" title="" class="moreanchor">더보기</a>
        </div>
      </div>

      <div class="row index_content04">
        <div class="col">
          <div class="card mb-3">
            <div class="row g-0">
              <div class="col-md-8">
                <div
                  id="carouselExampleControls02"
                  class="carousel slide"
                  data-bs-ride="carousel"
                >
                  <div class="carousel-inner">
                    <div class="carousel-item active">
                      <img src="images/bigdata.jpg" class="d-block" alt="..." />
                    </div>
                    <div class="carousel-item">
                      <img src="images/bigdata.jpg" class="d-block" alt="..." />
                    </div>
                    <div class="carousel-item">
                      <img src="images/bigdata.jpg" class="d-block" alt="..." />
                    </div>
                  </div>
                  <button
                    class="carousel-control-prev"
                    type="button"
                    data-bs-target="#carouselExampleControls02"
                    data-bs-slide="prev"
                  >
                    <span
                      class="carousel-control-prev-icon"
                      aria-hidden="true"
                    ></span>
                    <span class="visually-hidden">Previous</span>
                  </button>
                  <button
                    class="carousel-control-next"
                    type="button"
                    data-bs-target="#carouselExampleControls02"
                    data-bs-slide="next"
                  >
                    <span
                      class="carousel-control-next-icon"
                      aria-hidden="true"
                    ></span>
                    <span class="visually-hidden">Next</span>
                  </button>
                </div>
              </div>
              <div class="col-md-4">
                <div class="card-body">
                  <h5 class="card-title">Card title</h5>
                  <p class="card-text">
                    This is a wider card with supporting text below as a natural
                    lead-in to additional content. This content is a little bit
                    longer.
                  </p>
                  <p class="card-text">
                    <small class="text-muted">Last updated 3 mins ago</small>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <!-- import footer.jsp -->
      <jsp:include page="include/footer.jsp"></jsp:include>
      
      <!-- import navbar.js -->
      <script src="<%= request.getContextPath()%>/js/navbar.js"></script>
  </body>
</html>