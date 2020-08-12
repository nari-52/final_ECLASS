package com.spring.kimeh.model;

public class DonImg {
	
	private String donImgseq; //후원이미지 번호
	private String fk_donSeq; //후원글번호 
	private String donImg;    //후원이미지
	
	public DonImg() {};
	
	public DonImg(String donImgseq, String fk_donSeq, String donImg) {
		super();
		this.donImgseq = donImgseq;
		this.fk_donSeq = fk_donSeq;
		this.donImg = donImg;
	}

	public String getDonImgseq() {
		return donImgseq;
	}

	public void setDonImgseq(String donImgseq) {
		this.donImgseq = donImgseq;
	}

	public String getFk_donSeq() {
		return fk_donSeq;
	}

	public void setFk_donSeq(String fk_donSeq) {
		this.fk_donSeq = fk_donSeq;
	}

	public String getDonImg() {
		return donImg;
	}

	public void setDonImg(String donImg) {
		this.donImg = donImg;
	}
	
}
