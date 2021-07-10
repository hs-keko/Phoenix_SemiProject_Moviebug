<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //1. session 영역에서 로그인된 아이디를 읽어온다.
   String email=(String)session.getAttribute("email");
   //2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
   UsersDto dto=UsersDao.getInstance().getData(email);
   
   // 로그인 상태 확인
   boolean isLogin = false;
   if(email != null) isLogin = true;
   
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
   CafeDto dto2=new CafeDto();
   dto2.setStartRowNum(startRowNum);
   dto2.setEndRowNum(endRowNum);

	 //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	 List<CafeDto> list=null;
	 //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	 int totalRow=0;
	 //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
	 list=CafeDao.getInstance().getList(dto2);
	 //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
	 totalRow=CafeDao.getInstance().getCount();

   
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
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/update.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css" />

 <!-- 웹폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">
<style>
   
   /* 프로필 이미지를 작은 원형으로 만든다 */
    html, body {
		width: 100%;
		height: 100%;
	}
	
   #profileImage{
      width: 100px;
      height: 100px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   
   #imageForm{
   	  display: none;
   }
   
	.container {
		width: 100%;
		height: 100%;
	}
			
	.updateform_container {
		align-items: center;
		padding-top: 40px;
		padding-bottom: 40px;
		border: 1px solid #cecece;
	}
   
   .updateform_container .container--form {
		width: 100%;
		max-width: 600px;
		padding: 15px;	
		margin: auto;
	}
    
   .container--image {
   	  padding: 20px;
   	  border-bottom: 1px solid #cecece;
   }
   
	.container--form #setting {
   		text-decoration: none;
   		color: black;
   }
   
   .container--image #nick {
   		font-size: 30px;
   		text-align : center;
   }
   
	#UpdateForm form {
	 	padding: 20px;
		border-bottom: 1px solid #cecece;
	}
   
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
    <jsp:include page="../../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
	<div class="container">
		<div class="updateform_container">
			<div class="container--form">
	            <a id="setting" href="update_form.jsp">
	                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
					 	<path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"/>
						<path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"/>
					</svg>
	            </a>
				<div class="container--image">
	                <%if(dto.getProfile()==null){ %>
	                           <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
	                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
	                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
	                           </svg>
	                        <%}else{ %>
	                           <img id="profileImage" 
	                              src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
	                        <%} %>
	                        <span id="nick"><%=dto.getName() %></span>	                        
	                </div>       
	            
				  <div class="row align-items">
					    <div class="col text-center">
					      	<a href="">내가 쓴 게시글 보기</a>
					    </div>
					    <div class="col text-center">
					        <a href="">내가 쓴 댓글 보기</a>
					    </div>
				  </div>
				  
	<table>
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
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image-fill" viewBox="0 0 16 16">
					  <path d="M.002 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-12a2 2 0 0 1-2-2V3zm1 9v1a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V9.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12zm5-6.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0z"/>
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
      		</div>
		</div>
	</div>
</body>
</html>



