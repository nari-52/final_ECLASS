package com.spring.nari.model;

public class MemberVO {
	
	private String userid;			// 아이디
	private String name;			// 성명
	private String pwd;				// 비밀번호 (SHA-256 암호화 대상)
	private String identity;		// 회원구분 (학생1, 교수2, 관리자3)
	private String university;		// 대학명
	private String major;			// 학과명
	private String student_num;		// 학번 (학생만 not null)
	private String email;			// 이메일 (AES-256 암호화/복호화 대상)
	private String mobile;			// 핸드폰 (AES-256 암호화/복호화 대상)
	private String postcode;		// 우편번호
	
	private String address;			// 주소
	private String detailaddress;	// 상세주소
	private String extraaddress;	// 참고항목(주소)
	private String point;			// 포인트
	private String registerday;		// 가입일자
	private String status;			// 회원상태 1: 사용가능(가입중) / 0: 사용불가능(탈퇴)
	private String last_login_date;	// 마지막 로그인 날짜
	private String pwd_change_date;	// 마지막 비밀번호 변경 날짜
	private String filename;		// 파일이름 (WAS 저장용)
	private String orgfilename;		// 파일이름 (진짜 이름)
	
	
	private boolean requirePwdChange = false;
	// 마지막 로그인 한 날짜가 현재시각으로부터 3개월 지났으면 true 아니면 false
	private boolean idleStatus = false;		// 휴면유무 (휴면 true, 아니면 false)
	
	public MemberVO() {};
	
	public MemberVO(String userid, String name, String pwd, String identity, String university, String major,
			String student_num, String email, String mobile, String postcode, String address, String detailaddress,
			String extraaddress, String point, String registerday, String status, String last_login_date,
			String pwd_change_date, String filename, String orgfilename) {
		super();
		this.userid = userid;
		this.name = name;
		this.pwd = pwd;
		this.identity = identity;
		this.university = university;
		this.major = major;
		this.student_num = student_num;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.point = point;
		this.registerday = registerday;
		this.status = status;
		this.last_login_date = last_login_date;
		this.pwd_change_date = pwd_change_date;
		this.filename = filename;
		this.orgfilename = orgfilename;

	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getIdentity() {
		return identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public String getUniversity() {
		return university;
	}

	public void setUniversity(String university) {
		this.university = university;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getStudent_num() {
		return student_num;
	}

	public void setStudent_num(String student_num) {
		this.student_num = student_num;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLast_login_date() {
		return last_login_date;
	}

	public void setLast_login_date(String last_login_date) {
		this.last_login_date = last_login_date;
	}

	public String getPwd_change_date() {
		return pwd_change_date;
	}

	public void setPwd_change_date(String pwd_change_date) {
		this.pwd_change_date = pwd_change_date;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public boolean isIdleStatus() {
		return idleStatus;
	}

	public void setIdleStatus(boolean idleStatus) {
		this.idleStatus = idleStatus;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}



	
	
	
	
	
	
	
	
	
	

}
