<%@page import="moviebug.movieinfo.dao.MovieCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제할 댓글 번호를 읽어온다.
	int comment_idx=Integer.parseInt(request.getParameter("comment_idx"));
	//DB 에서 삭제한다.
	boolean isSuccess=MovieCommentDao.getInstance().delete(comment_idx);
	//json 으로 응답한다.
%>
{"isSuccess":<%=isSuccess %>}