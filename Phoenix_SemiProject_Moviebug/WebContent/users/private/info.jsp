<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //1. session 영역에서 로그인된 아이디를 읽어온다.
   String email=(String)session.getAttribute("email");
   //2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
   UsersDto dto=UsersDao.getInstance().getData(email);
   //3. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/info.jsp</title>
<style>
	
   /* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   
   html, body {
		width: 100%;
		height: 100%;
	}
	
	.container {
		width: 100%;
		height: 100%;
		
	}
			
	.container--formheader {
		display: flex;
		border: 1px solid #cecece;
	}
	
	.container--form {
		width: 600px;
		height: auto;	
		margin: auto;
	}
   
</style>
</head>
<body>
<div class="container">
	<div class="container--formheader">
   <h1>가입 정보 입니다.</h1>

         <%if(dto.getProfile() == null){ %>   
            <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
            </svg>
         <%}else{ %>
         	<img id="profileImage" src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
         <%} %>   
  
   		<a href="update_form.jsp">개인정보 수정</a>
   		<a href="javascript:deleteConfirm()">탈퇴</a>
	</div>
</div>
<script>
   function deleteConfirm(){
      const isDelete=confirm("<%=dto.getName()%> 님 탈퇴 하시겠습니까?");
      if(isDelete){
         location.href="delete.jsp";
      }
   }
</script>
</body>
</html>




