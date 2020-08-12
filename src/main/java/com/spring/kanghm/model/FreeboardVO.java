package com.spring.kanghm.model;

import org.springframework.web.multipart.MultipartFile;

public class FreeboardVO {

	private int free_seq;		// 글번호
	private String fk_userid; 		// 사용자ID
	private String name;			// 글쓴이
	private String title;			// 글제목
	private String content;			// 글내용
	private String password;		// 글암호
	private String viewcount;		// 글조회수
	private String writedate;		// 글쓴시간
	private String status;			// 글삭제여부  1:사용가능한글,  0:삭제된글
	private String fileName;		// WAS(톰캣)에 저장될 파일명(20190725092715353243254235235234.png)
	private String orgFilename;		// 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	private MultipartFile attach; // form 태그에서 type="file"인 파일을 받아서 저장되는 필드이다. 진짜파일 => WAS(톰캣) 디스크에 저장됨.
	// !!!!!! MultipartFile attach 는 오라클 데이터베이스 tblBoard 테이블의 컬럼이 아니다.!!!!!!  
	// /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	// 동일해야만 파일첨부가 가능해진다.!!!!
	
	public FreeboardVO(){}
	
	public FreeboardVO(int free_seq, String fk_userid, String name, String title, String content, String password,
			String viewcount, String writedate, String status, String fileName, String orgFilename) {
		super();
		this.free_seq = free_seq;
		this.fk_userid = fk_userid;
		this.name = name;
		this.title = title;
		this.content = content;
		this.password = password;
		this.viewcount = viewcount;
		this.writedate = writedate;
		this.status = status;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
	}

	public int getFree_seq() {
		return free_seq;
	}

	public void setFree_seq(int free_seq) {
		this.free_seq = free_seq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getViewcount() {
		return viewcount;
	}

	public void setViewcount(String viewcount) {
		this.viewcount = viewcount;
	}
	
	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
}
