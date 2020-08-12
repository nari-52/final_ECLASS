package com.spring.kimeh.model;

public class DonPayment {

	private String fk_donSeq;   //글번호(FK_시퀀스)
	private String fk_userid;   //회원번호(FK_시퀀스)
	private String fk_name;		//회원명(FK_시퀀스)
	private String noName;		//이름 비공개(Flag)
	private String noDonpmt;	//금액 비공개(Flag)
	private String paymentDate; //결제날짜 
	private String payment;     //결제금액 	
	
	public DonPayment() {};
	
	public DonPayment(String fk_donSeq, String fk_userid, String fk_name, String noName, String noDonpmt,
			String paymentDate, String payment) {
		super();
		this.fk_donSeq = fk_donSeq;
		this.fk_userid = fk_userid;
		this.fk_name = fk_name;
		this.noName = noName;
		this.noDonpmt = noDonpmt;
		this.paymentDate = paymentDate;
		this.payment = payment;
	}

	public String getFk_donSeq() {
		return fk_donSeq;
	}

	public void setFk_donSeq(String fk_donSeq) {
		this.fk_donSeq = fk_donSeq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getFk_name() {
		return fk_name;
	}

	public void setFk_name(String fk_name) {
		this.fk_name = fk_name;
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

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}
	
	
}
