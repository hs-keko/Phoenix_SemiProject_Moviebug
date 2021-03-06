<%@page import="java.util.List"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.movieinfo.dao.MovieCommentDao"%>
<%@page import="moviebug.movieinfo.dto.MovieCommentDto"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Thread.sleep(1000);
	//로그인된 아이디
	String email = (String)session.getAttribute("email");
	//ajax 요청 파라미터로 넘어오는 댓글의 페이지 번호를 읽어낸다
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	//ajax 요청 파라미터로 넘어오는 원글의 페이지 번호를 읽어낸다.
	String category=(String)request.getParameter("category");
	String keyword=request.getParameter("keyword");
	
	if(category==null){
		   category="";
	   }
	   
	/*
	[댓글 페이징 처리]
	*/
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=12;
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	//원글의 글번호를 이용해 해당글에 달린 댓글 목록을 얻어옴
	MovieDto movieDto = new MovieDto();
	movieDto.setMovie_category(category);
	
	//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
	movieDto.setStartRowNum(startRowNum);
	movieDto.setEndRowNum(endRowNum);
		
	//pageNum에 해당하는 댓글 목록만 select 되도록 한다. 
	List<MovieDto> movieList= new ArrayList<>();
		
	int totalRow = 0;
	if (category.equals("resent")) {
		movieList =  MovieDao.getInstance().getResentList(movieDto);
		totalRow=MovieDao.getInstance().getCountResent();
	} else if (category.equals("classic")){
		movieList =  MovieDao.getInstance().getSummerList(movieDto);
		totalRow=MovieDao.getInstance().getCountClassic();
	} else {
		   MovieDto Mdto=new MovieDto();
		   Mdto.setStartRowNum(startRowNum);
		   Mdto.setEndRowNum(endRowNum);
			 //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			
			   //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
			   int MtotalRow=0;
			   //만일 검색 키워드가 넘어온다면 
			   if(!keyword.equals("")){
			      //검색 조건이 무엇이냐에 따라 분기 하기
			      
			        Mdto.setMovie_title_eng(keyword);
			        Mdto.setMovie_title_kr(keyword);
			        Mdto.setMovie_director(keyword);
			        movieList=MovieDao.getInstance().getListTD(Mdto);
			         //제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
			         MtotalRow=MovieDao.getInstance().getCountTD(Mdto);
			     
			   }else{//검색 키워드가 넘어오지 않는다면
			      //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
			      movieList=MovieDao.getInstance().getList(Mdto);
			      //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
			      MtotalRow=CafeDao.getInstance().getCount();
			   }
		 
	}
	
		
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
%>
    
	<div class="row row-cols-1 row-cols-md-4 g-4"> 
            <%for(MovieDto tmp: movieList) {%>
                <div class="col col-6 col-lg-3 movie_list">
                  <a href="<%=request.getContextPath() %>/movieinfo/movieinfo.jsp?movie_num=<%=tmp.getMovie_num() %>" class="poster_link">
                  <div class="card border-0">
                  <div class="card-body poster_info">
                    <h5 class="card-title"><%=tmp.getMovie_title_kr() %></h5>
                    <p class=""><small class="text-muted"><%=tmp.getMovie_nation() %> | <%=tmp.getMovie_genre() %></small></p>
                    <p class="card-text">
                      <%=tmp.getMovie_story() == null ? '.' : tmp.getMovie_story().length() >= 120 ? tmp.getMovie_story()+"...":tmp.getMovie_story() %>
                    </p>
                    <p class="card-text"><small class="text-danger">평점 <%=tmp.getMovie_rating() %></small></p>
                  </div>
                  <img
                    src="<%=tmp.getMovie_image() != null ? tmp.getMovie_image():"images/bigdata.jpg" %>"
                    class="rounded card-img-top"
                    alt="<%=tmp.getMovie_title_kr() %>"/>
                   </div>
                   </a>
                 </div>
              <%} %>
         </div>