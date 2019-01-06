SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS tbl_attach;
DROP TABLE IF EXISTS tbl_like;
DROP TABLE IF EXISTS tbl_reply;
DROP TABLE IF EXISTS tbl_board;
DROP TABLE IF EXISTS tbl_user;




/* Create Tables */

CREATE TABLE tbl_attach
(
	fullName varchar(255) NOT NULL,
	bno int unsigned zerofill NOT NULL,
	regdate datetime,
	PRIMARY KEY (fullName)
);


CREATE TABLE tbl_board
(
	bno int unsigned zerofill NOT NULL AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	content text NOT NULL,
	writer varchar(30) NOT NULL,
	regdate datetime NOT NULL,
	viewcnt int unsigned,
	replycnt int unsigned,
	likecnt int unsigned,
	PRIMARY KEY (bno)
);


CREATE TABLE tbl_like
(
	lno int unsigned zerofill NOT NULL AUTO_INCREMENT,
	bno int unsigned zerofill NOT NULL,
	uid varchar(30) NOT NULL,
	likecnt int unsigned DEFAULT 0,
	PRIMARY KEY (lno)
);


CREATE TABLE tbl_reply
(
	rno int unsigned zerofill NOT NULL AUTO_INCREMENT,
	bno int unsigned zerofill NOT NULL,
	replywriter varchar(30) NOT NULL,
	replytext varchar(300) NOT NULL,
	regdate datetime,
	updatedate datetime,
	PRIMARY KEY (rno)
);


CREATE TABLE tbl_user
(
	uid varchar(30) NOT NULL,
	pw varchar(50) NOT NULL,
	name varchar(30) NOT NULL,
	gender varchar(5) NOT NULL,
	sessionkey varchar(255),
	sessionlimit varchar(255),
	thumbnail varchar(255),
	email varchar(100) NOT NULL,
	authkey varchar(255),
	authstatus tinyint,
	PRIMARY KEY (uid),
	UNIQUE (uid)
);



/* Create Foreign Keys */

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



