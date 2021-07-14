<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 아이디
	String email = (String)session.getAttribute("email");
	//ajax 요청 파라미터로 넘어오는 댓글의 페이지 번호를 읽어낸다
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	//ajax 요청 파라미터로 넘어오는 원글의 페이지 번호를 읽어낸다.
	int qna_idx=Integer.parseInt(request.getParameter("qna_idx"));
	/*
	[댓글 페이징 처리]
	*/
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	//원글의 글번호를 이용해 해당글에 달린 댓글 목록을 얻어옴
	CafeCommentDto commentDto = new CafeCommentDto();
	commentDto.setQna_comment_ref_group(qna_idx);
	
	//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
	commentDto.setStartRowNum(startRowNum);
	commentDto.setEndRowNum(endRowNum);
		
	//pageNum에 해당하는 댓글 목록만 select 되도록 한다. 
	List<CafeCommentDto> commentList=
		CafeCommentDao.getInstance().getList(commentDto);
		
	//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
	int totalRow=CafeCommentDao.getInstance().getCount(qna_idx);
	//댓글 전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
%>
<% 
for(CafeCommentDto tmp: commentList){ 
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
   				<li id="reli<%=tmp.getQna_comment_idx() %>" class="page-<%=pageNum %>">
   				<%}else{ %>
				<li id="reli<%=tmp.getQna_comment_idx()%>" class="page-<%=pageNum %>" style="padding-left:50px;">
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
                     value="<%=qna_idx%>"/>
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