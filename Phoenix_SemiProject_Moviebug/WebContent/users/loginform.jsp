<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
</head>
<body>
<div class="container">
	<h1>로그인 폼 입니다.</h1>
	<form action="login.jsp" method="post">
		<div>
			<label for="email">아이디</label>
			<input type="email" name="email" id="email" />
		</div>
		<div>
			<label for="pwd">비밀번호</label>
			<input type="password" name="pwd" id="pwd" />
		</div>
		<button type="submit">로그인</button>
	</form>	
</div>
</body>
</html>