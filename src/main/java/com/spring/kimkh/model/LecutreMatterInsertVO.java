package com.spring.kimkh.model;

import org.springframework.web.multipart.MultipartFile;

public class LecutreMatterInsertVO {

	private String subseq; // 교과목 번호-시퀀스 
	private String fk_userid;//아이디
	private String status;//이수구분(전공,교양,일반) 디폴트1
	private String subName;// 교과목명
	private String subContent;// 교과목소개
	private String subImg;// 교과목대표이미지
	private String writeday;// 교과목 등록일
	private MultipartFile attach; //파일첨부
	private String saveSubImg;//저장될 이미지
	
	
	public String getSaveSubImg() {
		return saveSubImg;
	}
	public void setSaveSubImg(String saveSubImg) {
		this.saveSubImg = saveSubImg;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getSubseq() {
		return subseq;
	}
	public void setSubseq(String subseq) {
		this.subseq = subseq;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	public String getSubContent() {
		return subContent;
	}
	public void setSubContent(String subContent) {
		this.subContent = subContent;
	}
	public String getSubImg() {
		return subImg;
	}
	public void setSubImg(String subImg) {
		this.subImg = subImg;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	public LecutreMatterInsertVO() {}//xml에서 리죨트타입을 자동으로 연결하려면 기본생성자를 꼭 생성해주자
	
	public LecutreMatterInsertVO(String subseq, String fk_userid, String status, String subName, String subContent,
			String subImg, String writeday,String saveSubImg) {
		super();
		this.subseq = subseq;
		this.fk_userid = fk_userid;
		this.status = status;
		this.subName = subName;
		this.subContent = subContent;
		this.subImg = subImg;
		this.writeday = writeday;
		this.saveSubImg = saveSubImg;
	}
	
}
