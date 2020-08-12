package com.spring.moonsa.model;

public class AttandVO {
	
	private String attandSeq;
	private String fk_subSeq;
	private String lecNum;
	private String fk_userid;
	private String attand;
	private String data;
	
	public AttandVO() {}
	
	public AttandVO(String attandSeq, String fk_subSeq, String lecNum, String fk_userid, String attand, String data) {
		super();
		this.attandSeq = attandSeq;
		this.fk_subSeq = fk_subSeq;
		this.lecNum = lecNum;
		this.fk_userid = fk_userid;
		this.attand = attand;
		this.data = data;
	}

	public String getAttandSeq() {
		return attandSeq;
	}

	public void setAttandSeq(String attandSeq) {
		this.attandSeq = attandSeq;
	}

	public String getFk_subSeq() {
		return fk_subSeq;
	}

	public void setFk_subSeq(String fk_subSeq) {
		this.fk_subSeq = fk_subSeq;
	}

	public String getLecNum() {
		return lecNum;
	}

	public void setLecNum(String lecNum) {
		this.lecNum = lecNum;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getAttand() {
		return attand;
	}

	public void setAttand(String attand) {
		this.attand = attand;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	
	
	
	
}
