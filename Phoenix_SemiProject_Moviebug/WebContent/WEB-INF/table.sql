-- 사용자(회원) 정보를 저장할 테이블
CREATE TABLE users(
	name VARCHAR2(20),
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100) PRIMARY KEY,
	addr VARCHAR2(100) NOT NULL,
	profile VARCHAR2(1000), -- 프로필 이미지 경로를 저장할 칼럼
	regdate DATE -- 가입일
);

-- QNA 게시글을 저장할 테이블
CREATE TABLE board_qna(
	qna_idx NUMBER PRIMARY KEY, --글번호
	qna_writer VARCHAR2(100) NOT NULL, --작성자 (로그인된 아이디)
	qna_title VARCHAR2(100) NOT NULL, --제목
	qna_content CLOB, --글 내용
	qna_file VARCHAR2(1000), --첨부파일
	qna_regdate DATE --글 작성일
); 

-- QNA 게시글의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_qna_seq;

-- QNA 게시글의 댓글을 저장할 테이블
CREATE TABLE board_qna_comment(
   qna_comment_idx NUMBER PRIMARY KEY, --댓글의 글번호
   qna_comment_writer VARCHAR2(100), --댓글 작성자의 아이디
   qna_comment_content VARCHAR2(2000), --댓글 내용
   qna_comment_target_id VARCHAR2(100), --댓글의 대상자 아이디
   qna_comment_ref_group NUMBER,
   qna_comment_group NUMBER,
   qna_comment_deleted CHAR(3) DEFAULT 'no',
   qna_comment_regdate DATE
);
-- QNA 댓글의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_qna_comment_seq;

-- 영화 댓글을 저장할 테이블
CREATE TABLE board_comment(
   comment_idx NUMBER PRIMARY KEY, --댓글의 글번호
   comment_writer VARCHAR2(100), --댓글 작성자의 아이디
   comment_content VARCHAR2(2000), --댓글 내용
   comment_target_id VARCHAR2(100), --댓글의 대상자 아이디
   comment_ref_group NUMBER,
   comment_group NUMBER,
   comment_deleted CHAR(3) DEFAULT 'no',
   comment_regdate DATE
);
-- 영화 댓글 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_comment_seq;


CREATE TABLE qna_board_comment(
   qna_comment_idx NUMBER PRIMARY KEY, --댓글의 글번호
   qna_comment_writer VARCHAR2(100), --댓글 작성자의 아이디
   qna_comment_content VARCHAR2(2000), --댓글 내용
   qna_comment_target_id VARCHAR2(100), --댓글의 대상자 아이디
   qna_comment_ref_group NUMBER,
   qna_comment_group NUMBER,
   qna_comment_deleted CHAR(3) DEFAULT 'no',
   qna_comment_regdate DATE
);
-- 댓글 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_comment_seq;


-- 영화 정보를 저장할 테이블
CREATE TABLE movie_info(
	movie_num NUMBER PRIMARY KEY not null, --영화 번호
	movie_title_kr VARCHAR2(100), --영화 제목(한글)
	movie_title_eng VARCHAR2(100), --영화 제목(영문)
	movie_story VARCHAR2(2000), -- 영화 줄거리
	movie_character VARCHAR2(300), -- 영화 감독/출연진
	movie_year varchar2(100),-- 영화 제작년도
	movie_genre VARCHAR2(100), -- 영화 장르
	movie_company VARCHAR2(100), -- 제작사
	movie_image VARCHAR2(2000), -- 영화 이미지 경로
	movie_trailer VARCHAR2(1000), -- 영화 트레일러 경로
	movie_time VARCHAR2(10), -- 러닝 타임
	movie_rating VARCHAR2(10) -- 영화 평점
	movie_nation varchar2(25) -- 제작 국가
	movie_director varchar2(20) -- 감독
);

-- 영화 정보 번호를 얻어낼 시퀀스
CREATE SEQUENCE movie_info_seq;

