<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제할 댓글 번호를 읽어온다.
	int qna_comment_idx=Integer.parseInt(request.getParameter("qna_comment_idx"));
	//DB에서 삭제한다.
	boolean isSuccess=CafeCommentDao.getInstance().delete(qna_comment_idx);
	//JSON으로 응답
%>
{"isSuccess":<%=isSuccess %>}