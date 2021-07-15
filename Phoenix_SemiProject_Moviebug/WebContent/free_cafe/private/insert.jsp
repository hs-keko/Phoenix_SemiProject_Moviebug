<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.free_cafe.dao.FreeCafeDao"%>
<%@page import="test.free_cafe.dto.FreeCafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email=(String)session.getAttribute("email");
	String name=UsersDao.getInstance().getData(email).getName();

	String free_title=request.getParameter("free_title");
	String free_content=request.getParameter("free_content");
	String free_file=request.getParameter("free_file");
	
	FreeCafeDto dto=new FreeCafeDto();
	dto.setFree_writer(name);
	dto.setFree_title(free_title);
	dto.setFree_content(free_content);
	dto.setFree_file(free_file);
	boolean isSuccess=FreeCafeDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free_cafe/private/insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
	   <script>
	      alert("새글이 추가 되었습니다.");
	      location.href="${pageContext.request.contextPath}/free_cafe/list.jsp";
	   </script>
   <%}else{ %>
	   <script>
	      alert("글 저장 실패!");
	      location.href="insertform.jsp";
	   </script>
   <%} %>
</body>
</html>