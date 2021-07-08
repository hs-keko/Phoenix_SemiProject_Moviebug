<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 상태 확인
	boolean isLogin = false;
	String email = (String)session.getAttribute("email"); 
	if(email != null) isLogin = true;
	// 메인 carousel 최신 영화 3개 리스트 가져오기
	List<MovieDto> NewMovieList = MovieDao.getInstance().getNewMovies();
	
	// 평점순위 4개 영화 리스트 가져오기
	List<MovieDto> Top4List = MovieDao.getInstance().getTop4ResList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>/users/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/navbar.css" />

 <!-- 웹폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">
<style>

	html, body {
		width: 100%;
		height: 100%;
	}
	
	.signupform_container .container {
		width: 100%;
		height: 100%;
		
	}
			
	.container--formborder {
		display: flex;
		border: 1px solid #cecece;
	}
	
	.signupform_container .container--form {
		width: 600px;
		height: auto;	
		margin: auto;
	}
	
	.signupform_container h1 {
		padding: 32px;
	}
	
	.signupform_container .signup_check > a {
		color: #0000ff;
	}
</style>
</head>
<body>

<div class="container">
 <jsp:include page="../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
    
	<div class="container--formborder signupform_container">
   	 	<div class="container--form">
   	
   	 	<h1>회원 가입</h1>
   	 	
		   <form class="row g-3" action="signup.jsp" method="post" id="myForm">
		      <div class="col-12">
		         <label class="control-label" for="name">이름</label>
		         <input class="form-control" type="text" name="name" id="name"/>
		      </div>
		      <div class="col-12">
		         <label class="control-label" for="email">이메일</label>
		         <input class="form-control" type="text" name="email" id="email"/>
		         <small class="form-text text-muted">ex) moviebug@xxx.xxx</small>
		         <div class="invalid-feedback">사용할 수 없는 이메일입니다.</div>
		      </div>
		      <div class="col-12">
		         <label class="control-label" for="pwd">비밀번호</label>
		         <input class="form-control" type="password" name="pwd" id="pwd"/>
		         <small class="form-text text-muted">5글자~10글자 이내로 입력하세요.</small>
		         <div class="invalid-feedback">비밀번호를 확인 하세요.</div>
		      </div>
		      <div class="col-12">
		         <label class="control-label" for="pwd2">비밀번호 확인</label>
		         <input class="form-control" type="password" name="pwd2" id="pwd2"/>
		      </div>
		      <div class="col-12">
		         <label class="control-label" for="addr">주소</label>
		         <input class="form-control" type="text" name="addr" id="addr"/>
		      </div>
		                   
		      <div class="signup_check">
				  <input class="form-check-input" type="checkbox" value="true"
				  onclick="toggle1(this)" name="agree" id="signup_check1">
				  <label class="form-check-label" for="signup_Check1">
				   moviebug 이용 약관동의
				  </label>
				  <a class="float-end" data-bs-toggle="offcanvas" 
				  	href="#offcanvasRight" role="button" aria-controls="offcanvasRight">
	  				내용보기 </a>
	
					<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
					  <div class="offcanvas-header">
					    <h5 id="offcanvasRightLabel">moviebug 이용 약관동의</h5>
					    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
					  </div>
					  <div class="offcanvas-body">
					    ...
					  </div>
					</div>
			  </div>
			  
			  <div class="signup_check">
				  <input class="form-check-input" type="checkbox" value="true"
				  onclick="toggle2(this)" name="agree" id="signup_check2">
				  <label class="form-check-label" for="signup_Check2">
				    개인정보 수집,이용 동의
				   </label>
				   <a class="float-end" data-bs-toggle="offcanvas" 
				  	href="#offcanvasRight2" role="button" aria-controls="offcanvasRight">
	  				내용보기 </a>
	
					<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight2" aria-labelledby="offcanvasRightLabel">
					  <div class="offcanvas-header">
					    <h5 id="offcanvasRightLabel">개인정보 수집,이용 동의</h5>
					    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
					  </div>
					  <div class="offcanvas-body">
					    ...
					  </div>
					</div>
		      </div>
		      
			  <div class="signup_check">
				  <input class="form-check-input" type="checkbox" value="true"
				  onclick="toggle3(this)" name="agree" id="signup_check3">
				  <label class="form-check-label" for="signup_Check3">
				   만 14세 이상입니다.
				  </label>
		      </div>
	          <button class="btn btn-primary mb-3" type="submit" id="signBtn">가입</button>
	   </form>
  	 </div>
  </div>

<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script type="text/javascript">
   // 이메일, 비밀번호, 약관동의의 유효성 여부를 관리한 변수 만들고 초기값 대입
   let isPwdValid=false;
   let isEmailValid=false;
   let isChecked=false;
   
   // 약관동의 버튼 value 값을 얻어오기 위한 변수
   let result1 = null;
   let result2 = null;
   let result3 = null;
   
   // 약관동의 버튼 onclick 에 들어갈 함수
   function toggle1(e) {
	   if(e.checked) { // checked = true 됐다면
		   result1 = e.value; // 체크박스에 해당하는 value 값 가져오기
	   } else {
		   result1 = '';
	   }
   }
   
   function toggle2(e) {
	   if(e.checked) {
		   result2 = e.value;
	   } else {
		   result2 = '';
	   }
   }
   
   function toggle3(e) {
	   if(e.checked) {
		   result3 = e.value;
	   } else {
		   result3 = '';
	   }
   }
   
   
   //아이디를 입력했을때(input) 실행할 함수 등록 
   document.querySelector("#email").addEventListener("input", function(){
      //일단 is-valid,  is-invalid 클래스를 제거한다.
      document.querySelector("#email").classList.remove("is-valid");
      document.querySelector("#email").classList.remove("is-invalid");
      
      //1. 입력한 아이디 value 값 읽어오기  
      let inputEmail=this.value;
      //입력한 아이디를 검증할 정규 표현식
      const reg_email=/@/;
      //만일 입력한 아이디가 정규표현식과 매칭되지 않는다면
      if(!reg_email.test(inputEmail)){
         isEmailValid=false; //아이디가 매칭되지 않는다고 표시하고 
         // is-invalid 클래스를 추가한다. 
         document.querySelector("#email").classList.add("is-invalid");
         return; //함수를 여기서 끝낸다 (ajax 전송 되지 않도록)
      }
      
      //2. util 에 있는 함수를 이용해서 ajax 요청하기
      ajaxPromise("checkEmail.jsp", "get", "inputEmail="+inputEmail)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
         console.log(data);
         //data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
         if(data.isExist){//만일 존재한다면
            //사용할수 없는 아이디라는 피드백을 보이게 한다. 
            isEmailValid=false;
            // is-invalid 클래스를 추가한다. 
            document.querySelector("#email").classList.add("is-invalid");
         }else{
            isEmailValid=true;
            document.querySelector("#email").classList.add("is-valid");
         }
      });
   });
   
   //비밀 번호를 확인 하는 함수 
   function checkPwd(){
      document.querySelector("#pwd").classList.remove("is-valid");
      document.querySelector("#pwd").classList.remove("is-invalid");
      
      const pwd=document.querySelector("#pwd").value;
      const pwd2=document.querySelector("#pwd2").value;
      
      // 최소5글자 최대 10글자인지를 검증할 정규표현식
      const reg_pwd=/^.{5,10}$/;
      if(!reg_pwd.test(pwd)){
         isPwdValid=false;
         document.querySelector("#pwd").classList.add("is-invalid");
         return; //함수를 여기서 종료
      }
      
      if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면
         //비밀번호를 잘못 입력한것이다.
         isPwdValid=false;
         document.querySelector("#pwd").classList.add("is-invalid");
      }else{
         isPwdValid=true;
         document.querySelector("#pwd").classList.add("is-valid");
      }
   }
   
   //비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
   document.querySelector("#pwd").addEventListener("input", checkPwd);
   document.querySelector("#pwd2").addEventListener("input", checkPwd);
   
   //폼에 submit 이벤트가 발생했을때 실행할 함수 등록
   document.querySelector("#myForm").addEventListener("submit", function(e){
	   // 폼 전송부터 막고 검사를 하고 submit 발생
	   e.preventDefault();
	   
      /*
  		 유효성 검사를 통해 하나라도 통과하지 못하면 return false 다 통과하면 submit
      */
      
      if(result1 == "true" && result2 == "true" && result3 == "true") {
     	  isChecked = true;
       } else {
     	  isChecked = false;
       }
      
      //폼 전체의 유효성 여부 알아내기    
      
      let isFormValid = isPwdValid && isEmailValid && isChecked;
      if(!isFormValid){//폼이 유효하지 않으면
         // 유효성 검사가 하나라도 맞지 않으면 return false;
      	 alert("다시 확인해주세요.");
         return false;
      } else {
    	  document.querySelector("#myForm").submit();
      }
   });
</script>
</div>
</body>
</html>




