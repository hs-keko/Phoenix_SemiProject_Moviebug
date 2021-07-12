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
   
   String keyword=request.getParameter("keyword");
   String condition=request.getParameter("condition");
   
   if(keyword==null){
	   keyword="";
	   condition="";
   }
   //특수기호를 인코딩한 키워드
   String encodedK=URLEncoder.encode(keyword);
   
   //CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   CafeDto dto=new CafeDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);

	 //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	   List<CafeDto> list=null;
	   //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	   int totalRow=0;
	   //만일 검색 키워드가 넘어온다면 
	   if(!keyword.equals("")){
	      //검색 조건이 무엇이냐에 따라 분기 하기
	      if(condition.equals("qna_title_content")){//제목 + 내용 검색인 경우
	         //검색 키워드를 CafeDto 에 담아서 전달한다.
	         dto.setQna_title(keyword);
	         dto.setQna_content(keyword);
	         //제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
	         list=CafeDao.getInstance().getListTC(dto);
	         //제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
	         totalRow=CafeDao.getInstance().getCountTC(dto);
	      }else if(condition.equals("qna_title")){ //제목 검색인 경우
	         dto.setQna_title(keyword);
	         list=CafeDao.getInstance().getListT(dto);
	         totalRow=CafeDao.getInstance().getCountT(dto);
	      }else if(condition.equals("qna_writer")){ //작성자 검색인 경우
	         dto.setQna_writer(keyword);
	         list=CafeDao.getInstance().getListW(dto);
	         totalRow=CafeDao.getInstance().getCountW(dto);
	      } // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	   }else{//검색 키워드가 넘어오지 않는다면
	      //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
	      list=CafeDao.getInstance().getList(dto);
	      //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
	      totalRow=CafeDao.getInstance().getCount();
	   }
   
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

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
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
   #one{
   		text-align: center;
   		margin-top: 15px;
   }
   #two{
   		float: right;
   }
   #three{
   		margin-bottom: 30px;
   }

</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
<div class="container">
	<h1 id="one"> Q&A </h1>
	<div id="two" class="btn btn-outline-primary">
		<a href="private/insertform.jsp">새글 작성하기</a>
	</div>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<%for(CafeDto tmp:list) {%>
			<tr>
				<td><%=tmp.getQna_idx() %></td>
				<td><%=tmp.getQna_writer() %></td>
				<td><%if(tmp.getQna_file() != null){ %>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-arrow-up" viewBox="0 0 16 16">
					  <path d="M8 11a.5.5 0 0 0 .5-.5V6.707l1.146 1.147a.5.5 0 0 0 .708-.708l-2-2a.5.5 0 0 0-.708 0l-2 2a.5.5 0 1 0 .708.708L7.5 6.707V10.5a.5.5 0 0 0 .5.5z"/>
					  <path d="M4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4zm0 1h8a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
					</svg>
					<a href="detail.jsp?num=<%=tmp.getQna_idx()%>"><%=tmp.getQna_title() %></a>
				<%}else{ %>
					<a href="detail.jsp?num=<%=tmp.getQna_idx()%>"><%=tmp.getQna_title() %></a>
				<%} %>
				</td>
				<td><%=tmp.getQna_regdate() %></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<div id="three" class="page-ui clearfix" style="float: left;">
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
	   <div id="three" style="float:right;">
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
     </div>
     <div style="clear:both;"></div>
	<!-- footer  -->
	
</body>
<div id=footer>
   	<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
</html>
