<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   // GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와 본다.
   String url=request.getParameter("url");
   //만일 넘어오는 값이 없다면
   if(url==null){
      //로그인 후에 index.jsp 페이지로 갈수 있도록 절대 경로를 구성한다.
      String cPath=request.getContextPath();
      url=cPath+"/index.jsp";
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
</head>
<body>
	<div class="container">
	    <jsp:include page="/include/navbar.jsp"> 
    		<jsp:param value="null" name="email"/>
    	</jsp:include>
		<h1>로그인 폼 입니다.</h1>
		<form action="login.jsp" method="post">
			<input type="hidden" name="url" value="<%=url %>" />
			<div>
				<label for="email">이메일</label>
				<input type="text" name="email" id="email" />
			</div>
			<div>
				<label for="pwd">비밀번호</label>
				<input type="password" name="pwd" id="pwd" />
			</div>
			<button type="submit">로그인</button>
		</form>
		
		<h3>아이디가 없으신가요? <a href="<%= request.getContextPath()%>/users/signupform.jsp">가입하기</a></h3>
	</div>
	
</body>
</html>