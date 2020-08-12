package com.spring.kimej.model;

public class LectureVO {
	
	private String lecSeq;
	private String fk_subSeq;
	private String lecTitle;
	private String lecLink;
	private String lecStartday;
	private String lecEndday;
	
	private String subName;
	// 교과목 명
	
	public LectureVO() {}
	
	public LectureVO(String lecSeq, String fk_subSeq, String lecTitle, String lecLink, String lecStartday, String lecEndday, String subName) {
		this.lecSeq = lecSeq;
		this.fk_subSeq = fk_subSeq;
		this.lecTitle = lecTitle;
		this.lecLink = lecLink;
		this.lecStartday = lecStartday;
		this.lecEndday = lecEndday;
		this.subName = subName;
	}

	public String getLecSeq() {
		return lecSeq;
	}

	public void setLecSeq(String lecSeq) {
		this.lecSeq = lecSeq;
	}

	public String getFk_subSeq() {
		return fk_subSeq;
	}

	public void setFk_subSeq(String fk_subSeq) {
		this.fk_subSeq = fk_subSeq;
	}

	public String getLecTitle() {
		return lecTitle;
	}

	public void setLecTitle(String lecTitle) {
		this.lecTitle = lecTitle;
	}

	public String getLecLink() {
		return lecLink;
	}

	public void setLecLink(String lecLink) {
		this.lecLink = lecLink;
	}

	public String getLecStartday() {
		return lecStartday;
	}

	public void setLecStartday(String lecStartday) {
		this.lecStartday = lecStartday;
	}

	public String getLecEndday() {
		return lecEndday;
	}

	public void setLecEndday(String lecEndday) {
		this.lecEndday = lecEndday;
	}

	public String getSubName() {
		return subName;
	}

	public void setSubName(String subName) {
		this.subName = subName;
	}
	

}
