<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=5;
   //하단 페이지를 몇개씩 표시할 것인지
   final int PAGE_DISPLAY_COUNT=5;
   
   //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
   int pageNum=1;
   //페이지 번호가 파라미터로 전달되는지 읽어와 본다.
   String strPageNum=request.getParameter("pageNum");
   //만일 페이지 번호가 파라미터로 넘어 온다면
   if(strPageNum != null){
      //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
      pageNum=Integer.parseInt(strPageNum);
   }
   
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum=pageNum*PAGE_ROW_COUNT;
   
   //CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   CafeDto dto=new CafeDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);

   //CafeDao 객체의 참조값 얻어와서 
   CafeDao dao=CafeDao.getInstance();
   //회원목록 얻어오기 
   List<CafeDto> list=dao.getList(dto);
   
   //하단 시작 페이지 번호 
   int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
   //하단 끝 페이지 번호
   int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
   
   //전체 row 의 갯수 
   int totalRow=dao.getCount();
   //전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
   if(endPageNum > totalPageCount){
      endPageNum=totalPageCount; //보정해 준다.
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
<style>
   .page-ui a{
      text-decoration: none;
      color: #000;
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: red;
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .page-ui ul > li{
      float: left;
      padding: 5px;
   }
</style>
</head>
<body>
<div class="container">
	<a href="private/insertform.jsp">새글 작성하기</a>
	<h1>글 목록</h1>
	<table>
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>제목</th>
				<th>내용</th>
				<th>첨부파일</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<%for(CafeDto tmp:list) {%>
			<tr>
				<td><%=tmp.getQna_idx() %></td>
				<td><%=tmp.getQna_writer() %></td>
				<td><%=tmp.getQna_title() %></td>
				<td><%=tmp.getQna_content() %></td>
				<td><%=tmp.getQna_file() %></td>
				<td><%=tmp.getQna_regdate() %></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<div class="page-ui clearfix">
         <ul>
            <%if(startPageNum != 1){ %>
               <li>
                  <a href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
               </li>   
            <%} %>
            
            <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
               <li>
                  <%if(pageNum == i){ %>
                     <a class="active" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
                  <%}else{ %>
                     <a href="list.jsp?pageNum=<%=i %>"><%=i %></a>
                  <%} %>
               </li>   
            <%} %>
            <%if(endPageNum < totalPageCount){ %>
               <li>
                  <a href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
               </li>
            <%} %>
         </ul>
      </div>
</div>
</body>
</html>