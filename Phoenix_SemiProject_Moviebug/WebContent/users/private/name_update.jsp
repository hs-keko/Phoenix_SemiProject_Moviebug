<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	// session 영역에 저장된 아이디 읽어오기
	String email = (String)session.getAttribute("email");
	// UsersDto 객체에 담아서
	UsersDto dto = new UsersDto();
	dto.setName(name);
	dto.setEmail(email);
	// DB에 수정 반영하고
	UsersDao.getInstance().updateName(dto);
	// 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	location.href = "update_form.jsp";
</script>
</body>
</html>