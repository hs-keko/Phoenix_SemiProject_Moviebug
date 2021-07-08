<%@page import="moviebug.movieinfo.dao.MovieCommentDao"%>
<%@page import="moviebug.movieinfo.dto.MovieCommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //ajax 전송되는 수정할 댓글의 번호와 내용을 읽어온다.
   int comment_idx=Integer.parseInt(request.getParameter("comment_idx"));
   String comment_content=request.getParameter("comment_content");
   //dto 에 담는다.
   MovieCommentDto dto=new MovieCommentDto();
   dto.setComment_idx(comment_idx);
   dto.setComment_content(comment_content);
   //DB 에 수정 반영한다.
   boolean isSuccess=MovieCommentDao.getInstance().update(dto);
   //json 으로 응답한다. 
%>    
{"isSuccess":<%=isSuccess%>}