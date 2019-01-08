# [HUGH Board] Spring CRUD 게시판 구현

<br>

<b>< 개발환경 ></b>

<ul>
  <li>Front-End</li>
    <ul>
      <li>HTML5, CSS3, JavaScript</li>
      <li>JSP</li>
      <li>jQuery</li>
      <li>Ajax</li>
      <li>Bootstrap</li>
    </ul>
</ul>
<ul>
  <li>Back-End</li>
    <ul>
      <li>Java</li>
      <li>Spring</li>
      <li>Maven</li>
      <li>Mybatis</li>
    </ul>
</ul>
<ul>
  <li>DB</li>
    <ul>
      <li>MariaDB</li>
    </ul>
</ul>
<ul>
  <li>Server</li>
    <ul>
      <li>Apache Tomcat</li>
    </ul>
</ul>
<ul>
  <li>Used Library/API/Framework</li>
    <ul>
      <li>Naver Login Open API</li>
      <li>emailJS</li>
      <li>Handlbars</li>
      <li>Jackson</li>
    </ul>
</ul>

<hr>

<b>< Tool Kit ></b>

<ul>
    <li>Eclipse, HeidiSQL</li>
    <li>Github</li>
    <li>Advanced REST client</li>
</ul>

<hr>

<b>< DB 구축 ></b>

<p><b> - database</b><p>
create database bdi;

use bdi;

<p><b> - tbl_board</b><p>

CREATE TABLE tbl_board
(
	bno int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	content text NOT NULL,
	writer varchar(30) NOT NULL,
	regdate datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() NOT NULL,
	viewcnt int(11) unsigned DEFAULT 0,
	replycnt int(11) unsigned DEFAULT 0,
	likecnt int(11) unsigned DEFAULT 0,
	PRIMARY KEY (bno)
);


<p><b> - tbl_reply</b><p>
  
CREATE TABLE tbl_reply
(
	rno int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
	bno int(11) unsigned zerofill NOT NULL,
	replywriter varchar(30) NOT NULL,
	replytext varchar(300) NOT NULL,
	regdate datetime DEFAULT current_timestamp() NOT NULL,
	updatedate datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() NOT NULL,
	PRIMARY KEY (rno)
);


<p><b> - tbl_attach</b><p>
  
CREATE TABLE tbl_attach
(
	fullName varchar(255) NOT NULL,
	bno int(11) unsigned zerofill NOT NULL,
	regdate datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() NOT NULL,
	PRIMARY KEY (fullName)
);

<p><b> - tbl_user</b><p>
  
CREATE TABLE tbl_user
(
	uid varchar(30) NOT NULL,
	-- SHA-256 암호화
	pw varchar(255) NOT NULL COMMENT 'SHA-256 암호화',
	name varchar(30) NOT NULL,
	gender varchar(5) NOT NULL,
	email varchar(150) NOT NULL,
	joindate datetime DEFAULT current_timestamp() NOT NULL,
	sessionkey varchar(255) DEFAULT 'none' NOT NULL,
	sessionlimit timestamp DEFAULT current_timestamp() ON UPDATE current_timestamp() NOT NULL,
	authkey varchar(255) DEFAULT 'NULL',
	authstatus tinyint DEFAULT 0,
	PRIMARY KEY (uid),
	UNIQUE (uid),
	UNIQUE (email)
);


<p><b> - tbl_like</b><p>
  
CREATE TABLE tbl_like
(
	lno int(11) unsigned NOT NULL AUTO_INCREMENT,
	bno int(11) unsigned zerofill NOT NULL,
	uid varchar(30) NOT NULL,
	PRIMARY KEY (lno)
);

<p><b> - foreign key</b></p>

ALTER TABLE tbl_attach
	ADD FOREIGN KEY (bno)
	REFERENCES tbl_board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tbl_like
	ADD FOREIGN KEY (bno)
	REFERENCES tbl_board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tbl_reply
	ADD FOREIGN KEY (bno)
	REFERENCES tbl_board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tbl_like
	ADD FOREIGN KEY (uid)
	REFERENCES tbl_user (uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


<hr>

<b>< ERD ></b>

<img src="https://user-images.githubusercontent.com/39483738/50820002-ed4baa00-136e-11e9-9bdd-1941be07bc2e.PNG" width="700px;">

<hr>

<b>< Program List ></b>

<img src="https://user-images.githubusercontent.com/39483738/50736343-d5094d00-11ff-11e9-875f-f9cd95cfa47b.JPG" width="400px;">

<hr>

<b>< Function ></b>

<ol>
  <b><li>회원가입</li></b>
  <ul>
    <ol>
      <b><li>기본 기능</li></b>
        <ul>
          <li>
            Ajax를 이용해 입력된 uid, email 값을 파라미터로 하여 컨트롤러에 전달 -> 
            tbl_user 테이블을 조회하여 아이디, 이메일 중복 결과를 text 데이터 타입으로 리턴
          </li>
          <li>비밀번호 4자리 이상 + 비밀번호 재입력 일치 시 -&raquo; 비밀번호 체크 표시 활성화</li>
          <li>---> jQeury .keyup() 사용, 매 입력시 최종 조건 모두 충족해야만 submit 버튼 활성화</li>
          <li>비밀번호 저장시 java.security.MessageDigest 클래스를 사용하여 SHA-256 암호화</li>
          <li>---> PassEncryption 클래스로, 비밀번호를 해시함수로 전환 후 digest로 encode해서 DB에 저장</li>
        </ul>
      <b><li>이메일 인증</li></b>
        <ul>
          <li>임시 회원가입 이후, 인증용 메일 수신(임의의 authkey정보 포함) -> 이메일 인증(사용자 권한 활성화)</li>
        </ul>
    </ol>   
  </ul>
 
  <b><li>로그인</li></b>
  <ul>
    <ol>
      <b><li>기본 기능</li></b>
        <ul>
          <li>Interceptor를 이용한 세션, 쿠키 관리</li>
          <li>강제 로그인이 필요한 경우, AuthInterceptor에서 해당 요청 url을 기억 -> 로그인 후 해당 요청으로 이동</li>
          <li>입력된 uid, pw 값을 파라미터로 하여 컨트롤러에 전달, 해당 사용자가 존재하는지 확인</li>
          <li>쿠키를 이용한 자동 로그인</li>
        </ul>
      <b><li>네이버로 로그인 하기(네이버 오픈 API)</li></b>
      <ul>
       <li>네이버 사용자 정보를 가져옴 -> 로그인 유지(DB 반영 X)</li>
      </ul>
  </ul>
  
  <b><li>CRUD 게시판</li></b>
  <ul>
    <ol>
      <b><li>기본 기능</li></b>
        <ul>
          <li>글 쓰기, 글 수정, 글 삭제, 글 보기, Pagination</li>
          <li>
            글 보기의 경우 Ajax를 이용해 페이지 이동없이 답글 달기 가능, 
            그 후 페이지 이동없이 게시글 정보(댓글 목록, 댓글수 등) reload
          </li>
          <li>Bootstrap Modal을 이용, 페이지 이동없이 댓글 관리 가능</li>
        </ul>
      <b><li>좋아요</li></b>
        <ul>
          <li>사용자별 좋아요 관리(시각적으로 표현)</li>
        </ul>
      <b><li>검색기능</li></b>
        <ul>
          <li>검색 조건 + 검색어 -> 조건 유지한 상태로 페이징 처리</li>
        </ul>
      <b><li>파일 첨부</li></b>
      <ul>
        <li>이미지, 일반 파일을 구분하여 처리</li>
        <li>Drop 영역에 파일을 올리면 해당 파일의 이름을 FormData 객체에 담아 컨트롤러에 요청 -> 실제 서버의 정해진 경로에 파일 저장, 화면에 목록으로 출력</li>
        <li>각 파일마다 표시된 'x' 클릭시, 위에서 실제 경로에 저장된 파일 삭제</li>
        <li>(게시글 수정 페이지에서는, deleteFile 배열에 하나씩 담은 후, 컨트롤러에 파라미터 값으로 넘겨 일괄 삭제)</li>
        <li>최종적으로 화면에 표시된 파일들의 이름을 files 배열에 담아 컨트롤러에 요청 -> DB에 데이터 저장</li>
        <li>
          게시글 삭제시, bno를 파라미터 값으로 컨트롤러에 요청
          -> 해당 bno를 가진 tbl_attach 레코드 삭제, 종속된 파일 일괄 삭제
        </li>
      </ul>
    </ol>
  </ul>
  
  <b><li>About</li></b>
  <ul>
    <ol>
      <b><li>관리자에게 메일 보내기(emailJS사용)</li></b>
      <ul>
          <li>사용자의 편의를 위한 간단한 메세지 보내기</li>
      </ul>
    </ol>
  </ul>
  
  <b><li>예외처리</li></b>
  <ul>
    <ol>
      <b><li>Java 클래스, HTTP 에러 코드별 예외처리(404,500,403,405,400 error 등)</li></b>
    </ol>
  </ul>
</ol>
