<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 아이디
	String email = (String)session.getAttribute("email");
	String name = UsersDao.getInstance().getData(email).getName();
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
    
<%for(CafeCommentDto tmp: commentList){ %>
   <%if(tmp.getQna_comment_deleted().equals("yes")){ %>
      <li>삭제된 댓글 입니다.</li>
   <% 
      // continue; 아래의 코드를 수행하지 않고 for 문으로 실행순서 다시 보내기 
      continue;
   }%>

   <%if(tmp.getQna_comment_idx() == tmp.getQna_comment_group()){ %>
   <li id="reli<%=tmp.getQna_comment_idx()%>" class="page-<%=pageNum %>">
   <%}else{ %>
   <li id="reli<%=tmp.getQna_comment_idx()%>" class="page-<%=pageNum %>" style="padding-left:50px;">
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
			value="<%=qna_idx %>" />	
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