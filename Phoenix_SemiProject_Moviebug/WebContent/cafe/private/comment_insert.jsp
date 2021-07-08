<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //폼 전송되는 파라미터 추출 
   int qna_comment_ref_group=Integer.parseInt(request.getParameter("qna_comment_ref_group"));
   String qna_comment_target_id=request.getParameter("qna_comment_target_id");
   String qna_comment_content=request.getParameter("qna_comment_content");
   /*
    *  원글의 댓글은 qna_comment_group 번호가 전송이 안되고
    *  댓글의 댓글은 qna_comment_group 번호가 전송이 된다.
    *  따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판단할수 있다. 
    */
   String qna_comment_group=request.getParameter("qna_comment_group");
   
   //댓글 작성자는 session 영역에서 얻어내기
   String email=(String)session.getAttribute("email");
   String name=UsersDao.getInstance().getData(email).getName();
   //댓글의 시퀀스 번호 미리 얻어내기
   int seq=CafeCommentDao.getInstance().getSequence();
   //저장할 댓글의 정보를 dto 에 담기
   CafeCommentDto dto=new CafeCommentDto();
   dto.setQna_comment_idx(seq);
   dto.setQna_comment_writer(name);
   dto.setQna_comment_target_id(email);
   dto.setQna_comment_content(qna_comment_content);
   dto.setQna_comment_ref_group(qna_comment_ref_group);
   //원글의 댓글인경우
   if(qna_comment_group == null){
      //댓글의 글번호를 comment_group 번호로 사용한다.
      dto.setQna_comment_group(seq);
   }else{
      //전송된 comment_group 번호를 숫자로 바꾸서 dto 에 넣어준다. 
	   dto.setQna_comment_group(Integer.parseInt(qna_comment_group));
   }
   //댓글 정보를 DB 에 저장하기
   CafeCommentDao.getInstance().insert(dto);
   //응답하기 (원글 자세히 보기로 다시 리다일렉트 시킨다)
   String cPath=request.getContextPath();
   response.sendRedirect(cPath+"/cafe/detail.jsp?num="+qna_comment_ref_group);
%>