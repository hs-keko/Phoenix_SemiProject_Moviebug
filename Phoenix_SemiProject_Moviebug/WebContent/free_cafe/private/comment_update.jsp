<%@page import="test.free_cafe.dao.FreeCafeCommentDao"%>
<%@page import="test.free_cafe.dto.FreeCafeCommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ajax 전송되는 수정할 댓글의 번호와 내용을 읽어온다.
	int free_comment_idx=Integer.parseInt(request.getParameter("free_comment_idx"));
	String free_comment_content=request.getParameter("free_comment_content");
	//dto 에 담는다.
	FreeCafeCommentDto dto=new FreeCafeCommentDto();
	dto.setFree_comment_idx(free_comment_idx);
	dto.setFree_comment_content(free_comment_content);
	//DB 에 수정 반영한다.
	boolean isSuccess=FreeCafeCommentDao.getInstance().update(dto);
	//json 으로 응답한다. 
%>    
{"isSuccess":<%=isSuccess %>} 