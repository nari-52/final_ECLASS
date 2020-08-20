package com.spring.kimej.service;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.kimej.model.ExamQuestionVO;
import com.spring.kimej.model.ExamVO;
import com.spring.kimej.model.InterExamDAO;

//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service  
public class ExamService implements InterExamService {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterExamDAO dao;

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@Override
	public int exam_insert(HashMap<String, String> paraMap) {
		int n = dao.exam_insert(paraMap);
		return n;
	}

	@Override
	public ExamVO exam_select(String examTitle) {
		ExamVO examvo = dao.exam_select(examTitle);
		return examvo;
	}
	
	// 시험 문제 출제 페이지 !!완료!! 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	@Override
	public int question_insert(HashMap<String, String> paraMap) {
		int n = dao.question_insert(paraMap);
		return n;
	}

	// 시험 제출 페이지 보여주기 (학생이 풀 문제 불러오기)
	@Override
	public List<ExamQuestionVO> questionList(String exam_seq) {
		List<ExamQuestionVO> questionList = dao.questionList(exam_seq);
		return questionList;
	}

	// 시험 제목 보여주기 페이지
	@Override
	public List<ExamVO> examList(String fk_subSeq) {
		List<ExamVO> examList = dao.examList(fk_subSeq);
		return examList;
	}

	// 시험 상세 정보
	@Override
	public ExamVO examDetail(String exam_seq) {
		ExamVO examvo = dao.examDetail(exam_seq);
		return examvo;
	}

	// 시험 수정하기
	@Override
	public int examEdit(HashMap<String, String> paraMap) {
		int n = dao.examEdit(paraMap);
		return n;
	}

	// 시험 삭제하기
	@Override
	public int examDelete(String exam_seq) {
		int n = dao.examDelete(exam_seq);
		return n;
	}

	// 시험 제출하기 (시험 점수 DB에 입력)
	@Override
	public int examG_insert(HashMap<String, String> paraMap) {
		int n = dao.examG_insert(paraMap);
		return n;
	}
	
	// 시험 날짜 알아오기
	@Override
	public ExamVO examDate(String fk_subSeq) {
		ExamVO examvo = dao.examDate(fk_subSeq);
		return examvo;
	}

	// 시험 문제들 알아오기
	@Override
	public List<String> getQuestions(String exam_seq) {
		List<String> questionArr = dao.getQuestions(exam_seq);
		return questionArr;
	}

	// 시험 정답들 알아오기
	@Override
	public List<String> getAnswers(String exam_seq) {
		List<String> answerArr = dao.getAnswers(exam_seq);
		return answerArr;
	}
	
	// 시험문제시퀀스들 알아오기
	@Override
	public List<String> getQuestionSeqs(String exam_seq) {
		List<String> question_seqArr = dao.getQuestionSeqs(exam_seq);
		return question_seqArr;
	}

	// 시험 문제 수정하기
	@Override
	public int question_update(HashMap<String, String> paraMap) {
		int n = dao.question_update(paraMap);
		return n;
	}

	// 시험 점수 알아오기
	@Override
	public String examG_select(HashMap<String, String> paraMap) {
		String examG = dao.examG_select(paraMap);
		return examG;
	}

	// 출석 점수 알아오기
	@Override
	public String getAttandG(HashMap<String, String> paraMap) {
		String attandG = dao.getAttandG(paraMap);
		return attandG;
	}

	// 최종 성적 입력하기
	@Override
	public int finalG_insert(HashMap<String, String> paraMap) {
		int n = dao.finalG_insert(paraMap);
		return n;
	}




	
}
