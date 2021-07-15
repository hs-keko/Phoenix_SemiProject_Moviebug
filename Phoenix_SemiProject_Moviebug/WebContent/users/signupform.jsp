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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MovieBug</title>
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
			
	.signupform_container {
		display: flex;
		align-items: center;
		padding-top: 40px;
		padding-bottom: 40px;
		border: 1px solid #cecece;
		height: 100%;
	}
	
	.signupform_container .container--form {
		width: 100%;
		max-width: 600px;
		padding: 15px;	
		margin: auto;
	}
	
	.signupform_container h1 {
		padding: 32px;
		text-align: center;
	}
	
	.signup_check > a {
		color: #0000ff;
	}
	
</style>
</head>
<body>
 <jsp:include page="../include/navbar.jsp"> 
    	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
    </jsp:include>
<div class="container">  
	<div class= "signupform_container">
   	 	<div class="container--form">
   	
   	 	<h1>회원 가입</h1>
   	 	
		   <form class="row g-3" action="signup.jsp" method="post" id="myForm">
		      <div class="col-12">
		         <label class="control-label" for="name">닉네임</label>
		         <input class="form-control" type="text" name="name" id="name"/>
		         <div class="invalid-feedback">사용할 수 없는 닉네임입니다.</div>
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
					    1. MovieBug 서비스의 회원이 되려면 만 14세 이상이어야 합니다. 만 14세 이하의 경우 보호자의 감독하에서만 서비스를 이용할 수 있습니다. <br/><br/>

2. MovieBug 서비스와 이 서비스를 통해 제공되는 모든 콘텐츠는 개인적, 비상업적 용도로만 사용해야 하며, 가구 구성원이 아닌 개인과 공유해서는 안 됩니다. MovieBug 멤버십 가입 기간 동안 MovieBug는 회원에게 MovieBug 서비스에 액세스하고 MovieBug 콘텐츠를 시청할 수 있는 제한적이고 비독점적이며 양도 불가능한 권한을 부여합니다. 앞서 언급한 권한을 제외하고는 어떠한 권리, 소유권 또는 이권도 회원에게 이전되지 않습니다. 또한 회원은 대중 공연을 목적으로 MovieBug 서비스를 이용해서도 안 됩니다.
<br/><br/>
3. 회원은 일차적으로 계정을 생성한 국가 내에서 그리고 MovieBug가 서비스를 제공하고 MovieBug 콘텐츠에 대한 라이선스를 허용한 지역 내에서만 해당 콘텐츠를 시청할 수 있습니다. 시청 가능한 콘텐츠는 지역에 따라 다르며 수시로 변경될 수 있습니다. 회원이 동시에 시청 가능한 디바이스의 수는 회원이 선택한 멤버십에 따라 결정되며 '계정' 페이지에서 확인할 수 있습니다. 콘텐츠 라이브러리를 비롯한 MovieBug 서비스는 정기적으로 업데이트됩니다. 또한, MovieBug는 웹사이트, 사용자 인터페이스, 프로모션 혜택, MovieBug 콘텐츠의 이용 가능 여부 등 서비스의 다양한 측면에 대한 테스트를 지속적으로 실시합니다. 회원은 언제든지 '계정' 페이지의 'MovieBug 테스터로 참여' 설정을 변경하여 테스트 참여 옵션을 끌 수 있습니다.
<br/><br/>
4. 일부 MovieBug 콘텐츠는 지원되는 특정 디바이스에서 일시적으로 저장해 오프라인으로 시청할 수 있습니다('오프라인 콘텐츠'). 단, 계정당 허용되는 오프라인 콘텐츠 수, 오프라인 콘텐츠를 저장할 수 있는 디바이스의 최대 수, 오프라인 콘텐츠 시청을 시작해야 하는 기간, 오프라인 콘텐츠를 이용할 수 있는 기간 등에 제약이 따릅니다. 일부 오프라인 콘텐츠는 특정 국가에서 재생할 수 없습니다. 이러한 오프라인 콘텐츠를 스트리밍할 수 없는 국가에서 온라인으로 접속한 경우, 해당 국가에 체류하는 동안에는 해당 오프라인 콘텐츠를 재생할 수 없습니다.
<br/><br/>
5. 회원은 모든 관련 법률, 규칙, 규정 또는 MovieBug 서비스 및 콘텐츠 사용과 관련된 기타 제한에 따라 MovieBug 서비스(MovieBug 서비스 내의 모든 기능을 포함)를 이용하는 데 동의합니다. 회원은 MovieBug 서비스에 포함되어 있거나 MovieBug 서비스를 통해 획득한 콘텐츠와 정보를 아카이브, 복제, 배포, 수정, 전시, 시연, 출판, 라이선스, 2차적 저작물로 생성, 판매 권유하거나 이용(본 이용 약관에 명시적으로 허용된 경우 제외)하지 않을 것에 동의합니다. 또한 회원은 MovieBug 서비스 내 콘텐츠 보호 기능을 우회, 삭제, 수정, 무효화, 약화 또는 훼손하거나, MovieBug 서비스에 접근하는 데 로봇, 스파이더, 스크레이퍼나 기타 자동화 수단을 이용하거나, MovieBug 서비스를 통해 접근 가능한 소프트웨어나 기타 제품, 프로세스를 역컴파일, 리버스 엔지니어링 또는 역어셈블하거나, 코드나 제품을 삽입하거나 어떤 방식으로든 MovieBug 서비스 콘텐츠를 조작하거나, 데이터 마이닝, 데이터 수집 또는 추출 방법을 사용해서는 안 됩니다. 또한 회원은 소프트웨어 바이러스나 기타 컴퓨터 코드, 파일이나 프로그램을 포함하여, MovieBug 서비스와 관련된 컴퓨터 소프트웨어나 하드웨어 또는 통신 장비의 기능을 방해, 파괴 또는 제한하기 위해 설계된 자료를 업로드, 게시, 이메일 전송, 또는 다른 방식으로 발송, 전송해서도 안 됩니다. 회원이 본 이용 약관의 4.1, 4.2, 4.3 또는 4.5조를 위반하거나 불법복제, 명의도용, 신용카드 부정 사용, 기타 이에 준하는 사기행위 또는 불법행위에 가담하는 경우, MovieBug는 회원의 서비스 사용을 종료시키거나 제한할 수 있습니다.
<br/><br/>
6. MovieBug 콘텐츠의 화면 품질은 디바이스에 따라 달라질 수 있으며 지역, 사용 가능한 인터넷 대역폭이나 인터넷 접속 속도 등 다양한 요인의 영향을 받을 수 있습니다. HD, UHD 및 HDR의 이용 가능 여부는 사용 중인 인터넷 서비스 및 디바이스 성능에 따라 결정됩니다. 모든 콘텐츠가 HD, UHD, HDR 등 모든 화질로 제공되는 것은 아니며, 모든 멤버십에서 모든 화질로 콘텐츠를 이용할 수 있는 것은 아닙니다. 모바일 네트워크 사용 시, 기본 재생 설정에서 HD, UHD 및 HDR 콘텐츠는 제외됩니다. SD 품질을 유지하기 위한 최소 연결 속도는 1.0Mbps이나, 양호한 영상 품질을 위해서는 더 높은 속도를 권장합니다. HD 콘텐츠(720p 이상의 해상도)를 수신하기 위한 권장 다운로드 속도는 스트리밍당 3.0Mbps 이상입니다. UHD 콘텐츠(4K 이상의 해상도)를 수신하기 위한 권장 다운로드 속도는 스트리밍당 15.0Mbps 이상입니다. 모든 인터넷 접속 요금은 사용자 부담입니다. 부과될 수 있는 인터넷 데이터 이용 요금에 대한 세부사항은 인터넷 서비스 제공업체에 확인하시기 바랍니다. MovieBug 콘텐츠 시청을 시작하는 데 소요되는 시간은 지역, 해당 시점에 사용 가능한 인터넷 대역폭, 선택한 콘텐츠, MovieBug 지원 디바이스의 설정 등 다양한 요인에 따라 달라질 수 있습니다.
<br/><br/>
7. MovieBug 소프트웨어는 MovieBug에 의해 자체 사용 목적으로 개발되었으며, MovieBug 지원 디바이스를 이용해 MovieBug로부터 콘텐츠를 합법적으로 스트리밍하고 시청하는 용도로만 사용할 수 있습니다. MovieBug 소프트웨어는 디바이스와 매체별로 달라질 수 있으며, 기능도 디바이스마다 다를 수 있습니다. 회원은 MovieBug 서비스 이용을 위해 타사 라이선스 계약의 대상인 타사 소프트웨어가 필요할 수 있음을 인지합니다. 회원은 MovieBug 소프트웨어와 관련 타사 소프트웨어의 업데이트된 버전을 자동으로 다운로드하는 데에 동의합니다.
<br/><br/>
8. 비밀번호 및 계정 액세스.
MovieBug 계정을 생성하여 본인의 등록 결제 수단에 요금이 청구되는 회원(이하 '계정 소유자')은 MovieBug 계정 사용으로 인한 모든 활동에 대해 책임이 있습니다. 계정해킹, 명의도용, 신용카드 부정사용이나 기타 이에 준하는 사기행위 또는 불법행위로부터 회원 및 MovieBug 등을 보호하기 위해 MovieBug는 회원 계정을 종료하거나 보류 조치를 취할 수 있습니다.
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
					    MovieBug는 다음과 같은 회원 정보를 수신 및 보관합니다.<br/><br/>
<ul>
<li>회원이 MovieBug에 제공하는 정보: MovieBug는 다음 정보를 포함해 회원이 MovieBug에 제공하는 정보를 수집합니다.</li><br/>
<ol>
<li>회원의 이름, 이메일 주소, 주소 또는 우편 번호, 결제 수단, 전화번호. MovieBug는 회원이 MovieBug 서비스 이용 과정에서 정보를 입력하는 경우, 고객 센터와 상담하는 경우 또는 설문 조사나 마케팅 프로모션에 참여하는 경우 등 다양한 방식을 통해 이러한 정보를 수집합니다.</li><br/>
<li>회원이 평가, 선호분야 설정, 계정 설정(웹사이트의 '계정' 섹션에 설정된 환경 설정 포함) 시 입력하는 정보 또는 MovieBug 서비스나 타사를 통해 MovieBug에 제공하는 정보.</li><br/>
</ol>
<li>MovieBug가 자동으로 수집하는 정보: MovieBug는 회원과 회원의 MovieBug 서비스 이용, 회원과 MovieBug의 커뮤니케이션 및 회원의 MovieBug 광고 참여에 관한 정보뿐만 아니라 회원이 MovieBug 서비스에 액세스하는 데 사용할 수 있는 네트워크, 네트워크 디바이스 및 컴퓨터 또는 기타 MovieBug 이용이 가능한 디바이스(게임 시스템, 스마트 TV, 모바일 디바이스, 셋톱박스 및 기타 스트리밍 미디어 디바이스)와 관련된 정보를 수집합니다. 이 정보에는 다음이 포함됩니다.</li><br/>
<ol>
<li>콘텐츠 선택, 시청한 프로그램 및 검색어 등 회원의 MovieBug 서비스 내 활동</li><br/>
<li>MovieBug가 발송한 이메일과 문자 메시지, 그리고 MovieBug가 푸시 알림 및 온라인 메시징 채널을 통해 보낸 메시지를 회원이 수신하고 이에 대응한 내용</li><br/>
<li>문의한 일시와 이유, 채팅 대화 기록, (전화 문의인 경우) 전화번호와 통화 녹음 등 회원의 MovieBug 고객 센터 문의에 관한 세부 내용</li><br/>
<li>디바이스 ID 등의 고유 식별자(회원의 네트워크 디바이스 및 Wi-Fi 네트워크에서 MovieBug 이용이 가능한 디바이스 포함).</li><br/>
<li>재설정 가능 디바이스 식별자(광고 식별자로도 알려짐). 예를 들어 이러한 식별자가 있는 모바일 디바이스, 태블릿 및 스트리밍 미디어 디바이스 등에서 사용하는 식별자(자세한 내용은 아래 '쿠키 및 인터넷 광고' 섹션 참조)</li><br/>
<li>디바이스 및 소프트웨어 특성(유형 및 구성 등), 유형(wifi 및 모바일 데이터)을 포함한 연결 정보, 페이지 뷰 관련 통계, 참조 소스(예: 참조 URL), IP 주소(회원의 대략적인 위치 정보), 브라우저 및 표준 웹 서버 로그 정보</li><br/>
<li>광고 데이터(광고 이용 여부 및 게재, 사이트 URL, 날짜 및 시간 관련 정보 등)를 비롯해 쿠키, 웹 비콘 및 기타 기술을 사용해 수집한 정보 (자세한 내용은 '쿠키 및 인터넷 광고' 섹션 참조).</li><br/>
</ol>

또한 회원은 다음과 같은 방식으로 본인 정보를 공개하기로 선택할 수 있습니다.<br/><br/>

MovieBug 서비스 중 일부는 회원의 스마트 디바이스에 설치된 클라이언트와 애플리케이션을 이용해 회원이 이메일, 문자 메시지 및 소셜 미디어 등의 공유 애플리케이션으로 정보를 공유할 수 있는 도구를 포함할 수 있습니다.<br/><br/>
회원은 소셜 플러그인과 기타 유사한 기술을 통해 정보를 공유할 수 있습니다.<br/><br/>
소셜 플러그인 및 소셜 애플리케이션은 해당 소셜 네트워크에서 자체적으로 운영하므로 해당 업체의 이용 약관 및 개인정보 보호 정책이 적용됩니다.<br/><br/>
</ul>
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
  </div>
 
  
        <script src="<%= request.getContextPath()%>/js/index.js"></script>

      <!-- navbar 필수 import -->
      <!-- import navbar.js -->
      <script src="<%= request.getContextPath()%>/js/navbar.js"></script>

		<!-- import footer.jsp -->
      	<jsp:include page="../include/footer.jsp"></jsp:include>

<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script type="text/javascript">
   // 이메일, 비밀번호, 약관동의의 유효성 여부를 관리한 변수 만들고 초기값 대입
   let isPwdValid=false;
   let isEmailValid=false;
   let isChecked=false;
   let isNameValid=false;
   
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
   
 //닉네임을 입력했을때(input) 실행할 함수 등록 
   document.querySelector("#name").addEventListener("input", function(){
      //일단 is-valid,  is-invalid 클래스를 제거한다.
      document.querySelector("#name").classList.remove("is-valid");
      document.querySelector("#name").classList.remove("is-invalid");
      
      //1. 입력한 아이디 value 값 읽어오기  
      let inputName=this.value;
      //입력한 아이디를 검증할 정규 표현식
      const reg_name=/^.{2,9}$/;
      //만일 입력한 아이디가 정규표현식과 매칭되지 않는다면
      if(!reg_name.test(inputName)){
         isNameValid=false; //아이디가 매칭되지 않는다고 표시하고 
         // is-invalid 클래스를 추가한다. 
         document.querySelector("#name").classList.add("is-invalid");
         return; //함수를 여기서 끝낸다 (ajax 전송 되지 않도록)
      }
      
      //2. util 에 있는 함수를 이용해서 ajax 요청하기
      ajaxPromise("checkName.jsp", "get", "inputName="+inputName)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
         console.log(data);
         //data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
         if(data.isExist){//만일 존재한다면
            //사용할수 없는 아이디라는 피드백을 보이게 한다. 
            isNameValid=false;
            // is-invalid 클래스를 추가한다. 
            document.querySelector("#name").classList.add("is-invalid");
         }else{
            isNameValid=true;
            document.querySelector("#name").classList.add("is-valid");
         }
      });
   });
   
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
      
      let isFormValid = isPwdValid && isEmailValid && isChecked && isNameValid;
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




