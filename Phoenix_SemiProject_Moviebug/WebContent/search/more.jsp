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
	String category_name= request.getParameter("category");
   
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
         
   int totalRow = 0;
   //1페이지에 해당하는 댓글 목록만 select 되도록 한다.

   
   if (category.equals("resent")) {
      movieList =  MovieDao.getInstance().getResentList(movieDto);
      totalRow=MovieDao.getInstance().getCountResent();
   } else if (category.equals("classic")) {
      movieList =  MovieDao.getInstance().getSummerList(movieDto);
      totalRow=MovieDao.getInstance().getCountClassic();
   } 
   if(category.equals("resent")){
	      category_name="최신 인기";
	   }else if(category.equals("classic")){
	      category_name="여름 추천";
	   }
   
   //원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
   
   //댓글 전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   
   //boolean isSearch = false;
  
   
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화리스트</title>
   <!-- more css -->
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/more.css" />

    <!-- navbar 필수 import -->
    <jsp:include page="../include/resource.jsp"></jsp:include>
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
   
   .loader{
		/* 로딩 이미지를 가운데 정렬하기 위해 */
		text-align: center;
		/* 일단 숨겨 놓기 */
		display: none;
	}	
	
	.loader svg{
		animation: rotateAni 1s ease-out infinite;
	}
	
	@keyframes rotateAni{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}
</style>
</head>
<body>

   <!-- navbar 필수 import -->
    <jsp:include page="../include/navbar.jsp"> 
       <jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>

<div class="container">

 


   <div class="container-xl index_content">
       
         <div class="row index_content02">
             <div class="row">
              <div class="col flex_box index_category">
               <h1><%=category_name %></h1>
              </div>
            </div>
            
            <div class="movie_row">
	           <div class="row row-cols-1 row-cols-md-4 g-4 "> 
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
     
     <div class="loader">
		<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
			  <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
		</svg>
	</div>
          
             
        
</div>   
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>   
<script>
	
	//클라이언트가 로그인 했는지 여부
	let isLogin=<%=isLogin%>;
	
	
	
	//댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
	let currentPage=1;
	//마지막 페이지는 totalPageCount 이다.  
	let lastPage=<%=totalPageCount%>;
	
	//추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
	let isLoading=false; //현재 로딩중인지 여부 
	
	/*
		window.scrollY => 위쪽으로 스크롤된 길이
		window.innerHeight => 웹브라우저의 창의 높이
		document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
	*/
	window.addEventListener("scroll", function(){
		//바닥 까지 스크롤 했는지 여부 
		const isBottom = 
			window.innerHeight + window.scrollY  >= document.body.offsetHeight;
		//현재 페이지가 마지막 페이지인지 여부 알아내기
		let isLast = currentPage == lastPage;	
		//현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
		if(isBottom && !isLoading && !isLast){
			//로딩바 띄우기
			document.querySelector(".loader").style.display="block";
			
			//로딩 작업중이라고 표시
			isLoading=true;
			
			//현재 댓글 페이지를 1 증가 시키고 
			currentPage++;
			
			/*
				해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
				"pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
			*/
			ajaxPromise("ajax_more_list.jsp","get",
					"pageNum="+currentPage+"&category=<%=category%>")
			.then(function(response){
				//json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
				return response.text();
			})
			.then(function(data){
				//data 는 html 형식의 문자열이다. 
				console.log(data);
				// beforebegin | afterbegin | beforeend | afterend
				document.querySelector(".movie_row")
					.insertAdjacentHTML("beforeend", data);
				//로딩이 끝났다고 표시한다.
				isLoading=false;
				//새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
				
				//로딩바 숨기기
				document.querySelector(".loader").style.display="none";
			});
		}
	});
	
</script>     
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>