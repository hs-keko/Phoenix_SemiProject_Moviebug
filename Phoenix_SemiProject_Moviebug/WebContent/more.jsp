<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=10;
   //하단 페이지를 몇개씩 표시할 것인지
   final int PAGE_DISPLAY_COUNT=10;
   
   //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
   int pageNum=1;
   //페이지 번호가 파라미터로 전달되는지 읽어와 본다.
   String strPageNum=request.getParameter("pageNum");
   //만일 페이지 번호가 파라미터로 넘어 온다면
   if(strPageNum != null){
      //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
      pageNum=Integer.parseInt(strPageNum);
   }
   
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum=pageNum*PAGE_ROW_COUNT;
   
   String category = request.getParameter("category");
   
   if(category==null){
      category="";
   }
   //특수기호를 인코딩한 키워드
   String encodedK=URLEncoder.encode(category);
   
   String condition = request.getParameter("condition");
   String keyword = request.getParameter("keyword");
   
   //CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   CafeDto dto=new CafeDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);
   int totalRow = 1;
   //하단 시작 페이지 번호 
   int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
   //하단 끝 페이지 번호
   int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
   
   //전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
   if(endPageNum > totalPageCount){
      endPageNum=totalPageCount; //보정해 준다.
   }
      String email=(String)session.getAttribute("email");
      
      
   
      List<MovieDto> RecentMovies = MovieDao.getInstance().getRecentList();
   
   List<MovieDto> ClassicList = MovieDao.getInstance().getHorrorList();
   
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>more.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="../css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/footer.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">
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
<jsp:include page="../include/navbar.jsp">
   <jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
<div class="container">
   <h1>높은 평점 순 최신작</h1>

      <%for(MovieDto tmp: RecentMovies) {%>
      <a href="<%=request.getContextPath() %>/movieinfo.jsp?movie_num=<%=tmp.getMovie_num() %>" class="col-6 col-lg-3">
          <div class="col">
            <div class="card border-0">
              <img
                src="<%=tmp.getMovie_image() != null ? tmp.getMovie_image():"images/bigdata.jpg" %>"
                class="card-img-top"
                alt="<%=tmp.getMovie_title_kr() %>"/>
              <div class="card-body">
                <h5 class="card-title"><%=tmp.getMovie_title_kr() %></h5>
                <p class="card-text"><small class="text-muted"><%=tmp.getMovie_nation() %> | <%=tmp.getMovie_genre() %></small></p>
                <p class="card-text">
                  <%=tmp.getMovie_story().length() >= 140 ? tmp.getMovie_story()+"...":tmp.getMovie_story() %>
                </p>
                <p class="card-text"><small class="text-danger">평점 <%=tmp.getMovie_rating() %></small></p>
              </div>
            </div>
          </div>
               </a>
          <%} %>
      </tbody>
   </table>
   <div class="page-ui clearfix">
         <ul>
            <%if(startPageNum != 1){ %>
               <li>
                  <a href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
               </li>   
            <%} %>

            <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
               <li>
                  <%if(pageNum == i){ %>
                     <a class="active" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
                  <%}else{ %>
                     <a href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
                  <%} %>
               </li>   
            <%} %>
            <%if(endPageNum < totalPageCount){ %>
               <li>
                  <a href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Next</a>
               </li>
            <%} %>
         </ul>
      </div>
         <form action="list.jsp" method="get">
            <label for="condition">검색 조건</label>
            <select name="condition" id="condition">
              <option value="qna_title_content" <%=condition.equals("qna_title_content") ? "selected" : ""%>>제목+내용</option>
               <option value="qna_title" <%=condition.equals("qna_title") ? "selected" : ""%>>제목</option>
               <option value="qna_writer" <%=condition.equals("qna_writer") ? "selected" : ""%>>작성자</option>
          </select>
          <input type="text" name="keyword" placeholder="검색어를 입력하세요..." value="<%=keyword%>"/>
          <button type="submit">검색</button>
         </form>

         <%if(!condition.equals("")){ %>
            <p>
               <strong><%=totalRow %></strong>개의 글이 검색되었습니다.
            </p>
         <%} %>
      </div>
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>