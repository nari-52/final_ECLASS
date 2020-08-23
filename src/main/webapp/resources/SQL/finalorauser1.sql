
    show user;
    -- USER이(가) "FINALORAUSER1"입니다.
    
    -- 테이블 지우기
    drop table lectureComment_tbl;
    drop table lecture_tbl;

    drop table myPForS_tbl;
    drop table myPForP_tbl;
    drop table attand_tbl;

    drop table examQuestion;
    drop table exam;

    drop table notice_board;
    drop table free_board_comment;
    drop table free_board;
    drop table question_board;
    drop table donStory;
    drop table donImg;
    drop table donPayment;

    drop table login_table;
    drop table subject_tbl;
    drop table eclass_member;
    

    -- 시퀀스 지우기    
    drop sequence seq_subseq;
    drop sequence seq_lecSeq;
    drop sequence seq_lecComSeq;
    drop sequence seq_attandSeq;
    drop sequence seq_myPSeq;
    drop sequence seq_mySSeq;
    drop sequence seq_exam_seq;
    drop sequence seq_question_seq;
    drop sequence notice_seq;
    drop sequence free_seq;
    drop sequence comment_seq;
    drop sequence question_seq;
    drop sequence donStorySeq;
    drop sequence donImgSeq;
    
    commit;
    
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
    , mobile                    varchar2(200)   not null    -- 핸드폰
    , postcode                  varchar2(5)                 -- 우편번호
    , address                   varchar2(200)               -- 주소
    , detailaddress             varchar2(200)               -- 상세주소
    , extraaddress              varchar2(200)               -- 참고항목
    , point                     number default 0            -- 포인트
    , registerday               date default sysdate        -- 가입일자
    , status                    number(1) default 1         -- 회원상태   1:사용가능(가입중) / 0:사용불능(탈퇴)
    , last_login_date           date default sysdate        -- 마지막 로그인 날짜
    , pwd_change_date           date default sysdate        -- 암호 바꾼 날짜
    , filename                  varchar2(255)               -- 파일이름
    , orgfilename               varchar2(255)               -- 파일이름 (진짜이름)
    , constraint PK_eclass_member_userid primary key (userid)
    , constraint CK_eclass_member_status check(status in(0,1))
    );
    
    -- 로그인 테이블
    create table login_table
    ( fk_userid                 varchar2(50)   not null     -- 아이디
    , name                      varchar2(30)   not null     -- 성명
    , identity                  number(1) default 1         -- 회원 구분 (학생 1, 교수 2, 관리자 3)
    , constraint FK_login_table_fk_userid foreign key (fk_userid)
                                          references eclass_member (userid)
    );

    
    select *
    from eclass_member
    
     -- 교과목 테이블
    create table subject_tbl
    (subseq number not null  -- 교과목 번호-시퀀스
    ,fk_userid  varchar2(50) not null -- 아이디
    ,status number(1) default 1 -- 이수구분(전공,교양,일반)
    ,subName varchar2(500) not null -- 교과목명
    ,subContent varchar2(2000)  -- 교과목소개
    ,subImg varchar2(200) -- 파일이름
    ,saveSubImg varchar2(800) -- 파일이름(WAS에 저장될 이름)
    ,writeday date default sysdate -- 교과목 등록일
    ,constraint PK_subject_tbl_subseq PRIMARY KEY (subseq)
    ,constraint FK_subject_tbl_userid foreign key(fk_userid) references eclass_member(userid) on delete cascade
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
    (lecSeq number not null -- 강의글시퀀스
    ,lecNum number not null -- 해당 과목의 강의 차수
    ,fk_subSeq number not null -- 교과목번호 - 시퀀스
    ,lecLink varchar2(1000) -- 강의영상
    ,lecTitle varchar2(50) not null
    ,lecStartday date  --강의 시작일자
    ,lecEndday date  -- 강의 마감일자
    ,constraint PK_lecture_tbl_lecSeq PRIMARY KEY (lecSeq)
    ,constraint FK_lecture_tbl_subSeq foreign key(fk_subSeq) references subject_tbl(subseq) on delete cascade
    );
        
    create sequence seq_lecSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
        
    -- 강의 댓글 테이블
    create table lectureComment_tbl
    (lecComSeq number not null  -- 강의댓글번호 - 시퀀스
    ,fk_subSeq number not null -- 교과목번호 - 시퀀스
    ,fk_lecSeq number not null -- 강의글시퀀스
    ,fk_userid varchar2(50) not null -- 아이디
    ,comContent varchar2(2000) not null -- 댓글 내용
    ,writeday date default sysdate -- 작성일자
    ,constraint PK_lectureComment_tbl PRIMARY KEY (lecComSeq)
    ,constraint FK_lectureComment_tbl_subSeq foreign key(fk_subSeq) references subject_tbl(subseq)
    ,constraint FK_lectureComment_tbl_lecSeq foreign key(fk_lecSeq) references lecture_tbl(lecSeq) on delete cascade
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
    ,lecNum number not null -- 강의차수번호
    ,fk_userid varchar2(50) not null -- 아이디
    ,attand varchar2(2) default 'X' -- 출석여부
    ,data date default sysdate -- 출석날짜
    ,constraint PK_attand_tbl_attandSeq PRIMARY KEY (attandSeq)
    ,constraint FK_attand_tbl_subSeq foreign key(fk_subSeq) references subject_tbl(subSeq) on delete cascade
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
    ,subject varchar2(500)  -- 교과목
    ,major varchar2(100) -- 학과명
    ,constraint PK_myPForP_tbl_myPSeq PRIMARY KEY (myPSeq)
    ,constraint FK_myPForP_tbl_userid foreign key(fk_userid) references eclass_member(userid)
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
    ,finalG varchar2(2) default '-'  -- 최종성적
    ,examG number default -1 -- 시험점수
    ,attandG number default 0 -- 출석점수
    ,constraint PK_myPForS_tbl_mySSeq PRIMARY KEY (mySSeq)
    ,constraint FK_myPForS_tbl_subseq foreign key(fk_subSeq) references subject_tbl(subseq) on delete cascade
    ,constraint FK_myPForS_tbl_userid foreign key(fk_userid) references eclass_member(userid)
    );
    
   alter table myPForS_tbl drop constraint PK_myPForS_tbl_fk_subSeq;
   -- 아래 아직 수정은 안함.. (건형)
   alter table myPForS_tbl
      add constraint UK_myPForS_tbl unique(fk_subSeq, fk_userid);
   
   
   commit;
   
   select *
   from myPForS_tbl
   where fk_userid='eomjh'
    
    create sequence seq_mySSeq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    -- 시험 테이블
    create table exam    -- 시험 테이블
    (exam_seq number     -- 시험 번호
    ,subSeq number       -- 교과목 번호
    ,userid varchar2(50) -- 아이디(교수아이디)
    ,examTitle varchar2(100) -- 시험 제목
    ,examDate date -- 시험 볼 날짜
    ,constraint PK_exam_exam_seq primary key(exam_seq)
    ,constraint FK_exam_subSeq foreign key(subSeq)
                               references subject_tbl(subSeq) on delete cascade
    );
    
    create sequence seq_exam_seq
    start with 1
    increment by 1
    nomaxvalue 
    nominvalue
    nocycle
    nocache;
    
    -- 시험 문제 테이블
    create table examQuestion -- 시험 문제 테이블
    (question_seq number -- 시험문제번호
    ,exam_seq number     -- 시험 번호
    ,question varchar2(100) -- 시험 문제
    ,answer varchar2(10) -- 시험 정답
    ,constraint PK_question_seq primary key(question_seq)
    ,constraint FK_exam_exam_seq foreign key(exam_seq)
                               references exam(exam_seq) on delete cascade
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
    ,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
    ,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
    ,constraint  PK_free_board_seq primary key(free_seq)
    ,constraint  FK_free_board_userid foreign key(fk_userid) references eclass_member(userid)
    ,constraint  CK_free_board_status check( status in(0,1) )
    );
        
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
    ,secret         number(1) default 0   not null
    ,commentCount   number default 0
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
    
    drop table donStory;
    drop table donImg;
    drop table donPayment;
    drop sequence donStorySeq;
    drop sequence donImgSeq;
    
    ---------------------------- [[ 후원하기 테이블 ]] ----------------------------
    create table donStory
    (donseq         number                not null    -- 글번호(시퀀스)
    ,subject        Nvarchar2(200)        not null    -- 후원제목
    ,content        Nvarchar2(2000)       not null    -- 후원내용   -- clob (최대 4GB까지 허용) 
    ,listMainImg    varchar2(100)                     -- 리스트 메인이미지  -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png) -->saveSubImg 
    ,storyImg       varchar2(100)                     -- 상세 메인이미지   -- WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
    ,donCnt         number default 0      not null    -- 글 조회수 
    ,donDate        date default sysdate  not null    -- 후원 등록일자 --,to_date('2020-07-23 10:00:00' , 'yyyy-mm-dd hh24:mi:ss')
    ,donDueDate     date                  not null    -- 후원 종료일자 
    ,donStatus      number default 1      not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글 
    ,targetAmount   number default 0                  -- 목표금액   
    ,totalPayment   number default 0                  -- 후원총액
    ,totalSupporter number default 0                  -- 후원총인원
    ,orgListMainImg varchar2(100)                     -- 진짜 파일명(강아지.png) //리스트 메인이미지 -->SubImg 
    ,orgStoryImg    varchar2(100)                     -- 진짜 파일명(강아지.png) //상세 메인이미지
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
    ,point          number default 0               -- 포인트 사용액             
    ,constraint FK_donPayment_fk_donSeq foreign key(fk_donSeq) references donStory(donseq)
    ,constraint FK_donPayment_fk_member_num foreign key(fk_userid) references eclass_member(userid)
    ,constraint CK_donPayment_status check( noName in(0,1) )
    ,constraint CK_noDonpmt_status check( noDonpmt in(0,1) )
    );
    
    select *
    from donStory;
    
    -- 최종 넣는 인서트     
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '지온이가 환하게 웃을 수 있도록..', '<h3>폭력과 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg04.jpg', 'storyImg04.jpg', default, default, to_date('2020-10-10 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
   
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 1 ,'donStoDe401.jpg');
    
    --후원 종료용
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '인도 아이들에게 새로운 꿈을..!', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg02.png', 'storyImg02.png', default, to_date('2020-08-19 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-08-19 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1200000,240000,16);
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 2 ,'donStoDe201.jpg');
    
    
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '아프리카에 일어나는 흔한 일은..', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg03.jpg', 'storyImg03.jpg', default, to_date('2020-07-25 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-07-25 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1000000,650000,30);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval,3 ,'schoolme.jpg');
    
    
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '고아원 아이들을 위한 교육후원', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg01.png', 'storyImg01.png', default, to_date('2020-08-19 21:00:00' , 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-08-19 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1000000,245000,18);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 4 ,'donStoDe202.jpg');
    
    
    -- 다시 정상 남은기간 인서트 (지온- 코로나19 - 인도 - 아프리카 - 고아원 -아프리카)
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '코로나19, 아이들을 구해주세요!', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg05.jpg', 'storyImg05.jpg', default, default, to_date('2020-10-01 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 5 ,'donStoDe503.jpg');
    
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '인도 아이들에게 새로운 꿈을..!', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록...</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg02.png', 'storyImg02.png', default, default, to_date('2020-09-29 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
   
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 6 ,'donStoDe201.jpg');
               
 
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '아프리카에 일어나는 흔한 일은..', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg03.jpg', 'storyImg03.jpg', default,default, to_date('2020-09-27 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1000000,650000,30);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 7 ,'schoolme.jpg');
  
  
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '고아원 아이들을 위한 교육후원', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg01.png', 'storyImg01.png', default, default, to_date('2020-09-09 21:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1000000,245000,18);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 8 ,'donStoDe202.jpg');
  
   
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '아프리카에 일어나는 흔한 일은..', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg03.jpg', 'storyImg03.jpg', default, default, to_date('2020-09-02 20:00:00' , 'yyyy-mm-dd hh24:mi:ss'), default,1000000,650000,30);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 9 ,'schoolme.jpg');
  
  
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '지온이가 환하게 웃을 수 있도록..', '<h3>폭력과 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg04.jpg', 'storyImg04.jpg', default, default, to_date('2020-08-30 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
   
   insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 10 ,'donStoDe401.jpg');
  
   insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
   values(donStorySeq.nextval, '코로나19, 아이들을 구해주세요!', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록 도와주세요.</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg05.jpg', 'storyImg05.jpg', default, default, to_date('2020-08-29 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 11 ,'donStoDe503.jpg');
    
    insert into donStory(donseq, subject, content, orgListMainImg, orgStoryImg, donCnt, donDate, donDueDate, donStatus, targetAmount,totalPayment,totalSupporter)
    values(donStorySeq.nextval, '인도 아이들에게 새로운 꿈을..!', '<h3>모든 아동이 폭력과 학대, 방임, 착취로부터 보호받고 안전한 환경에서 성장하도록...</h3> 후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
               후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
               언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
               친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
               희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
               해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
               시키는데 중요한 역할을 합니다.<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.
                
               <h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
               아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
               급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
               잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
               다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
               부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br />', 'donMainImg02.png', 'storyImg02.png', default, default, to_date('2020-08-25 15:00:00' , 'yyyy-mm-dd hh24:mi:ss'),default,1500000,127000,22);
   
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donImgSeq.nextval, 12 ,'donStoDe201.jpg');
  
  
   commit;
   --------------------------------------------------------------------------------------------------------- 
   
   select *
   from subject_tbl
   -- >> 회원 대량가입
   
   update eclass_member set status = '0'
   where userid = 'kimhs98'
   
    create or replace procedure eclass_member_insert2
    (p_userid  IN  varchar2
    ,p_name    IN  varchar2)
    is
    begin
        for i in 1..100 loop 
            insert into eclass_member(userid,name,pwd,identity,university,major,email,mobile,postcode,address,detailaddress,extraaddress,point,registerday,status,last_login_date, pwd_change_date) 
            values(p_userid||i, p_name||i, 'qwer1234$', '2' , '연세대학교', '전자공학과', 'parkgs@gmail.com', '01012341234', '06097', '오금동 현대아파트','101동 706호', '(삼성동)', '0', sysdate, default, sysdate, sysdate);         
        end loop;
    end eclass_member_insert2;   
    -- Procedure PCD_SHOPPING_MEMBER_INSERT이(가) 컴파일되었습니다.  
    
    exec eclass_member_insert('kimhs','김학생','20203040');
    
    exec eclass_member_insert1('leehs','이학생','20193040');
    exec eclass_member_insert2('parkgs','박교수');
    commit;
   
   select attandG
		from myPForS_tbl
        where fk_userid = 'kimhs1'
   
    -->> 회원가입 insert
   insert into eclass_member(userid, name, pwd, identity, university, major, email, mobile, point)
   values ('admin', '관리자', 'qwer1234$', 3, '서울대', '수학과', 'admin@eclass.ac.kr', '01000000000', 99999);
    
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('Grace', '김은혜', 'asdf1234!', '서울대', '수학과', 'milkim0907@gmail.com', '010-1234-5678', 1000);
    
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('kh123', '김건형', 'asdf1234!', '서울대', '심리학과', 'k2001mik@gmail.com', '010-2083-8287', 2000);
   
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('hymnin', '강현민', 'asdf1234!', '서울대', '철학과', 'hymnin@gmail.com', '010-2083-8387', 5000);
   
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('moonsa', '문상아', 'asdf1234!', '서울대', '음악학과', 'moonsa@gmail.com', '010-2222-4287', 2000);
   
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('nari8282', '김나리', 'asdf1234!', '서울대', '도덕학과', 'nari8282@gmail.com', '010-4020-8282', 1000);
    
   insert into eclass_member(userid, name, pwd, university, major, email, mobile, point)
   values ('ej123', '김언지', 'asdf1234!', '서울대', '게임학과', 'ej@gmail.com', '010-8949-8282', 1000);
     
    
    -- 후원 종료용 / 후원 기간 있는거 샘플용 한개 
    -- == 결제 시 == (5명 다르게 나오게 하기 - 순위 )
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '8' , 'Grace', '김은혜', default, default, '2020-08-13', '15000', 1000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'moonsa', '문상아', default, default, '2020-08-12', '40000', 0 );  
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'hymnin', '강현민', default, default, '2020-08-11', '55000', 0 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'ej123', '김언지', default, default, '2020-08-19', '30000', 0 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'nari8282', '김나리', default, default, '2020-08-20', '15000', 0 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'kh123', '김건형', default, default, '2020-08-20', '15000', 5000); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'nari8282', '김나리', 1, 1, '2020-08-09', '20000', 0); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'Grace', '김은혜', default, 1, '2020-08-12', '150000', 0 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '4' , 'kh123', '김건형', 0, default, '2020-08-17', '20000', 5000); 

    commit;

    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', 1, 1, '2020-08-17', '25000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1, default, '2020-08-19', '55000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, '2020-08-19', '35000', 2000 ); 
    
    commit;
      
    -- 결제금액 (insert) //
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '6' , 'Grace', '김은혜', 0, 1, '2020-08-19', '300000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '6' , 'Grace', '김은혜', 0, 0, '2020-08-16', '25000', default ); 
        
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '6' , 'kh123', '김건형', 1, 0, '2020-08-17', '150000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '6' , 'kh123', '김건형',0, 0, '2020-08-20', '50000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '5' , 'moonsa', '문상아', default, default, '2020-08-20', '25000', default );  
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '5' , 'hymnin', '강현민', default, default, '2020-08-20', '30000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '5' , 'moonsa', '문상아', default, default, '2020-08-18', '25000', 5000 );  
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '5' , 'hymnin', '강현민', default, default, '2020-08-20', '50000', 5000 ); 
    
    commit;
    
    
    commit;
    
   -- 결제금액 (insert) // 후원 종료용  
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'Grace', '김은혜', 1, 1, '2020-08-18', '30000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'Grace', '김은혜', 0, 1, '2020-08-16', '25000', default ); 
        
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'kh123', '김건형', 1,0, '2020-08-17', '15000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'kh123', '김건형',0, 0, '2020-08-20', '50000', default ); 
    
    commit; 
    
    
    
    
    
    
    ---------
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, default, '2020-08-20', '10000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1, 1, '2020-08-19', '125000', 5000); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, '2020-08-19', '20000', 5000); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, 1, '2020-08-15', '15000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1, default, '2020-08-16', '20000', 50000); 

    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, default, '2020-08-18', '20000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, '2020-08-19', '50000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, '2020-08-20', '50000', 2000 ); 
    
      
    -- 결제금액 (insert) //
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'Grace', '김은혜', 0, 0, '2020-08-20', '25000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'hymnin', '강현민', 0, 0, '2020-08-20', '15000', default ); 
        
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'kh123', '김건형', 0,0, '2020-08-20', '50000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'nari8282', '김나리',0, 0, '2020-08-19', '17000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'moonsa', '문상아',0, 0, '2020-08-18', '18000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '11' , 'ej123', '김언지',0, 0, '2020-08-14', '24000', default ); 
    
    commit;
    
   -- 결제금액 (insert) // 후원 종료용  
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'Grace', '김은혜', 1, 1, '2020-08-18', '30000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'Grace', '김은혜', 0, 1, '2020-08-16', '25000', default ); 
        
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'kh123', '김건형', 1,0, '2020-08-17', '15000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '3' , 'kh123', '김건형',0, 0, '2020-08-20', '50000', default ); 
    
    commit;
    
    
    --------------------------------------------------------- 예시 안쓸 거임 ----------------------------
    -->> 상세스토리 DB 이미지 넣어주기  
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 60 ,'happy.jpg');
    
    --지온
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 45 ,'donStoDe401.jpg');
    -- 아프리카에 넣을 이미지(후원종료시)
    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 23 ,'schoolme.jpg');
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 1 ,'schoolme.jpg');    
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 47 ,'donStoDe101.jpg');
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 47 ,'donStoDe106.jpg');
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 23 ,'schoolme.jpg');
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 25 ,'tab1_2.png');
    insert into donImg(donImgseq, fk_donSeq, donImg) values(donStorySeq.nextval, 47,'tab1_3.png');
    
    commit;
    ----------------------------------------------------------------------------------------------------------

    -- 후원 종료용 / 후원 기간 있는거 샘플용 한개 
    -- == 결제 시 == 
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, default, default, '10000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1, 1, '2020-08-18', '125000', 5000); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, '2020-08-19', '20000', 5000); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, 1, '2020-08-15', '15000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1, default, '2020-08-09', '20000', 50000); 

    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', default, default, default, '20000', 2000 ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', default, default, default, '50000', 2000 ); 
    
    commit;
  
    -- 결제금액 (insert) // 후원 종료용 
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', 1, 1, '2020-08-18''2020-08-01', '30000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'Grace', '김은혜', 0, 1, '2020-08-16''2020-08-01', '25000', default ); 
    
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형', 1,0, '2020-08-17''2020-08-01', '15000', default ); 
    
    insert into donPayment(fk_donSeq, fk_userid, name, noName, noDonpmt, paymentDate, payment, point) 
    values( '1' , 'kh123', '김건형',0, 0, '2020-08-19', '50000', default ); 
    
    commit;
    
    ---- 공지사항 insert
    
    begin
    for i in 1..50 loop 
        insert into notice_board(notice_seq, title, content, viewcount, writedate, status)
        values(notice_seq.nextval, i||'번째 공지사항입니다.', 'ECLASS에 오신것을 환영합니다.', default, default, default); 
    end loop;
    end;    
    commit;

    ---- 자유게시판 insert
    begin
    for i in 1..100 loop 
        insert into free_board(free_seq, fk_userid, name, title, content, password, viewcount, writedate, status)
        values(free_seq.nextval, 'hymnin', '강현민', '자유게시판 글쓰기'||i||'번', '글쓰기 연습입니다.'||i, '1234', default, default, default); 
    end loop;
    end;  
    commit;
    
    ---- Q&A 게시판 insert
        begin
    for i in 1..100 loop 
        insert into question_board(question_seq, fk_userid, name, title, content, password, viewcount, writedate, status,groupno,fk_seq,depthno,secret)
        values(question_seq.nextval, 'hymnin', '강현민', i||'번째 문의글입니다.', '문의글입니다.'||i, '1234', default, default, default, i, default, default, default); 
    end loop;
    end; 
    commit;   

    --------------------------------------테이블 끝-----------------------------------------------