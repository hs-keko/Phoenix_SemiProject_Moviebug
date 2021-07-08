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
<title>movieinfo.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="css/navbar.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
	.genre-container{
		text-align: center;
	}
	
	.title-container{
		text-align: center;
	}
	
	.movieInfo-container{
		width: 1200px;
		height: 400px;
		margin: 0 auto;
		overflow: hidden; /* 부모 높이를 잊어벼리기때문에 다시 높이를 생기게끔해주는 float 해제 기법 */
	}
	
	.movieInfo_item{
		float: left; /* 가로 정렬을 하기 위한 float */
	}
	
	.movieInfo_item.trailer{
		width:600px;
		height:400px;
	}
	.movieInfo_item>iframe{
		width: 100%;
		height: 100%;
	}
	
	.movieInfo_item.detail{
		width:600px;
		height:400px;
		border-style: solid;
		border-width: 2px;
	}
	
	.btn-group{
		width:100%;
		height: 10%;
		margin-top: 10px;
	}
	
	li { font-size: 15px; line-height: 30px; }
	
	#rating {
		text-align: center;
		margin-top: 10%;
	}
	.content{
      border: 1px dotted gray;
   }
   
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
     margin: 0 0 10px;
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
	
	<div class="container">
		<div class="genre-container mb-3">
			<p><%=dto.getMovie_genre() %></p>
		</div>
		
		
		<div class="title-container mb-3">
			<h1><%=dto.getMovie_title_kr() %></h1>
			<h5><%=dto.getMovie_title_eng() %></h5>
		</div>
		
		
		<div class="movieInfo-container row align-items-center">
			<div class="movieInfo_item trailer">
				<iframe src="<%=dto.getMovie_trailer() %>" 
					title="YouTube video player" frameborder="0" 
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
				</iframe>
			</div>
			<div class="movieInfo_item detail">
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
	  				<input type="radio" class="btn-check" name="btnradio" id="btnOne" autocomplete="off" checked>
	  				<label class="btn btn-outline-secondary" for="btnOne">기본정보</label>
	
	  				<input type="radio" class="btn-check" name="btnradio" id="btnTwo" autocomplete="off">
	  				<label class="btn btn-outline-secondary" for="btnTwo">감독/출연진</label>
	  				
	  				<input type="radio" class="btn-check" name="btnradio" id="btnThree" autocomplete="off">
	  				<label class="btn btn-outline-secondary" for="btnThree">줄거리</label>
	
	  				<input type="radio" class="btn-check" name="btnradio" id="btnFour" autocomplete="off">
	  				<label class="btn btn-outline-secondary" for="btnFour">유저평점</label>
				</div>
				
				<div class="mt-3" id="movieInfo_wrapper"></div>
			</div>			
		</div>
	</div>
	
	<!-- 댓글 목록 -->
   <div class="comments">
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
                     <span><%=tmp.getComment_writer() %></span>
                  <%if(tmp.getComment_idx() != tmp.getComment_group()){ %>
                     @<i><%=tmp.getComment_target_id() %></i>
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
                  action="movieinfo/private/comment_insert.jsp" method="post">
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
                  action="movieinfo/private/comment_update.jsp" method="post">
                  <input type="hidden" name="comment_idx" value="<%=tmp.getComment_idx() %>" />
                  <textarea name="comment_content"><%=tmp.getComment_content() %></textarea>
                  <button type="submit">수정</button>
               </form>
               <%} %>                  
            </li>
         <%} %>
      </ul>
   </div>
   <div class="loader">
    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
  		<path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
  		<path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
	</svg>
   </div>
   <!-- 원글에 댓글을 작성할 폼 -->
   <form class="comment-form insert-form" action="movieinfo/private/comment_insert.jsp" method="post">
      <!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
      <input type="hidden" name="comment_ref_group" value="<%=movie_num%>"/>
      <!-- 원글의 작성자가 댓글의 대상자가 된다. -->
      <input type="hidden" name="comment_target_id" value="<%=dto.getMovie_writer()%>"/>
      
      <textarea name="comment_content"><%if(!isLogin){%>댓글 작성을 위해 로그인이 필요 합니다.<%}%></textarea>
      <button type="submit">등록</button>
   </form>
   
   <!-- footer  -->
   <jsp:include page="include/footer.jsp"></jsp:include>

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
         ajaxPromise("movieinfo/ajax_comment_list.jsp","get",
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
               ajaxPromise("movieinfo/private/comment_delete.jsp", "post", "comment_idx="+comment_idx)
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
		const div=document.querySelector("#movieInfo_wrapper");
		div.innerHTML="";
		const ul=document.createElement("ul");
		const li1=document.createElement("li");
		const li2=document.createElement("li");
		const li3=document.createElement("li");
		const li4=document.createElement("li");
		const li5=document.createElement("li");
		
		li1.innerText="제작년월 : <%=dto.getMovie_year()%>";
		li2.innerText="장르 : <%=dto.getMovie_genre()%>";
		li3.innerText="국가 : <%=dto.getMovie_nation()%>";
		li4.innerText="러닝타임 : <%=dto.getMovie_time()%>";
		li5.innerText="제작사 : <%=dto.getMovie_company()%>";
		
		ul.append(li1);
		ul.append(li2);
		ul.append(li3);
		ul.append(li4);
		ul.append(li5);
		
		div.append(ul);
	}
	
	function infoTwo(){
		const div=document.querySelector("#movieInfo_wrapper");
		div.innerHTML="";
		const ul=document.createElement("ul");
		const li1=document.createElement("li");
		const li2=document.createElement("li");
		li1.innerText="감독 : <%=dto.getMovie_director()%>";
		li2.innerText="출연진 : <%=dto.getMovie_character()%>";
		
		ul.append(li1);
		ul.append(li2);
		
		div.append(ul);
	}
	
	function infoThree(){
		const div=document.querySelector("#movieInfo_wrapper");
		div.innerHTML="";
		
		const p=document.createElement("p");
		p.setAttribute('class','mt-3');
		p.innerText="<%=dto.getMovie_story()%>";
		div.append(p);
	}
	
	function infoFour(){
		const div=document.querySelector("#movieInfo_wrapper");
		div.innerHTML="";
		
		const h1=document.createElement("h1");
		h1.setAttribute('id','rating');
		h1.innerText="<%=dto.getMovie_rating()%> 점";
		div.append(h1);
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
	document.querySelector("#btnFour").addEventListener("click",function(){
		infoFour();
	});
	
	
</script>
</body>
</html>