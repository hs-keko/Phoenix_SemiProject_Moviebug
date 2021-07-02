<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insertform.jsp</title>
</head>
<body>
<div class="container">
	<h1>새 글 등록하는 폼</h1>
	<form action="insert.jsp" method="post">
		<div>
			<label for="qna_title">제목</label>
			<input type="text" name="qna_title" id="qna_title"/>
		</div>	
		<div>
			<label for="qna_content">내용</label>
			<textarea name="qna_content" id="qna_content"></textarea>
		</div>
		<div>
         <label for="qna_file">첨부파일</label>
         <input type="file" name="qna_file" id="qna_file"/>
      </div>
		<button type="submit">저장</button>
	</form>
</div>
</body>
</html>