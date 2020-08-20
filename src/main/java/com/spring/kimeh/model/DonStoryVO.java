package com.spring.kimeh.model;

import org.springframework.web.multipart.MultipartFile;

public class DonStoryVO {
	
	private String donseq;          //글번호(시퀀스)
	private String subject;		    //후원제목
	private String content;		    //후원내용
	private String listMainImg;     //리스트 메인이미지 (날짜+나노초.png)
	private String storyImg;        //상세 메인이미지  (날짜+나노초.png)
	private String donCnt;          //글 조회수 
	private String donDate;         //후원 등록일자
	private String donDueDate;      //후원 종료일자 
	private String donStatus;       //글삭제여부   1:사용가능한 글,  0:삭제된글 
	private String targetAmount;    //목표금액
	private String totalPayment;    //후원총액
	private String totalSupporter;  //후원총인원
	
	private String donImgseq; //후원이미지 번호
	private String fk_donSeq; //후원글번호 
	private String donImg; 
	
	private String dDay; //후원 종료날짜 
	
	//결제하기에서 가져옴 
	private String name; 
	private String payment;
	private String point;
	private String noName;
	private String noDonpmt; 
	private String showDate; // 후원결제후 경과 시간 
	private String sumPayment; //회원의 총후원금액(포인트+결제) 	
	
	private String orgListMainImg;//진짜 파일명(강아지.png) 
	private String orgStoryImg;//진짜 파일명(강아지.png) 
	
//	private String fileName; //WAS(톰캣)에 저장될 파일명
//	private String orgFilename; //진짜 파일명(강아지.png) 
	private MultipartFile attach; //메인이미지 //form태그에 있는 type="file"인 파일을 받아서 저장되는 필드이다.
	private MultipartFile attach2; //상세이미지 
	// /Eclass/src/main/webapp/WEB-INF/views/tiles1/donation/donationStoryAdd.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	// 동일해야만 파일첨부가 가능해진다.!!!! (name과 vo에 있는 필드명은 같아야 함)
	
	
	public DonStoryVO() {};
	
	public DonStoryVO(String donseq, String subject, String content, String listMainImg, String storyImg, String donCnt,
			String donDate, String donDueDate, String donStatus, String targetAmount, String totalPayment,
			String totalSupporter, String donImgseq, String fk_donSeq, String donImg, String dDay, String name,
			String payment, String point, String noName, String noDonpmt, String showDate, String sumPayment,
			String orgListMainImg, String orgStoryImg, MultipartFile attach, MultipartFile attach2) {
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
		this.donImgseq = donImgseq;
		this.fk_donSeq = fk_donSeq;
		this.donImg = donImg;
		this.dDay = dDay;
		this.name = name;
		this.payment = payment;
		this.point = point;
		this.noName = noName;
		this.noDonpmt = noDonpmt;
		this.showDate = showDate;
		this.sumPayment = sumPayment;
		this.orgListMainImg = orgListMainImg;
		this.orgStoryImg = orgStoryImg;
		this.attach = attach;
		this.attach2 = attach2;
	}




	public String getdDay() {
		return dDay;
	}

	public void setdDay(String dDay) {
		this.dDay = dDay;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getNoName() {
		return noName;
	}

	public void setNoName(String noName) {
		this.noName = noName;
	}

	public String getNoDonpmt() {
		return noDonpmt;
	}

	public void setNoDonpmt(String noDonpmt) {
		this.noDonpmt = noDonpmt;
	}

	public String getShowDate() {
		return showDate;
	}

	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}

	public String getSumPayment() {
		return sumPayment;
	}

	public void setSumPayment(String sumPayment) {
		this.sumPayment = sumPayment;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public MultipartFile getAttach2() {
		return attach2;
	}

	public void setAttach2(MultipartFile attach2) {
		this.attach2 = attach2;
	}

	public String getOrgListMainImg() {
		return orgListMainImg;
	}

	public void setOrgListMainImg(String orgListMainImg) {
		this.orgListMainImg = orgListMainImg;
	}

	public String getOrgStoryImg() {
		return orgStoryImg;
	}

	public void setOrgStoryImg(String orgStoryImg) {
		this.orgStoryImg = orgStoryImg;
	}


	
}