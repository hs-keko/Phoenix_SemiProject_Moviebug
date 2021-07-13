<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 아이디
	String email = (String)session.getAttribute("email");
	//ajax 요청 파라미터로 넘어오는 댓글의 페이지 번호를 읽어낸다
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	//ajax 요청 파라미터로 넘어오는 원글의 페이지 번호를 읽어낸다.
	int qna_idx=Integer.parseInt(request.getParameter("qna_idx"));

	/*
	[댓글 페이징 처리]
	*/
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;

	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;

	//원글의 글번호를 이용해 해당글에 달린 댓글 목록을 얻어옴
	CafeCommentDto commentDto = new CafeCommentDto();
	commentDto.setQna_comment_ref_group(qna_idx);
	
	//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
	commentDto.setStartRowNum(startRowNum);
	commentDto.setEndRowNum(endRowNum);
		
	//pageNum에 해당하는 댓글 목록만 select 되도록 한다. 
	List<CafeCommentDto> commentList=
		CafeCommentDao.getInstance().getList(commentDto);
		
	//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
	int totalRow=CafeCommentDao.getInstance().getCount(qna_idx);
	//댓글 전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
%>