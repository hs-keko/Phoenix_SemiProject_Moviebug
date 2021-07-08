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
	
	CafeCommentDto commentDto = new CafeCommentDto();
	commentDto.setQna_comment_ref_group(qna_idx);
	
	List<CafeCommentDto> commentList=
			CafeCommentDao.getInstance().getList(commentDto);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/detail.jsp</title>
<style>
	.qna_content{
		border: 1px dotted gray;
	}
</style>
</head>
<body>
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
      String email=(String)session.getAttribute("email");
      if(email != null){
  	  String name=UsersDao.getInstance().getData(email).getName();
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
   				<li>
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
	                  </dt>
	                  <dd>
	                     <pre><%=tmp.getQna_comment_content() %></pre>                  
	                  </dd>
	               </dl>
            	</li>
   			<%} %>
   		</ul>
   </div>
   <!-- 원글에 댓글을 작성할 폼 -->
   <form action="private/comment_insert.jsp" method="post">
   		<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
   		<input type="hidden" name="qna_comment_ref_group" value="<%=qna_idx %>" />
   		<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
   		<input type="hidden" name="qna_comment_writer" value="<%=dto.getQna_writer() %>"/>
   		<textarea name="qna_comment_content"></textarea>
   		<button type="submit">등록</button>
   </form>
</div>











