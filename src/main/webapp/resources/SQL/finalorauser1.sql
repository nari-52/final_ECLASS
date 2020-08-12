
    show user;
    -- USER이(가) "FINALORAUSER1"입니다.
    
    drop table login_table;
    drop table subject_tbl;
    drop table lecture_tbl;
    drop table lectureComment_tbl;
    drop table myPForS_tbl;
    drop table myPForP_tbl;
    drop table attand_tbl;
    drop table exam;
    drop table examQuestion;
    drop table notice_board;
    drop table free_board;
    drop table free_board_comment;
    drop table question_board;
    drop table donStory;
    drop table donImg;
    drop table donPayment;
    drop table eclass_member;
    
    -- 회원정보 테이블
    create table eclass_member
    ( userid                    varchar2(50)   not null     -- 아이디
    , name                      varchar2(30)   not null     -- 성명
    , pwd                       varchar2(200)   not null    -- 비밀번호 (SHA-256 암호화 대상)
    , identity                  number(1) default 1         -- 회원 구분 (학생 1, 교수 2, 관리자 3)
    , university                varchar2(100)   not null    -- 대학명
    , major                     varchar2(100)   not null    -- 학과명
    , student_num               varchar2(100)               -- 학번 (학생만 not null)
    , email                     varchar2(300)   not null    -- 이메일 (AES-256 암호화/복호화 대상)
    , mobile                    varchar2(200)     not null    -- 핸드폰
    , postcode                  varchar2(5)                 -- 우편번호
    , address                   varchar2(200)               -- 주소
    , detailaddress             varchar2(200)               -- 상세주소
    , extraaddress              varchar2(200)               -- 참고항목
    , point                     number default 0            -- 포인트
    , registerday               date default sysdate        -- 가입일자
    , status                    number(1) default 1         -- 회원상태   1:사용가능(가입중) / 0:사용불능(탈퇴)
    , last_login_date           date default sysdate        -- 마지막 로그인 날짜
    , pwd_change_date           varchar2(255)               -- 파일이름(WAS 저장용)
    , orgfilename               varchar2(255)               -- 파일이름 (진짜이름)
    , constraint PK_eclass_member_userid primary key (userid)
    , constraint CK_eclass_member_status check(status in(0,1))
    );
    
    alter table eclass_member add (filename varchar2(255));
    alter table eclass_member modify (pwd_change_date date default sysdate);
    commit;
    
    -- 임시 회원 추가
    insert into eclass_member(userid,name,pwd,identity,university,major,student_num,email,mobile,postcode,address,detailaddress,extraaddress,point,registerday,status,last_login_date)
    values('admin','관리자','qwer1234$',3,'서울대','서울과','20200804','admin@gmail.com','01012345678','12345','서울시 종로구','123-567','종로동',default,sysdate,default,sysdate);
    
    insert into eclass_member(userid,name,pwd,identity,university,major,student_num,email,mobile,postcode,address,detailaddress,extraaddress,point,registerday,status,last_login_date)
    values('admin1','관리자1','qwer1234$',3,'서울대','서울과','20200804','admin@gmail.com','01012345678','12345','서울시 종로구','123-567','종로동',default,sysdate,default,sysdate);
    
    
    select userid, name
    from eclass_member
    where userid = 'admin' and
          pwd = 'qwer1234$'
    
    
    select *
    from eclass_member;
    
    
    
    
    -- 로그인 테이블
    create table login_table
    ( fk_userid                 varchar2(50)   not null     -- 아이디
    , name                      varchar2(30)   not null     -- 성명
    , identity                  number(1) default 1         -- 회원 구분 (학생 1, 교수 2, 관리자 3)
    , constraint FK_login_table_fk_userid foreign key (fk_userid)
                                          references eclass_member (userid)
    );
    
    select *
    from login_table;
        
     -- 교과목 테이블
    create table subject_tbl
    (subseq number not null  -- 교과목 번호-시퀀스
    ,fk_userid  varchar2(50) not null -- 아이디
    ,status number(1) default 1 -- 이수구분(전공,교양,일반)
    ,subName varchar2(500) not null -- 교과목명
    ,subContent varchar2(2000)  -- 교과목소개
    ,subImg varchar2(200) -- 교과목대표이미지
    ,writeday date default sysdate -- 교과목 등록일
    ,constraint PK_subject_tbl_subseq PRIMARY KEY (subseq)
    ,constraint FK_subject_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    ,constraint CK_subject_tbl check (status in(1,2,3))
    );
    
    create sequence seq_subseq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 강의 테이블
    create table lecture_tbl
    (lecSeq number not null -- 강의차수 - 시퀀스
    ,fk_subSeq number not null -- 교과목번호 - 시퀀스
    ,lecLink varchar2(1000) -- 강의영상
    ,lecStartday date  --강의 시작일자
    ,lecEndday date  -- 강의 마감일자
    ,constraint PK_lecture_tbl_lecSeq PRIMARY KEY (lecSeq)
    ,constraint FK_lecture_tbl_subSeq foreign key(fk_subSeq) references subject_tbl(subseq)
    );
    
    alter table lecture_tbl add (lecTitle varchar2(50) not null);
    commit;
    
    create sequence seq_lecSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 강의 댓글 테이블(출석)
    create table lectureComment_tbl
    (lecComSeq number not null  -- 강의댓글번호 - 시퀀스
    ,fk_lecSeq number not null -- 강의차수시퀀스
    ,fk_userid varchar2(50) not null -- 아이디
    ,comContent varchar2(2000) not null -- 댓글 내용
    ,writeday date default sysdate -- 작성일자
    ,constraint PK_lectureComment_tbl PRIMARY KEY (lecComSeq)
    ,constraint FK_lectureComment_tbl_lecSeq foreign key(fk_lecSeq) references lecture_tbl(lecSeq)
    ,constraint FK_lectureComment_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    );
    
    create sequence seq_lecComSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 출석테이블
    create table attand_tbl
    (attandSeq number not null -- 출석시퀀스
    ,fk_subSeq number not null -- 교과목번호 시퀀스
    ,fk_lecSeq number not null -- 강의차수 시퀀스
    ,fk_userid varchar2(50) not null -- 아이디
    ,data date default sysdate -- 출석날짜
    ,constraint PK_attand_tbl_attandSeq PRIMARY KEY (attandSeq)
    ,constraint FK_attand_tbl_subSeq foreign key(fk_subSeq) references subject_tbl(subSeq)
    ,constraint FK_attand_tbl_lecSeq foreign key(fk_lecSeq) references lecture_tbl(lecSeq)
    ,constraint FK_attand_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    );
    
    create sequence seq_attandSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 교수 강의실 (마이페이지)
    create table myPForP_tbl
    (myPSeq number not null -- 교수강의실시퀀스
    ,fk_userid varchar2(50) not null -- 아이디
    ,university varchar2(100) not null -- 대학명
    ,subject varchar2(500)  -- 교과목
    ,major varchar2(100) -- 학과명
    ,constraint PK_myPForP_tbl_myPSeq PRIMARY KEY (myPSeq)
    ,constraint FK_myPForP_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    ,constraint UK_myPForP_tbl_university unique(university)
    );
    
    create sequence seq_myPSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 학생 강의실 (마이페이지)
    create table myPForS_tbl
    (mySSeq  number not null -- 학생강의실 시퀀스
    ,fk_subSeq number not null -- 교과목번호 시퀀스
    ,fk_userid varchar2(50) not null -- 아이디
    ,finalG varchar2(2) default 'F'  -- 최종성적
    ,examG number default 0 -- 시험점수
    ,attandG number default 0 -- 출석점수
    ,constraint PK_myPForS_tbl_mySSeq PRIMARY KEY (mySSeq)
    ,constraint FK_myPForS_tbl_subseq foreign key(fk_subSeq) references subject_tbl(subseq)
    ,constraint FK_myPForS_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    );
    
    create sequence seq_mySSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    ---------------------------- [[ 시험 테이블 ]] ----------------------------
    create table exam    -- 시험 테이블
    (exam_seq number     -- 시험 번호
    ,subSeq number       -- 교과목 번호
    ,userid varchar2(50) -- 아이디(교수아이디)
    ,examTitle varchar2(100) -- 시험 제목
    ,examDate date -- 시험 볼 날짜
    ,constraint PK_exam_exam_seq primary key(exam_seq)
    ,constraint FK_exam_subSeq foreign key(subSeq)
                               references subject_tbl(subSeq)
    );
    
    create sequence seq_exam_seq
    start with 1
    increment by 1
    nomaxvalue 
    nominvalue
    nocycle
    nocache;
    
    
    ---------------------------- [[ 시험 문제 테이블 ]] ----------------------------
    create table examQuestion -- 시험 문제 테이블
    (question_seq number -- 시험문제번호
    ,exam_seq number     -- 시험 번호
    ,question varchar2(100) -- 시험 문제
    ,answer varchar2(10) -- 시험 정답
    ,constraint PK_question_seq primary key(question_seq)
    ,constraint FK_exam_exam_seq foreign key(exam_seq)
                               references exam(exam_seq)
    );
    
    create sequence seq_question_seq
    start with 1
    increment by 1
    nomaxvalue 
    nominvalue
    nocycle
    nocache;
    
    
    -- 공지사항 게시판 테이블
    create table notice_board
    (notice_seq     number                not null   -- 글번호
    ,title          Nvarchar2(200)        not null   -- 글제목
    ,content        Nvarchar2(2000)       not null   -- 글내용
    ,viewcount      number default 0      not null   -- 조회수
    ,writedate      date default sysdate  not null   -- 작성일자
    ,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글
    ,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
    ,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
    ,constraint  PK_notice_board_seq primary key(notice_seq)
    ,constraint  CK_tblBoard_status check( status in(0,1) )
    );
    
    -- 공지사항 게시판 시퀀스
    create sequence notice_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 자유게시판 테이블
    create table free_board
    (free_seq            number                not null   -- 글번호
    ,fk_userid      varchar2(50)          not null   -- 사용자ID
    ,name           VARCHAR2(30)         not null   -- 글쓴이
    ,title        Nvarchar2(200)        not null   -- 글제목
    ,content        Nvarchar2(2000)       not null   -- 글내용
    ,password           varchar2(20)          not null   -- 글암호
    ,viewcount      number default 0      not null   -- 글조회수
    ,writedate        date default sysdate  not null   -- 글쓴시간
    ,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글
    ,commentCount   number default 0      not null   -- 댓글의 갯수
    ,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
    ,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
    ,constraint  PK_free_board_seq primary key(free_seq)
    ,constraint  FK_free_board_userid foreign key(fk_userid) references eclass_member(userid)
    ,constraint  CK_free_board_status check( status in(0,1) )
    );
    
    alter table free_board drop COLUMN commentCount;
    alter table question_board add (commentCount number default 0);
    commit;
        
    -- 자유게시판 시퀀스
    create sequence free_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- 자유게시판 댓글테이블
    create table free_board_comment
    (comment_seq   number               not null   -- 댓글번호
    ,parentSeq     number               not null   -- 원게시물 글번호
    ,fk_userid     varchar2(50)         not null   -- 사용자ID
    ,name          varchar2(50)         not null   -- 성명
    ,content       varchar2(1000)       not null   -- 댓글내용
    ,writedate     date default sysdate not null   -- 작성일자
    ,status        number(1) default 1  not null   -- 글삭제여부
                                                   -- 1 : 사용가능한 글,  0 : 삭제된 글
                                                   -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
    ,constraint PK_free_board_comment_seq primary key(comment_seq)
    ,constraint FK_free_board_comment_userid foreign key(fk_userid)
                                        references eclass_member(userid)
    ,constraint FK_free_board_comment_Seq foreign key(parentSeq)
                                          references free_board(free_seq) on delete cascade
    ,constraint CK_free_board_comment_status check( status in(1,0) )
    );
    
    -- 자유게시판 댓글 시퀀스
    create sequence comment_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    -- Q&A 게시판 테이블
    create table question_board
    (question_seq            number                not null   -- 글번호
    ,fk_userid      varchar2(50)          not null   -- 사용자ID
    ,name           VARCHAR2(30)         not null   -- 글쓴이
    ,title          Nvarchar2(200)        not null   -- 글제목
    ,content        Nvarchar2(2000)       not null   -- 글내용
    ,password       varchar2(20)          not null   -- 글암호
    ,viewcount      number default 0      not null   -- 글조회수
    ,writedate      date default sysdate  not null   -- 글쓴시간
    ,status         number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글
    ,groupno        number                not null   -- 답변글쓰기에 있어서 그룹번호
                                                     -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                                     -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
    ,fk_seq         number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
                                                     -- fk_seq 컬럼은 자신의 글(답변글)에 있어서
                                                     -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                     -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은
                                                     -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                     -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
    ,depthno        number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면
                                                     -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                     -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
    ,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
    ,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
    ,secret      number(1) default 0   not null
    ,constraint  PK_question_board primary key(question_seq)
    ,constraint  FK_question_board foreign key(fk_userid) references eclass_member(userid)
    ,constraint  CK_question_board check( status in(0,1) )
    );
    
    -- Q&A게시판 시퀀스
    create sequence question_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    ---------------------------- [[ 후원하기 테이블 ]] ----------------------------
    --후원하기 스토리, 후원테이블 
    create table donStory
    (donseq         number                not null    -- 글번호(시퀀스)
    ,subject        Nvarchar2(200)        not null    -- 후원제목
    ,content        Nvarchar2(2000)       not null    -- 후원내용   -- clob (최대 4GB까지 허용) 
    ,listMainImg    varchar2(100)         not null    -- 리스트 메인이미지  
    ,storyImg       varchar2(100)         not null    -- 상세 메인이미지  
    ,donCnt         number default 0      not null    -- 글 조회수 
    ,donDate        date default sysdate  not null    -- 후원 등록일자
    ,donDueDate     date                  not null    -- 후원 종료일자 
    ,donStatus      number default 1      not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글 
    ,targetAmount   number -- 목표금액   
    ,totalPayment   number -- 후원총액
    ,totalSupporter number -- 후원총인원
    ,constraint PK_donStory_seq primary key(donseq)
    ,constraint CK_donSotry_status check( donStatus in(0,1) )
    );
    
    
    create sequence donStorySeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    --후원하기 상세이미지 테이블 (donImg table)
    create table donImg
    (donImgseq  number                not null    -- 후원이미지 번호
    ,fk_donSeq  number                not null    -- 후원 글번호 
    ,donImg     varchar2(200)         not null    -- 후원 이미지
    ,constraint PK_donImg_seq primary key(donImgseq)
    ,constraint FK_donImg_fk_donSeq foreign key(fk_donSeq) references donStory(donseq)
    );
    
    create sequence donImgSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    
    --후원결제 테이블 
    create table donPayment
    (fk_donSeq      number               not null  -- 글번호(FK_시퀀스)
    ,fk_userid      varchar2(50)         not null  -- 회원아이디(FK_아이디)
    ,name           varchar2(30)         not null  -- 회원명
    ,noName         number(1) default 0            -- 이름 비공개(Flag)
    ,noDonpmt       number(1) default 0            -- 금액 비공개(Flag)
    ,paymentDate    date default sysdate not null  -- 결제날짜 
    ,payment        number               not null  -- 결제금액 
    ,constraint FK_donPayment_fk_donSeq foreign key(fk_donSeq) references donStory(donseq)
    ,constraint FK_donPayment_fk_member_num foreign key(fk_userid) references eclass_member(userid)
    ,constraint CK_donPayment_status check( noName in(0,1) )
    ,constraint CK_noDonpmt_status check( noDonpmt in(0,1) )
    );
    
    alter table donPayment add (point number default 0);
    commit;
    
    --------------------------------------테이블 끝-----------------------------------------------
    


