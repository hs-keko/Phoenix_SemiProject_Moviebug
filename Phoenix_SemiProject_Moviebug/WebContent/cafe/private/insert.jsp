<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String qna_writer=(String)session.getAttribute("qna_writer");
	//1. 폼 전송되는 글제목과 내용을 읽어와서
	String qna_title=request.getParameter("qna_title");
	String qna_content=request.getParameter("qna_content");
	String qna_file=request.getParameter("qna_file");
	//2. DB 에 저장하고
	CafeDto dto=new CafeDto();
	dto.setQna_writer(qna_writer);
	dto.setQna_title(qna_title);
	dto.setQna_content(qna_content);
	dto.setQna_file(qna_file);
	boolean isSuccess=CafeDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
	<script>
		alert("글을 성공적으로 등록하였습니다.")
		location.href="${pageContext.request.contextPath}/cafe/list.jsp";
	</script>
	<%}else{ %>
	<script>
		alert("글 저장이 완료되지 않았습니다. 다시 한 번 시도해주세요.")
		location.href="insertform.jsp";
	</script>
	<%} %>
</body>
</html>