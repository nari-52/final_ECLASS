package com.spring.kimej.model;

import java.util.HashMap;
import java.util.List;

public interface InterExamDAO {

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	int exam_insert(HashMap<String, String> paraMap);
	
	ExamVO exam_select(String examTitle);

	// 시험 문제 출제 페이지 !!완료!! 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	int question_insert(HashMap<String, String> paraMap);
	
	// 시험 제출 페이지 보여주기 (학생이 풀 문제 불러오기)
	List<ExamQuestionVO> questionList(String exam_seq);

	// 시험 제목 보여주기 페이지
	List<ExamVO> examList(String fk_subSeq);

	// 시험 상세 정보
	ExamVO examDetail(String exam_seq);

	// 시험 수정하기
	int examEdit(HashMap<String, String> paraMap);

	// 시험 삭제하기
	int examDelete(String exam_seq);

	// 시험 제출하기 (시험 점수 DB에 입력)
	int examG_insert(HashMap<String, String> paraMap);

	// 시험 날짜 알아오기
	ExamVO examDate(String fk_subSeq);

	// 시험 문제들 알아오기
	List<String> getQuestions(String exam_seq);

	// 시험 정답들 알아오기
	List<String> getAnswers(String exam_seq);
	
	// 시험문제시퀀스들 알아오기
	List<String> getQuestionSeqs(String exam_seq);

	// 시험 문제 수정하기
	int question_update(HashMap<String, String> paraMap);

	// 시험 점수 알아오기
	String examG_select(HashMap<String, String> paraMap);

	// 출석 점수 알아오기
	String getAttandG(HashMap<String, String> paraMap);

	// 최종 성적 입력하기
	int finalG_insert(HashMap<String, String> paraMap);

	

}
