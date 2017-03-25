-- 도서관
DROP SCHEMA IF EXISTS book_project;

-- 도서관
CREATE SCHEMA book_project;

-- 도서
CREATE TABLE book_project.book_info (
	b_code    CHAR(4)     NOT NULL, -- 도서코드
	b_name    VARCHAR(20) NULL,     -- 도서명
	author    VARCHAR(20) NULL,     -- 저자
	publisher VARCHAR(50) NULL,     -- 출판사명
	price     INTEGER     NULL      -- 가격
);

-- 도서
ALTER TABLE book_project.book_info
	ADD CONSTRAINT PK_book_info -- 도서 기본키
		PRIMARY KEY (
			b_code -- 도서코드
		);

-- 회원
CREATE TABLE book_project.member_info (
	m_code   CHAR(4)     NOT NULL, -- 회원코드
	m_name   VARCHAR(20) NULL,     -- 성명
	tel      CHAR(13)    NULL,     -- 연락처
	zip_code INTEGER(5)  NULL,     -- 우편번호
	address  VARCHAR(50) NULL,     -- 주소
	is_secsn BOOLEAN     NULL     DEFAULT false -- 탈퇴여부
);

-- 회원
ALTER TABLE book_project.member_info
	ADD CONSTRAINT PK_member_info -- 회원 기본키
		PRIMARY KEY (
			m_code -- 회원코드
		);

-- 출납
CREATE TABLE book_project.payment_io (
	no          INTEGER NOT NULL, -- 출납번호
	b_code      CHAR(4) NOT NULL, -- 도서코드
	m_code      CHAR(4) NOT NULL, -- 회원코드
	lend_date   DATE    NULL,     -- 대여일
	return_date DATE    NULL     DEFAULT null -- 반납일
);

-- 출납
ALTER TABLE book_project.payment_io
	ADD CONSTRAINT PK_payment_io -- 출납 기본키
		PRIMARY KEY (
			no -- 출납번호
		);

ALTER TABLE book_project.payment_io
	MODIFY COLUMN no INTEGER NOT NULL AUTO_INCREMENT;

-- 출판사
CREATE TABLE book_project.publisher_info (
	publisher VARCHAR(50) NOT NULL, -- 출판사명
	p_name    VARCHAR(20) NULL,     -- 담당자명
	p_tel     VARCHAR(13) NULL      -- 연락처
);

-- 출판사
ALTER TABLE book_project.publisher_info
	ADD CONSTRAINT PK_publisher_info -- 출판사 기본키
		PRIMARY KEY (publisher);

-- 도서대여정보
CREATE TABLE book_project.b_lend_info (
	b_code       CHAR(4) NOT NULL, -- 도서코드
	is_lending   BOOLEAN NULL     DEFAULT true, -- 대여여부
	b_lend_count INTEGER NULL     DEFAULT 0 -- 총 대여횟수
);

-- 도서대여정보
ALTER TABLE book_project.b_lend_info
	ADD CONSTRAINT PK_b_lend_info -- 도서대여정보 기본키
		PRIMARY KEY (
			b_code -- 도서코드
		);

-- 회원대여정보
CREATE TABLE book_project.m_lend_info (
	m_code       CHAR(4) NOT NULL, -- 회원코드
	is_posbl     BOOLEAN NULL     DEFAULT true, -- 대여가능여부
	delay_count  INTEGER NULL     DEFAULT 0, -- 연체 횟수
	m_lend_count INTEGER NULL     DEFAULT 0, -- 총 대여권수
	m_now_count  INTEGER NULL     DEFAULT 0, -- 현재 대여권수
	black_date   DATE    NULL      -- 대여금지일
);

-- 회원대여정보
ALTER TABLE book_project.m_lend_info
	ADD CONSTRAINT PK_m_lend_info -- 회원대여정보 기본키
		PRIMARY KEY (
			m_code -- 회원코드
		);

-- 도서분류
CREATE TABLE book_project.coden (
	c_name VARCHAR(50) NOT NULL, -- 분류
	c_code CHAR(2)     NOT NULL  -- 코드
);

-- 도서
ALTER TABLE book_project.book_info
	ADD CONSTRAINT FK_publisher_info_TO_book_info -- 출판사 -> 도서
		FOREIGN KEY (publisher)	REFERENCES book_project.publisher_info (publisher);

-- 출납
ALTER TABLE book_project.payment_io
	ADD CONSTRAINT FK_book_info_TO_payment_io -- 도서 -> 출납
		FOREIGN KEY (
			b_code -- 도서코드
		)
		REFERENCES book_project.book_info ( -- 도서
			b_code -- 도서코드
		);

-- 출납
ALTER TABLE book_project.payment_io
	ADD CONSTRAINT FK_member_info_TO_payment_io -- 회원 -> 출납
		FOREIGN KEY (
			m_code -- 회원코드
		)
		REFERENCES book_project.member_info ( -- 회원
			m_code -- 회원코드
		);

-- 도서대여정보
ALTER TABLE book_project.b_lend_info
	ADD CONSTRAINT FK_book_info_TO_b_lend_info -- 도서 -> 도서대여정보
		FOREIGN KEY (
			b_code -- 도서코드
		)
		REFERENCES book_project.book_info ( -- 도서
			b_code -- 도서코드
		);

-- 회원대여정보
ALTER TABLE book_project.m_lend_info
	ADD CONSTRAINT FK_member_info_TO_m_lend_info -- 회원 -> 회원대여정보
		FOREIGN KEY (
			m_code -- 회원코드
		)
		REFERENCES book_project.member_info ( -- 회원
			m_code -- 회원코드
		);
		
----------------------------------------------------------------------

INSERT INTO book_project.publisher_info (publisher, p_name, p_tel) values
('한빛미디어', '교보문고', '123-456-7890'),
('길벗', '교보문고', '123-456-7890'),
('한빛미디어', '교보문고', '123-456-7890'),
('제이펍', '교보문고', '123-456-7890'),
('책세상', '교보문고', '123-456-7890'),
('민음사', '교보문고', '123-456-7890'),
('인플루엔셜', '교보문고', '123-456-7890'),
('부키', '교보문고', '123-456-7890'),
('돌베개', '교보문고', '123-456-7890'),
('와이즈베리', '교보문고', '123-456-7890');


delete * from publisher_info;

select * from book_project.publisher_info;


INSERT INTO book_project.book_info values
('T001', '이것이자바다', '신용권', '한빛미디어', 30000),
('T002', '자바+안드로이드를다루는기술', '정재곤', '길벗', 40000),
('T003', '인사이드자바스크립트','송형주','한빛미디어',18000),
('T004', '자바스크립트&제이쿼리','존두켓','제이펍',36000),
('H001', '어떻게죽음을마주할것인가','모니카렌츠','책세상',13950),
('H002','공부할권리','정여울','민음사',16500),
('H003','미움받을용기','기시미이치로','인플루엔셜',14900),
('H004','나는생각이너무많아','크리스텔프리콜랭','부키',14800),
('S001','국가란무엇인가','유시민','돌베개',15000),
('S002','정의란무엇인가','마이클샌델','와이즈베리',15000),
('S003','한국사회어디로','김우창','아시아',16000),
('S004','페페의희망교육','로베르트프란시스가르시아','학이시습',15000),
('J001','여행이아니면알수없는것들','손미나','씨네21북스',15000),
('J002','여행하지않을자유','피코아이어','문학동네',12800),
('J003','런던여행백서','정꽃나래','나무자전거',18000),
('J004','후쿠오카여행가는길','김남규','연두',14000),
('D001', '쓸모없는짓의행복', '크리스길아보', '더퀘스트', 15000),
('D002', '버리고시작하라', '위르겐볼프', '흐름출판', 12000),
('D003', '인생의발견', '월트아이작슨', '21세기북스', 16800),
('D004', '쿤달리니와명상', '김득주', '보문사', 25000);

select * from book_info;
		

INSERT INTO book_pjt.b_lend_info (b_code, is_lending, b_lend_count) VALUES
('T001', true, 2),
('T002', true, 2),
('T003', true, 2),
('T004', true, 2),
('H001', true, 2),
('H002', true, 2),
('H003', true, 2),
('H004', true, 2),
('S001', true, 2),
('S002', true, 2),
('S003', true, 2),
('S004', true, 2),
('J001', false, 2),
('J002', true, 2),
('J003', true, 2),
('J004', true, 2),
('D001', true, 2),
('D002', true, 2),
('D003', true, 2),
('D004', true, 2);






INSERT INTO book_project.member_info (m_code, m_name, tel, zip_code, address, is_secsn) VALUES
('M001', '김유정', '010-1234-1234',04524,'서울특별시 중구 세종대로 110',false),
('M002', '김태희', '010-1234-1234',35242,'대전광역시 서구 둔산로 100',false), 
('M003', '박보영', '010-1234-1234',41911,'대구광역시 중구 공평로 88',false),
('M004', '전지현', '010-1234-1234',47545,'부산광역시 연제구 중앙대로 1001',false),
('M005', 'Emma Watson', '010-1234-1234',41908,'대구광역시 중구 국채보상로139길 1',false),
('M006', '고수', '010-1234-1234',41185,'대구광역시 동구 아양로 207',true), -- 탈퇴상태
('M007', '박보검', '010-1234-1234',41777,'대구광역시 서구 국채보상로 257',false),
('M008', '박형식', '010-1234-1234',42429,'대구광역시 남구 이천로 51',false),
('M009', 'Dan Stevens', '010-1234-1234',41590,'대구광역시 북구 옥산로 65',false),
('M010', '원빈', '010-1234-1234',42424,'대구 남구 중앙대로 220 3층',false);


INSERT INTO book_project.m_lend_info (m_code, is_posbl, delay_count, m_lend_count, m_now_count, black_date)VALUES
('M001', true, 0, 0, 2, null),
('M002', true, 1, 0, 2, null),
('M003', true, 0, 15, 1, null),		
('M004', true, 0, 15, 4, null),					-- 4권 빌린사람
('M005', false, 1, 10, 5, null),				-- 5권 빌린사람
('M006', false, 0, 15, 0, null),				-- 탈퇴회원
('M007', false, 1, 15, 1, null),				-- 책 연체 중인 사람(일반)
('M008', true, 2, 15, 2, null),					-- 곧 블랙.. 연체횟수 2번이나 연체중 아님
('M009', false, 2, 15, 2, null), 				-- 곧 블랙리스트 될 사람.. 연체횟수2번에 연체중인사람
('M010', false, 3, 15, 0, '2017-03-23'); 		-- 현재 블랙리스트
	


INSERT INTO book_project.payment_io (b_code, m_code, lend_date, return_date) VALUES
('T001','M001','2017-03-23' , null),
('T003','M002','2017-03-23' , null),
('T004','M002','2017-03-23' , null),
('S004','M003','2017-03-23' , null),
('J004','M004','2017-03-23' , null),
('S001','M005','2017-03-23' , null),
('D004','M005','2017-03-23' , null),
('D001','M004','2017-03-23' , null),
('H001','M004','2017-03-23' , null),
('D002','M004','2017-03-23' , null),
('J002','M005','2017-03-23' , null),
('D003','M005','2017-03-23' , null),
('J003','M005','2017-03-23' , null),
('S002','M007','2017-03-23' , null),
('B016','M008','2017-03-23' , null),
('S003','M008','2017-03-23' , null),
('T002','M001','2017-03-23' , null),
('H002','M009','2017-03-23' , null),
('H003','M009','2017-03-23' , null);



delimiter $$
create procedure book_pjt.proc_payment_io_insert(
	in _b_code char(4),
	in _m_code char(4)
)
begin 
	
	declare err int default 0;
	declare continue handler for sqlexception set err - -1;
	
	start transaction;
	UPDATE b_lend_info SET  b_lend_count=(b_lend_count+1) WHERE b_code=_b_code;
	UPDATE m_lend_info SET  m_lend_count=(m_lend_count+1) WHERE m_code=_m_code;

	INSERT INTO payment_io (b_code, m_code, lend_date, return_date) VALUES(_b_code,_m_code, now(), null);
	UPDATE b_lend_info SET is_posbl=false  WHERE b_code= _b_code;
	
	
	if err < 0 then
		rollback;
	else
		commit;
	end if;
	
end $$
delimiter ;



delimiter $$
create procedure book_pjt.proc_payment_io_update(
	in _b_code char(4),
	in _m_code char(4)
)
begin	
	
	declare err int default 0;
	declare continue handler for sqlexception set err - -1;
	
	start transaction;

	UPDATE payment_io SET return_date = now() where no = (
		select * from(select no from payment_io where b_code = _b_code and m_code= _m_code and return_date is null) as b);
	UPDATE book_info SET is_posbl=true WHERE b_code= _b_code;
	
	if err < 0 then
		rollback;
	else
		commit;
	end if;
	
end $$
delimiter ;

create trigger tri_payment_io_after_insert
after insert on payment_io
for each row
begin 
	
	set @due_date = new.lend_date;
	
	UPDATE payment_io SET due_date = ADDDATE(@due_date, interval 3 day) where no=new.no; 
	
end;

call book_pjt.proc_booksinout_insert('B001', 'M001');
call book_pjt.proc_booksinout_insert('B002', 'M002');
call book_pjt.proc_booksinout_insert('B003', 'M003');

call book_pjt.proc_booksinout_update('B002', 'M002');