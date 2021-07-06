<%@page import="java.net.URLEncoder"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 후에 이동해야 되는 목적지
	String url = request.getParameter("url");
	// 인코딩 된 목적지(로그인 실패 시에 )
	String encodedUrl = URLEncoder.encode(url);
	
	//1. 폼 전송되는 아이디와 비밀번호를 읽어온다.
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	UsersDto dto = new UsersDto();
	dto.setEmail(email);
	dto.setPwd(pwd);
	//2. DB에 실제로 존재하는 정보인지 확인한다.
	boolean isValid = UsersDao.getInstance().isValid(dto);
	//3. 유효한 정보이면 로그인 처리를 하고 응답, 그렇지 않으면 아이디 혹은 비밀번호가 틀렸다고 응답
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
	
		<h1>알림</h1>
		<%if(isValid) {
			session.setAttribute("email", email);
			// 초 단위로 세션 유지시간을 설정할 수 있다. 
			session.setMaxInactiveInterval(60*20);
			UsersDto dto2 = UsersDao.getInstance().getData(email);
			%>
			
		<p>
			<strong><%=dto2.getName() %></strong> 님 로그인 되었습니다.
			<a href="<%=url%>">확인</a>
		</p>
		<%} else { %>
			<p>
				아이디 혹은 비밀번호가 틀려요.
				<a href="loginform.jsp?url=<%=encodedUrl%>">다시 시도</a>
			</p>
		<%} %>
	</div>
</body>
</html>