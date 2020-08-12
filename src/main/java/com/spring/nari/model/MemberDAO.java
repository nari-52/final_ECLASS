package com.spring.nari.model;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

// DAO 선언
@Repository
public class MemberDAO implements InterMemberDAO {

	// 의존 객체 주입하기
	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	// 로그인 처리하기
	@Override
	public MemberVO getLoginMember(HashMap<String, String> paraMap) {
	
		MemberVO loginuser = sqlsession.selectOne("member.getLoginMember", paraMap);
		
		return loginuser;
	}


	// AJAX를 이용하여 회원가입 아이디 중복검사
	@Override
	public String idDuplicateCheck(String userid) {
		
		String isUse = sqlsession.selectOne("member.idDuplicateCheck", userid);
		
		return isUse;
	}

	// 회원가입 하기
	@Override
	public int registerMember(MemberVO mvo) {
		
		int n = sqlsession.insert("member.registerMember", mvo);
		
		return n;
	}


	// AJAX를 이용하여 휴대전화 중복검사
	@Override
	public String mobileDuplicateCheck(String mobile) {
		
		String isUseMobile = sqlsession.selectOne("member.mobileDuplicateCheck", mobile);
		
		return isUseMobile;
	}


	// 아이디 찾기
	@Override
	public String idFind(HashMap<String, String> paraMap) {

		String userid = sqlsession.selectOne("member.idFind", paraMap);	
		
		return userid;
	}


	// 비밀번호 찾기 시 비밀번호 변경 하기
	@Override
	public int pwd_update(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("member.pwd_update", paraMap); 
		return n;
	}


	// 회원 탈퇴하기 (status = 0)
	@Override
	public int delMember(String userid) {
		int n = sqlsession.update("member.delMember", userid);
		return n;
	}
	
	
	
	
	
	
	
	
	
	

}


















