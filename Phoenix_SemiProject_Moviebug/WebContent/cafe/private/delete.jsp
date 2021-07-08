<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1.get방식 파라미터로 전달되는 삭제할 글 번호를 가지고 오자
	int num=Integer.parseInt(request.getParameter("num"));
	
	//2.로그인된 이메일(id)로부터 이름을 가져와서 
	//  삭제할 글의 글작성자와 이름이 같은지 비교하여
	String email=(String)session.getAttribute("email");
	String name=UsersDao.getInstance().getData(email).getName();
	String writer=CafeDao.getInstance().getData(num).getQna_writer();
	//작성자와 이름이 다르면 금지된 요청이라고 응답하고,
	if(!writer.equals(name)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "잘못된 접근입니다");
		return;
	}
	//같으면 DB에서 삭제하고 응답하자	
	boolean isSuccess=CafeDao.getInstance().delete(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/delete.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
	   <script>
	      alert("삭제하였습니다.");
	      location.href="${pageContext.request.contextPath}/cafe/list.jsp";
	   </script>
   <%}else{ %>
	   <script>
	      alert("삭제 실패!");
	      location.href="detail.jsp?num=<%=num%>";
	   </script>
	<%} %>
</body>
</html>