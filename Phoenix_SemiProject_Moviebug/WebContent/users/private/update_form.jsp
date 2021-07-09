<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //1. session 영역에서 로그인된 아이디를 읽어온다.
   String email=(String)session.getAttribute("email");
   //2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
   UsersDto dto=UsersDao.getInstance().getData(email);
   
	// 로그인 상태 확인
	boolean isLogin = false;
	if(email != null) isLogin = true;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/update.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/navbar.css" />

 <!-- 웹폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">
<style>
   /* 프로필 이미지를 작은 원형으로 만든다 */
    html, body {
		width: 100%;
		height: 100%;
	}
	
   #profileImage{
      width: 100px;
      height: 100px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   
   #imageForm{
   	  display: none;
   }
   
	.container {
		width: 100%;
		height: 100%;
	}
			
	.updateform_container {
		align-items: center;
		padding-top: 40px;
		padding-bottom: 40px;
		border: 1px solid #cecece;
	}
   
   .updateform_container .container--form {
		width: 100%;
		max-width: 600px;
		padding: 15px;	
		margin: auto;
	}
    
   .container--image {
   	  padding: 20px;
   	  border-bottom: 1px solid #cecece;
   }
	
   .container--image button {
   	  border-radius: 15px;
   	  width: 100px;
   	  font-size: 12px;
   }	

	#UpdateForm form {
	 	padding: 20px;
		border-bottom: 1px solid #cecece;
	}
	
	
</style>
</head>
<body>
    <jsp:include page="../../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
	<div class="container">
    
		<div class="updateform_container">
			<div class="container--form">
				<h1>설정</h1>
				 		<a id="profileLink" href="javascript:">
				      		<%if(dto.getProfile()==null){ %>
						         <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
						              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
						              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
						         </svg>
						      <%}else{ %>
						         <img id="profileImage" 
						            src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
						      <%} %>
				      		</a>	
				<div class="container--image">
		   		<form class="row g-3" action="profile_update.jsp" method="post">
		   		<input type="hidden" name="profile" 
		   	  		value="<%=dto.getProfile()==null ? "empty" : dto.getProfile()%>" />
		   	  		<button class="btn btn-dark" type="submit">프로필 저장</button>
				</form>
				</div>
				
				<div class="clear-fix d-flex flex-column bd-highlight" id="UpdateForm">
				
					<form class="update_nameForm row-3" action="name_update.jsp" method="post">
						<div class="p-2 bd-highlight col-12">
							<p class="float-start">이름</p>					
							<p>
							  <a class="btn btn-primary float-end" data-bs-toggle="collapse" href="#name" role="button" aria-expanded="false" aria-controls="collapseExample">
							    변경
							  </a>
							</p>
			      		</div>
			      		<div class="collapse col-12" id="name">
				      		 	 <div class="d-inline-flex p-2 bd-highlight col-12">
				         		 <label for="name"></label>
				         		 <input type="text" id="name" name="name" value="<%=dto.getName()%>"/>
				         		 <button class="btn btn-dark" type="submit">저장</button>
				      		 	 </div>
			      		 	 </div>
		      		</form>
			
				<form class="update_addrForm row-3" action="addr_update.jsp" method="post">
					<div class="p-2 bd-highlight col-12">
						<p class="float-start">주소</p>
						<p>
						  <a class="btn btn-primary float-end" data-bs-toggle="collapse" href="#addr" role="button" aria-expanded="false" aria-controls="collapseExample">
						    변경
						  </a>
						</p>
					</div>
		      		 <div class="collapse col-12" id="addr">
		      		 	 <div class="d-inline-flex p-2 bd-highlight col-12">
		         		 	<label for="addr"></label>
		         		 	<input type="text" id="addr" name="addr" value="<%=dto.getAddr()%>"/>
		         		 	<button class="btn btn-dark" type="submit">저장</button>
		      		 	 </div> 	 
		      		</div>
		      	</form>
		
		
					<form class="row-3" action="pwd_update.jsp" method="post" id="myForm">
						<div class="p-2 bd-highlight col-12">
							<p class="float-start">비밀번호</p>
							<p>
							  <a class="btn btn-primary float-end" data-bs-toggle="collapse" href="#pwd" role="button" aria-expanded="false" aria-controls="collapseExample">
							    변경
							  </a>
							</p>
						</div>
						<div class="collapse col-12 p-4" id="pwd">
							  <div class="card card-body col-12">
							   	<label class="control-label" for="pwd">현재 비밀번호</label>
						        <input class="form-control mb-3" type="password" name="pwd" id="pwd"/>
						        
							   	<label class="control-label" for="newPwd">새 비밀번호</label>
						        <input class="form-control mb-3" type="password" name="newPwd" id="newPwd"/>
						        
							   	<label class="control-label" for="newPwd2">새 비밀번호 확인</label>
						        <input class="form-control mb-3" type="password" id="newPwd2"/>
						        
						        <button class="btn btn-dark m-3" type="submit">저장</button>
							</div>
						</div>
					</form>
					
				</div>
				
				<form action="ajax_profile_upload.jsp" method="post" 
		            id="imageForm" enctype="multipart/form-data">
		     			 <input type="file" name="image" id="image" 
		        			 accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
		  		 </form>
	  		 </div>
  		 </div>	
	</div>
	

<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script>

	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm").addEventListener("submit", function(e){
	   let pwd1=document.querySelector("#newPwd").value;
	   let pwd2=document.querySelector("#newPwd2").value;
	   //새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
	   if(pwd1 != pwd2){
	      alert("비밀번호를 확인 하세요!");
	      e.preventDefault();//폼 전송 막기 
	   }
	});

   //프로필 이미지 링크를 클릭하면 
   document.querySelector("#profileLink").addEventListener("click", function(){
      // input type="file" 을 강제 클릭 시킨다. 
      document.querySelector("#image").click();
   });
   //이미지를 선택했을때 실행할 함수 등록 
   document.querySelector("#image").addEventListener("change", function(){
      
      let form=document.querySelector("#imageForm");
      
      // gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
      ajaxFormPromise(form)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
    	  // data는 {imagePath:"/upload/xxx.jpg"} 형식의 object 이다.
         console.log(data);
    	 let img=`<img id="profileImage" src="<%=request.getContextPath()%>\${data.imagePath}"/>`;
    	 document.querySelector("#profileLink").innerHTML = img;
    	 // input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
    	 document.querySelector("input[name=profile]").value=data.imagePath;
      });
      /*  util 을 사용하지 않는 코드는 아래와 같다  
      
      let form=document.querySelector("#imageForm");
      const url=form.getAttribute("action");
      const method=form.getAttribute("method");
      //폼에 입력한 데이터를 FormData 에 담고 
      let data=new FormData(form);
      // fetch() 함수가 리턴하는 Promise 객체를 
      fetch(url,{
         method:method,
         body:data
      })
      .then(function(response){
         return response.json();
      })
      .then(function(data){
         console.log(data);
         
      });
      */
   });
   
   
</script>
</body>
</html>




