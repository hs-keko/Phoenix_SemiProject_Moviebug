<%@page import="test.free_cafe.dao.FreeCafeDao"%>
<%@page import="java.util.List"%>
<%@page import="moviebug.users.dao.UsersDao"%>
<%@page import="moviebug.users.dto.UsersDto"%>
<%@page import="test.free_cafe.dto.FreeCafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//1. session 영역에서 로그인된 아이디를 읽어온다.
	String email=(String)session.getAttribute("email");
	//2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
	UsersDto dto=UsersDao.getInstance().getData(email);
	// Free 게시판의 이름과 유저정보 이름 확인
	String Free_writer = dto.getName();
	
	//한 페이지에 몇개씩 표시할 것인지
	final int FREE_PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int FREE_PAGE_DISPLAY_COUNT=10;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int freePageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String freeStrPageNum=request.getParameter("freePageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(freeStrPageNum != null){
	   //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
	   freePageNum=Integer.parseInt(freeStrPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int freeStartRowNum=1+(freePageNum-1)*FREE_PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int freeEndRowNum=freePageNum*FREE_PAGE_ROW_COUNT;
	 
	//CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	FreeCafeDto dto2=new FreeCafeDto();
	dto2.setStartRowNum(freeStartRowNum);
	dto2.setEndRowNum(freeEndRowNum);
	dto2.setFree_writer(Free_writer);
	
		 //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		 List<FreeCafeDto> list=null;
		 //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		 int totalRow=0;
		 //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
		 list=FreeCafeDao.getInstance().userGetList(dto2);
		 //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
		 totalRow=FreeCafeDao.getInstance().userGetCount(dto2);
	
	
	//하단 시작 페이지 번호 
	int freeStartPageNum = 1 + ((freePageNum-1)/FREE_PAGE_DISPLAY_COUNT)*FREE_PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int freeEndPageNum=freeStartPageNum+FREE_PAGE_DISPLAY_COUNT-1;
	
	int freeTotalPageCount=(int)Math.ceil(totalRow/(double)FREE_PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(freeEndPageNum > freeTotalPageCount){
	   freeEndPageNum= freeTotalPageCount; //보정해 준다.
	}

%>
<table class="table">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
									<%for(FreeCafeDto tmp:list) {%>
									<tr>
										<td><%=tmp.getFree_idx() %></td>									
										<td><%if(tmp.getFree_file() != null){ %>
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image-fill" viewBox="0 0 16 16">
								  				<path d="M.002 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-12a2 2 0 0 1-2-2V3zm1 9v1a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V9.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12zm5-6.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0z"/>
											</svg>
											<a href="<%=request.getContextPath()%>/free_cafe/detail.jsp?num=<%=tmp.getFree_idx()%>"><%=tmp.getFree_title() %></a>
									<%}else{ %>
										<a href="<%=request.getContextPath()%>/free_cafe/detail.jsp?num=<%=tmp.getFree_idx()%>"><%=tmp.getFree_title() %></a>
									<%} %>
										</td>
										<td><%=tmp.getFree_writer() %></td>
										<td style="color:gray"><%=tmp.getFree_regdate() %></td>
									</tr>
									<%} %>
								</tbody>
							</table>
							<div class="page-ui clearfix">
				      			<ul>
				         		<%if(freeStartPageNum != 1){ %>
				            		<li>
				              			 <a href="info.jsp?freePageNum=<%=freeStartPageNum-1 %>">Prev</a>
				            		</li>   
				         		<%} %>
				         
				         		<%for(int i=freeStartPageNum; i<=freeEndPageNum ; i++){ %>
				            		<li>
				              		<%if(freePageNum == i){ %>
				                  		<a class="active" href="info.jsp?freePageNum=<%=i %>"><%=i %></a>
				               		<%}else{ %>
				                  		<a href="info.jsp?freePageNum=<%=i %>"><%=i %></a>
				              		<%} %>
				           			</li>   
				        			<%} %>
				         			<%if(freeEndPageNum < freeTotalPageCount){ %>
				            		<li>
				               			<a href="info.jsp?freePageNum=<%=freeEndPageNum+1 %>">Next</a>
				           			</li>
				         			<%} %>
				      			</ul>
							</div>