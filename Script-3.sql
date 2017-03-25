-- 도서관
DROP SCHEMA IF EXISTS book_project;

-- 도서관
CREATE SCHEMA book_project;

-- 도서
CREATE TABLE book_project.bookInfo (
	b_code      CHAR(4)     NOT NULL, -- 도서코드
	c_name      VARCHAR(50) NULL,     -- 분류
	b_name      VARCHAR(20) NULL,     -- 도서명
	author      VARCHAR(20) NULL,     -- 저자
	p_code      CHAR(4)     NULL,     -- 출판사코드
	price       INTEGER     NULL,     -- 가격
	insert_date DATE        NULL,     -- 도서등록일
	is_del      BOOLEAN     NULL     DEFAULT false -- 도서폐기여부
);

-- 도서
ALTER TABLE book_project.bookInfo
	ADD CONSTRAINT PK_bookInfo -- 도서 기본키
		PRIMARY KEY (
			b_code -- 도서코드
		);

-- 회원
CREATE TABLE book_project.memberInfo (
	m_code     CHAR(4)     NOT NULL, -- 회원코드
	m_pass     VARCHAR(20) NULL,     -- 비밀번호
	m_name     VARCHAR(20) NULL,     -- 성명
	m_tel      CHAR(13)    NULL,     -- 연락처
	m_zip_code INTEGER(5)  NULL,     -- 우편번호
	m_address  VARCHAR(50) NULL,     -- 주소
	is_manager BOOLEAN     NULL,     -- 관리자모드
	is_secsn   BOOLEAN     NULL     DEFAULT false -- 탈퇴여부
);

-- 회원
ALTER TABLE book_project.memberInfo
	ADD CONSTRAINT PK_memberInfo -- 회원 기본키
		PRIMARY KEY (
			m_code -- 회원코드
		);

-- 출납
CREATE TABLE book_project.paymentIO (
	no          INTEGER NOT NULL, -- 출납번호
	b_code      CHAR(4) NOT NULL, -- 도서코드
	m_code      CHAR(4) NOT NULL, -- 회원코드
	lend_date   DATE    NULL,     -- 대여일
	return_date DATE    NULL     DEFAULT null -- 반납일
);

-- 출납
ALTER TABLE book_project.paymentIO
	ADD CONSTRAINT PK_paymentIO -- 출납 기본키
		PRIMARY KEY (
			no -- 출납번호
		);

ALTER TABLE book_project.paymentIO
	MODIFY COLUMN no INTEGER NOT NULL AUTO_INCREMENT;

-- 출판사
CREATE TABLE book_project.publisherInfo (
	p_code     CHAR(4)     NOT NULL, -- 출판사코드
	publisher  VARCHAR(50) NULL,     -- 출판사명
	p_name     VARCHAR(20) NULL,     -- 담당자명
	p_tel      VARCHAR(13) NULL,     -- 연락처
	p_zip_code INTEGER(5)  NULL,     -- 우편번호
	p_address  VARCHAR(50) NULL      -- 주소
);

-- 출판사
ALTER TABLE book_project.publisherInfo
	ADD CONSTRAINT PK_publisherInfo -- 출판사 기본키
		PRIMARY KEY (
			p_code -- 출판사코드
		);

-- 도서대여정보
CREATE TABLE book_project.bookLend (
	b_code       CHAR(4) NOT NULL, -- 도서코드
	is_lending   BOOLEAN NULL     DEFAULT false, -- 대여여부
	b_lend_count INTEGER NULL     DEFAULT 0 -- 총 대여횟수
);

-- 도서대여정보
ALTER TABLE book_project.bookLend
	ADD CONSTRAINT PK_bookLend -- 도서대여정보 기본키
		PRIMARY KEY (
			b_code -- 도서코드
		);

-- 회원대여정보
CREATE TABLE book_project.memberLend (
	m_code       CHAR(4) NOT NULL, -- 회원코드
	is_posbl     BOOLEAN NULL     DEFAULT true, -- 대여가능여부
	delay_count  INTEGER NULL     DEFAULT 0, -- 연체 횟수
	m_lend_count INTEGER NULL     DEFAULT 0, -- 총 대여권수
	m_now_count  INTEGER NULL     DEFAULT 0, -- 현재 대여권수
	black_date   DATE    NULL      -- 대여금지일
);

-- 회원대여정보
ALTER TABLE book_project.memberLend
	ADD CONSTRAINT PK_memberLend -- 회원대여정보 기본키
		PRIMARY KEY (
			m_code -- 회원코드
		);

-- 도서분류
CREATE TABLE book_project.coden (
	c_name VARCHAR(50) NOT NULL, -- 분류
	c_code CHAR(2)     NOT NULL  -- 코드
);

-- 도서분류
ALTER TABLE book_project.coden
	ADD CONSTRAINT PK_coden -- 도서분류 기본키
		PRIMARY KEY (
			c_name -- 분류
		);

-- 도서
ALTER TABLE book_project.bookInfo
	ADD CONSTRAINT FK_publisherInfo_TO_bookInfo -- 출판사 -> 도서
		FOREIGN KEY (
			p_code -- 출판사코드
		)
		REFERENCES book_project.publisherInfo ( -- 출판사
			p_code -- 출판사코드
		)
		ON UPDATE CASCADE;

-- 도서
ALTER TABLE book_project.bookInfo
	ADD CONSTRAINT FK_coden_TO_bookInfo -- 도서분류 -> 도서
		FOREIGN KEY (
			c_name -- 분류
		)
		REFERENCES book_project.coden ( -- 도서분류
			c_name -- 분류
		)
		ON UPDATE CASCADE;

-- 출납
ALTER TABLE book_project.paymentIO
	ADD CONSTRAINT FK_bookInfo_TO_paymentIO -- 도서 -> 출납
		FOREIGN KEY (
			b_code -- 도서코드
		)
		REFERENCES book_project.bookInfo ( -- 도서
			b_code -- 도서코드
		)
		ON UPDATE CASCADE;

-- 출납
ALTER TABLE book_project.paymentIO
	ADD CONSTRAINT FK_memberInfo_TO_paymentIO -- 회원 -> 출납
		FOREIGN KEY (
			m_code -- 회원코드
		)
		REFERENCES book_project.memberInfo ( -- 회원
			m_code -- 회원코드
		)
		ON UPDATE CASCADE;

-- 도서대여정보
ALTER TABLE book_project.bookLend
	ADD CONSTRAINT FK_bookInfo_TO_bookLend -- 도서 -> 도서대여정보
		FOREIGN KEY (
			b_code -- 도서코드
		)
		REFERENCES book_project.bookInfo ( -- 도서
			b_code -- 도서코드
		)
		ON UPDATE CASCADE;

-- 회원대여정보
ALTER TABLE book_project.memberLend
	ADD CONSTRAINT FK_memberInfo_TO_memberLend -- 회원 -> 회원대여정보
		FOREIGN KEY (
			m_code -- 회원코드
		)
		REFERENCES book_project.memberInfo ( -- 회원
			m_code -- 회원코드
		)
		ON UPDATE CASCADE;
		
-- --------------------------------------------------------------------


INSERT INTO book_project.publisherInfo (p_code, publisher, p_name, p_tel, p_zip_code, p_address) VALUES 
('P001','한빛미디어', '교보문고', '123-456-7890',04029,'서울특별시 마포구 양화로7길 83'),
('P002','길벗', '교보문고', '123-456-7890',04003,'서울특별시 마포구 월드컵로10길 56'),
('P003','제이펍', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 159 3층 3-B호'),
('P004','책세상', '교보문고', '123-456-7890',03176,'서울특별시 종로구 경희궁길 33 내자빌딩'),
('P005','민음사', '교보문고', '123-456-7890',06027,'서울특별시 강남구 도산대로1길 62'),
('P006','인플루엔셜', '교보문고', '123-456-7890',04511,'서울특별시 중구 통일로2길 16 에이아이에이타워 8층'),
('P007','부키', '교보문고', '123-456-7890',03785,'서울특별시 서대문구 신촌로3길 15 산성빌딩'),
('P008','돌베개', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 77-20'),
('P009','와이즈베리', '교보문고', '123-456-7890',06532,'서울특별시 서초구 신반포로 321'),
('P010','아시아', '교보문고', '123-456-7890',06972,'서울특별시 동작구 서달로 161-1'),
('P011','학이시습', '교보문고', '123-456-7890',37186,'경상북도 상주시 서문길 111-24'),
('P012','씨네21북스', '교보문고', '123-456-7890',04550,'서울특별시 중구 충무로5길 2 '),
('P013','문학동네', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 210'),
('P014','나무자전거', '교보문고', '123-456-7890',10441,'경기도 고양시 덕양구 강매로 256-21 1층'),
('P015','연두', '교보문고', '123-456-7890',03911,'서울특별시 마포구 매봉산로 18'),
('P016','더퀘스트', '교보문고', '123-456-7890',04558,'서울특별시 중구 창경궁로 17'),
('P017','흐름출판', '교보문고', '123-456-7890',55019,'전라북도 전주시 덕진구 정언신로 59'),
('P018','21세기북스', '교보문고', '123-456-7890',04560,'서울특별시 중구 퇴계로 293-1'),
('P019','보문사', '교보문고', '123-456-7890',23007,'인천광역시 강화군 삼산면 삼산남로828번길 44'),
('P020','메디치미디어', '교보문고', '123-456-7890',03027,'서울특별시 종로구 사직로9길 22'),
('P021','에이콘출판사', '교보문고', '123-456-7890',07967,'서울특별시 양천구 국회대로 287 2층'),
('P022','다산지식하우스', '교보문고', '123-456-7890',07626,'서울특별시 강서구 공항대로8길 77-24'),
('P023','한빛미디어', '교보문고', '123-456-7890',04768,'서울특별시 성동구 서울숲4길 28');

insert into book_project.coden (c_name, c_code) values 
('IT', 'T'),
('인문', 'H'),
('사회', 'S'),
('여행', 'J'),
('자기계발', 'D');

INSERT INTO book_project.bookInfo(b_code,c_name,b_name,author,p_code,price,insert_date) values
('T001', 'IT','이것이자바다', '신용권', 'P001', 30000,'2016-01-01'),
('T002','IT', '자바+안드로이드를다루는기술', '정재곤', 'P002', 40000,'2016-01-10'),
('T003','IT', '인사이드자바스크립트','송형주','P023',18000,'2016-01-15'),
('T004','IT', '자바스크립트&제이쿼리','존두켓','P003',36000,'2016-01-20'),
('T005','IT', '퀄리티 코드', '스티븐 밴스', 'P021', 30000,'2016-01-31'),
('H001','인문', '어떻게죽음을마주할것인가','모니카렌츠','P004',13950,'2016-02-03'),
('H002','인문','공부할권리','정여울','P005',16500,'2016-02-10'),
('H003','인문','미움받을용기','기시미이치로','P006',14900,'2016-02-15'),
('H004','인문','나는생각이너무많아','크리스텔프리콜랭','P007',14800,'2016-02-20'),
('S001','사회','국가란무엇인가','유시민','P008',15000,'2016-02-28'),
('S002','사회','정의란무엇인가','마이클샌델','P009',15000,'2016-03-01'),
('S003','사회','한국사회어디로','김우창','P010',16000,'2016-03-01'),
('S004','사회','페페의희망교육','로베르트프란시스가르시아','P011',15000,'2016-03-05'),
('S005','사회','국가가 할 일은 무엇인가','이헌재,이원재','P020',12500,'2016-03-05'),
('S006','사회', '기록 너머에 사람이 있다 ', '안종오', 'P022', 13800,'2016-03-14'),
('J001','여행','여행이아니면알수없는것들','손미나','P012',15000,'2016-03-15'),
('J003','여행','런던여행백서','정꽃나래','P014',18000,'2016-03-17'),
('J002','여행','후쿠오카여행가는길','김남규','P015',14000,'2016-03-20'),
('D001','자기계발', '쓸모없는짓의행복', '크리스길아보', 'P016', 15000,'2016-03-22'),
('D002','자기계발', '버리고시작하라', '위르겐볼프', 'P017', 12000,'2016-04-03');
		

INSERT into book_project.bookLend (b_code, is_lending, b_lend_count) VALUES
('T001', true, 3),
('T002', true, 1),
('T003', true, 4),
('T004', true, 1),
('T005', true, 2),
('H001', true, 2),
('H002', true, 2),
('H003', true, 2),
('H004', true, 1),
('S001', true, 1),
('S002', true, 5),
('S003', true, 2),
('S004', true, 1),
('S005', true, 1),
('S006', true, 2),
('J001', false, 4),
('J002', true, 2),
('J003', true, 1),
('D001', true, 1),
('D002', true, 1);






INSERT INTO book_project.memberInfo (m_code, m_name, m_tel, m_zip_code, m_address, is_secsn, m_pass, is_manager) VALUES
('M001', '김유정', '010-1111-1234',04524,'서울특별시 중구 세종대로 110',false, '1234', false),
('M002', '박보영', '010-1234-2255',35242,'대전광역시 서구 둔산로 100',false, '4567', false), 
('M003', '박보영', '010-2222-4567',41911,'대구광역시 중구 공평로 88',false, '5864', false),
('M004', '전지현', '010-7777-2255',47545,'부산광역시 연제구 중앙대로 1001',false, 'aaba', true),
('M005', 'Emma Watson', '010-5555-4567',41908,'대구광역시 중구 국채보상로139길 1',false, 'bbbb', false),
('M006', '고수', '010-1234-1234',41185,'대구광역시 동구 아양로 207',true, '8888', false), -- 탈퇴상태
('M007', '박보검', '010-5432-1234',41777,'대구광역시 서구 국채보상로 257',false, '9595', true),
('M008', '박형식', '010-1234-9999',42429,'대구광역시 남구 이천로 51',false, '5555', false),
('M009', 'Dan Stevens', '010-9876-1200',41590,'대구광역시 북구 옥산로 65',false, '4444', false),
('M010', '원빈', '010-9876-5432',42424,'대구 남구 중앙대로 220 3층',false, '8811', false),
('M050', '원빈', '010-234-1234',42424,'대구 남구 중앙대로 220 3층',false, '8811', false);







INSERT INTO book_project.memberLend (m_code, is_posbl, delay_count, m_lend_count, m_now_count, black_date)VALUES
('M001', true, 0, 0, 2, null),
('M002', true, 1, 0, 2, null),
('M003', true, 0, 3, 1, null),		
('M004', true, 0, 1, 4, null),					-- 4권 빌린사람
('M005', false, 1, 2, 5, null),				-- 5권 빌린사람
('M006', false, 0, 1, 0, null),				-- 탈퇴회원
('M007', false, 1, 2, 1, null),				-- 책 연체 중인 사람(일반)
('M008', true, 2, 2, 2, null),					-- 곧 블랙.. 연체횟수 2번이나 연체중 아님
('M009', false, 2, 4, 2, null), 				-- 곧 블랙리스트 될 사람.. 연체횟수2번에 연체중인사람
('M010', false, 3, 5, 0, '2017-03-23'); 		-- 현재 블랙리스트
	


INSERT INTO book_project.paymentIO (no, b_code, m_code, lend_date, return_date) values
(1,'S002','M003','2017-01-20' , '2017-01-21'),
(2,'J002','M003','2017-01-22' , '2017-01-25'),
(3,'J001','M007','2017-01-23' , '2017-01-25'),
(4,'S002','M010','2017-01-23' , '2017-02-02'),	-- 연체도서
(5,'J001','M010','2017-01-25' , '2017-02-05'),	-- 연체도서
(6,'S002','M007','2017-01-31' , '2017-02-01'),
(7,'T003','M010','2017-02-07' , '2017-02-08'),
(8,'J001','M005','2017-02-10' , '2017-02-12'),
(9,'T003','M009','2017-02-18' , '2017-02-19'),
(10,'S002','M009','2017-02-19' , '2017-02-28'),	-- 연체도서
(11,'T003','M004','2017-02-23' , '2017-02-24'),
(12,'J001','M003','2017-02-28' , '2017-03-02'),
(13,'T005','M005','2017-03-04' , '2017-03-06'),
(14,'H002','M008','2017-03-05' , '2017-03-10'),	-- 연체도서
(15,'T001','M010','2017-03-05' , '2017-03-06'),
(16,'S006','M010','2017-03-08' , '2017-03-15'),  -- 연체도서
(17,'S003','M009','2017-03-08' , '2017-03-09'),
(18,'T001','M009','2017-03-09' , '2017-03-20'),	-- 연체도서
(19,'H003','M008','2017-03-15' , '2017-03-20'),	-- 연체도서
(20,'H001','M006','2017-03-19' , '2017-03-21'),
(21,'H002','M009','2017-03-20' , null), -- 연체중
(22,'T001','M001','2017-03-21' , null),
(23,'T003','M002','2017-03-21' , null),
(24,'T004','M002','2017-03-21' , null),
(25,'S004','M003','2017-03-21' , null),
(26,'J002','M004','2017-03-21' , null),
(27,'S001','M005','2017-03-22' , null),
(28,'S006','M005','2017-03-22' , null),
(29,'H001','M004','2017-03-22' , null),
(30,'D002','M004','2017-03-22' , null),
(31,'S005','M005','2017-03-22' , null),
(32,'T005','M005','2017-03-22' , null),
(33,'J003','M005','2017-03-22' , null),
(34,'S002','M007','2017-03-22' , null),
(35,'H004','M008','2017-03-23' , null),
(36,'S003','M008','2017-03-23' , null),
(37,'T002','M001','2017-03-23' , null),
(38,'D001','M004','2017-03-23' , null),
(39,'H003','M009','2017-03-23' , null);


-- -------------------------------------------

select b_code, count(*) from book_project.paymentio group by b_code;


-- <<대여관리>>
-- #제일 처음 창이 뜰 때  
-- 1. 대여가능 목록에 출력할 정보 [도서코드],[도서명],[저자],[출판사],[가격],[총대여횟수]
SELECT b.b_code, b_name, author, p.publisher, price, l.b_lend_count FROM book_project.bookInfo b 
inner join book_project.publisherInfo p on b.p_code = p.p_code 
inner join book_project.bookLend l on b.b_code = l.b_code 
where l.is_lending = false;

-- # 대여버튼 누르기
-- 1. 대여가능목록에서 도서 선택시 입력창에 정보 뿌리기
-- 1-1. 왼쪽 도서정보 뿌림 [도서코드],[도서명],[저자],[출판사],[가격],[총대여횟수]
SELECT b.b_code, b_name, author, p.publisher, price, bl.b_lend_count FROM book_project.bookInfo b 
inner join book_project.publisherInfo p on b.p_code = p.p_code 
inner join book_project.bookLend bl on b.b_code = bl.b_code 
where b.b_code= 'J001';

-- 2. 오른쪽에서 회원 검색 
-- 2-1. 대여 가능한 회원인가? -- 대여불가시 창을 띄워서 정보 띄우지 않음
select is_posbl from book_project.memberLend where m_code = 'M009'; -- 1/0 반환

-- 2-1-1. 대여불가 회원이라면 블랙리스트 해당인지 검색
select if(black_date is null, " ", black_date) from book_project.memberlend where m_code = 'M010'; -- 블랙 아닐시 " " 블랙일시 date 형식 반환
--        --블랙이라면 ( 해당시 대여 금지마지막일 출력)(~~까지 대여불가)메세지 jLabel로 출력해줄 것;
-- 2-1-2. 대여가능회원이라면  [회원코드], [성명],[전화번호] 출력;
select m_code, m_name, m_tel from book_project.memberInfo where m_code = 'M009';

-- 3. 대여버튼
-- 3-1. <<회원대여정보>>테이블에서 [총대여권수] +1, <<도서대여정보>>테이블에서 [총대여횟수] +1
UPDATE book_project.bookLend SET b_lend_count=(b_lend_count+1) WHERE b_code= 'T001';-- 3
UPDATE book_project.memberLend SET m_lend_count=(m_lend_count+1) WHERE m_code= 'M001';


select m_lend_count from book_project.memberLend where m_code = 'M001';
select b_lend_count, b_lend_count*2 from book_project.bookLend where b_code = 'T001'; -- 3 / 업데이트 제대로 되었는지 확인한 거

-- 3-2. <<출납>>테이블 [회원코드],[도서코드],[대여일자(컴퓨터 현재일자): CURRENT_DATE()? now()?],[반납일자(초기화 : null)]
INSERT INTO book_project.paymentIO (b_code, m_code, lend_date, return_date) values (_b_code,_m_code, CURRENT_DATE(), null);
INSERT INTO book_project.paymentIO (no, b_code, m_code, lend_date, return_date) values (100, 'T001','M001', CURRENT_DATE(), null);
select * from book_project.paymentIO;
delete from book_project.paymentIO where no=100;

-- 3-3. <<도서대여정보>>테이블에서 [대여여부] true 설정
UPDATE book_project.bookLend SET is_lending=true WHERE b_code='J001';

-- 3-4. [도서 대여 가능 목록]에 자료 출력 : 1번 다시 실행
SELECT b.b_code, b_name, author, p.publisher, price, l.b_lend_count FROM book_project.bookInfo b 
inner join book_project.publisherInfo p on b.p_code = p.p_code 
inner join book_project.bookLend l on b.b_code = l.b_code 
where l.is_lending = false;


-- ------------------------------------------------------------

-- <<회원 검색>>
-- 1. [[성명]]으로 <<회원>>테이블 검색 
-- 1-1. 이름으로 검색한 데이터가 중복인지 확인
select count(*) from book_project.memberInfo where m_name like '%보영%'; -- 1이 아니면 중복이 데이터가 존재하는 것
-- 1-2.[[성명]]으로 <<회원>>테이블 검색  : [성명], [회원코드], [전화번호], [우편번호], [주소], <<회원대여정보>>에서 [블랙리스트종료 날짜] 가져오기

select m.m_name, m.m_code, m_tel, m_zip_code, m_address, if(black_date is null," ",black_date) from book_project.memberInfo m
inner join book_project.memberlend ml on m.m_code = ml.m_code where m.m_name like '%보영%';
-- 1-3. 중복 발생시 해당 데이터 띄우고 선택하면 해당 [[회원코드]] 로 재검색
select m.m_name, m.m_code, m_tel, m_zip_code, m_address, if(black_date is null," ",black_date) from book_project.memberInfo m
inner join book_project.memberlend ml on m.m_code = ml.m_code where m.m_code = 'M003';

-- 2. [[전화번호]]로 검색
-- 2-1. 이름으로 검색한 데이터가 중복인지 확인
select count(*) from book_project.memberInfo where m_tel like '%1234%'; -- 1이 아니면 중복이 데이터가 존재하는 것
-- 2-2.  [[전화번호]]로 검색 : [성명], [회원코드], [전화번호], [우편번호], [주소], <<회원대여정보>>에서 [블랙리스트종료 날짜] 가져오기
select m.m_name, m.m_code, m_tel, m_zip_code, m_address, if(black_date is null," ",black_date) from book_project.memberInfo m
inner join book_project.memberLend ml on m.m_code = ml.m_code where m.m_tel like '%1234';
-- 2-3. 중복 발생시 해당 데이터 띄우고 선택하면 해당 [[회원코드]] 로 재 검색
select m.m_name, m.m_code, m_tel, m_zip_code, m_address, if(black_date is null," ",black_date) from book_project.memberInfo m
inner join book_project.memberInfo  ml on m.m_code = ml.m_code where m.m_code = 'M003';

-- 3. [[회원코드]] 로 검색
select m.m_name, m.m_code, m_tel, m_zip_code, m_address, if(black_date is null," ",black_date) from book_project.memberInfo m
inner join book_project.memberInfo ml on m.m_code = ml.m_code where m.m_code = 'M003';


-- 4. 하단에 띄울 ((대여정보)) [도서코드],[도서명],[대여일자],[반납일자],[연체여부(대여후 3일이후 부터: 10일 대여시 12일이 마감. 13일이 연체시작)]
-- 4-1. 미반납도서 (현재 날짜를 기준으로 계산) : 19개
-- select b.b_code, b_name, lend_date, return_date, if(DATEDIFF(CURRENT_DATE,lend_date)>2,'Y','N') is_delay from book_project.paymentIO p inner join book_project.bookInfo b on b.b_code = p.b_code where p.return_date is null;
-- 4-2. 반납도서 (return_date)를 기준으로 : 20개
-- select b.b_code, b_name, lend_date, return_date, if(DATEDIFF(return_date,lend_date) > 2,'Y','N') is_delay from book_project.paymentIO p inner join book_project.bookInfo b on b.b_code = p.b_code where p.return_date is not null;
-- 4-3. 위 두개 합쳐본 것 : 39개
select b.b_code, b_name, lend_date, return_date, 
if(return_date is null, if(DATEDIFF(CURRENT_DATE,lend_date)>2,'Y','N') , if(DATEDIFF(return_date,lend_date) > 2,'Y','N')) is_delay 
from book_project.paymentIO p
inner join book_project.bookInfo b on b.b_code = p.b_code;

-- 5. 최하단 총계 출력
-- 5-1. 반납된 도서 수
select count(*) from book_project.paymentIO 
where return_date is not null and m_code = 'M009'; -- 4
-- 5-1-1. 반납된 도서 중 연체된 도서 수
select count(*) from book_project.paymentIO 
where return_date is not null and (DATEDIFF(return_date,lend_date) >2 ) and  m_code = 'M009'; -- 2

-- 5-2. 대출중인 도서
select count(*) from book_project.paymentIO 
where return_date is null and m_code = 'M009' ; -- 2
-- 5-2-1. 대출 중인 도서 중 연체도서
select count(*) from book_project.paymentIO 
where return_date is null and (DATEDIFF(CURRENT_DATE,lend_date) >2 ) and  m_code = 'M009'; -- 1
-- 5-3. 총 이용한 도서
select count(*) from book_project.paymentIO where m_code = 'M009'; -- 6
-- 5-3-1. 총 이용도서 중 연체중인 도서 
select count(*) from book_project.paymentIO 
where if(return_date is null, (DATEDIFF(CURRENT_DATE,lend_date) >2), (DATEDIFF(return_date,lend_date) >2)) 
and m_code = 'M009'; -- 3
 	
-- -------------------------------------------------------

 	
 	
-- -----------------------
-- <<도서관리>> 
-- 1. 도서코드 자동세팅
-- 1-1. 선택된 분야의 코드를 가져온다
select c_code from coden where c_name = '여행';
-- 1-2. 해당 분야의 도서 권수 count
select count(*) from bookInfo where b_code like 'J___';

-- --------------------------------
-- <<도서현황>>
-- 1. 도서현황 
-- 1-1. 총 보유 권수 
select count(*) from book_project.bookInfo;
-- 1-2. 총 연체 권수 : 반납된 예전 기록 말고 **현재시점**에서 반납되지 않고 연체중인 권수
select count(*) from book_project.bookInfo b
inner join book_project.paymentIO p on b.b_code = p.b_code
where return_date is null and (DATEDIFF(CURRENT_DATE,lend_date) >= 3);
-- 1-3. 총 대여횟수 : 예전 기록 말고 **현재시점**에서 대여상태인 권수
select count(*) from book_project.bookInfo b
inner join book_project.paymentIO p on b.b_code = p.b_code
where return_date is null;

-- 2. 분야별 보유 권수
select count(*) from book_project.coden; -- 분야는 5개
select count(*) from book_project.bookinfo where c_name like (select )


-- 베스트 지수 랭킹 1~3위
select (select (count(*)+1) from book_project.bookLend 
where b_lend_count > bl.b_lend_count ) book_rank, b.b_name, b.author 
from book_project.bookLend bl 
inner join book_project.bookInfo b on b.b_code = bl.b_code
order by book_rank asc, insert_date desc limit 0, 3; 


-- 동순위 여러개시 문제
create view book_project.view_rn as

select b_code, count(*) co from book_project.paymentio group by b_code order by co desc;
select b_code , b_lend_count from book_project.booklend order by b_lend_count desc;


UPDATE book_project.bookLend SET b_lend_count = 1 WHERE b_code='S005';  -- 원래 1


select (select (count(*)+1) from book_project.bookLend 
where b_lend_count > bl.b_lend_count ) book_rank, b.b_name, b.author 
from book_project.bookLend bl 
inner join book_project.bookInfo b on b.b_code = bl.b_code
order by book_rank asc, insert_date desc 
limit 0, 3; -- 동순위 여러개시 문제

select * from book_project.view_rn where book_rank < 6;
             


-- 월별 베스트 지수
select (select (count(*)+1) from bookLend 
where b_lend_count > bl.b_lend_count ) book_rank, b.b_name, b.author 
from bookLend bl 
inner join bookInfo b on b.b_code = bl.b_code
order by book_rank limit 0, 3;








-- ---------------------------------------

delimiter $$
create procedure book_pjt.proc_paymentIO_insert(
	in _b_code char(4),
	in _m_code char(4)
)
begin 
	
	declare err int default 0;
	declare continue handler for sqlexception set err - -1;
	
	start transaction;
	UPDATE bookLend SET  b_lend_count=(b_lend_count+1) WHERE b_code=_b_code;
	UPDATE memberLend SET  m_lend_count=(m_lend_count+1) WHERE m_code=_m_code;

	INSERT INTO paymentIO (b_code, m_code, lend_date, return_date) VALUES(_b_code,_m_code, now(), null);
	UPDATE bookLend SET is_posbl=false  WHERE b_code= _b_code;
	
	
	if err < 0 then
		rollback;
	else
		commit;
	end if;
	
end $$
delimiter ;



delimiter $$
create procedure book_pjt.proc_paymentIO_update(
	in _b_code char(4),
	in _m_code char(4)
)
begin	
	
	declare err int default 0;
	declare continue handler for sqlexception set err - -1;
	
	start transaction;

	UPDATE paymentIO SET return_date = now() where no = (
		select * from(select no from paymentIO where b_code = _b_code and m_code= _m_code and return_date is null) as b);
	UPDATE bookInfo SET is_posbl=true WHERE b_code= _b_code;
	
	if err < 0 then
		rollback;
	else
		commit;
	end if;
	
end $$
delimiter ;

create trigger tri_paymentIO_after_insert
after insert on paymentIO
for each row
begin 
	
	set @due_date = new.lend_date;
	
	UPDATE paymentIO SET due_date = ADDDATE(@due_date, interval 3 day) where no=new.no; 
	
end;

call book_pjt.proc_booksinout_insert('B001', 'M001');
call book_pjt.proc_booksinout_insert('B002', 'M002');
call book_pjt.proc_booksinout_insert('B003', 'M003');

call book_pjt.proc_booksinout_update('B002', 'M002');