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
	

}
