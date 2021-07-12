<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	CafeDto dto=CafeDao.getInstance().getData(num);
	
	String email=(String)session.getAttribute("email");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/updateform.jsp</title>
   <jsp:include page="../../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    
    <link rel="stylesheet" type="text/css" href="../css/navbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/footer.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
	
	<!-- 웹폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Tourney:wght@600&display=swap" rel="stylesheet">

	<!-- 웹폰트 test -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Girassol&family=Major+Mono+Display&display=swap" rel="stylesheet">
  
	<!-- 웹폰트 댓글  -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>
	html, body {
		width: 100%;
		height: 100%;
	}
	
	.container {
		width: 100%;
		height: 100%;	
	}
	.footer {
		  height: 50px;
		  margin-top: -50px;
	}
	a{
	text-decoration: none; 
	}
</style>
</head>
<body>
<div class="container">
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
	<br>
	<br>
	<form action="update.jsp" method="post">
		<input type="hidden" name="qna_idx" value="<%=num %>" />
			<div class="mb-3">
				<label class="form-label" for="qna_writer">작성자</label>
				<input class="form-control" type="text" id="qna_writer" value="<%=dto.getQna_writer() %>" disabled/>
			</div>
			<div>
				<label class="form-label" for="qna_title">제목</label>
				<input class="form-control" type="text" name="qna_title" id="qna_title" value="<%=dto.getQna_title()%>"/>
			</div>
			<br>
			<div class="mb-3">
				<label class="form-label" for="qna_file">첨부파일</label>
				<input class="form-control" type="file" name="qna_file" id="qna_file" value="<%=dto.getQna_file()%>"/>
			</div>
			<br>
			<div class="mb-3">
				<label class="form-label" for="qna_content">내용</label>
				<textarea class="form-control" name="qna_content" id="qna_content"><%=dto.getQna_content() %></textarea>
			</div>
		<div class="w-100 clearfix">
			<button class="btn btn-outline-secondary float-end ms-2" type="submit" onclick="submitContents(this);">수정확인</button>
			<button class="btn btn-outline-secondary float-end" type="reset"><a class="link-secondary" href=../list.jsp>취소</a></button>
		</div>
	</form>
</div>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "qna_content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["qna_content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["qna_content"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["qna_content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["qna_content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<script src="<%= request.getContextPath()%>/js/navbar.js"></script>
	<!-- footer  -->
<div id="footer">
   	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
</body>
</html>





