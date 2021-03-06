<%@page import="test.free_cafe.dao.FreeCafeDao"%>
<%@page import="test.free_cafe.dto.FreeCafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FreeCafeDto dto=FreeCafeDao.getInstance().getData(num);
	
	String email=(String)session.getAttribute("email");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
    <!-- navbar 필수 import -->
    <jsp:include page="../../include/resource.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/navbar.css" />
    <!-- import css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/footer.css" />
	
	
<style>
	.footer_inner a {
	   color:white;
	}
	#free_content{
		height: 500px;
	}
	html, body {
		width: 100%;
		height: 100%;
		margin-top: 30px;
	}
	
	.container {
		width: 100%;
		height: 100%;	
		margin-bottom:150px
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
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="<%=email != null ? email:null %>" name="email"/>
</jsp:include>
<div class="container">
	<br>
	<br>
	<form action="update.jsp" method="post">
		<input type="hidden" name="free_idx" value="<%=num %>" />
			<div class="mb-3">
				<label class="form-label" for="free_writer">작성자</label>
				<input class="form-control" type="text" id="free_writer" value="<%=dto.getFree_writer() %>" disabled/>
			</div>
			<div>
				<label class="form-label" for="free_title">제목</label>
				<input class="form-control" type="text" name="free_title" id="free_title" value="<%=dto.getFree_title()%>"/>
			</div>
			<br>
			<div class="mb-3">
				<label class="form-label" for="free_file">첨부파일</label>
				<input class="form-control" type="file" name="free_file" id="free_file" value="<%=dto.getFree_file()%>"/>
			</div>
			<br>
			<div class="mb-3">
				<label class="form-label" for="free_content">내용</label>
				<textarea class="form-control" name="free_content" id="free_content"><%=dto.getFree_content() %></textarea>
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
		elPlaceHolder: "free_content",
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
		oEditors.getById["free_content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["free_content"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["free_content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["free_content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<script src="<%= request.getContextPath()%>/js/navbar.js"></script>
	<!-- footer  -->
<div id="footer">
   	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
</body>
</html>





