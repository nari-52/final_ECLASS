package com.spring.kimej.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 ===
@Repository  
public class ExamDAO implements InterExamDAO{
	
	// 의존객체 주입하기(DI: Dependency Injection)
	@Resource
	private SqlSessionTemplate sqlsession;

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@Override
	public int exam_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("exam.exam_insert", paraMap);
		return n;
	}
	
	@Override
	public ExamVO exam_select(String examTitle) {
		ExamVO examvo = sqlsession.selectOne("exam.exam_select", examTitle);
		return examvo;
	}

	// 시험 문제 출제 페이지 !!완료!! 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	@Override
	public int question_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("exam.question_insert", paraMap);
		return n;
	}

	// 시험 제출 페이지 보여주기 (학생이 풀 문제 불러오기)
	@Override
	public List<ExamQuestionVO> questionList(String exam_seq) {
		List<ExamQuestionVO> questionList = sqlsession.selectList("exam.questionList", exam_seq);
		return questionList;
	}

	@Override
	public List<ExamVO> examList(String fk_subSeq) {
		List<ExamVO> examList = sqlsession.selectList("exam.examList", fk_subSeq);
		return examList;
	}

	// 시험 상세 보기
	@Override
	public ExamVO examDetail(String exam_seq) {
		ExamVO examvo = sqlsession.selectOne("exam.examDetail", exam_seq);
		return examvo;
	}

	// 시험 수정하기
	@Override
	public int examEdit(HashMap<String, String> paraMap) {
		int n = sqlsession.update("exam.examEdit", paraMap);
		return n;
	}

	// 시험 삭제하기
	@Override
	public int examDelete(String exam_seq) {
		int n = sqlsession.delete("exam.examDelete", exam_seq);
		return n;
	}

	// 시험 제출하기 (시험 점수 DB에 입력)
	@Override
	public int examG_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.update("exam.examG_insert", paraMap);
		return n;
	}

	// 시험 날짜 받아오기
	@Override
	public ExamVO examDate(String fk_subSeq) {
		ExamVO examvo = sqlsession.selectOne("exam.examList", fk_subSeq);
		return examvo;
	}

	// 시험 문제들 알아오기
	@Override
	public List<String> getQuestions(String exam_seq) {
		List<String> questionArr = sqlsession.selectList("exam.questions", exam_seq);
		return questionArr;
	}

	// 시험 정답들 알아오기
	@Override
	public List<String> getAnswers(String exam_seq) {
		List<String> answerArr = sqlsession.selectList("exam.answers", exam_seq);
		return answerArr;
	}
	
	// 시험문제시퀀스들 알아오기
	@Override
	public List<String> getQuestionSeqs(String exam_seq) {
		List<String> question_seqArr = sqlsession.selectList("exam.question_seqs", exam_seq);
		return question_seqArr;
	}
	
	// 시험 수정하기
	@Override
	public int question_update(HashMap<String, String> paraMap) {
		int n = sqlsession.update("exam.question_update", paraMap);
		return n;
	}

	// 시험 점수 알아오기
	@Override
	public String examG_select(HashMap<String, String> paraMap) {
		String examG = sqlsession.selectOne("exam.examG_select", paraMap);
		return examG;
	}

	// 출석 점수 알아오기
	@Override
	public String getAttandG(HashMap<String, String> paraMap) {
		String attandG = sqlsession.selectOne("exam.getAttandG", paraMap);
		return attandG;
	}

	// 최종 성적 입력하기
	@Override
	public int finalG_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.update("exam.finalG_insert", paraMap);
		return n;
	}

	
}
