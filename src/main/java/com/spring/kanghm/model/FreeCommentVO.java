package com.spring.kanghm.model;

public class FreeCommentVO {

	private String comment_seq;
	private String parentSeq;
	private String fk_userid;
	private String name;
	private String content;
	private String writedate;
	private String status;
	
	public FreeCommentVO() {}
	
	public FreeCommentVO(String comment_seq, String parentSeq, String fk_userid, String name, String content,
			String writedate, String status) {
		super();
		this.comment_seq = comment_seq;
		this.parentSeq = parentSeq;
		this.fk_userid = fk_userid;
		this.name = name;
		this.content = content;
		this.writedate = writedate;
		this.status = status;
	}

	public String getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(String comment_seq) {
		this.comment_seq = comment_seq;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
	
		

	
}
