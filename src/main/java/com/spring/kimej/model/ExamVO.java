package com.spring.kimej.model;

public class ExamVO {
	
	private String exam_seq;
	private String subSeq;
	private String userid;
	private String examTitle;
	private String examDate;
	
	public ExamVO() {}
	
	public ExamVO(String exam_seq, String subSeq, String userid, String examTitle, String examDate) {
		super();
		this.exam_seq = exam_seq;
		this.subSeq = subSeq;
		this.userid = userid;
		this.examTitle = examTitle;
		this.examDate = examDate;
	}

	public String getExam_seq() {
		return exam_seq;
	}

	public void setExam_seq(String exam_seq) {
		this.exam_seq = exam_seq;
	}

	public String getSubSeq() {
		return subSeq;
	}

	public void setSubSeq(String subSeq) {
		this.subSeq = subSeq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getExamTitle() {
		return examTitle;
	}

	public void setExamTitle(String examTitle) {
		this.examTitle = examTitle;
	}

	public String getExamDate() {
		return examDate;
	}

	public void setExamDate(String examDate) {
		this.examDate = examDate;
	}
	

}