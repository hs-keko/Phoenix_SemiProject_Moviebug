<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="java.util.List"%>
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
   
	// 로그인 상태 확인
	boolean isLogin = false;
	String email = (String)session.getAttribute("email"); 
	if(email != null) isLogin = true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
<!-- navbar 필수 import -->
    <jsp:include page="../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    
    <!-- import css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/footer.css" />
    
    <!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">

	<!-- 웹폰트 test -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Girassol&family=Major+Mono+Display&display=swap" rel="stylesheet">
<style>

	html, body {
		width: 100%;
		height: 100%;
	}
	
	.container {
		width: 100%;
		height: 100%;	
	}			
	
	.loginform_container {
		display: flex;
		align-items: center;
		padding-top: 40px;
		padding-bottom: 40px;
		transform: translateY(0%);
		border: 1px solid #cecece;
		height: 100%;
	}
	
	.loginform_container .container--form {
		width: 100%;
		max-width: 400px;
		padding: 15px;	
		margin: auto;
	}
	
	.loginform_container h1 {
		padding: 32px;
		text-align: center;
	}
	
	.loginform_container p {
		color: #6e6e6e;
		text-align: center;
	}
	
	.loginform_container .signup_a{
		color: #0000ff;
	}
	   
    #company {
    	text-align: center;
    }
      
</style>
</head>
<body>
	 <jsp:include page="../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
	<div class="container">
		<div class="loginform_container">
			<div class="container--form">	
			
				<h1>로그인</h1>
				
				<form class="row g-3" action="login.jsp" method="post">
					<input type="hidden" name="url" value="<%=url %>" />
					<div class="col-12">
						<label class="control-label" for="email">이메일</label>
						<input class="form-control" type="text" name="email" id="email" 
								placeholder="이메일을 입력하세요." />
					</div>
					<div class="col-12">
						<label class="control-label" for="pwd">비밀번호</label>
						<input class="form-control" type="password" name="pwd" id="pwd"
								placeholder="비밀번호를 입력하세요." />
					</div>
					<button class="btn btn-primary" type="submit">로그인</button>
					<div class="signup">
						<p>아직 계정이 없으신가요? <a class="signup_a" href="<%=request.getContextPath()%>/users/signupform.jsp">가입하기</a></p>
					</div>
						<p id="company" class="mt-5 mb-3 text-muted">&copy; MovieBug</p>
				</form>
			</div>
		</div>
	</div>
      
      <script src="<%= request.getContextPath()%>/js/index.js"></script>

      <!-- navbar 필수 import -->
      <!-- import navbar.js -->
      <script src="<%= request.getContextPath()%>/js/navbar.js"></script>

		<!-- import footer.jsp -->
      	<jsp:include page="../include/footer.jsp"></jsp:include>
      
</body>
</html>