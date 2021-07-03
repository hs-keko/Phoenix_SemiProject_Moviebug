<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
   <h1 class=text-center>회원 가입</h1>
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
           
      <button class="btn btn-primary" type="submit">가입</button>
   </form>
</div>
<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script>
   //아이디, 비밀번호, 이메일의 유효성 여부를 관리한 변수 만들고 초기값 대입
   let isPwdValid=false;
   let isEmailValid=false;

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
      /*
         입력한 아이디, 비밀번호, 이메일의 유효성 여부를 확인해서 하나라도 유효 하지 않으면
         e.preventDefault(); 
         가 수행 되도록 해서 폼의 제출을 막아야 한다. 
      */
      //폼 전체의 유효성 여부 알아내기 
      let isFormValid = isPwdValid && isEmailValid;
      if(!isFormValid){//폼이 유효하지 않으면
         //폼 전송 막기 
         e.preventDefault();
      }   
   });
</script>
</body>
</html>



