<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="test.free_cafe.dto.FreeCafeCommentDto"%>
<%@page import="test.free_cafe.dao.FreeCafeCommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //폼 전송되는 파라미터 추출 
   int free_comment_ref_group=Integer.parseInt(request.getParameter("free_comment_ref_group"));
   String free_comment_target_id=request.getParameter("free_comment_target_id");
   String free_comment_content=request.getParameter("free_comment_content");
   /*
    *  원글의 댓글은 free_comment_group 번호가 전송이 안되고
    *  댓글의 댓글은 free_comment_group 번호가 전송이 된다.
    *  따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판단할수 있다. 
    */
   String free_comment_group=request.getParameter("free_comment_group");
   
   //댓글 작성자는 session 영역에서 얻어내기
   String free_comment_writer=(String)session.getAttribute("email");
   //댓글의 시퀀스 번호 미리 얻어내기
   int seq=FreeCafeCommentDao.getInstance().getSequence();
   //저장할 댓글의 정보를 dto 에 담기
   FreeCafeCommentDto dto=new FreeCafeCommentDto();
   dto.setFree_comment_idx(seq);
   dto.setFree_comment_writer(free_comment_writer);
   dto.setFree_comment_target_id(free_comment_target_id);
   dto.setFree_comment_content(free_comment_content);
   dto.setFree_comment_ref_group(free_comment_ref_group);
   //원글의 댓글인경우
   if(free_comment_group == null){
      //댓글의 글번호를 comment_group 번호로 사용한다.
      dto.setFree_comment_group(seq);
   }else{
      //전송된 comment_group 번호를 숫자로 바꾸서 dto 에 넣어준다. 
	   dto.setFree_comment_group(Integer.parseInt(free_comment_group));
   }
   //댓글 정보를 DB 에 저장하기
   FreeCafeCommentDao.getInstance().insert(dto);
   //응답하기 (원글 자세히 보기로 다시 리다일렉트 시킨다)
   String cPath=request.getContextPath();
   response.sendRedirect(cPath+"/free_cafe/detail.jsp?num="+free_comment_ref_group);
%>