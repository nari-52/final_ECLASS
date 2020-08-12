package com.spring.nari.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.nari.model.InterMemberDAO;
import com.spring.nari.model.MemberVO;

// 서비스 선언
@Service
public class MemberService implements InterMemberService {
	
	// 의존객체 주입하기
	@Autowired
	private InterMemberDAO dao;
	
	// 양방향 암호화 알고리즘 AES256 사용하여 복호화 하기 위한 의존객체 주입
	@Autowired
	private AES256 aes;
	
	
	// 로그인 처리하기
	@Override
	public MemberVO getLoginMember(HashMap<String, String> paraMap) {
		
		MemberVO loginuser = dao.getLoginMember(paraMap);
		return loginuser;
	}


	// AJAX를 이용하여 회원가입 아이디 중복검사
	@Override
	public String idDuplicateCheck(String userid) {
		
		String isUse = dao.idDuplicateCheck(userid);
		
		return isUse;
	}

	// 회원가입 하기
	@Override
	public int registerMember(MemberVO mvo) {
		int n = dao.registerMember(mvo);
		return n;
	}

	
	// AJAX를 이용하여 휴대전화 중복검사
	@Override
	public String mobileDuplicateCheck(String mobile) {
		String isUseMobile = dao.mobileDuplicateCheck(mobile);
		
		return isUseMobile;
	}


	// 아이디 찾기
	@Override
	public String idFind(HashMap<String, String> paraMap) {
		String userid = dao.idFind(paraMap);
		return userid;
	}


	// 비밀번호 찾기 시 비밀번호 변경 하기
	@Override
	public int pwd_update(HashMap<String, String> paraMap) {
		
		int n = dao.pwd_update(paraMap);
		
		return n;
	}


	// 회원 탈퇴하기 (status = 0)
	@Override
	public int delMember(String userid) {
		
		int n = dao.delMember(userid);
		
		return n;
	}

}













