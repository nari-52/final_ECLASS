package com.spring.moonsa.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.nari.model.MemberVO;

@Repository
public class MypageDAO implements InterMypageDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 로그인한 학생 정보 불러오기
	@Override
	public MemberVO getSInfo(HashMap<String, String> paraMap) {
		MemberVO membervo = sqlsession.selectOne("mypage.getSInfo", paraMap);
		return membervo;
	}

	// 교과목 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getSubjectList(String userid) {
		List<HashMap<String, String>> subjectList = sqlsession.selectList("mypage.getSubjectList", userid);
		return subjectList;
	}

	// 해당 학생의 출석 리스트 불러오기
	@Override
	public List<AttandVO> getAttandList(HashMap<String, String> paraMap) {
		List<AttandVO> attandList = sqlsession.selectList("mypage.getAttandList", paraMap);
		return attandList;
	}

	// 총 출석 수 가져오기
	@Override
	public String getAttandOX(HashMap<String, String> paraMap) {
		String attandOX = sqlsession.selectOne("mypage.getAttandOX", paraMap);
		return attandOX;
	}

	// 교수 교과목 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getSubjectListforP(String userid) {
		List<HashMap<String, String>> subjectListforP = sqlsession.selectList("mypage.getSubjectListforP", userid);
		return subjectListforP;
	}

	// 해당 과목의 학생정적 모두 불러오기
	@Override
	public List<HashMap<String, String>> getStudentP(String subjectSelect) {
		List<HashMap<String, String>> studentP = sqlsession.selectList("mypage.getStudentP", subjectSelect);
		return studentP;
	}
	
	// 수정할 학생명 가져오기
	@Override
	public String getSName(String userid) {
		String SName = sqlsession.selectOne("mypage.getSName", userid);
		return SName;
	}

	// 출석 정보 수정하기(update)
	@Override
	public int getChangeA(HashMap<String, String> paraMap) {
		int n = sqlsession.update("mypage.getChangeA", paraMap);
		return n;
	}

	// 성적 정보 수정하기(update)
	@Override
	public int getChangeG(HashMap<String, String> paraMap) {
		int n = sqlsession.update("mypage.getChangeG", paraMap);
		return n;
	}

	// 'O'로 변경될 경우 출석점수 변경
	@Override
	public void getChangeAtotal(HashMap<String, String> paraMap) {
		sqlsession.update("mypage.getChangeAtotal", paraMap);
	}


	
	
}
