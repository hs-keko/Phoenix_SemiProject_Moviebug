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
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	
	if(keyword==null){
	   //키워드와 검색 조건에 빈 문자열을 넣어준다. 
	   //클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
	   keyword="";
	   condition=""; 
	}
	//CafeDto 객체를 생성해서 
	CafeDto dto=new CafeDto();
	//자세히 보여줄 글번호를 넣어준다. 
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
    System.out.println(totalPageCount);
    String email=(String)session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
    <!-- navbar 필수 import -->
    <jsp:include page="../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    <!-- import css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/footer.css" />

	<!-- Custom styles for this template -->
<link href="https://getbootstrap.com/docs/5.0/examples/product/product.css" rel="stylesheet">
    
    <link rel="stylesheet" type="text/css" href="../css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/footer.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
	
	<!-- 웹폰트 댓글  -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
	
	   .font-do{
	   		font-family: 'Nanum Gothic', sans-serif;
	   }
	   .font-small { 
	   		font-size: small; 
	   		color: gray
	   }
	   .footer_inner a {
	   		color:white;
	    }
	   
		html, body {
		  height: 100%;
		  weight: 100%
		  margin: 0;
		  padding-top: 30px;
		}
		
		.container {
		width: 100%;
		height: 100%;
		padding-top: 10px;
		padding-bottom: 10px;
		}
		
		.detail_container{
		margin-top: 30px;
		}
		
		.content-inside {
		  padding: 20px;
		  padding-bottom: 50px;
		  transform: translateY(0%);

		}
		
		.footer {
       	 transform: translateY(-100%);
      	 position:absolute;
      	 width:100%;
   	  	 height:100px;
   	 	 bottom:0;
		}
		
		footer{
		margin-top: 50px;
		}
	
		.content {
		width: 100%;
		height: 100%;
		margin-bottom: 50px;
		margin-top: 50px;
		min-height: 100%;
			
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
		margin-bottom: 35px;
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
	
	a { 
	text-decoration: none; 
	color:black;
	}

	.cafe_list_content{
    margin-top: 65px;
    height: auto;
    min-height: 100%;
    margin-bottom: 40px;
   }
   
	a{
	text-decoration: none; 
	}

	.detail_container{
		align-items: center;
		padding-top: 20px;
		padding-bottom: 20px;
		padding-left:30px;
		padding-right:30px;
		margin-bottom:40px;
		border: 1px solid #cecece;
		height: auto;
	}

	#footer {
	  height: 50px;
	  transform: translateY(-100%);
      position:absolute;
      width: 100%;
	 }
	 
   .footer_inner a {
   		color:white;
    }

</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
<div class="wrapper">
<div class="container cafe_list_content">
	<div class="detail_container">
	<dl>
	<%if(dto.getPrevNum()!=0) {%>
   		<div id="prev" style="float: left;">
   		<a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">
		<svg class="prev-icon" xmlns="http://www.w3.org/2000/svg" width="36" height="36" fill="currentColor" class="bi bi-arrow-left-circle" viewBox="0 0 16 16">
	  		<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5-.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
		</svg>
		</a>
		</div>
   	<%} %>
   	<%if(dto.getNextNum()!=0) {%>
   		<div id="prev" style="float: right;">
   		<a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">
   		<svg class="next-icon" xmlns="http://www.w3.org/2000/svg" width="36" height="36" fill="currentColor" class="bi bi-arrow-right-circle" viewBox="0 0 16 16">
		  <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
		</svg>
   		</a>
   		</div>
   	<%} %>
   	<div style="clear:both;"></div>
   	</dl>
   	<%if(!keyword.equals("")){ %>
   	<p>
   		<strong><%=condition %></strong> 조건,
   		<strong><%=keyword %></strong> 검색어로 검색된 내용 자세히 보기
   	</p>
   <%} %>
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
         <%if(dto.getQna_file() == null){%>
         <td> </td>
         <%}else{ %>
         <td><%=dto.getQna_file() %></td>
         <%} %>
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
      
      <%
      
      if(email != null){
      %>
      <%if(dto.getQna_writer().equals(UsersDao.getInstance().getData(email).getName())){ %>
      <a class="btn btn-outline-secondary" href="private/updateform.jsp?num=<%=dto.getQna_idx() %>">수정</a>
      <a class="btn btn-outline-secondary" href="private/delete.jsp?num=<%=dto.getQna_idx() %>">삭제</a>
      <% } 
      }
      %>
      <a class="btn btn-outline-secondary" href="list.jsp">목록</a>
      <br>
      <br>
   </div>
   <!-- 여기서부터 댓글 목록 입니다. -->

   <!-- 원글에 댓글을 작성할 폼 -->
   <div>
   <form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
   		<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
   		<input type="hidden" name="qna_comment_ref_group" value="<%=qna_idx %>" />
   		<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
   		<input type="hidden" name="qna_comment_target_id" value="<%=dto.getQna_writer() %>"/>
   		<textarea name="qna_comment_content"></textarea>
   		<button class="btn btn-secondary" type="submit">등록</button>
   </form>
   </div>
   
   <br>
   <br>
   
   <div id="one" class="comments">
   		<ul>
   			<%for(CafeCommentDto tmp: commentList){ 
   			System.out.println(tmp.getQna_comment_ref_group());
   			System.out.println(tmp.getEndRowNum());
   			System.out.println(tmp.getStartRowNum());
   			%>
   				<%if(tmp.getQna_comment_deleted().equals("yes")){%>
   					<li>삭제된 댓글입니다</li>
   				<%
   					// continue 아래의 코드를 수행않고 for문으로 다시 실행순서 보내기 
   				 	continue;
   			  }%>

   				<%if(tmp.getQna_comment_idx()==tmp.getQna_comment_group()){ %>
   				<li id="reli<%=tmp.getQna_comment_idx() %>">
   				<%}else{ %>
				<li id="reli<%=tmp.getQna_comment_idx()%>" style="padding-left:50px;">
	               <svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
	                    <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
	               </svg>
   				<%} %>
	               <dl>
	                  <dt>
	                  	<div class="w-100 clearfix">
		                  <%if(tmp.getProfile() == null){ %>
		                  <svg class="profile-image" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
		                      <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
		                      <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		                  </svg>
		                  <%}else{ %>
		                      <img class="profile-image" src="${pageContext.request.contextPath}<%=tmp.getProfile()%>"/>
		                  <%} %>
		                  	<span><strong><%=UsersDao.getInstance().getData(tmp.getQna_comment_writer()).getName() %></strong></span>
		                  <%if(tmp.getQna_comment_idx() != tmp.getQna_comment_group()){ %>
		                  	@<i><%=UsersDao.getInstance().getData(tmp.getQna_comment_target_id()).getName() %></i>
		                  <%} %>
		                	<%	if(email != null && tmp.getQna_comment_writer().equals(email)){ %>
							<a data-num="<%=tmp.getQna_comment_idx() %>" class="delete-link float-end ms-3" href="javascript:">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
								  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
								  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
								</svg>
								</a>
								<a data-num="<%=tmp.getQna_comment_idx() %>" class="update-link float-end ms-3" href="javascript:">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
								  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
								</svg>
								</a>							
							<%} %>
	                 	</div>
	                  </dt>
	              <dd>
                     <pre class="font-do" id="pre<%=tmp.getQna_comment_idx()%>"><%=tmp.getQna_comment_content() %></pre>                  
                  </dd>
                  <dd>
                  	<span class="font-small"><%=tmp.getQna_comment_regdate () %></span>
                  </dd>
                  <dd>
                  <button type="button" class="btn btn-outline-secondary">
                  	<a data-num="<%=tmp.getQna_comment_idx() %>" href="javascript:" class="reply-link">답글</a>
                  </button>
                  </dd>
	               </dl>
					<form id="reForm<%=tmp.getQna_comment_idx() %>" class="animate__animated comment-form re-insert-form" 
                  action="private/comment_insert.jsp" method="post">
                  <input type="hidden" name="qna_comment_ref_group"
                     value="<%=dto.getQna_idx()%>"/>
                  <input type="hidden" name="qna_comment_target_id"
                     value="<%=tmp.getQna_comment_writer()%>"/>
                  <input id="two" type="hidden" name="qna_comment_group"
                     value="<%=tmp.getQna_comment_group()%>"/>
                  <textarea name="qna_comment_content"></textarea>
                  <button type="submit" class="btn btn-secondary">등록</button>
               </form>   
               <%if(tmp.getQna_comment_writer().equals(email)){ %>   
               <form id="updateForm<%=tmp.getQna_comment_idx() %>" class="comment-form update-form" 
                  action="private/comment_update.jsp" method="post">
                  <input type="hidden" name="qna_comment_idx" value="<%=tmp.getQna_comment_idx() %>" />
                  <textarea name="qna_comment_content"><%=tmp.getQna_comment_content() %></textarea>
                  <button type="submit" class="btn btn-outline-secondary">수정</button>
               </form>
					<%} %>						
            	</li>
   			<%} %>
   		</ul>
   </div>
   <br>
   <br>
   <div class="loader">
	   	<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-hourglass-bottom" viewBox="0 0 16 16">
		  <path d="M2 1.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-1v1a4.5 4.5 0 0 1-2.557 4.06c-.29.139-.443.377-.443.59v.7c0 .213.154.451.443.59A4.5 4.5 0 0 1 12.5 13v1h1a.5.5 0 0 1 0 1h-11a.5.5 0 1 1 0-1h1v-1a4.5 4.5 0 0 1 2.557-4.06c.29-.139.443-.377.443-.59v-.7c0-.213-.154-.451-.443-.59A4.5 4.5 0 0 1 3.5 3V2h-1a.5.5 0 0 1-.5-.5zm2.5.5v1a3.5 3.5 0 0 0 1.989 3.158c.533.256 1.011.791 1.011 1.491v.702s.18.149.5.149.5-.15.5-.15v-.7c0-.701.478-1.236 1.011-1.492A3.5 3.5 0 0 0 11.5 3V2h-7z"/>
		</svg>
	</div>
   <div style="clear:both;"></div>
   </div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
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
	               "pageNum="+currentPage+"&qna_idx="+<%=qna_idx%>)
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
	            //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록하기
	            addUpdateListener(".page-"+currentPage+" .update-link");
	            addDeleteListener(".page-"+currentPage+" .delete-link");
	            addReplyListener(".page-"+currentPage+" .reply-link");
	            addUpdateFormListener(".page-"+currentPage+" .update-form");
				
	            //로딩바 숨기기
	            document.querySelector(".loader").style.display="none";
			});
		}
	});
	      
	      	//인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수
	     	function addUpdateListener(sel){
	     		//댓글 수정 링크의 참조값을 배열에 담아오기
	     		let updateLinks=document.querySelectorAll(sel);
	     			for(let i=0; i<updateLinks.length; i++){
	     				updateLinks[i].addEventListener("click", function(){
	     					//click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
	     					const qna_comment_idx=this.getAttribute("data-num"); //댓글의 글번호
	     					document.querySelector("#updateForm"+qna_comment_idx).style.display="block";
	     			});
	     		}
	      	}
			function addDeleteListener(sel){
				//댓글 삭제 링크의 참조값을 배열에 담아오기 
				let deleteLinks=document.querySelectorAll(sel);
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
	        }
			function addReplyListener(sel){
				//댓글 링크의 참조값을 배열에 담아오기
				let replyLinks=document.querySelectorAll(sel);
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
			                  const qna_comment_idx=form.querySelector("input[name=qna_comment_idx]").value;
			                  const qna_comment_content=form.querySelector("textarea[name=qna_comment_content]").value;
			                  //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
			                  document.querySelector("#pre"+qna_comment_idx).innerText=qna_comment_content;
			                  form.style.display="none";
			               }
			            });
			         });
			      }
			   }
</script>
<script src="<%= request.getContextPath()%>/js/navbar.js"></script>
<!-- footer  -->
<div id="footer">
   	<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
</div>
</body>
</html>