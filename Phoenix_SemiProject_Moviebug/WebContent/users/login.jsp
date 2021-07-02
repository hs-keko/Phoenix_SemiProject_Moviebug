<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email=request.getParameter("email");
	String pwd=request.getParameter("pwd");
	UsersDto dto=new UsersDto();
	dto.setEmail(email);
	dto.setPwd(pwd);
	boolean isValid=UsersDao.getInstance().isValid(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/login.jsp</title>
</head>
<body>
<div class="container">
	<h1>알림</h1>
	<%if(isValid){
		session.setAttribute("email", email); %>
		<p>
			<strong><%=email %></strong>님 로그인 되었습니다.
			<a href="../cafe/list.jsp">확인</a>
		</p>
	<%}else{ %>
		<p>
			아이디 혹은 비밀 번호가 틀려요!
			<a href="loginform.jsp">다시 시도</a>
		</p>
	<%} %>
</div>
</body>
</html>