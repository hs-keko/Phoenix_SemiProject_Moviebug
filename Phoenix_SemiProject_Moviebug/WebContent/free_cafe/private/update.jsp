<%@page import="test.free_cafe.dto.FreeCafeDto"%>
<%@page import="test.free_cafe.dao.FreeCafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int free_idx=Integer.parseInt(request.getParameter("free_idx"));
	String free_title=request.getParameter("free_title");
	String free_content=request.getParameter("free_content");
	String free_file=request.getParameter("free_file");
	
	FreeCafeDto dto = new FreeCafeDto();
	dto.setFree_idx(free_idx);
	dto.setFree_title(free_title);
	dto.setFree_content(free_content);
	dto.setFree_file(free_file);
	//3. DB 에 수정반영하고 
	boolean isSuccess=FreeCafeDao.getInstance().update(dto);
	//4. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free_cafe/private/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="../detail.jsp?num=<%=dto.getFree_idx()%>";
		</script>
	<%}else{ %>
		<h1>알림</h1>
		<p>
			글 수정 실패!
			<a href="updateform.jsp?num=<%=dto.getFree_idx()%>">다시 시도</a>
		</p>
	<%} %>
</body>
</html>