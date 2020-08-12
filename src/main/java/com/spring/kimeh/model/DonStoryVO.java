package com.spring.kimeh.model;

public class DonStoryVO {
	
	private String donseq;          //글번호(시퀀스)
	private String subject;		    //후원제목
	private String content;		    //후원내용
	private String listMainImg;     //리스트 메인이미지
	private String storyImg;        //상세 메인이미지 
	private String donCnt;          //글 조회수 
	private String donDate;         //후원 등록일자
	private String donDueDate;      //후원 종료일자 
	private String donStatus;       //글삭제여부   1:사용가능한 글,  0:삭제된글 
	private String targetAmount;    //목표금액
	private String totalPayment;    //후원총액
	private String totalSupporter;  //후원총인원
	
	
	public DonStoryVO() {};
	
	public DonStoryVO(String donseq, String subject, String content, String listMainImg, String storyImg, String donCnt,
			String donDate, String donDueDate, String donStatus, String targetAmount, String totalPayment,
			String totalSupporter) {
		super();
		this.donseq = donseq;
		this.subject = subject;
		this.content = content;
		this.listMainImg = listMainImg;
		this.storyImg = storyImg;
		this.donCnt = donCnt;
		this.donDate = donDate;
		this.donDueDate = donDueDate;
		this.donStatus = donStatus;
		this.targetAmount = targetAmount;
		this.totalPayment = totalPayment;
		this.totalSupporter = totalSupporter;
	}
	
	public String getDonseq() {
		return donseq;
	}
	public void setDonseq(String donseq) {
		this.donseq = donseq;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getListMainImg() {
		return listMainImg;
	}
	public void setListMainImg(String listMainImg) {
		this.listMainImg = listMainImg;
	}
	public String getStoryImg() {
		return storyImg;
	}
	public void setStoryImg(String storyImg) {
		this.storyImg = storyImg;
	}
	public String getDonCnt() {
		return donCnt;
	}
	public void setDonCnt(String donCnt) {
		this.donCnt = donCnt;
	}
	public String getDonDate() {
		return donDate;
	}
	public void setDonDate(String donDate) {
		this.donDate = donDate;
	}
	public String getDonDueDate() {
		return donDueDate;
	}
	public void setDonDueDate(String donDueDate) {
		this.donDueDate = donDueDate;
	}
	public String getDonStatus() {
		return donStatus;
	}
	public void setDonStatus(String donStatus) {
		this.donStatus = donStatus;
	}
	public String getTargetAmount() {
		return targetAmount;
	}
	public void setTargetAmount(String targetAmount) {
		this.targetAmount = targetAmount;
	}
	public String getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(String totalPayment) {
		this.totalPayment = totalPayment;
	}
	public String getTotalSupporter() {
		return totalSupporter;
	}
	public void setTotalSupporter(String totalSupporter) {
		this.totalSupporter = totalSupporter;
	}

	
	
}
