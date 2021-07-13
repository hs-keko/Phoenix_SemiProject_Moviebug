<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

   String category = request.getParameter("category");
   
   if(category==null){
      category="";
   }
   //특수기호를 인코딩한 키워드
   String encodedK=URLEncoder.encode(category);
   
   //최신 인기
   //List<MovieDto> ResentList = MovieDao.getInstance().getResentList();
   //여름 특선
   //List<MovieDto> SummerList = MovieDao.getInstance().getSummerList();

   //로그인된 아이디 (로그인을 하지 않았으면 null 이다)
   String email=(String)session.getAttribute("email");
   //로그인 여부
   boolean isLogin=false;
   if(email != null){
      isLogin=true;
   }
   
   /*
      [ 댓글 페이징 처리에 관련된 로직 ]
   */
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=12;
   
   //detail.jsp 페이지에서는 항상 1페이지의 댓글 내용만 출력한다. 
   int pageNum=1;
   
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum=pageNum*PAGE_ROW_COUNT;
   
   //원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
   MovieDto movieDto=new MovieDto();
   
   //1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
   movieDto.setStartRowNum(startRowNum);
   movieDto.setEndRowNum(endRowNum);
   
   List<MovieDto> movieList= new ArrayList<>();
         
    
   //1페이지에 해당하는 댓글 목록만 select 되도록 한다. 
   if (category == "resent") {
      movieList =  MovieDao.getInstance().getResentList();
   } else if (category == "classic") {
      movieList =  MovieDao.getInstance().getSummerList();
   }
   
   
   //원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
   int totalRow=MovieDao.getInstance().getCount();
   //댓글 전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   
   
   
 
   //boolean isSearch = false;
  
   
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>more.jsp</title>
   <!-- more css -->
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/more.css" />

    <!-- navbar 필수 import -->
    <jsp:include page="include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    
    <link rel="stylesheet" type="text/css" href="css/footer.css" />
    
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

   <!-- 웹폰트 test -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Girassol&family=Major+Mono+Display&display=swap" rel="stylesheet">
<style>
   .page-ui a{
      text-decoration: none;
      color: #000;
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: red;
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .page-ui ul > li{
      float: left;
      padding: 5px;
   }
</style>
</head>
<body>

   <!-- navbar 필수 import -->
    <jsp:include page="include/navbar.jsp"> 
       <jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>

<div class="container">

   <!-- 검색했을경우 보이는 검색창 -->
        <%
           //String condition = request.getParameter("condition");
           // 검색옵션처리는 나중에
           String condition = "qna_title_content";
           String keyword = request.getParameter("keyword");
           if(keyword != null){%>
           
         <form action="list.jsp" method="get">
            <label for="condition">검색 조건</label>
            <select name="condition" id="condition">
              <option value="qna_title_content" <%=condition.equals("qna_title_content") && condition != null ? "selected" : ""%>>제목+내용</option>
               <option value="qna_title" <%=condition.equals("qna_title") && condition != null ? "selected" : ""%>>제목</option>
               <option value="qna_writer" <%=condition.equals("qna_writer")  && condition != null? "selected" : ""%>>작성자</option>
          </select>
          <input type="text" name="keyword" placeholder="검색어를 입력하세요..." value="<%=keyword%>"/>
          <button type="submit">검색</button>
         </form>

         <%if(!condition.equals("")){ %>
            <p>
               <strong><%=totalRow %></strong>개의 글이 검색되었습니다.
            </p>
         <%} 
           }%>
        


   <div class="container-xl index_content">
       
         <div class="row index_content02">
             <div class="row">
              <div class="col flex_box index_category">
               <h1>최신 인기작</h1>
              </div>
            </div>
            
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
       </div>
          
         
     </div>
          
             
        
</div>   
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>   
<script>
   
</script>      
   <jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>