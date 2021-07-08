<%@page import="moviebug.movieinfo.dto.MovieCommentDto"%>
<%@page import="moviebug.movieinfo.dao.MovieCommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 파라미터 추출
	int comment_ref_group=Integer.parseInt(request.getParameter("comment_ref_group"));
	String comment_target_id=request.getParameter("comment_target_id");
	String comment_content=request.getParameter("comment_content");
	/*
		원글의 댓글은 comment_group 번호가 전송이 안되고
		댓글의 댓글은 comment_group 번호가 전송이 된다.
		따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판단할 수 있다.
	*/
	String comment_group=request.getParameter("comment_group");
	
	//댓글 작성자는 session 영역에서 얻어내기
	String comment_writer=(String)session.getAttribute("email");
	//댓글의 시퀀스 번호 미리 얻어내기
	int seq=MovieCommentDao.getInstance().getSequence();
	//저장할 댓글의 정보를 dto 에 담기
	MovieCommentDto dto=new MovieCommentDto();
	dto.setComment_idx(seq);
	dto.setComment_writer(comment_writer);
	dto.setComment_target_id(comment_target_id);
	dto.setComment_content(comment_content);
	dto.setComment_ref_group(comment_ref_group);
	//원글의 댓글인경우
	if(comment_group == null){
		//댓글의 글번호를 comment_group 번호로 사용한다.
		dto.setComment_group(seq);
	}else{
		//전송된 comment group 번호를 숫자로 바꿔서 dto 에 넣어준다.
		dto.setComment_group(Integer.parseInt(comment_group));
	}
	//댓글 정보를 DB 에 저장하기
	MovieCommentDao.getInstance().insert(dto);
	//응답하기 (원글 자세히 보기로 다시 리다일렉트 시킨다)
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/movieinfo.jsp?movie_num="+comment_ref_group);
%>