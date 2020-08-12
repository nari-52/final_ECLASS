package com.spring.kimej.model;

public class LectureCommentVO {
	
	private String lecComSeq;
	private String fk_subSeq;
	private String fk_lecSeq;
	private String fk_userid;
	private String comContent;
	private String writeday;
	
	public LectureCommentVO() {}
	
	public LectureCommentVO(String lecComSeq, String fk_subSeq, String fk_lecSeq, String fk_userid, String comContent, String writeday) {
		this.lecComSeq = lecComSeq;
		this.fk_subSeq = fk_subSeq;
		this.fk_lecSeq = fk_lecSeq;
		this.fk_userid = fk_userid;
		this.comContent = comContent;
		this.writeday = writeday;
	}

	public String getLecComSeq() {
		return lecComSeq;
	}

	public void setLecComSeq(String lecComSeq) {
		this.lecComSeq = lecComSeq;
	}

	public String getFk_subSeq() {
		return fk_subSeq;
	}

	public void setFk_subSeq(String fk_subSeq) {
		this.fk_subSeq = fk_subSeq;
	}

	public String getFk_lecSeq() {
		return fk_lecSeq;
	}

	public void setFk_lecSeq(String fk_lecSeq) {
		this.fk_lecSeq = fk_lecSeq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getComContent() {
		return comContent;
	}

	public void setComContent(String comContent) {
		this.comContent = comContent;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	

}
