<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.movieinfo.dao.MovieCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="moviebug.movieinfo.dto.MovieCommentDto"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자세히 보여줄 글번호를 읽어온다. 
	int movie_num=Integer.parseInt(request.getParameter("movie_num"));
	//로그인된 아이디 (로그인을 하지 않았으면 null 이다)
	String email=(String)session.getAttribute("email");
	//로그인 여부
	boolean isLogin=false;
	if(email != null){
	   isLogin=true;
	}

	MovieDto dto=MovieDao.getInstance().getData(movie_num);
	
	
	
	/*
    [ 댓글 페이징 처리에 관련된 로직 ]
 	*/
 	//한 페이지에 몇개씩 표시할 것인지
 	final int PAGE_ROW_COUNT=10;
 
 	//detail.jsp 페이지에서는 항상 1페이지의 댓글 내용만 출력한다. 
 	int pageNum=1;
 
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
 
	//원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
	MovieCommentDto commentDto=new MovieCommentDto();
	commentDto.setComment_ref_group(movie_num);
	//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
	commentDto.setStartRowNum(startRowNum);
	commentDto.setEndRowNum(endRowNum);
 
	//1페이지에 해당하는 댓글 목록만 select 되도록 한다. 
	List<MovieCommentDto> commentList=
		MovieCommentDao.getInstance().getList(commentDto);
 
	//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
	int totalRow=MovieCommentDao.getInstance().getCount(movie_num);
	//댓글 전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
 
	//글정보를 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[<%=dto.getMovie_title_kr()%>] 영화 정보</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="../css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/footer.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">
<link rel="icon" 
	href="${pageContext.request.contextPath}/images/dy_cat.png" 
	type="image/x-icon" />
<!-- Custom styles for this template -->
<link href="https://getbootstrap.com/docs/5.0/examples/product/product.css" rel="stylesheet">
<style>
	
	.css-title{
		box-sizing: border-box;
		min-width: 0px;
		color: black;
		font-size: 30px;
		font-weight: 600;
		flex: 1 1 0px;
		width: 446px;
		margin: 0px;
		font-family: 'NanumSquare';
	}
	
	.css-title_eng{
		box-sizing: border-box;
		margin: 0px 14px 0px 0px;
		min-width: 0px;
		align-items: center;
		display: flex;
	}
	
	.css-title_eng_txt{
		box-sizing: border-box;
		margin: 0px 0px 0px 4px;
		min-width: 0px;
		font-size: 17px;
		line-height: 1.15;
		color: rgb(103, 103, 103);
	}
	
	.css-detail_txt{
		box-sizing: border-box;
		margin: 0;
		min-width: 0;
	}
	
	.css-bar{
		box-sizing: border-box;
		display: block;
		vertical-align: middle;
		margin: 4px 8px 2px;
		min-width: 1px;
		width: 1px;
		height: 16px;
		background-color: black;
	}
	
	
	#movieinfo_container{
		margin-top:100px;
		max-width:720px;
	}

	.container.movieinfo{
		width: 720px;
	}
	
	.movie_trailer{
		position: relative;
	    margin-bottom: 11px;
	    width: 720px;
	    height: 405px;
	    display: flex;
	    align-items: center;
	    padding: 0;
	}
	
	.movie_primary_info{
		box-sizing: border-box;
		position: relative;
	    margin-bottom: 10px;
	    min-width: 0px;
	    width: 720px;
	    height: 250px;
	    padding: 20px;
	    display: flex;
	    border: 2px solid rgb(170 170 170);
	    border-radius: 10px;
	}
	
	.movie_primary_info_inner{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		width: 100%;
		display: flex;
	}
	
	.movie_primary_info_inner_poster{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		width: 151px;
		height: 204px;
		overflow: hidden;
		flex: 0 0 auto;
		border-radius: 6px;
	}
	
	.movie_img{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		max-width: 100%;
		height: auto;
		width: 100%
	}
	
	.movie_primary_info_inner_detail{
		box-sizing: border-box;
		margin: 0px 0px 0px 16px;
		min-width: 0px;
		flex: 1 1 0%;
		flex-direction: column;
		overflow: hidden;
		padding-top: 5px;
		padding-bottom: 5px;
		display: flex;
	}
	
	.movie_primary_info_inner_detail_title{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		display: flex;
	}
	
	.title_txt_container{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		align-items: center;
		display:flex;
	}
	
	.title_txt{
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.movie_primary_info_inner_detail_eng_title{
		box-sizing: border-box;
		margin: 8px 0px 0px;
		min-width: 0px;
		height: auto;
		align-items: flex-start;
		flex: 1 1 0%;
		display: flex;
	}
	
	.movie_primary_info_inner_detail_info{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		flex: 1 1 0%;
		flex-direction: column;
		justify-content: space-between;
		font-size: 16px;
		color: black;
		display: flex;
		font-size: 14px;
	}
	
	.movie_primary_info_inner_detail_info_one{
		box-sizing: border-box;
		margin: 20px 0px 0px 0px;
		min-width: 0px;
		align-items: center;
		display: flex;
	}
	.movie_primary_info_inner_detail_info_two{
		box-sizing: border-box;
		margin: 0px 0px 0px 0px;
		min-width: 0px;
		align-items: center;
		display: flex;
	}
	
	.movie_secondary_info{
		box-sizing: border-box;
		position: relative;
		margin-bottom: 10px;
		min-width: 0px;
		width: 720px;
	    display: flex;
	    border: 2px solid rgb(170 170 170);
	    border-radius: 10px;
	    flex-direction: column;
	    padding: 0;
	}
	
	.movie_secondary_info_radio_wrapper{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		width: 100%;
		height: 50px;
		display:flex;
		padding:0;
	}
	
	.movie_secondary_info_radio{
		box-sizing: border-box;
		width: 100%;
		height: 100%;
		display: flex;
	}
	
	#btnOne, #btnTwo, #btnThree{
		text-align: center;
		line-height: 30px;
		width: 100%;
		height: 100%;
		border: 3px solid rgb(170 170 170);
	}
	
	#btnOne{
		border-radius: 10px 0 0 0;
	}
	
	#btnTwo{
		border-radius: 0px;
	}
	
	#btnThree{
		border-radius: 0 10px 0 0;
	}
	
	.movie_secondary_info_detail_wrapper{
		width: 100%;
		height: 350px;
		padding: 20px;
	}
	
	.movie_secondary_info_detail_box{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		width: 100%;
		paddig-top: 12px;
		padding-bottom: 12px;
		display: flex;
	}
	.movie_secondary_info_detail_title{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		flex: 0 0 auto;
		width: 86px;
		line-height: 27px;
		font-weight: bold;
		color: rgb(120 120 120);
	}
	
	.movie_secondary_info_detail_content{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		flex: 1 1 0%;
		line-height: 27px;
		font-weight: bold;
		color: black;
	}
	
	.movie_secondary_info_detail_rating_box{
		box-sizing: border-box;
		margin: 0px;
		min-width: 0px;
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		
	}
	
	#star{
		width: 40px;
		height: 40px;
		margin-right: 20px;
	}
	
	#rating_span{
		font-size: 40px;
	}
	
	#noRating_span{
		font-size: 40px;
		color: rgb(170 170 170);
	}
   /*======================================================================*/
   
   
   
   	
   /* 댓글 프로필 이미지를 작은 원형으로 만든다. */
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   /* ul 요소의 기본 스타일 제거 */
   .comments ul{
      padding: 0;
      margin: 0;
      list-style-type: none;
   }
   .comments dt{
      margin-top: 5px;
   }
   .comments dd{
      margin-left: 50px;
   }
   .comment-form textarea, .comment-form button{
      float: left;
   }
   .comments li{
      clear: left;
   }
   .comments ul li{
      border-top: 1px solid #888;
   }
   .comment-form textarea{
      width: 84%;
      height: 100px;
   }
   .comment-form button{
      width: 14%;
      height: 100px;
   }
   /* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
   .comments .comment-form{
      display: none;
   }
   /* .reply_icon 을 li 요소를 기준으로 배치 하기 */
   .comments li{
      position: relative;
   }
   .comments .reply-icon{
      position: absolute;
      top: 1em;
      left: 1em;
      color: red;
   }
   pre {
     display: block;
     padding: 9.5px;
     font-size: 13px;
     line-height: 1.42857143;
     color: #333333;
     word-break: break-all;
     word-wrap: break-word;
     background-color: #f5f5f5;
     border: 1px solid #ccc;
     border-radius: 4px;
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
	<jsp:include page="../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
    <div class="container" id="movieinfo_container">
	<div class="row movieinfo">
		<!-- 영화 정보 카드 -->
		<div class="row movie_primary_info">
			<div class="movie_primary_info_inner">
				<div class="movie_primary_info_inner_poster">
					<img class="movie_img" src="<%=dto.getMovie_image() %>"/>
				</div>
				<div class="movie_primary_info_inner_detail">
					<div class="movie_primary_info_inner_detail_title">
						<div class="title_txt_container">
							<h2 class="title_txt css-title"><%=dto.getMovie_title_kr() %></h2>
						</div>
					</div>
					<div class="movie_primary_info_inner_detail_eng_title">
						<div class="eng_title_txt_container">
							<div class="css-title_eng">
								<div class="css-title_eng_txt"><%=dto.getMovie_title_eng() %></div>
							</div>
						</div>
					</div>
					<div class="movie_primary_info_inner_detail_info">
						<div class="movie_primary_info_inner_detail_info_one">
							<div class="css-detail_txt"><%=dto.getMovie_nation() %></div>
							<div class="css-bar"></div>
							<div class="css-detail_txt"><%=dto.getMovie_genre() %></div>
							<div class="css-bar"></div>
							<div class="css-detail_txt"><%=dto.getMovie_time() %></div>
						</div>
						<div class="movie_primary_info_inner_detail_info_two">
							<div class="css-detail_txt"><%=dto.getMovie_company() %></div>
							<div class="css-bar"></div>
							<div class="css-detail_txt"><%=dto.getMovie_year() %></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 트레일러 -->
		<div class="row movie_trailer">
			<video autoplay muted controls width="100%" height="100%" style="padding:0;">
				<source src="../trailer/<%=movie_num%>.mp4" type="video/mp4">
			</video>
		</div>
		
		<!-- 영화 상세 정보 -->
		<div class="row movie_secondary_info">
			<div class="movie_secondary_info_radio_wrapper">
				<div class="movie_secondary_info_radio" role="group" aria-label="Basic radio toggle button group">
  					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
  						<label id="btnOne" class="btn btn-outline-secondary" for="btnradio1">줄거리</label>

  					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
  						<label id="btnTwo" class="btn btn-outline-secondary" for="btnradio2">감독 / 출연진</label>

  					<input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
  						<label id="btnThree" class="btn btn-outline-secondary" for="btnradio3">유저 평점</label>
				</div>
			</div>
			<div class="movie_secondary_info_detail_wrapper">
				
			</div>
		</div>
	</div>
		
		
		<!-- 댓글 목록 -->
   <div class="row comments">
      <ul>
         <%for(MovieCommentDto tmp: commentList){ %>
            <%if(tmp.getComment_deleted().equals("yes")){ %>
               <li>삭제된 댓글 입니다.</li>
            <% 
               // continue; 아래의 코드를 수행하지 않고 for 문으로 실행순서 다시 보내기 
               continue;
            }%>
         
            <%if(tmp.getComment_idx() == tmp.getComment_group()){ %>
            <li id="reli<%=tmp.getComment_idx()%>">
            <%}else{ %>
            <li id="reli<%=tmp.getComment_idx()%>" style="padding-left:50px;">
               <svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
               </svg>
            <%} %>
               <dl>
                  <dt>
                  <%if(tmp.getProfile() == null){ %>
                     <svg class="profile-image" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                     </svg>
                  <%}else{ %>
                     <img class="profile-image" src="${pageContext.request.contextPath}<%=tmp.getProfile()%>"/>
                  <%} %>
                  		<!-- 댓글 작성자의 이름을 가져와야 한다. -->
                  		
                     <span><%=UsersDao.getInstance().getData(tmp.getComment_writer()).getName() %></span>
                  <%if(tmp.getComment_idx() != tmp.getComment_group()){ %>
                     @<i><%=UsersDao.getInstance().getData(tmp.getComment_target_id()).getName() %></i>
                  <%} %>
                     <span><%=tmp.getComment_regdate() %></span>
                     <a data-num="<%=tmp.getComment_idx() %>" href="javascript:" class="reply-link">답글</a>
                  <%if(email != null && tmp.getComment_writer().equals(email)){ %>
                     <a data-num="<%=tmp.getComment_idx() %>" class="update-link" href="javascript:">수정</a>
                     <a data-num="<%=tmp.getComment_idx() %>" class="delete-link" href="javascript:">삭제</a>
                  <%} %>
                  </dt>
                  <dd>
                     <pre id="pre<%=tmp.getComment_idx()%>"><%=tmp.getComment_content() %></pre>                  
                  </dd>
               </dl>   
               <form id="reForm<%=tmp.getComment_idx() %>" class="animate__animated comment-form re-insert-form" 
                  action="<%=request.getContextPath() %>/movieinfo/private/comment_insert.jsp" method="post">
                  <input type="hidden" name="comment_ref_group"
                     value="<%=dto.getMovie_num()%>"/>
                  <input type="hidden" name="comment_target_id"
                     value="<%=tmp.getComment_writer()%>"/>
                  <input type="hidden" name="comment_group"
                     value="<%=tmp.getComment_group()%>"/>
                  <textarea name="comment_content"></textarea>
                  <button type="submit">등록</button>
               </form>   
               <%if(tmp.getComment_writer().equals(email)){ %>   
               <form id="updateForm<%=tmp.getComment_idx() %>" class="comment-form update-form" 
                  action="private/comment_update.jsp" method="post">
                  <input type="hidden" name="comment_idx" value="<%=tmp.getComment_idx() %>" />
                  <textarea name="comment_content"><%=tmp.getComment_content() %></textarea>
                  <button type="submit">수정</button>
               </form>
               <%} %>                  
            </li>
         <%} %>
      </ul>
   </div>
   <div class="row loader">
    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
  		<path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
  		<path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
	</svg>
   </div>
   <!-- 원글에 댓글을 작성할 폼 -->
   <div class="row">
   <form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
      <!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
      <input type="hidden" name="comment_ref_group" value="<%=movie_num%>"/>
      <!-- 원글의 작성자가 댓글의 대상자가 된다. -->
      <input type="hidden" name="comment_target_id" value="<%=dto.getMovie_writer()%>"/>
      
      <textarea name="comment_content"><%if(!isLogin){%>댓글 작성을 위해 로그인이 필요 합니다.<%}%></textarea>
      <button type="submit">등록</button>
   </form>
   </div>
</div>

<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
   
   //클라이언트가 로그인 했는지 여부
   let isLogin=<%=isLogin%>;
   
   document.querySelector(".insert-form")
      .addEventListener("submit", function(e){
         //만일 로그인 하지 않았으면 
         if(!isLogin){
            //폼 전송을 막고 
            e.preventDefault();
            //로그인 폼으로 이동 시킨다.
            location.href=
               "${pageContext.request.contextPath}/users/loginform.jsp?url=${pageContext.request.contextPath}/movieinfo.jsp?movie_num=<%=movie_num%>";
         }
      });
   
   /*
      detail.jsp 페이지 로딩 시점에 만들어진 1 페이지에 해당하는 
      댓글에 이벤트 리스너 등록 하기 
   */
   addUpdateFormListener(".update-form");
   addUpdateListener(".update-link");
   addDeleteListener(".delete-link");
   addReplyListener(".reply-link");
   
   
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
         ajaxPromise("ajax_comment_list.jsp","get",
               "pageNum="+currentPage+"&movie_num="+<%=movie_num%>)
         .then(function(response){
            //json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
            return response.text();
         })
         .then(function(data){
            //data 는 html 형식의 문자열이다. 
            console.log(data);
            // beforebegin | afterbegin | beforeend | afterend
            document.querySelector(".comments ul")
               .insertAdjacentHTML("beforeend", data);
            //로딩이 끝났다고 표시한다.
            isLoading=false;
            //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
            addUpdateListener(".page-"+currentPage+" .update-link");
            addDeleteListener(".page-"+currentPage+" .delete-link");
            addReplyListener(".page-"+currentPage+" .reply-link");
            //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
            addUpdateFormListener(".page-"+currentPage+" .update-form");
            
            //로딩바 숨기기
            document.querySelector(".loader").style.display="none"
         });
      }
   });
   
   //인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수 
   function addUpdateListener(sel){
      //댓글 수정 링크의 참조값을 배열에 담아오기 
      // sel 은  ".page-xxx  .update-link" 형식의 내용이다 
      let updateLinks=document.querySelectorAll(sel);
      for(let i=0; i<updateLinks.length; i++){
         updateLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const comment_idx=this.getAttribute("data-num"); //댓글의 글번호
            document.querySelector("#updateForm"+comment_idx).style.display="block";
            
         });
      }
   }
   function addDeleteListener(sel){
      //댓글 삭제 링크의 참조값을 배열에 담아오기 
      let deleteLinks=document.querySelectorAll(sel);
      for(let i=0; i<deleteLinks.length; i++){
         deleteLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const comment_idx=this.getAttribute("data-num"); //댓글의 글번호
            const isDelete=confirm("댓글을 삭제 하시겠습니까?");
            if(isDelete){
               // gura_util.js 에 있는 함수들 이용해서 ajax 요청
               ajaxPromise("private/comment_delete.jsp", "post", "comment_idx="+comment_idx)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  //만일 삭제 성공이면 
                  if(data.isSuccess){
                     //댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
                     document.querySelector("#reli"+comment_idx).innerText="삭제된 댓글입니다.";
                  }
               });
            }
         });
      }
   }
   function addReplyListener(sel){
      //댓글 링크의 참조값을 배열에 담아오기 
      let replyLinks=document.querySelectorAll(sel);
      //반복문 돌면서 모든 링크에 이벤트 리스너 함수 등록하기
      for(let i=0; i<replyLinks.length; i++){
         replyLinks[i].addEventListener("click", function(){
            
            if(!isLogin){
               const isMove=confirm("로그인이 필요 합니다. 로그인 페이지로 이동 하시겠습니까?");
               if(isMove){
                  location.href=
                     "${pageContext.request.contextPath}/users/loginform.jsp?url=${pageContext.request.contextPath}/movieinfo.jsp?movie_num=<%=movie_num%>";
               }
               return;
            }
            
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const comment_idx=this.getAttribute("data-num"); //댓글의 글번호
            
            const form=document.querySelector("#reForm"+comment_idx);
            
            //현재 문자열을 읽어온다 ( "답글" or "취소" )
            let current = this.innerText;
            
            if(current == "답글"){
               //번호를 이용해서 댓글의 댓글폼을 선택해서 보이게 한다. 
               form.style.display="block";
               form.classList.add("animate__flash");
               this.innerText="취소";   
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__flash");
               }, {once:true});
            }else if(current == "취소"){
               form.classList.add("animate__fadeOut");
               this.innerText="답글";
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__fadeOut");
                  form.style.display="none";
               },{once:true});
            }
         });
      }
   }
   
   function addUpdateFormListener(sel){
      //댓글 수정 폼의 참조값을 배열에 담아오기
      let updateForms=document.querySelectorAll(sel);
      for(let i=0; i<updateForms.length; i++){
         //폼에 submit 이벤트가 일어 났을때 호출되는 함수 등록 
         updateForms[i].addEventListener("submit", function(e){
            //submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기 
            const form=this;
            //폼 제출을 막은 다음 
            e.preventDefault();
            //이벤트가 일어난 폼을 ajax 전송하도록 한다.
            ajaxFormPromise(form)
            .then(function(response){
               return response.json();
            })
            .then(function(data){
               if(data.isSuccess){
                  /*
                     document.querySelector() 는 html 문서 전체에서 특정 요소의 
                     참조값을 찾는 기능
                     
                     특정문서의 참조값.querySelector() 는 해당 문서 객체의 자손 요소 중에서
                     특정 요소의 참조값을 찾는 기능
                  */
                  const comment_idx=form.querySelector("input[name=comment_idx]").value;
                  const comment_content=form.querySelector("textarea[name=comment_content]").value;
                  //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
                  document.querySelector("#pre"+comment_idx).innerText=comment_content;
                  form.style.display="none";
               }
            });
         });
      }

   }
</script>	
<script>
	
	function infoOne(){
		const div=document.querySelector(".movie_secondary_info_detail_wrapper");
		div.innerHTML="";
		
		const box_div=document.createElement("div");
		const div1=document.createElement("div");
		const div2=document.createElement("div");
		
		box_div.setAttribute('class','movie_secondary_info_detail_box');
		div1.setAttribute('class','movie_secondary_info_detail_title');
		div2.setAttribute('class','movie_secondary_info_detail_content');
		
		div1.innerText="줄거리";
		div2.innerText="<%=dto.getMovie_story()%>";
		
		box_div.append(div1);
		box_div.append(div2);
		
		div.append(box_div);
	}
	
	function infoTwo(){
		const div=document.querySelector(".movie_secondary_info_detail_wrapper");
		div.innerHTML="";
		
		const box_div1=document.createElement("div");
		const box_div2=document.createElement("div");
		const div1=document.createElement("div");
		const div2=document.createElement("div");
		const div3=document.createElement("div");
		const div4=document.createElement("div");
		
		box_div1.setAttribute('class','movie_secondary_info_detail_box');
		box_div2.setAttribute('class','movie_secondary_info_detail_box');
		div1.setAttribute('class','movie_secondary_info_detail_title');
		div2.setAttribute('class','movie_secondary_info_detail_content');
		div3.setAttribute('class','movie_secondary_info_detail_title');
		div4.setAttribute('class','movie_secondary_info_detail_content');
		
		div1.innerText="감독";
		div2.innerText="<%=dto.getMovie_director()%>";
		div3.innerText="출연진";
		div4.innerText="<%=dto.getMovie_character()%>";
		
		box_div1.append(div1);
		box_div1.append(div2);
		box_div2.append(div3);
		box_div2.append(div4);
		
		div.append(box_div1);
		div.append(box_div2);
	}
	
	function infoThree(){
		const div=document.querySelector(".movie_secondary_info_detail_wrapper");
		div.innerHTML="";
		
		const box_div=document.createElement("div");
		const star_img=document.createElement("img");
		const rating_span=document.createElement("span");
		const noRating_span=document.createElement("span");
		box_div.setAttribute('class','movie_secondary_info_detail_rating_box');
		star_img.setAttribute('src','https://upload.wikimedia.org/wikipedia/commons/0/0b/Star_red.svg');
		star_img.setAttribute('id','star');
		rating_span.setAttribute('id','rating_span');
		noRating_span.setAttribute('id','noRating_span');
		rating_span.innerText=" <%=dto. getMovie_rating()%> 점";
		noRating_span.innerText="개봉 전입니다.";
		<%if(dto.getMovie_rating()!=null){%>
			box_div.append(star_img);
			box_div.append(rating_span);
		<%}else{%>
			box_div.append(noRating_span);
		<%}%>
		div.append(box_div);
		
	}
	
	infoOne();
	
	document.querySelector("#btnOne").addEventListener("click",function(){
		infoOne();
	});
	document.querySelector("#btnTwo").addEventListener("click",function(){
		infoTwo();
	});
	document.querySelector("#btnThree").addEventListener("click",function(){
		infoThree();
	});

	
	
</script>
</body>
</html>