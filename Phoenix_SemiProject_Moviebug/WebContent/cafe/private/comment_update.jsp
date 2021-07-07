<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ajax 전송되는 수정할 댓글의 번호와 내용을 읽어온다.
	int qna_comment_idx=Integer.parseInt(request.getParameter("qna_comment_idx"));
	String qna_comment_content=request.getParameter("qna_comment_content");
	//dto 에 담는다.
	CafeCommentDto dto=new CafeCommentDto();
	dto.setQna_comment_idx(qna_comment_idx);
	dto.setQna_comment_content(qna_comment_content);
	//DB 에 수정 반영한다.
	boolean isSuccess=CafeCommentDao.getInstance().update(dto);
	//json 으로 응답한다. 
%>    
{"isSuccess":<%=isSuccess %>} 