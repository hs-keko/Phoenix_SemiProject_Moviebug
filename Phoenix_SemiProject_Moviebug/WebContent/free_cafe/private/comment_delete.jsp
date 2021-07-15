<%@page import="test.free_cafe.dao.FreeCafeCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제할 댓글 번호를 읽어온다.
	int free_comment_idx=Integer.parseInt(request.getParameter("free_comment_idx"));
	//DB 에서 삭제한다.
	boolean isSuccess=FreeCafeCommentDao.getInstance().delete(free_comment_idx);
	//json 으로 응답한다.
%>    
{"isSuccess":<%=isSuccess %>}