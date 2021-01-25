-- SYSTEM 계정에서 실행해서 새로운 계정 생성
-- CREATE USER FD IDENTIFIED BY FD;
-- 새로운 계정 접속
-- GRANT RESOURCE, CONNECT TO FD;

DROP TABLE POINT_CHARGING;
DROP TABLE FUNDING;
DROP TABLE BOARD;
DROP TABLE CARRYFUNDING_PROJECT;
DROP TABLE MEMBER;

DROP SEQUENCE SEQ_UNO;
DROP SEQUENCE SEQ_PROJECT_NO;
DROP SEQUENCE SEQ_BOARD_NO;
DROP SEQUENCE SEQ_FUNDING_NO;
DROP SEQUENCE SEQ_PAYMENT_NO;

COMMIT;

----------------------------------------------------------
--------------------- USER 관련 테이블 ---------------------
----------------------------------------------------------
CREATE TABLE MEMBER (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(100),
    ADDRESS VARCHAR2(150),
    USER_ENROLL_DATE DATE DEFAULT SYSDATE,
    USER_MODIFY_DATE DATE DEFAULT SYSDATE,
    USER_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(USER_STATUS IN('Y', 'N')),
    USER_ROLE VARCHAR2(20) DEFAULT 'ROLE_USER',
    USER_COIN NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_UNO;

COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원ID';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원PWD';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.USER_ENROLL_DATE IS '회원가입일';
COMMENT ON COLUMN MEMBER.USER_MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.USER_STATUS IS '회원상태(Y/N)';
COMMENT ON COLUMN MEMBER.USER_ROLE IS '회원타입';
COMMENT ON COLUMN MEMBER.USER_COIN IS '캐리머니';

INSERT INTO MEMBER VALUES(
    SEQ_UNO.NEXTVAL,'admin', '1234', '관리자', '010-1234-5678', 'admin@iei.or.kr', '서울시 강남구', SYSDATE, SYSDATE, DEFAULT, 'ROLE_ADMIN', DEFAULT
);

INSERT INTO MEMBER VALUES(
    SEQ_UNO.NEXTVAL, 'ismoon', '1234', '일반회원', '010-1111-2222', 'ismoon@iei.or.kr', '서울시 동작구', SYSDATE, SYSDATE, DEFAULT, DEFAULT, 100000
);

INSERT INTO MEMBER VALUES(
    SEQ_UNO.NEXTVAL, 'creator', '1234', '창작자', '010-3333-5555', 'creator@iei.or.kr', '서울시 송파구', SYSDATE, SYSDATE, DEFAULT, 'ROLE_CREATOR', DEFAULT
);

--------------------------------------------------------------------
---------------------- project test 관련 테이블 ----------------------
--------------------------------------------------------------------
CREATE TABLE CARRYFUNDING_PROJECT(
    PROJECT_NO NUMBER PRIMARY KEY,
    PROJECT_TITLE VARCHAR2(200) NOT NULL,
    PROJECT_COMPANY VARCHAR2(100),
    TARGET_AMOUNT NUMBER NOT NULL,
    REACH_AMOUNT NUMBER NOT NULL,
    PROJECT_ENROLL_DATE DATE DEFAULT SYSDATE,
    PROJECT_MODIFY_DATE DATE DEFAULT SYSDATE,
    PROJECT_END_DATE DATE NOT NULL,
    IMG_ORIGINAL_NAME VARCHAR2(100),
    IMG_RENAMED_NAME VARCHAR2(100),
    PROJECT_CONTENT VARCHAR2(4000),
    PROJECT_CHECK VARCHAR2(1) DEFAULT 'N' CHECK (PROJECT_CHECK IN('Y', 'N')),
    PROJECT_COUNT NUMBER DEFAULT 0,
    PROJECT_LIKE NUMBER DEFAULT 0,
    PROJECT_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (PROJECT_STATUS IN('Y', 'N')),
    CREATOR_NO NUMBER NOT NULL,
    CONSTRAINT FK_PROJECT_WRITER FOREIGN KEY(CREATOR_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_PROJECT_NO;

COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_NO" IS '프로젝트번호';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_TITLE" IS '프로젝트제목';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_COMPANY" IS '업체명';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."TARGET_AMOUNT" IS '목표금액';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."REACH_AMOUNT" IS '현재도달금액';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_ENROLL_DATE" IS '프로젝트시작날짜';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_MODIFY_DATE" IS '프로젝트정보수정날짜';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_END_DATE" IS '프로젝트종료날짜';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."IMG_ORIGINAL_NAME" IS '이미지원래이름';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."IMG_RENAMED_NAME" IS '이미지변경이름';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_CONTENT" IS '프로젝트내용';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_CHECK" IS '프로젝트심사상태';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_COUNT" IS '프로젝트조회수';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_LIKE" IS '좋아요등록수';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."PROJECT_STATUS" IS '프로젝트상태';
COMMENT ON COLUMN CARRYFUNDING_PROJECT."CREATOR_NO" IS '창작자번호';

-- 프로젝트 게시판 DB의 경우 WEB상에서 직접 생성할 것.

--------------------------------------------------------------------
------------------------- Board 관련 테이블 --------------------------
--------------------------------------------------------------------
CREATE TABLE BOARD (   
"BOARD_NO" NUMBER,
"BOARD_WRITER_NO" NUMBER, 
"BOARD_TITLE" VARCHAR2(50), 
"BOARD_CONTENT" VARCHAR2(2000), 
"BOARD_ORIGINAL_FILENAME" VARCHAR2(100), 
"BOARD_RENAMED_FILENAME" VARCHAR2(100), 
"BOARD_READCOUNT" NUMBER DEFAULT 0, 
"STATUS" VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
"BOARD_CREATE_DATE" DATE DEFAULT SYSDATE, 
"BOARD_MODIFY_DATE" DATE DEFAULT SYSDATE,
CONSTRAINT PK_BOARD_NO PRIMARY KEY(BOARD_NO),
CONSTRAINT FK_BOARD_WRITER FOREIGN KEY(BOARD_WRITER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_BOARD_NO;

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글번호';
COMMENT ON COLUMN "BOARD"."BOARD_WRITER_NO" IS '게시글작성자';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글제목';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글내용';
COMMENT ON COLUMN "BOARD"."BOARD_ORIGINAL_FILENAME" IS '첨부파일원래이름';
COMMENT ON COLUMN "BOARD"."BOARD_RENAMED_FILENAME" IS '첨부파일변경이름';
COMMENT ON COLUMN "BOARD"."BOARD_READCOUNT" IS '조회수';
COMMENT ON COLUMN "BOARD"."STATUS" IS '상태값(Y/N)';
COMMENT ON COLUMN "BOARD"."BOARD_CREATE_DATE" IS '게시글올린날짜';
COMMENT ON COLUMN "BOARD"."BOARD_MODIFY_DATE" IS '게시글수정날짜';

INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, 2, '게시글 1',  '우하하하하...', '원본파일명.txt', '변경된파일명.txt', DEFAULT, 'Y', SYSDATE, SYSDATE);

--------------------------------------------------------------------
------------------------- FUNDING 관련 테이블 --------------------------
--------------------------------------------------------------------
CREATE TABLE FUNDING(
    FUNDING_NO NUMBER PRIMARY KEY,
    FUNDING_PRICE NUMBER,
    FUNDING_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(FUNDING_STATUS IN('Y', 'N')),
    FUNDING_USER NUMBER NOT NULL,
    FUNDING_PROJECT NUMBER NOT NULL,
    CONSTRAINT FK_FUNDING_USER FOREIGN KEY(FUNDING_USER) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_FUNDING_PROJECT FOREIGN KEY(FUNDING_PROJECT) REFERENCES CARRYFUNDING_PROJECT(PROJECT_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_FUNDING_NO;

COMMENT ON COLUMN FUNDING."FUNDING_NO" IS '후원번호';
COMMENT ON COLUMN FUNDING."FUNDING_PRICE" IS '후원가격';
COMMENT ON COLUMN FUNDING."FUNDING_STATUS" IS '후원상태';
COMMENT ON COLUMN FUNDING."FUNDING_USER" IS '후원회원번호';
COMMENT ON COLUMN FUNDING."FUNDING_PROJECT" IS '후원프로젝트번호';

--------------------------------------------------------------------
------------------------- POINT_CHARGING 관련 테이블 -----------------
--------------------------------------------------------------------
CREATE TABLE POINT_CHARGING (
    PAYMENT_NO NUMBER PRIMARY KEY,
    PAYMENT_AMOUNT NUMBER NOT NULL,
    PAYMENT_BANK_NAME VARCHAR2(30) NOT NULL,
    BANK_ACCOUNT_NUMBER NUMBER NOT NULL,
    PAYMENT_DATE DATE DEFAULT SYSDATE,
    CANCLE_PAYMENT_DATE DATE DEFAULT SYSDATE,
    PAYMENT_PROGRESS VARCHAR2(1) DEFAULT 'Y' CHECK (PAYMENT_PROGRESS IN('Y', 'N')),
    PAYER_NO NUMBER NOT NULL,
    CONSTRAINT FK_POINT_PAYER FOREIGN KEY(PAYER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_PAYMENT_NO;

COMMENT ON COLUMN POINT_CHARGING.PAYMENT_NO IS '결제번호';
COMMENT ON COLUMN POINT_CHARGING.PAYMENT_AMOUNT IS '결제금액';
COMMENT ON COLUMN POINT_CHARGING.PAYMENT_BANK_NAME IS '결제은행명';
COMMENT ON COLUMN POINT_CHARGING.BANK_ACCOUNT_NUMBER IS '계좌번호';
COMMENT ON COLUMN POINT_CHARGING.PAYMENT_DATE IS '결제날짜';
COMMENT ON COLUMN POINT_CHARGING.CANCLE_PAYMENT_DATE IS '결제취소날짜';
COMMENT ON COLUMN POINT_CHARGING.PAYMENT_PROGRESS IS '결제진행상태';
COMMENT ON COLUMN POINT_CHARGING.PAYER_NO IS '결제자번호';


-- 마지막으로 COMMIT 꼭 하기! --

COMMIT;











