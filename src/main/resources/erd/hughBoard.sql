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
	bno int(11) unsigned zerofill NOT NULL,
	regdate datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() NOT NULL,
	PRIMARY KEY (fullName)
);


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


CREATE TABLE tbl_like
(
	lno int(11) unsigned NOT NULL AUTO_INCREMENT,
	bno int(11) unsigned zerofill NOT NULL,
	uid varchar(30) NOT NULL,
	likecnt int unsigned DEFAULT 0,
	PRIMARY KEY (lno)
);


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



