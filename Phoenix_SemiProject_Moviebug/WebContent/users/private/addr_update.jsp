<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 폼 전송되는 프로필 이미지 경로와 이름 주소 읽어오기
	String addr = request.getParameter("addr");
	// session 영역에 저장된 아이디 읽어오기
	String email = (String)session.getAttribute("email");
	// UsersDto 객체에 담아서
	UsersDto dto = new UsersDto();
	dto.setAddr(addr);
	dto.setEmail(email);
	// DB에 수정 반영하고
	UsersDao.getInstance().updateAddr(dto);
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