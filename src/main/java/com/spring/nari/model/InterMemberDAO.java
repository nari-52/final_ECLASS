package com.spring.nari.model;

import java.util.HashMap;
import java.util.List;

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

	// 회원정보 수정하기 위한 정보 가져오기
	MemberVO select_updateMember(String userid);

	// 회원정보 수정하기
	int updateMember(MemberVO mvo);

	// 관리자페이지 학생관리 보여주기
	List<MemberVO> member_studentList();

	// 관리자페이지 교수관리 보여주기
	List<MemberVO> member_professorList(); 

}
