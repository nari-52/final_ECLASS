package com.spring.moonsa.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.moonsa.model.AttandVO;
import com.spring.moonsa.model.InterMypageDAO;
import com.spring.nari.model.MemberVO;

@Service
public class MypageService implements InterMypageService {

	@Autowired
	private InterMypageDAO dao;

	// 로그인한 학생 정보 불러오기
	@Override
	public MemberVO getSInfo(HashMap<String, String> paraMap) {
		MemberVO membervo = dao.getSInfo(paraMap);
		return membervo;
	}

	// 교과목 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getSubjectList(String userid) {
		List<HashMap<String, String>> subjectList = dao.getSubjectList(userid);
		return subjectList;
	}

	// 해당 학생의 출석 리스트 불러오기
	@Override
	public List<AttandVO> getAttandList(HashMap<String, String> paraMap) {
		List<AttandVO> attandList = dao.getAttandList(paraMap);
		return attandList;
	}

	// 총 출석 수 가져오기
	@Override
	public String getAttandOX(HashMap<String, String> paraMap) {
		String attandOX = dao.getAttandOX(paraMap);
		return attandOX;
	}

	// 교수 교과목 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getSubjectListforP(String userid) {
		List<HashMap<String, String>> subjectListforP = dao.getSubjectListforP(userid);
		return subjectListforP;
	}

	// 해당 과목의 학생정적 모두 불러오기
	@Override
	public List<HashMap<String, String>> getStudentP(String subjectSelect) {
		List<HashMap<String, String>> studentP = dao.getStudentP(subjectSelect);
		return studentP;
	}

	// 수정할 학생명 가져오기
	@Override
	public String getSName(String userid) {
		String SName = dao.getSName(userid);
		return SName;
	}

	// 출석 정보 수정하기(update)
	@Override
	public int getChangeA(HashMap<String, String> paraMap) {
		int n = dao.getChangeA(paraMap);
		return n;
	}

	// 성적 정보 수정하기(update)
	@Override
	public int getChangeG(HashMap<String, String> paraMap) {
		int n = dao.getChangeG(paraMap);
		return n;
	}

	// 'O'로 변경될 경우 출석점수 변경
	@Override
	public void getChangeAtotal(HashMap<String, String> paraMap) {
		 dao.getChangeAtotal(paraMap);
	}


	
	
	
}
