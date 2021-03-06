-- 테이블 삭제
DROP TABLE ITEMIMAGE CASCADE CONSTRAINTS;
PROMPT DROPPING ITEMIMAGE...
DROP TABLE NOTICE CASCADE CONSTRAINTS;
PROMPT DROPPING NOTICE...
DROP TABLE QNA CASCADE CONSTRAINTS;
PROMPT DROPPING QNA...
DROP TABLE REVIEW CASCADE CONSTRAINTS;
PROMPT DROPPING REVIEW...
DROP TABLE STATISTIC CASCADE CONSTRAINTS;
PROMPT DROPPING STATISTIC...
DROP TABLE WISHLIST CASCADE CONSTRAINTS;
PROMPT DROPPING WISHLIST...
DROP TABLE CARTLIST CASCADE CONSTRAINTS;
PROMPT DROPPING CARTLIST...
DROP TABLE ORDERLIST CASCADE CONSTRAINTS;
PROMPT DROPPING ORDERLIST...
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
PROMPT DROPPING PAYMENT...
DROP TABLE IMAGE CASCADE CONSTRAINTS;
PROMPT DROPPING IMAGE...
DROP TABLE ITEM CASCADE CONSTRAINTS;
PROMPT DROPPING ITEM...
DROP TABLE KEYWORD CASCADE CONSTRAINTS;
PROMPT DROPPING KEYWORD...
DROP TABLE DELIVERY CASCADE CONSTRAINTS;
PROMPT DROPPING DELIVERY...
DROP TABLE MEMBER CASCADE CONSTRAINTS;
PROMPT DROPPING MEMBER...
DROP TABLE RANK CASCADE CONSTRAINTS;
PROMPT DROPPING RANK...

-- 테이블 추가
PROMPT CREATING RANK...
CREATE TABLE RANK
(
	RANK_NO	NVARCHAR2(10) CONSTRAINT PK_RANK PRIMARY KEY,
	RANK_NAME NVARCHAR2(60),
	RANK_POINTRAT NUMBER,
	RANK_POINTCAP NUMBER,
	RANK_POINTMIN NUMBER,
	RANK_POINTMAX NUMBER
);

COMMENT ON COLUMN RANK.RANK_NO IS '등급번호(R1~R5)';
COMMENT ON COLUMN RANK.RANK_NAME IS '등급이름(씨앗,새싹,가지,열매,나무)';
COMMENT ON COLUMN RANK.RANK_POINTRAT IS '등급적립율(1%~5%)';
COMMENT ON COLUMN RANK.RANK_POINTCAP IS '포인트사용한도(2000~10000)';
COMMENT ON COLUMN RANK.RANK_POINTMIN IS '등급업 최소 구매금액';
COMMENT ON COLUMN RANK.RANK_POINTMAX IS '등급업 최대 구매 금액';

PROMPT CREATING MEMBER...
CREATE TABLE MEMBER
(
	MEMBER_NO NVARCHAR2(10) CONSTRAINT PK_MEMBER PRIMARY KEY,
	MEMBER_ADMIN NVARCHAR2(2) DEFAULT 'N' NOT NULL CONSTRAINT CK_MEMBER_ADMIN CHECK(MEMBER_ADMIN IN('Y', 'N')),
	MEMBER_ID NVARCHAR2(30) NOT NULL CONSTRAINT UQ_MEMBER_ID UNIQUE,
	MEMBER_PWD NVARCHAR2(30),
	MEMBER_NAME	NVARCHAR2(30) NOT NULL,
	MEMBER_PHONE1 NVARCHAR2(10),
	MEMBER_PHONE2 NVARCHAR2(10),
	MEMBER_PHONE3 NVARCHAR2(10),
	MEMBER_EMAIL1 NVARCHAR2(30),
	MEMBER_EMAIL2 NVARCHAR2(30),
	MEMBER_POSTCODE	NVARCHAR2(30),
	MEMBER_ADDRESS1	NVARCHAR2(2000),
	MEMBER_ADDRESS2	NVARCHAR2(2000),
	MEMBER_JOINDATE	DATE DEFAULT SYSDATE NOT NULL,
	MEMBER_STATUS NVARCHAR2(2) DEFAULT 'N' NOT NULL CONSTRAINT CK_MEMBER_STATUS CHECK(MEMBER_STATUS IN('Y', 'N')),
	MEMBER_EXIT	NVARCHAR2(500),
	MEMBER_POINT NUMBER,
	MEMBER_RANK	NVARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN MEMBER.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN MEMBER.MEMBER_ADMIN IS '관리자:Y, 일반회원:N';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '아이디,유니크';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '이름';
COMMENT ON COLUMN MEMBER.MEMBER_PHONE1 IS '연락처1';
COMMENT ON COLUMN MEMBER.MEMBER_PHONE2 IS '연락처2';
COMMENT ON COLUMN MEMBER.MEMBER_PHONE3 IS '연락처3';
COMMENT ON COLUMN MEMBER.MEMBER_EMAIL1 IS '이메일1';
COMMENT ON COLUMN MEMBER.MEMBER_EMAIL2 IS '이메일2';
COMMENT ON COLUMN MEMBER.MEMBER_POSTCODE IS '우편번호';
COMMENT ON COLUMN MEMBER.MEMBER_ADDRESS1 IS '주소';
COMMENT ON COLUMN MEMBER.MEMBER_ADDRESS2 IS '상세주소';
COMMENT ON COLUMN MEMBER.MEMBER_JOINDATE IS '회원가입날짜';
COMMENT ON COLUMN MEMBER.MEMBER_STATUS IS '탈퇴:Y 기본: N, 카카오:K 회원상태';
COMMENT ON COLUMN MEMBER.MEMBER_EXIT IS '탈퇴사유';
COMMENT ON COLUMN MEMBER.MEMBER_POINT IS '포인트';
COMMENT ON COLUMN MEMBER.MEMBER_RANK IS '등급번호(R1~R5)';

ALTER TABLE MEMBER ADD CONSTRAINT FK_RANK_TO_MEMBER FOREIGN KEY ( MEMBER_RANK )
REFERENCES RANK ( RANK_NO );


PROMPT CREATING DELIVERY...
CREATE TABLE DELIVERY
(
	DELIVERY_CODE NVARCHAR2(10) DEFAULT 'D1' CONSTRAINT PK_DELIVERY PRIMARY KEY,
	DELIVERY_STATUS	NVARCHAR2(100)
);

COMMENT ON COLUMN DELIVERY.DELIVERY_CODE IS 'D1 : 배송전, D2 : 배송중, D3 : 배송완료(배송코드)';
COMMENT ON COLUMN DELIVERY.DELIVERY_STATUS IS '배송전, 배송중, 배송완료(배송상태)';

PROMPT CREATING KEYWORD...
CREATE TABLE KEYWORD (
	KEYWORD_NO NVARCHAR2(10) CONSTRAINT PK_KEYWORD PRIMARY KEY,
	KEYWORD_NAME NVARCHAR2(20)
);

COMMENT ON COLUMN KEYWORD.KEYWORD_NO IS '키워드번호(K1~)';
COMMENT ON COLUMN KEYWORD.KEYWORD_NAME IS '중복 선택(산소뿜뿜, 반려동물 친화)';


PROMPT CREATING ITEM...
CREATE TABLE ITEM 
(	
ITEM_NO NVARCHAR2(10) CONSTRAINT PK_ITEM PRIMARY KEY, 
ITEM_NAME NVARCHAR2(50) NOT NULL, 
ITEM_CATEGORY NVARCHAR2(2000) NOT NULL, 
KEYWORD_NO NVARCHAR2(20) NOT NULL, 
ITEM_PRICE NUMBER NOT NULL, 
ITEM_DISCOUNT NUMBER NOT NULL, 
ITEM_RATE NUMBER, 
ITEM_STOCK NUMBER NOT NULL, 
ITEM_DISPLAY NVARCHAR2(2) DEFAULT 'N' NOT NULL CONSTRAINT CK_ITEM_DISPLAY CHECK(ITEM_DISPLAY IN('Y', 'N')), 
ITEM_INFO NVARCHAR2(2000) NOT NULL, 
ITEM_CDATE DATE DEFAULT SYSDATE NOT NULL, 
ITEM_UDATE DATE DEFAULT SYSDATE NOT NULL, 
ITEM_SCOUNT NUMBER, 
ITEM_MAX NUMBER NOT NULL, 
ITEM_SALE NVARCHAR2(2) DEFAULT 'Y' CONSTRAINT CK_ITEM_SALE CHECK(ITEM_SALE IN('Y', 'N'))
);

COMMENT ON COLUMN ITEM.ITEM_NO IS '상품번호(I1~)';
COMMENT ON COLUMN ITEM.ITEM_NAME IS '상품명';
COMMENT ON COLUMN ITEM.ITEM_CATEGORY IS '상품카테고리';
COMMENT ON COLUMN ITEM.KEYWORD_NO IS '키워드번호(K1~)';
COMMENT ON COLUMN ITEM.ITEM_PRICE IS '상품가격';
COMMENT ON COLUMN ITEM.ITEM_DISCOUNT IS '할인값';
COMMENT ON COLUMN ITEM.ITEM_RATE IS '평점';
COMMENT ON COLUMN ITEM.ITEM_STOCK IS '상품재고';
COMMENT ON COLUMN ITEM.ITEM_DISPLAY IS '전시 : Y, 비전시 : N';
COMMENT ON COLUMN ITEM.ITEM_INFO IS '상품설명텍스트';
COMMENT ON COLUMN ITEM.ITEM_CDATE IS '상품등록일';
COMMENT ON COLUMN ITEM.ITEM_UDATE IS '최종수정일';
COMMENT ON COLUMN ITEM.ITEM_SCOUNT IS '누적판매량';
COMMENT ON COLUMN ITEM.ITEM_MAX IS '최대구매수량';
COMMENT ON COLUMN ITEM.ITEM_SALE IS '판매중 : Y, 판매중지 : N';

ALTER TABLE item ADD CONSTRAINT FK_keyword_TO_item FOREIGN KEY ( keyword_no )
REFERENCES keyword ( keyword_no );


PROMPT CREATING IMAGE...
CREATE TABLE IMAGE 
(
	IMAGE_NO NVARCHAR2(14) CONSTRAINT PK_IMAGE PRIMARY KEY,
	IMAGE_PATH NVARCHAR2(2000),
	IMAGE_NAME NVARCHAR2(2000)
);

COMMENT ON COLUMN IMAGE.IMAGE_NO IS '이미지번호(IMG1~)';
COMMENT ON COLUMN IMAGE.IMAGE_PATH IS '이미지 경로';
COMMENT ON COLUMN IMAGE.IMAGE_NAME IS '이미지 명칭';


PROMPT CREATING PAYMENT...
CREATE TABLE PAYMENT 
(
	PAYMENT_CODE NVARCHAR2(10) DEFAULT 'P1' CONSTRAINT PK_PAYMENT PRIMARY KEY,
	PAYMENT_STATUS NVARCHAR2(100)
);

COMMENT ON COLUMN PAYMENT.PAYMENT_CODE IS 'P1 : 입금 전, P2 : 입금 후(입금코드)';
COMMENT ON COLUMN PAYMENT.PAYMENT_STATUS IS '입금 전, 입금 후(입금상태)';


PROMPT CREATING ORDERLIST...
CREATE TABLE ORDERLIST 
(
	ORDER_NO NVARCHAR2(10),
	ITEM_NO	NVARCHAR2(10),
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
	ORDER_COUNT	NUMBER NOT NULL,
	ORDER_USEPOINT	NUMBER NOT NULL,
	ORDER_NAME	NVARCHAR2(100) NOT NULL,
	ORDER_PHONE1 NVARCHAR2(10) NOT NULL,
	ORDER_PHONE2 NVARCHAR2(10) NOT NULL,
	ORDER_PHONE3 NVARCHAR2(10) NOT NULL,
	ORDER_POSTCODE NVARCHAR2(30) NOT NULL,
	ORDER_ADDRESS1 NVARCHAR2(2000) NOT NULL,
	ORDER_ADDRESS2 NVARCHAR2(2000) NOT NULL,
	ORDER_REQUEST NVARCHAR2(2000),
	ORDER_DCOST	NUMBER NOT NULL,
	ORDER_CANCELREQUEST	NVARCHAR2(2) DEFAULT 'N' CONSTRAINT CK_ORDER_CANCELREQUEST CHECK(ORDER_CANCELREQUEST IN('Y', 'N')),
	ORDER_CANCELYN NVARCHAR2(2) DEFAULT 'N' CONSTRAINT CK_ORDER_CANCELYN CHECK(ORDER_CANCELYN IN('Y', 'N')),
	DELIVERY_CODE NVARCHAR2(10) NOT NULL,
	PAYMENT_CODE NVARCHAR2(10) DEFAULT 'P1' NOT NULL
);

ALTER TABLE ORDERLIST ADD CONSTRAINT PK_ORDERLIST PRIMARY KEY (
	ORDER_NO,
	ITEM_NO
);

ALTER TABLE ORDERLIST ADD CONSTRAINT FK_ITEM_TO_ORDERLIST FOREIGN KEY ( ITEM_NO )
REFERENCES ITEM ( ITEM_NO );
ALTER TABLE ORDERLIST ADD CONSTRAINT FK_MEMBER_TO_ORDERLIST FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER (	MEMBER_NO );
ALTER TABLE ORDERLIST ADD CONSTRAINT FK_DELIVERY_TO_ORDERLIST FOREIGN KEY ( DELIVERY_CODE )
REFERENCES DELIVERY ( DELIVERY_CODE );
ALTER TABLE ORDERLIST ADD CONSTRAINT FK_PAYMENT_TO_ORDERLIST FOREIGN KEY ( PAYMENT_CODE )
REFERENCES PAYMENT ( PAYMENT_CODE );


COMMENT ON COLUMN ORDERLIST.ORDER_NO IS '주문번호(O1~ )';
COMMENT ON COLUMN ORDERLIST.ITEM_NO IS '상품번호(I1~)';
COMMENT ON COLUMN ORDERLIST.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN ORDERLIST.ORDER_DATE IS '주문일시';
COMMENT ON COLUMN ORDERLIST.ORDER_COUNT IS '주문수량';
COMMENT ON COLUMN ORDERLIST.ORDER_USEPOINT IS '사용포인트';
COMMENT ON COLUMN ORDERLIST.ORDER_NAME IS '수령자이름';
COMMENT ON COLUMN ORDERLIST.ORDER_PHONE1 IS '수령자전화번호1';
COMMENT ON COLUMN ORDERLIST.ORDER_PHONE2 IS '수령자전화번호2';
COMMENT ON COLUMN ORDERLIST.ORDER_PHONE3 IS '수령자전화번호3';
COMMENT ON COLUMN ORDERLIST.ORDER_POSTCODE IS '수령자우편번호';
COMMENT ON COLUMN ORDERLIST.ORDER_ADDRESS1 IS '수령자주소';
COMMENT ON COLUMN ORDERLIST.ORDER_ADDRESS2 IS '수령자상세주소';
COMMENT ON COLUMN ORDERLIST.ORDER_REQUEST IS '배송시요청사항';
COMMENT ON COLUMN ORDERLIST.ORDER_DCOST IS '배송비';
COMMENT ON COLUMN ORDERLIST.ORDER_CANCELREQUEST IS '기본: N , 취소 : Y';
COMMENT ON COLUMN ORDERLIST.ORDER_CANCELYN IS '기본: N , 승인 : Y (주문 삭제 효과)';
COMMENT ON COLUMN ORDERLIST.DELIVERY_CODE IS 'D1 : 배송전, D2 : 배송중, D3 : 배송완료';
COMMENT ON COLUMN ORDERLIST.PAYMENT_CODE IS 'P1 : 입금 전, P2 : 입금 후';


PROMPT CREATING CARTLIST...
CREATE TABLE CARTLIST 
(
	CARTLIST_NO	NVARCHAR2(10) CONSTRAINT PK_CARTLIST PRIMARY KEY,
	ITEM_NO NVARCHAR2(10) NOT NULL,
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	CARTLIST_COUNT NUMBER
);

ALTER TABLE CARTLIST ADD CONSTRAINT FK_ITEM_TO_CARTLIST FOREIGN KEY ( ITEM_NO )
REFERENCES ITEM ( ITEM_NO );

ALTER TABLE CARTLIST ADD CONSTRAINT FK_MEMBER_TO_CARTLIST FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER ( MEMBER_NO );

COMMENT ON COLUMN CARTLIST.CARTLIST_NO IS '장바구니번호(C1~)';
COMMENT ON COLUMN CARTLIST.ITEM_NO IS '상품번호';
COMMENT ON COLUMN CARTLIST.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN CARTLIST.CARTLIST_COUNT IS '수량';


PROMPT CREATING CARTLIST...
CREATE TABLE WISHLIST 
(
	WISHLIST_NO	NVARCHAR2(10) CONSTRAINT PK_WISHLIST PRIMARY KEY,
	ITEM_NO	NVARCHAR2(10) NOT NULL,
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	WISHLIST_MEMO NVARCHAR2(500)
);

ALTER TABLE WISHLIST ADD CONSTRAINT FK_ITEM_TO_WISHLIST FOREIGN KEY ( ITEM_NO )
REFERENCES ITEM ( ITEM_NO );
ALTER TABLE WISHLIST ADD CONSTRAINT FK_MEMBER_TO_WISHLIST FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER ( MEMBER_NO );

COMMENT ON COLUMN WISHLIST.WISHLIST_NO IS '위시리스트번호(W1~)';
COMMENT ON COLUMN WISHLIST.ITEM_NO IS '상품번호';
COMMENT ON COLUMN WISHLIST.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN WISHLIST.WISHLIST_MEMO IS '메모';


PROMPT CREATING STATISTIC...
CREATE TABLE STATISTIC 
(
	STATISTIC_NO NVARCHAR2(14) CONSTRAINT PK_STATISTIC PRIMARY KEY,
	STATISTIC_VISITCOUNT NUMBER,
	STATISTIC_TODAYJOIN NUMBER,
	STATISTIC_CANCELCOUNT NUMBER,
	STATISTIC_MEMBER NUMBER,
	STATISTIC_DASK NUMBER,
	STATISTIC_IASK NUMBER,
	STATISTIC_CASK NUMBER,
	STATISTIC_SALES NUMBER,
	STATISTIC_DBEFORE	NUMBER,
	STATISTIC_NEWORDER NUMBER,
	STATISTIC_CDATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN STATISTIC.STATISTIC_NO IS '일일통계(sta1-)';
COMMENT ON COLUMN STATISTIC.STATISTIC_VISITCOUNT IS '방문자수';
COMMENT ON COLUMN STATISTIC.STATISTIC_TODAYJOIN IS '금일가입';
COMMENT ON COLUMN STATISTIC.STATISTIC_CANCELCOUNT IS '취소요청';
COMMENT ON COLUMN STATISTIC.STATISTIC_MEMBER IS '전체회원';
COMMENT ON COLUMN STATISTIC.STATISTIC_DASK IS '배송문의';
COMMENT ON COLUMN STATISTIC.STATISTIC_IASK IS '상품문의';
COMMENT ON COLUMN STATISTIC.STATISTIC_CASK IS '취소문의';
COMMENT ON COLUMN STATISTIC.STATISTIC_SALES IS '금일매출';
COMMENT ON COLUMN STATISTIC.STATISTIC_DBEFORE IS '배송대기';
COMMENT ON COLUMN STATISTIC.STATISTIC_NEWORDER IS '신규주문';
COMMENT ON COLUMN STATISTIC.STATISTIC_CDATE IS '등록일';


PROMPT CREATING REVIEW...
CREATE TABLE REVIEW 
(
	REVIEW_NO NVARCHAR2(10) CONSTRAINT PK_REVIEW PRIMARY KEY,
	ORDER_NO NVARCHAR2(10) NOT NULL,
	ITEM_NO	NVARCHAR2(10) NOT NULL,
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	REVIEW_CDATE DATE DEFAULT SYSDATE,
	REVIEW_RATE	NUMBER,
	REVIEW_CONTENT NVARCHAR2(2000),
	REVIEW_UDATE DATE DEFAULT SYSDATE,
	IMAGE_NO NVARCHAR2(14)
);

ALTER TABLE REVIEW ADD CONSTRAINT FK_ORDERLIST_TO_REVIEW FOREIGN KEY ( ORDER_NO, ITEM_NO )
REFERENCES ORDERLIST ( ORDER_NO, ITEM_NO );
ALTER TABLE REVIEW ADD CONSTRAINT FK_MEMBER_TO_REVIEW FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER ( MEMBER_NO );
ALTER TABLE REVIEW ADD CONSTRAINT FK_IMAGE_TO_REVIEW FOREIGN KEY ( IMAGE_NO )
REFERENCES IMAGE ( IMAGE_NO );

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '리뷰번호(R1~ )';
COMMENT ON COLUMN REVIEW.ORDER_NO IS '주문번호(O1~ )';
COMMENT ON COLUMN REVIEW.ITEM_NO IS '상품번호(I1~ )';
COMMENT ON COLUMN REVIEW.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN REVIEW.REVIEW_CDATE IS '리뷰등록일';
COMMENT ON COLUMN REVIEW.REVIEW_RATE IS '평점';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '리뷰내용';
COMMENT ON COLUMN REVIEW.REVIEW_UDATE IS '리뷰수정일';
COMMENT ON COLUMN REVIEW.IMAGE_NO IS '이미지번호(img1~) 고객용';


PROMPT CREATING QNA...
CREATE TABLE QNA 
(
	QNA_NO NVARCHAR2(10) CONSTRAINT PK_QNA PRIMARY KEY,
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	QNA_TITLE NVARCHAR2(100) NOT NULL,
	QNA_CDATE DATE,
	QNA_CONTENT	NVARCHAR2(2000),
	QNA_ANSWER NVARCHAR2(2000),
	QNA_CATEGORY NVARCHAR2(20) NOT NULL,
    QNA_PASSWORD NVARCHAR2(20) NOT NULL,
	QNA_YN NVARCHAR2(2) DEFAULT 'N' CONSTRAINT CK_QNA_YN CHECK(QNA_YN IN('Y', 'N')),
	IMAGE_NO NVARCHAR2(14)
);

ALTER TABLE QNA ADD CONSTRAINT FK_MEMBER_TO_QNA FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER ( MEMBER_NO );
ALTER TABLE QNA ADD CONSTRAINT FK_IMAGE_TO_QNA FOREIGN KEY ( IMAGE_NO )
REFERENCES IMAGE ( IMAGE_NO );

COMMENT ON COLUMN QNA.QNA_NO IS '글번호(Q1~)';
COMMENT ON COLUMN QNA.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN QNA.QNA_TITLE IS '질문제목';
COMMENT ON COLUMN QNA.QNA_CDATE IS '게시일';
COMMENT ON COLUMN QNA.QNA_CONTENT IS '내용';
COMMENT ON COLUMN QNA.QNA_ANSWER IS '답변';
COMMENT ON COLUMN QNA.QNA_CATEGORY IS '분류';
COMMENT ON COLUMN QNA.QNA_YN IS '답변 전 : N, 답변 : Y';
COMMENT ON COLUMN QNA.IMAGE_NO IS '이미지번호(img1~)';
COMMENT ON COLUMN QNA.QNA_PASSWORD IS '비밀번호';


PROMPT CREATING NOTICE...
CREATE TABLE NOTICE (
	NOTICE_NO NVARCHAR2(10) CONSTRAINT PK_NOTICE PRIMARY KEY,
	MEMBER_NO NVARCHAR2(10) NOT NULL,
	NOTICE_TITLE NVARCHAR2(100) NOT NULL,
	NOTICE_CDATE DATE,
	NOTICE_CONTENT NVARCHAR2(2000),
	IMAGE_NO NVARCHAR2(14)
);

ALTER TABLE NOTICE ADD CONSTRAINT FK_MEMBER_TO_NOTICE FOREIGN KEY ( MEMBER_NO )
REFERENCES MEMBER ( MEMBER_NO );
ALTER TABLE NOTICE ADD CONSTRAINT FK_IMAGE_TO_NOTICE FOREIGN KEY ( IMAGE_NO )
REFERENCES IMAGE ( IMAGE_NO );

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지글번호(N1~)';
COMMENT ON COLUMN NOTICE.MEMBER_NO IS '회원번호(M1~)';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '제목';
COMMENT ON COLUMN NOTICE.NOTICE_CDATE IS '게시일';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '내용';
COMMENT ON COLUMN NOTICE.IMAGE_NO IS '이미지번호(img1~)';


PROMPT CREATING ITEMIMAGE...
CREATE TABLE ITEMIMAGE (
    ITEMIMAGE_NO NVARCHAR2(14) CONSTRAINT PK_ITEMIMAGE PRIMARY KEY,
    ITEM_NO   NVARCHAR2(10),
    IMAGE_NO NVARCHAR2(14),
    ITEMIMAGE_CATEGORY NUMBER
);

ALTER TABLE ITEMIMAGE ADD CONSTRAINT FK_ITEM_TO_ITEMIMAGE FOREIGN KEY ( ITEM_NO )
REFERENCES ITEM ( ITEM_NO );
ALTER TABLE ITEMIMAGE ADD CONSTRAINT FK_IMAGE_TO_ITEMIMAGE FOREIGN KEY ( IMAGE_NO )
REFERENCES IMAGE ( IMAGE_NO );

COMMENT ON COLUMN ITEMIMAGE.ITEMIMAGE_NO IS '상품이미지번호(Ii1~)';
COMMENT ON COLUMN ITEMIMAGE.ITEM_NO IS '상품번호(I1~)';
COMMENT ON COLUMN ITEMIMAGE.IMAGE_NO IS '이미지번호(img1~)';
COMMENT ON COLUMN ITEMIMAGE.ITEMIMAGE_CATEGORY IS '메인이미지:1,서브이미지:2';

--------------------------------------------------------
-- DDL for Sequence IMAGE_SEQ
DROP SEQUENCE IMAGE_SEQ;
DROP SEQUENCE ITEMIMAGE_SEQ;
DROP SEQUENCE ITEM_SEQ;

CREATE SEQUENCE  IMAGE_SEQ MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 
START WITH 24 
CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE ITEMIMAGE_SEQ MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 
START WITH 25 
CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE ITEM_SEQ MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 
START WITH 23 
CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------

-- 데이터 추가
REM INSERTING into ONECHO.RANK
SET DEFINE OFF;
Insert into ONECHO.RANK (RANK_NO,RANK_NAME,RANK_POINTRAT,RANK_POINTCAP,RANK_POINTMIN,RANK_POINTMAX) values ('R1','씨앗',1,2000,0,50000);
Insert into ONECHO.RANK (RANK_NO,RANK_NAME,RANK_POINTRAT,RANK_POINTCAP,RANK_POINTMIN,RANK_POINTMAX) values ('R2','새싹',2,4000,50001,200000);
Insert into ONECHO.RANK (RANK_NO,RANK_NAME,RANK_POINTRAT,RANK_POINTCAP,RANK_POINTMIN,RANK_POINTMAX) values ('R3','가지',3,6000,200001,500000);
Insert into ONECHO.RANK (RANK_NO,RANK_NAME,RANK_POINTRAT,RANK_POINTCAP,RANK_POINTMIN,RANK_POINTMAX) values ('R4','열매',4,8000,500001,1000000);
Insert into ONECHO.RANK (RANK_NO,RANK_NAME,RANK_POINTRAT,RANK_POINTCAP,RANK_POINTMIN,RANK_POINTMAX) values ('R5','나무',5,10000,1000001,999999999);

REM INSERTING into ONECHO.MEMBER
SET DEFINE OFF;
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK) 
values ('M1','Y','admin1','admin1','정유진','010','1234','5678','admin1','@oncho.com','12345','2','2',to_date('20/06/02','RR/MM/DD'),'N',null,2000,'R2');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK) 
values ('M2','Y','admin2','admin2','강광산','010','1234','5678','admin2','@oncho.com','12345','2','2',to_date('20/06/02','RR/MM/DD'),'N',null,4000,'R2');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK) 
values ('M3','Y','admin3','admin3','이아라','010','1234','5678','admin3','@oncho.com','12345','3','3',to_date('20/06/02','RR/MM/DD'),'N',null,8000,'R3');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK)
values ('M4','Y','admin4','admin4','김경남','010','1234','5678','admin4','@oncho.com','12345','4','4',to_date('20/06/02','RR/MM/DD'),'N',null,12000,'R4');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK)
values ('M5','Y','admin5','admin5','이수한','010','1234','5678','admin5','@oncho.com','12345','5','5',to_date('20/06/02','RR/MM/DD'),'N',null,16000,'R5');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK)
values ('M6','N','user1','user1','홍길동','010','2828','8282','user1','@naver.com','06234','서울특별시 강남구 테헤란로14길 6 (역삼동)','2층',to_date('20/06/02','RR/MM/DD'),'N',null,2000,'R1');
Insert into ONECHO.MEMBER (MEMBER_NO,MEMBER_ADMIN,MEMBER_ID,MEMBER_PWD,MEMBER_NAME,MEMBER_PHONE1,MEMBER_PHONE2,MEMBER_PHONE3,MEMBER_EMAIL1,MEMBER_EMAIL2,MEMBER_POSTCODE,MEMBER_ADDRESS1,MEMBER_ADDRESS2,MEMBER_JOINDATE,MEMBER_STATUS,MEMBER_EXIT,MEMBER_POINT,MEMBER_RANK)
values ('M7','N','user2','user2','홍길남','010','7568','5678','user2','@gmail.com','06234','서울특별시 강남구 테헤란로14길 6 (역삼동)','3층',to_date('20/06/03','RR/MM/DD'),'N',null,9000,'R2');

REM INSERTING into ONECHO.KEYWORD
SET DEFINE OFF;
Insert into ONECHO.KEYWORD (KEYWORD_NO,KEYWORD_NAME) values ('K1','산소뿜뿜');
Insert into ONECHO.KEYWORD (KEYWORD_NO,KEYWORD_NAME) values ('K2','반려동물 친화');
Insert into ONECHO.KEYWORD (KEYWORD_NO,KEYWORD_NAME) values ('K3','산소뿜뿜 반려동물 친화');

REM INSERTING into ONECHO.IMAGE
SET DEFINE OFF;
Insert into ONECHO.IMAGE (IMAGE_NO,IMAGE_PATH,IMAGE_NAME) values ('IMG1','/IMAGES/ITEM/','고무나무.jpg');
Insert into ONECHO.IMAGE (IMAGE_NO,IMAGE_PATH,IMAGE_NAME) values ('IMG2','/IMAGES/ITEM/','smim.jpg');
Insert into ONECHO.IMAGE (IMAGE_NO,IMAGE_PATH,IMAGE_NAME) values ('IMG3','/IMAGES/ITEM/','testsample.jpg');


REM INSERTING into ONECHO.ITEM
SET DEFINE OFF;
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I2','문샤인','SOIL','K1',25000,24000,0,34,'Y','이름 그대로 달빛을 머금은듯한 오묘한 색이 매력적인 문샤인',to_date('20/05/22','RR/MM/DD'),to_date('20/05/22','RR/MM/DD'),8,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I3','몬스테라','SOIL','K1',27000,26000,0,21,'Y','넓은 잎이 주는 이국적인 분위기를 내는 몬스테라',to_date('20/05/23','RR/MM/DD'),to_date('20/05/23','RR/MM/DD'),1,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I4','디시디아','HANGING','K3',19500,17000,0,15,'Y','동글동글한 입사귀에 흰색 테두리가 매력적인 디시디아',to_date('20/05/24','RR/MM/DD'),to_date('20/05/24','RR/MM/DD'),1,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I5','라탄포레스트','SOIL','K1',28900,26900,0,19,'Y','스파티필름과 스노우사파이어가 라탄바구니에 담겨 이국적인 분위기를 업 ',to_date('20/05/25','RR/MM/DD'),to_date('20/05/25','RR/MM/DD'),2,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I6','스파티필름','WATER','K1',22000,21000,0,31,'Y','사계절 내내 아름다운 꽃과 함께하는 즐거움 스파티필름',to_date('20/05/26','RR/MM/DD'),to_date('20/05/26','RR/MM/DD'),3,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I7','행운목','WATER','K1',20000,17000,0,28,'Y','이산화탄소, 포름알데히드, 벤젠 등의 유해물질을 모두 흡수해주는 행운목',to_date('20/05/27','RR/MM/DD'),to_date('20/05/27','RR/MM/DD'),1,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I8','산세베리아','SOIL','K1',23500,22500,0,21,'Y','사막에 있는 선인장, 생명력 왕이라 불리는 산세베리아',to_date('20/05/28','RR/MM/DD'),to_date('20/05/28','RR/MM/DD'),1,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I9','틸란테라리움','SOIL','K3',24500,23000,0,55,'Y','지구상에서 가장 강력한 공기청정기 틸란드시아',to_date('20/05/29','RR/MM/DD'),to_date('20/05/29','RR/MM/DD'),2,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I10','스킨답서스','WATER','K1',15000,14000,0,43,'Y','환경적응력이 뛰어나 반려식물 초보자도 친구가 될 수 있는 스킨답서스',to_date('20/05/30','RR/MM/DD'),to_date('20/05/30','RR/MM/DD'),3,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I11','수경몬스테라','WATER','K1',27000,24000,0,5,'Y','정화능력이 뛰어나 새 집이나 사무실에서 각광받는 수경몬스테라',to_date('20/05/31','RR/MM/DD'),to_date('20/05/31','RR/MM/DD'),5,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I12','테이블야자','WATER','K3',22500,19500,0,7,'Y','공기정화는 물론 가습효과까지 탁월한 테이블야자',to_date('20/06/01','RR/MM/DD'),to_date('20/06/01','RR/MM/DD'),2,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I13','스노우사파이어','WATER','K1',28000,27000,0,9,'Y','부와 행운을 가져다준다는 스노우사파이어',to_date('20/06/02','RR/MM/DD'),to_date('20/06/02','RR/MM/DD'),7,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I14','이오난사','HANGING','K3',20000,16500,0,30,'Y','크기는 작지만 공기를 정화시켜주는 이오난사',to_date('20/06/03','RR/MM/DD'),to_date('20/06/03','RR/MM/DD'),3,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I15','필레아페페','WATER','K3',30000,26000,0,9,'Y','귀여운 비주얼에 걸맞는 귀여운 이름, 필레아페페',to_date('20/06/04','RR/MM/DD'),to_date('20/06/04','RR/MM/DD'),5,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I16','스투키','SOIL','K1',21500,19500,0,11,'Y','미국 NASA에서도 인증한 공기정화 능력을 가진 스투키',to_date('20/06/05','RR/MM/DD'),to_date('20/06/05','RR/MM/DD'),20,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I17','마리모','WATER','K2',25000,22500,0,20,'Y','기분이 좋을땐 물 위를 둥둥, 보기만 해도 행복해지는 귀여운 마리모',to_date('20/06/06','RR/MM/DD'),to_date('20/06/06','RR/MM/DD'),19,10,'Y');
Insert into ONECHO.ITEM (ITEM_NO,ITEM_NAME,ITEM_CATEGORY,KEYWORD_NO,ITEM_PRICE,ITEM_DISCOUNT,ITEM_RATE,ITEM_STOCK,ITEM_DISPLAY,ITEM_INFO,ITEM_CDATE,ITEM_UDATE,ITEM_SCOUNT,ITEM_MAX,ITEM_SALE) 
values ('I1','야자수염틸란드시아','HANGING','K3',26500,25000,0,28,'Y','집에 싱그러움을 더해줄 뿐 아니라 공기정화 능력도 뛰어난 야자수염틸란드시아',to_date('20/05/21','RR/MM/DD'),to_date('20/05/21','RR/MM/DD'),13,10,'Y');


REM INSERTING into ONECHO.ITEMIMAGE
SET DEFINE OFF;
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II1','I1','IMG1',1);
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II6','I3','IMG5',2);
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II2','I1','IMG2',2);
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II3','I2','IMG3',1);
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II4','I2','IMG2',2);
Insert into ONECHO.ITEMIMAGE (ITEMIMAGE_NO,ITEM_NO,IMAGE_NO,ITEMIMAGE_CATEGORY) values ('II5','I3','IMG4',1);

REM INSERTING into ONECHO.CARTLIST
SET DEFINE OFF;
Insert into ONECHO.CARTLIST (CARTLIST_NO,ITEM_NO,MEMBER_NO,CARTLIST_COUNT) values ('C1','I1','M7',3);
Insert into ONECHO.CARTLIST (CARTLIST_NO,ITEM_NO,MEMBER_NO,CARTLIST_COUNT) values ('C4','I2','M7',1);
Insert into ONECHO.CARTLIST (CARTLIST_NO,ITEM_NO,MEMBER_NO,CARTLIST_COUNT) values ('C2','I1','M6',2);
Insert into ONECHO.CARTLIST (CARTLIST_NO,ITEM_NO,MEMBER_NO,CARTLIST_COUNT) values ('C3','I2','M6',2);

REM INSERTING into ONECHO.WISHLIST
SET DEFINE OFF;
Insert into ONECHO.WISHLIST (WISHLIST_NO,ITEM_NO,MEMBER_NO,WISHLIST_MEMO) values ('W1','I1','M7','찜!!');
Insert into ONECHO.WISHLIST (WISHLIST_NO,ITEM_NO,MEMBER_NO,WISHLIST_MEMO) values ('W2','I2','M6','친구선물');

REM INSERTING into ONECHO.DELIVERY
SET DEFINE OFF;
Insert into ONECHO.DELIVERY (DELIVERY_CODE,DELIVERY_STATUS) values ('D1','배송 전');
Insert into ONECHO.DELIVERY (DELIVERY_CODE,DELIVERY_STATUS) values ('D2','배송 중');
Insert into ONECHO.DELIVERY (DELIVERY_CODE,DELIVERY_STATUS) values ('D3','배송 완료');

REM INSERTING into ONECHO.PAYMENT
SET DEFINE OFF;
Insert into ONECHO.PAYMENT (PAYMENT_CODE,PAYMENT_STATUS) values ('P1','입금 전');
Insert into ONECHO.PAYMENT (PAYMENT_CODE,PAYMENT_STATUS) values ('P2','입금 후');

REM INSERTING into ONECHO.STATISTIC
SET DEFINE OFF;
Insert into ONECHO.STATISTIC (STATISTIC_NO,STATISTIC_VISITCOUNT,STATISTIC_TODAYJOIN,STATISTIC_CANCELCOUNT,STATISTIC_MEMBER,STATISTIC_DASK,STATISTIC_IASK,STATISTIC_CASK,STATISTIC_SALES,STATISTIC_DBEFORE,STATISTIC_NEWORDER,STATISTIC_CDATE) values ('STA1',312312,84,10,300000,23,3,7,124123,70,100,to_date('20/06/01','RR/MM/DD'));
Insert into ONECHO.STATISTIC (STATISTIC_NO,STATISTIC_VISITCOUNT,STATISTIC_TODAYJOIN,STATISTIC_CANCELCOUNT,STATISTIC_MEMBER,STATISTIC_DASK,STATISTIC_IASK,STATISTIC_CASK,STATISTIC_SALES,STATISTIC_DBEFORE,STATISTIC_NEWORDER,STATISTIC_CDATE) values ('STA2',100000,77,10,300077,12,8,7,523088,82,120,to_date('20/06/02','RR/MM/DD'));

REM INSERTING into ONECHO.ORDERLIST
SET DEFINE OFF;
Insert into ONECHO.ORDERLIST (ORDER_NO,ITEM_NO,MEMBER_NO,ORDER_DATE,ORDER_COUNT,ORDER_USEPOINT,ORDER_NAME,ORDER_PHONE1,ORDER_PHONE2,ORDER_PHONE3,ORDER_POSTCODE,ORDER_ADDRESS1,ORDER_ADDRESS2,ORDER_REQUEST,ORDER_DCOST,ORDER_CANCELREQUEST,ORDER_CANCELYN,DELIVERY_CODE,PAYMENT_CODE) values ('O1','I1','M6',to_date('20/06/02','RR/MM/DD'),3,0,'홍길동','010','1234','1234','98762','서울시 송파구 가락동 가락아파트','110동 101호',null,2500,'N','N','D1','P1');
Insert into ONECHO.ORDERLIST (ORDER_NO,ITEM_NO,MEMBER_NO,ORDER_DATE,ORDER_COUNT,ORDER_USEPOINT,ORDER_NAME,ORDER_PHONE1,ORDER_PHONE2,ORDER_PHONE3,ORDER_POSTCODE,ORDER_ADDRESS1,ORDER_ADDRESS2,ORDER_REQUEST,ORDER_DCOST,ORDER_CANCELREQUEST,ORDER_CANCELYN,DELIVERY_CODE,PAYMENT_CODE) values ('O2','I1','M7',to_date('20/06/02','RR/MM/DD'),3,0,'홍길동','010','1234','1234','98762','서울시 송파구 가락동 가락아파트','110동 101호',null,2500,'N','N','D1','P1');
Insert into ONECHO.ORDERLIST (ORDER_NO,ITEM_NO,MEMBER_NO,ORDER_DATE,ORDER_COUNT,ORDER_USEPOINT,ORDER_NAME,ORDER_PHONE1,ORDER_PHONE2,ORDER_PHONE3,ORDER_POSTCODE,ORDER_ADDRESS1,ORDER_ADDRESS2,ORDER_REQUEST,ORDER_DCOST,ORDER_CANCELREQUEST,ORDER_CANCELYN,DELIVERY_CODE,PAYMENT_CODE) values ('O3','I1','M6',to_date('20/06/02','RR/MM/DD'),1,0,'홍길동','010','1234','1234','98762','서울시 송파구 가락동 가락아파트','110동 101호',null,2500,'N','N','D1','P1');
Insert into ONECHO.ORDERLIST (ORDER_NO,ITEM_NO,MEMBER_NO,ORDER_DATE,ORDER_COUNT,ORDER_USEPOINT,ORDER_NAME,ORDER_PHONE1,ORDER_PHONE2,ORDER_PHONE3,ORDER_POSTCODE,ORDER_ADDRESS1,ORDER_ADDRESS2,ORDER_REQUEST,ORDER_DCOST,ORDER_CANCELREQUEST,ORDER_CANCELYN,DELIVERY_CODE,PAYMENT_CODE) values ('O3','I2','M6',to_date('20/06/02','RR/MM/DD'),1,0,'홍길동','010','1234','1234','98762','서울시 송파구 가락동 가락아파트','110동 101호',null,2500,'N','N','D1','P1');

REM INSERTING into ONECHO.REVIEW
SET DEFINE OFF;
Insert into ONECHO.REVIEW (REVIEW_NO,ORDER_NO,ITEM_NO,MEMBER_NO,REVIEW_CDATE,REVIEW_RATE,REVIEW_CONTENT,REVIEW_UDATE,IMAGE_NO) values ('R1','O1','I1','M7',to_date('20/06/02','RR/MM/DD'),5,'좋아 아주좋아요',to_date('20/06/02','RR/MM/DD'),'IMG3');
Insert into ONECHO.REVIEW (REVIEW_NO,ORDER_NO,ITEM_NO,MEMBER_NO,REVIEW_CDATE,REVIEW_RATE,REVIEW_CONTENT,REVIEW_UDATE,IMAGE_NO) values ('R3','O3','I1','M6',to_date('20/06/02','RR/MM/DD'),5,'공기가 달라요 ^^',to_date('20/06/02','RR/MM/DD'),'IMG3');

REM INSERTING into ONECHO.QNA
SET DEFINE OFF;
Insert into ONECHO.QNA (QNA_NO,MEMBER_NO,QNA_TITLE,QNA_CDATE,QNA_CONTENT,QNA_ANSWER,QNA_CATEGORY,QNA_PASSWORD,QNA_YN,IMAGE_NO) values ('Q1','M6','화분색 선택 가능한가요?',to_date('20/06/02','RR/MM/DD'),'화분색이 궁금해요',null,'상품','1234','N','IMG3');


--- VIEW ADD
-- 카트리스트 뷰
CREATE OR REPLACE VIEW MEMBER_CARTLIST AS
SELECT CARTLIST_NO, CA.ITEM_NO, ITEM_NAME, ITEM_PRICE, ITEM_MAX, MEMBER_NO, CARTLIST_COUNT, II.IMAGE_NO, IMAGE_NAME
FROM CARTLIST CA
JOIN (
      select I.item_no, itemimage_no, IMAGE_NO, ITEM_NAME, ITEM_PRICE, ITEM_MAX
      from item I
      join (SELECT *
            FROM ITEMIMAGE
            WHERE itemimage_category=1) M on (I.item_no=M.item_no)
      ) II on (CA.item_no=II.item_no)
JOIN IMAGE IM ON (II.IMAGE_NO = IM.IMAGE_NO);

-- 오더 확인
CREATE OR REPLACE VIEW ORDERCHK AS
SELECT ORDER_NO, IMAGE_PATH, ITEM_NO, ITEM_NAME, ITEM_MAX, DELIVERY_STATUS
FROM ORDERLIST O
JOIN ITEM IT ON(IT.ITEM_NO = O.ITEM_NO)
JOIN ITEMIMAGE II ON(II.ITEM_NO = IT.ITEM_NO)
JOIN IMAGE IM ON(IM.IMAGE_NO = II.IMAGE_NO)
JOIN DELIVERY D ON(D.DELIVERY_CODE = O.DELIVERY_CODE);
ROLLBACK;

-- 위시 확인
CREATE OR REPLACE VIEW WISHCHK AS
SELECT WISHLIST_NO, IMAGE_PATH, ITEM_NAME, WISHLIST_MEMO
FROM WISHLIST W
JOIN ITEM IT ON(IT.ITEM_NO = W.ITEM_NO)
JOIN ITEMIMAGE II ON(II.ITEM_NO = IT.ITEM_NO)
JOIN IMAGE IM ON(IM.IMAGE_NO = II.IMAGE_NO);

CREATE OR REPLACE FORCE VIEW V_ITEMIMAGE ("ITEM_NO", "mItemImgNo", "mainImgNo", "mainImgName", "mainPath", "sItemImgNo", "subImgNo", "subImgName", "subPath") AS 
select I.item_no,M.itemimage_no "mItemImgNo", M.image_no "mainImgNo", M.IMAGE_NAME "mainImgName",M.image_path "mainPath",
        S.itemimage_no "sItemImgNo",S.image_no "subImgNo",S.image_name "subImgName",S.image_path "subPath"
from item I
left join (SELECT IT.ITEM_NO,ITEMIMAGE_NO,IT.IMAGE_NO,IMAGE_NAME,IMAGE_PATH,ITEMIMAGE_CATEGORY
            FROM ITEMIMAGE IT
            left join image G on (IT.IMAGE_NO = G.IMAGE_NO)
            WHERE itemimage_category=1) M on (I.item_no=M.item_no)
left join (SELECT MG.ITEM_NO, ITEMIMAGE_NO, MG.IMAGE_NO,IMAGE_NAME,IMAGE_PATH,ITEMIMAGE_CATEGORY
            FROM ITEMIMAGE MG
            left join image E on (MG.IMAGE_NO = E.IMAGE_NO)
            WHERE itemimage_category=2) S on (I.item_no=S.item_no);

COMMIT;
