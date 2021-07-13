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

	//한 페이지에 몇개씩 표시할 것인지
	   final int COMMENT_PAGE_ROW_COUNT=5;
	   //하단 페이지를 몇개씩 표시할 것인지
	   final int COMMENT_PAGE_DISPLAY_COUNT=10;
	   
	   //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	   int cmtPageNum=1;
	   //페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	   String cmtStrPageNum=request.getParameter("cmtPageNum");
	   //만일 페이지 번호가 파라미터로 넘어 온다면
	   if(cmtStrPageNum != null){
	      //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
	      cmtPageNum=Integer.parseInt(cmtStrPageNum);
	   }
	   
	   //보여줄 페이지의 시작 ROWNUM
	   int cmtStartRowNum=1+(cmtPageNum-1)*COMMENT_PAGE_ROW_COUNT;
	   //보여줄 페이지의 끝 ROWNUM
	   int cmtEndRowNum=cmtPageNum*COMMENT_PAGE_ROW_COUNT;
	   
	     
	   //CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	   CafeCommentDto dto3=new CafeCommentDto();
	   
	   dto3.setStartRowNum(cmtStartRowNum);
	   dto3.setEndRowNum(cmtEndRowNum);
	   dto3.setQna_comment_writer(email);

		 //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		 List<CafeCommentDto> commentList=null;
		 //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		 int cmtTotalRow=0;
		 //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
		 commentList=CafeCommentDao.getInstance().userCommentList(dto3);
		 //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
		 cmtTotalRow=CafeCommentDao.getInstance().userCommentCount(dto3);
	   
		   //하단 시작 페이지 번호 
		   int cmtStartPageNum = 1 + ((cmtPageNum-1)/COMMENT_PAGE_DISPLAY_COUNT)*COMMENT_PAGE_DISPLAY_COUNT;
		   //하단 끝 페이지 번호
		   int cmtEndPageNum=cmtStartPageNum+COMMENT_PAGE_DISPLAY_COUNT-1;
		   
		   int cmtTotalPageCount=(int)Math.ceil(cmtTotalRow/(double)COMMENT_PAGE_ROW_COUNT);
		   //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
		   if(cmtEndPageNum > cmtTotalPageCount){
		      cmtEndPageNum=cmtTotalPageCount; //보정해 준다.
		   }
%>