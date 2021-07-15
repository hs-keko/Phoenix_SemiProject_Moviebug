<%@page import="moviebug.movieinfo.dao.MovieDao"%>
<%@page import="moviebug.movieinfo.dto.MovieDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
final int PAGE_ROW_COUNT = 10;
//하단 페이지를 몇개씩 표시할 것인지
final int PAGE_DISPLAY_COUNT = 10;

//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
int pageNum = 1;
//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
String strPageNum = request.getParameter("pageNum");
//만일 페이지 번호가 파라미터로 넘어 온다면
if (strPageNum != null) {
	//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
	pageNum = Integer.parseInt(strPageNum);
}

//보여줄 페이지의 시작 ROWNUM
int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
//보여줄 페이지의 끝 ROWNUM
int endRowNum = pageNum * PAGE_ROW_COUNT;

String keyword = request.getParameter("keyword");
String condition = request.getParameter("condition");

if (keyword == null) {
	keyword = "";
	condition = "";
}
//특수기호를 인코딩한 키워드
String encodedK = URLEncoder.encode(keyword);

// 영화 검색 목록
MovieDto Mdto = new MovieDto();
Mdto.setStartRowNum(startRowNum);
Mdto.setEndRowNum(endRowNum);
//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
List<MovieDto> Mlist = null;
//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
int MtotalRow = 0;
//만일 검색 키워드가 넘어온다면 
if (!keyword.equals("")) {
	//검색 조건이 무엇이냐에 따라 분기 하기
	if (condition.equals("movie_title_direc")) {//제목 + 배우 검색인 경우
		Mdto.setMovie_title_eng(keyword);
		Mdto.setMovie_title_kr(keyword);
		Mdto.setMovie_director(keyword);
		Mlist = MovieDao.getInstance().getListTD(Mdto);
		//제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
		MtotalRow = MovieDao.getInstance().getCountTD(Mdto);
	}
} else {//검색 키워드가 넘어오지 않는다면
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
	Mlist = MovieDao.getInstance().getList(Mdto);
	//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
	MtotalRow = CafeDao.getInstance().getCount();
}

//CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
CafeDto dto = new CafeDto();
dto.setStartRowNum(startRowNum);
dto.setEndRowNum(endRowNum);
//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
List<CafeDto> list = null;
//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
int totalRow = 0;
//만일 검색 키워드가 넘어온다면 
if (!keyword.equals("")) {
	//검색 조건이 무엇이냐에 따라 분기 하기
	if (condition.equals("qna_title_content")) {//제목 + 내용 검색인 경우
		//검색 키워드를 CafeDto 에 담아서 전달한다.
		dto.setQna_title(keyword);
		dto.setQna_content(keyword);
		//제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
		list = CafeDao.getInstance().getListTC(dto);
		//제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
		totalRow = CafeDao.getInstance().getCountTC(dto);
	}
	if (condition.equals("movie_title_direc")) {
		// navbar 검색 처리중
		//검색 키워드를 CafeDto 에 담아서 전달한다.
		dto.setQna_title(keyword);
		dto.setQna_content(keyword);
		//제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
		list = CafeDao.getInstance().getListTC(dto);
		totalRow = CafeDao.getInstance().getCountTC(dto);
	}
} else {//검색 키워드가 넘어오지 않는다면
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
	list = CafeDao.getInstance().getList(dto);
	//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
	totalRow = CafeDao.getInstance().getCount();
}
String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<style>
html, body {
	margin: 0;
	width: 100%;
	height: 100%;
}

.page-ui a {
	text-decoration: none;
	color: #000;
}

.page-ui a:hover {
	text-decoration: underline;
}

.page-ui a.active {
	color: red;
	font-weight: bold;
	text-decoration: underline;
}

.page-ui ul {
	list-style-type: none;
	padding: 0;
}

.page-ui ul>li {
	float: left;
	padding: 5px;
}

#one {
	text-align: center;
}

#two {
	float: right;
}

.searchlist_container {
	margin-top: 65px;
	height: auto;
	min-height: 100%;
}

.searchlist_form form {
	margin: 30px 0;
	width: 80%;
}

.searchlist_form form input {
	
}

.search_title {
	align-items: center;
}

#condition {
	display: none;
}

#footer {
	transform: translateY(-100%);
}
</style>
</head>
<body>
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="<%=email != null ? email : null%>" name="email" />
	</jsp:include>
	<div class="container searchlist_container">
		<div class="row d-felx searchlist_form">
			<div class="col d-flex justify-content-center">
				<form action="<%=request.getContextPath()%>/search/searchall.jsp"
					method="get" class="input-group mb-3">
					<select name="condition" id="condition">
						<option class="condition" value="movie_title_direc"
							<%=condition.equals("movie_title_direc") ? "selected" : ""%>>영화
							제목/감독</option>
					</select> <input type="text" name="keyword" class="form-control"
						placeholder="검색어를 입력하세요..." aria-describedby="button-addon2"
						value="<%=keyword%>" />
					<button id="button-addon2" type="submit"
						class="btn btn-outline-secondary">검색</button>
				</form>
			</div>
		</div>
		<div class="row search_title">
			<div class="col">
				<h1 id="one">영화 검색 결과</h1>
			</div>
			<div class="col d-flex">
				<%
					if (!condition.equals("")) {
				%>
				<span> <strong><%=MtotalRow%></strong>개의 글이 검색되었습니다.
				</span>
				<%
					}
				%>
			</div>
		</div>
		<div class="row">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>번호</th>
						<th>감독</th>
						<th>제목</th>
						<th>개봉일</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (MovieDto tmp : Mlist) {
					%>
					<tr>
						<td><%=tmp.getMovie_num()%></td>
						<td><%=tmp.getMovie_director() != null ? tmp.getMovie_director() : "알수없음"%></td>
						<td><a
							href="<%=request.getContextPath()%>/movieinfo/movieinfo.jsp?movie_num=<%=tmp.getMovie_num()%>"><%=tmp.getMovie_title_kr()%>
								<%=tmp.getMovie_title_eng() != null ? "( " + tmp.getMovie_title_eng() + " )" : ""%></a>
						</td>
						<td><%=tmp.getMovie_year()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>
		<div class="row">
			<div class="col d-flex justify-content-end">
				<a
					href="<%=request.getContextPath()%>/search/more_search.jsp?keyword=<%=keyword%>">
					<button type="button" class="btn btn-secondary btn-lg mb-4">영화
						검색결과 더보기</button>
				</a>
			</div>
		</div>

		<div class="row search_title">
			<div class="col">
				<h1 id="one">Q&A 검색 결과</h1>
			</div>
			<div class="col d-flex">
				<%
					if (!condition.equals("")) {
				%>
				<span> <strong><%=totalRow%></strong>개의 글이 검색되었습니다.
				</span>
				<%
					}
				%>
			</div>
		</div>
		<div class="row">

			<table class="table table-striped">
				<thead>
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (CafeDto tmp : list) {
					%>
					<tr>
						<td><%=tmp.getQna_idx()%></td>
						<td><%=tmp.getQna_writer()%></td>
						<td>
							<%
								if (tmp.getQna_file() != null) {
							%> <svg
								xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-file-arrow-up"
								viewBox="0 0 16 16">
					  <path
									d="M8 11a.5.5 0 0 0 .5-.5V6.707l1.146 1.147a.5.5 0 0 0 .708-.708l-2-2a.5.5 0 0 0-.708 0l-2 2a.5.5 0 1 0 .708.708L7.5 6.707V10.5a.5.5 0 0 0 .5.5z" />
					  <path
									d="M4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4zm0 1h8a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z" />
					</svg> <a
							href="<%=request.getContextPath()%>/cafe/detail.jsp?num=<%=tmp.getQna_idx()%>"><%=tmp.getQna_title()%></a>
							<%
								} else {
							%> <a
							href="<%=request.getContextPath()%>/cafe/detail.jsp?num=<%=tmp.getQna_idx()%>"><%=tmp.getQna_title()%></a>
							<%
								}
							%>
						</td>
						<td><%=tmp.getQna_regdate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>
		<div class="row">
			<div class="col d-flex justify-content-end">
				<a
					href="<%=request.getContextPath()%>/cafe/list.jsp?condition=qna_title_content&keyword=<%=keyword%>">
					<button type="button" class="btn btn-secondary btn-lg mb-4">Q&A
						검색결과 더보기</button>
				</a>
			</div>
		</div>
	</div>

	<!-- footer  -->

	<div id=footer>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
	<script src="<%=request.getContextPath()%>/js/navbar.js"></script>
	<script>
		let content = document.querySelector(".searchlist_container")
		let footer = document.querySelector("#footer")
		content.style.paddingBottom = footer.offsetHeight+"px"	
		
	window.onresize = ()=>{
		content.style.paddingBottom = footer.offsetHeight+"px"	
	}
	</script>
</body>
</html>