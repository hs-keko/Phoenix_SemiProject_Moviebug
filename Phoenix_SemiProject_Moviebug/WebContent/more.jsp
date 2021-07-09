<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String category = request.getParameter("category");

	List<MovieDto> list = new ArrayList<>();
	
	if(category == null) category = "search";
	
	 if(category.equals("resent")){
	    list = MovieDao.getInstance().getRecentMovies();
	 }else if(category.equals("classic")){
	    list = MovieDao.getInstance().getClassicList();
	 } 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>more.jsp</title>
</head>
<body>
<div class="row index_content02">
      	 <div class="row">
	        <div class="col flex_box index_category">
	        <%if(category.equals("resent")){ %>
	      		높은 평점 순 최신작
	      		<%}else{ %>
	      		 여름 추천 영화 (스릴러, 액션)
	      		<%} %>
	        </div>
      	</div>
        <div class="row">
          <div class="col">
            <div class="row">
        <!-- ****************************************** -->
              		 <%for(MovieDto dto: list){ %>
              		
		              <div class="col">
		                <div class="card border-0">
		                  <img
		                    src="<%=dto.getMovie_image() != null ? dto.getMovie_image():"images/bigdata.jpg" %>"
		                    class="card-img-top"
		                    alt="<%=dto.getMovie_title_kr()  %>"/>
		                  <div class="card-body">
		                    <h5 class="card-title"><%=dto.getMovie_title_kr() %></h5>
		                    <p class="card-text"><small class="text-muted"><%=dto.getMovie_nation() %> | <%=dto.getMovie_genre() %></small></p>
		                    <p class="card-text">
		                      <%=dto.getMovie_story()%>
		                    </p>
		                    <p class="card-text"><small class="text-danger">평점 <%=dto.getMovie_rating() %></small></p>
		                  </div>
		                </div>
		              </div>
              		 
		              <%} %>
      <!-- ********************************************* -->
             
            </div>
          </div>
        </div>
        <div class="row align-self-center justify-content-center morewrapper">
          <a href="<%=request.getContextPath() %>/more.jsp?category=resent" title="" class="moreanchor">더보기</a>
        </div>
      </div>
	
	
</body>
</html>