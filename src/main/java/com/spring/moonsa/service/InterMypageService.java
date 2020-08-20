package com.spring.moonsa.service;

import java.util.HashMap;
import java.util.List;

import com.spring.moonsa.model.AttandVO;
import com.spring.nari.model.MemberVO;

public interface InterMypageService {

	MemberVO getSInfo(HashMap<String, String> paraMap); // 로그인한 학생 정보 불러오기

	List<HashMap<String, String>> getSubjectList(String userid); // 교과목 리스트 불러오기

	List<AttandVO> getAttandList(HashMap<String, String> paraMap); // 해당 학생의 출석 리스트 불러오기

	String getAttandOX(HashMap<String, String> paraMap); // 총 출석 수 가져오기

	List<HashMap<String, String>> getSubjectListforP(String userid); // 교수 교과목 리스트 불러오기

	List<HashMap<String, String>> getStudentP(String subjectSelect); // 해당 과목의 학생정적 모두 불러오기

	String getSName(String userid); // 수정할 학생명 가져오기

	int getChangeA(HashMap<String, String> paraMap); // 출석 정보 수정하기(update)

	int getChangeG(HashMap<String, String> paraMap); // 성적 정보 수정하기(update)

	void getChangeAtotal(HashMap<String, String> paraMap); // 'O'로 변경될 경우 출석점수 변경


}
