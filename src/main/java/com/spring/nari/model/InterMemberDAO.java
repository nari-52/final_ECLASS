package com.spring.nari.model;

import java.util.HashMap;

public interface InterMemberDAO {

	// 로그인 처리하기
	MemberVO getLoginMember(HashMap<String, String> paraMap);

	// AJAX를 이용하여 회원가입 아이디 중복검사
	String idDuplicateCheck(String userid);

	// 회원가입 하기
	int registerMember(MemberVO mvo);

	// AJAX를 이용하여 휴대전화 중복검사
	String mobileDuplicateCheck(String mobile);

	// 아이디 찾기
	String idFind(HashMap<String, String> paraMap);

	// 비밀번호 찾기 시 비밀번호 변경 하기
	int pwd_update(HashMap<String, String> paraMap);

	// 회원 탈퇴하기 (status = 0)
	int delMember(String userid); 

}
