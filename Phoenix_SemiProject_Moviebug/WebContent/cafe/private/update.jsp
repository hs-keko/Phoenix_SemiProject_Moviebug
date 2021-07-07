<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int qna_idx=Integer.parseInt(request.getParameter("qna_idx"));
	String qna_title=request.getParameter("qna_title");
	String qna_content=request.getParameter("qna_content");
	String qna_file=request.getParameter("qna_file");
	
	CafeDto dto = new CafeDto();
	dto.setQna_idx(qna_idx);
	dto.setQna_title(qna_title);
	dto.setQna_content(qna_content);
	dto.setQna_file(qna_file);
	//3. DB 에 수정반영하고 
	boolean isSuccess=CafeDao.getInstance().update(dto);
	//4. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="../detail.jsp?num=<%=dto.getQna_idx()%>";
		</script>
	<%}else{ %>
		<h1>알림</h1>
		<p>
			글 수정 실패!
			<a href="updateform.jsp?num=<%=dto.getQna_idx()%>">다시 시도</a>
		</p>
	<%} %>
</body>
</html>