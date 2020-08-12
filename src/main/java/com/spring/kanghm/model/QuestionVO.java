package com.spring.kanghm.model;

import org.springframework.web.multipart.MultipartFile;

public class QuestionVO {

	private int question_seq;      // 글번호
	private String fk_userid;	   // 사용자ID	
	private String name;		   // 글쓴이	
	private String title;		   // 글제목	
	private String content;        // 글내용
	private String password;       // 글암호
	private String viewcount;      // 글조회수
	private String writedate;      // 글쓴시간
	private String status;         // 글삭제여부  1:사용가능한글,  0:삭제된글
	private String groupno;        // 답변글쓰기에 있어서 그룹번호 
	private String fk_seq;         // 원글(부모글)이 누구인지에 대한 정보값이다. 
	private String depthno;        // 답변글갯수 
	private String fileName;       // WAS(톰캣)에 저장될 파일명
	private String orgFilename;    // 진짜 파일명(강아지.png)
	private String secret;         // 비밀글여부
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	private MultipartFile attach; 
	
	public QuestionVO() {}
	
	public QuestionVO(int question_seq, String fk_userid, String name, String title, String content, String password,
			String viewcount, String writedate, String status, String groupno, String fk_seq, String depthno,
			String fileName, String orgFilename, String secret) {
		super();
		this.question_seq = question_seq;
		this.fk_userid = fk_userid;
		this.name = name;
		this.title = title;
		this.content = content;
		this.password = password;
		this.viewcount = viewcount;
		this.writedate = writedate;
		this.status = status;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.secret = secret;
	}

	public int getQuestion_seq() {
		return question_seq;
	}

	public void setQuestion_seq(int question_seq) {
		this.question_seq = question_seq;
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

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
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

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
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
