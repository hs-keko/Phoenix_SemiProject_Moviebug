<%@page import="moviebug.users.dto.UsersDto"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자세히 보여줄 글번호 가져오기
	int qna_idx=Integer.parseInt(request.getParameter("num"));
	CafeDto dto1=new CafeDto();
	dto1.setQna_idx(qna_idx);
	CafeDto dto=CafeDao.getInstance().getData(dto1);
	
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	
	if(keyword==null){
	   //키워드와 검색 조건에 빈 문자열을 넣어준다. 
	   //클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
	   keyword="";
	   condition=""; 
	}
	
	dto.setQna_idx(qna_idx);
	if(!keyword.equals("")){
		   //검색 조건이 무엇이냐에 따라 분기 하기
		   if(condition.equals("qna_title_content")){//제목 + 내용 검색인 경우
		      //검색 키워드를 CafeDto 에 담아서 전달한다.
		      dto.setQna_title(keyword);
		      dto.setQna_content(keyword);
		      dto=CafeDao.getInstance().getDataTC(dto);
		   }else if(condition.equals("qna_title")){ //제목 검색인 경우
		      dto.setQna_title(keyword);
		      dto=CafeDao.getInstance().getDataT(dto);
		   }else if(condition.equals("qna_writer")){ //작성자 검색인 경우
		      dto.setQna_writer(keyword);
		      dto=CafeDao.getInstance().getDataW(dto);
		   } // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}else{//검색 키워드가 넘어오지 않는다면
		   dto=CafeDao.getInstance().getData(dto);
		}
	//특수기호를 인코딩한 키워드를 미리 준비한다. 
	String encodedK=URLEncoder.encode(keyword);
	
	/*
		[댓글 페이징 처리]
	*/
	//한 페이지에 몇개씩 표시할 것인지
   	final int PAGE_ROW_COUNT=10;
   
   	//detail.jsp 페이지에서는 항상 1페이지의 댓글 내용만 출력함
   	int pageNum=1;
   
   	//보여줄 페이지의 시작 ROWNUM
   	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   	//보여줄 페이지의 끝 ROWNUM
   	int endRowNum=pageNum*PAGE_ROW_COUNT;
    
    //원글의 글번호를 이용해 해당글에 달린 댓글 목록을 얻어옴
    CafeCommentDto commentDto = new CafeCommentDto();
	commentDto.setQna_comment_ref_group(qna_idx);
	
	//1페이지에 해당하는 stratRowNum과 endRowNum을 dto에 담아
	commentDto.setStartRowNum(startRowNum);
	commentDto.setEndRowNum(endRowNum);
	
	//1페이지에 해당하는 댓글 목록만 select되도록 함
	List<CafeCommentDto> commentList=
			CafeCommentDao.getInstance().getList(commentDto);
	
	// 원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
    int totalRow=CafeCommentDao.getInstance().getCount(qna_idx);
    // 댓글 전체 페이지의 갯수
    int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
    
    String email=(String)session.getAttribute("email");
	 String name=UsersDao.getInstance().getData(email).getName();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="../css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/footer.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">

<style>
	.content{
		border: 1px dotted red;
		width: 500px;
		height: 300px;
	}
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
		color: pink;
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
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
<div class="container">
   <a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">이전글</a>
   <a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">다음글</a>
   <table>
      <tr>
         <th>글번호</th>
         <td><%=dto.getQna_idx() %></td>
      </tr>
      <tr>
         <th>작성자</th>
         <td><%=dto.getQna_writer() %></td>
      </tr>
      <tr>
         <th>제목</th>
         <td><%=dto.getQna_title() %></td>
      </tr>
      <tr>
         <th>첨부파일</th>
         <td><%=dto.getQna_file() %></td>
      </tr>
      <tr>
         <th>등록일</th>
         <td><%=dto.getQna_regdate() %></td>
      </tr>
      <tr>
		<td colspan="2">
			<div class="content"><%=dto.getQna_content() %></div>
		</td>
	</tr>
   </table>
   <ul>
      <li><a href="list.jsp">목록보기</a></li>
      <%
      
      if(email != null){

      %>
      <%if(dto.getQna_writer().equals(name)){ %>
      <li><a href="private/updateform.jsp?num=<%=dto.getQna_idx() %>">수정</a></li>
      <li><a href="private/delete.jsp?num=<%=dto.getQna_idx() %>">삭제</a></li>
      <% } 
      }
      %>
   </ul>
   <!-- 여기서부터 댓글 목록 입니다. -->
   <div class="comments">
   		<ul>
   			<%for(CafeCommentDto tmp: commentList){ %>
   				<%if(tmp.getQna_comment_deleted().equals("yes")){%>
   					<li>삭제된 댓글입니다</li>
   				<%
   					// continue 아래의 코드를 수행않고 for문으로 다시 실행순서 보내기 
   				 	continue;
   				
   				}%>
   				
   				
   				<%if(tmp.getQna_comment_idx()==tmp.getQna_comment_group()){ %>
   				<li id="reli<%=tmp.getQna_comment_idx() %>">
   				<%}else{ %>
   				<li id="reli<%=tmp.getQna_comment_idx() %>" style="padding-left:50px;">
	   				<svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-square-fill" viewBox="0 0 16 16">
						  <path d="M0 14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v12zm4.5-6.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5a.5.5 0 0 1 0-1z"/>
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
		                  	<span><strong><%=tmp.getQna_comment_writer() %></strong></span>
		                  <%if(tmp.getQna_comment_idx() != tmp.getQna_comment_group()){ %>
		                  	[<%=tmp.getQna_comment_writer() %>]님에게
		                  <%} %>
		                  	<span><%=tmp.getQna_comment_regdate () %></span>
		                  	<a data-num="<%=tmp.getQna_comment_idx() %>" href="javascript:" class="reply-link">답글</a>
						<%
						
							if(email != null && tmp.getQna_comment_writer().equals(name)){ %>
							<a data-num="<%=tmp.getQna_comment_idx() %>" class="update-link" href="javascript:">수정</a>
							<a data-num="<%=tmp.getQna_comment_idx() %>" class="delete-link" href="javascript:">삭제</a>
						<%} %>
	                  </dt>
	                  <dd>
	                     <pre id="pre<%=tmp.getQna_comment_idx()%>"><%=tmp.getQna_comment_content() %></pre>                  
	                  </dd>
	               </dl>
				<form id="reForm<%=tmp.getQna_comment_idx() %>" class="animate__animated comment-form re-insert-form"
					action="private/comment_insert.jsp" method="post">
					<input type="hidden" name="qna_comment_ref_group"
						value="<%=dto.getQna_idx() %>" />	
						<input type="hidden" name="qna_comment_writer"
						value="<%=tmp.getQna_comment_writer() %>" />
						<input type="hidden" name="qna_comment_group"
						value="<%=tmp.getQna_comment_group() %>" />
						<textarea name="qna_comment_content"></textarea>
						<button type="submit">등록</button>		
				</form>
				<%if(tmp.getQna_comment_writer().equals(name)){ %>	
					<form id="updateForm<%=tmp.getQna_comment_idx() %>" class="comment-form update-form" 
						action="private/comment_update.jsp" method="post">
						<input type="hidden" name="qna_comment_idx" value="<%=tmp.getQna_comment_idx() %>" />
						<textarea name="qna_comment_content"><%=tmp.getQna_comment_content() %></textarea>
						<button type="submit">수정</button>
					</form>
					<%} %>						
            	</li>
   			<%} %>
   		</ul>
   </div>
   <!-- 원글에 댓글을 작성할 폼 -->
   <form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
   		<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
   		<input type="hidden" name="qna_comment_ref_group" value="<%=qna_idx %>" />
   		<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
   		<input type="hidden" name="qna_comment_writer" value="<%=dto.getQna_writer() %>"/>
   		<textarea name="qna_comment_content"></textarea>
   		<button type="submit">등록</button>
   </form>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
	//댓글 수정 폼의 참조값을 배열에 담아오기
	let updateForms=document.querySelectorAll(".update-form");
	for(let i=0; i<updateForms.length; i++){
		//폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
		updateForms[i].addEventListener("submit", function(e){
			//submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기
			const form=this;
			//폼 제출 막기
			e.preventDefault();
			//이벤트가 일어난 폼을 ajax 전송
			ajaxFormPromise(form)
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				if(data.isSuccess){
					//수정폼에 입력한 value 값을 pre 요소에도 출력하기
					const qna_comment_idx=form.querySelector("input[name=qna_comment_idx]").value;
					const qna_comment_content=form.querySelector("textarea[name=qna_comment_content]").value;
					document.querySelector("#pre"+qna_comment_idx).innerText=qna_comment_content;
					form.style.display="none";
				}
			});
		});
	}
	//댓글 수정 링크의 참조값을 배열에 담아오기
	let updateLinks=document.querySelectorAll(".update-link");
		for(let i=0; i<updateLinks.length; i++){
			updateLinks[i].addEventListener("click", function(){
				//click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
				const qna_comment_idx=this.getAttribute("data-num"); //댓글의 글번호
				document.querySelector("#updateForm"+qna_comment_idx).style.display="block";
		});
	}
	//댓글 삭제 링크의 참조값을 배열에 담아오기 
	let deleteLinks=document.querySelectorAll(".delete-link");
	for(let i=0; i<deleteLinks.length; i++){
		deleteLinks[i].addEventListener("click", function(){
			//click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
			const qna_comment_idx=this.getAttribute("data-num"); //댓글의 글번호
			const isDelete=confirm("댓글을 삭제 하시겠습니까?");
			if(isDelete){
				// gura_util.js 에 있는 함수들 이용해서 ajax 요청
				ajaxPromise("private/comment_delete.jsp", "post", "qna_comment_idx="+qna_comment_idx)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//만일 삭제 성공이면 
					if(data.isSuccess){
						//댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
						document.querySelector("#reli"+qna_comment_idx).innerText="삭제된 댓글입니다.";
					}
				});
			}
		});
	}
	//댓글 링크의 참조값을 배열에 담아오기
	let replyLinks=document.querySelectorAll(".reply-link");
	//반복문 돌면서 모든 링크에 이벤트 리스너 함수 등록
	for(let i=0; i<replyLinks.length; i++){
		replyLinks[i].addEventListener("click", function(){
				//click 이벤트가 발생한 바로 그 요소의 data-num 속성의 value값 읽어오기
				const qna_comment_idx=this.getAttribute("data-num"); //댓글의 글번호
				
				const form=document.querySelector("#reForm"+qna_comment_idx);
				
				//현재 문자열을 읽어온다 (답글 or 취소)
				let current = this.innerText;
				if(current=="답글"){
					//번호를 이용해서 댓글의 댓글폼을 선택해서 보이게 한다.
					form.style.display="block";
					form.classList.add("animate__fadeIn");
					this.innerText="취소";
					form.addEventListener("animationend", function(){
							form.classList.remove("animated__fadeIn");
					}, {once:true});
				}else if(current=="취소"){
					form.classList.add("animated__fadeOut");
					this.innerText="답글";
					form.addEventListener("animationend", function(){
						form.classList.remove("animated__fadeOut");
						form.style.display="none";
				}, {once:true});
			}
			
		});
	}
	
	//댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
	let currentPage=1;
	//마지막
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
		//현재 페이지가 마지막 페이지인지 여부
		let isLast = currentPage == lastPage;
		//현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
		if(isBottom && !isLoading && !isLast){
			//로딩 작업중이라고 표시
			isLoading=true;
			
			//현재 댓글 페이지를 1 증가 시키고
			currentPage++;
			/*
				해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
				"pageNum=xxx&num=xxx" 형식으로 get 방식 파라미터를 전달한다.
			*/
			ajaxPromise("ajax_comment_list.jsp","get",
					"pageNum="+currentPage+"&qna_idx="<%=qna_idx%>)
			.then(function(response){
				//json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
				return response.text();
			})
			.then(function(date){
				//data는 html 형식의 문자열이다.
				console.log(data);
				document.queryelector(".comments ul")
					.insertAdjacentHTML("beforeend", data);
				//로딩이 끝났다고 표시한다.
				isLoading=false;
			});
		}
	});
</script>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
