package com.spring.kimej.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.kimej.model.InterLectureDAO;
import com.spring.kimej.model.LectureCommentVO;
import com.spring.kimej.model.LectureVO;
import com.spring.nari.model.MemberVO;

//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service  
public class LectureService implements InterLectureService {
	
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterLectureDAO dao;

	// 강의 등록 페이지 보여주기
	@Override
	public int lecture_insert(HashMap<String, String> paraMap) {
		int n = dao.lecture_insert(paraMap);
		return n;
	}

	// 강의 목록 페이지 보여주기 (차수,제목)
	@Override
	public List<LectureVO> lectureListSearch(HashMap<String, String> paraMap) {
		List<LectureVO> lectureList = dao.lectureListSearch(paraMap);
		return lectureList;
	}

	// 강의 상세 페이지 보여주기 (유튜브영상, 댓글)
	@Override
	public LectureVO getView(String lecSeq) {
		LectureVO lecturevo = dao.getView(lecSeq);
		return lecturevo;
	}

	// 댓글 작성하기
	@Override
	public int addComment(LectureCommentVO commentvo) {
		int n = dao.addComment(commentvo);
		return n;
	}
	
	// 댓글 지우기
	@Override
	public int lectureCommentDelete(String lecComSeq) {
		int n = dao.lectureCommentDelete(lecComSeq);
		return n;
	}

	// 원게시물에 딸린 댓글들을 페이징처리해서 보여주기(Ajax 로 처리)
	@Override
	public List<LectureCommentVO> getCommentListPaging(HashMap<String, String> paraMap) {
		List<LectureCommentVO> commentList = dao.getCommentListPaging(paraMap);
		return commentList;
	}

	// 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리)
	@Override
	public int getCommentTotalCount(HashMap<String, String> paraMap) {
		int totalCount = dao.getCommentTotalCount(paraMap);
		return totalCount;
	}

	// 나의 강의실 - 나의 교과목 보여주기
	@Override
	public List<HashMap<String, String>> getSubjectList(String userid) {
		List<HashMap<String, String>> subjectList = dao.getSubjectList(userid);
		return subjectList;
	}
	@Override
	public List<HashMap<String, String>> getSubjectListforP(String userid) {
		List<HashMap<String, String>> subjectListforP = dao.getSubjectListforP(userid);
		return subjectListforP;
	}

	// 강의 수정 페이지 보여주기 (유튜브영상)
	@Override
	public int lectureEdit(HashMap<String, String> paraMap) {
		int n = dao.lectureEdit(paraMap);
		return n;
	}

	// 강의 삭제하기
	@Override
	public int lectureDelete(String lecSeq) {
		int n = dao.lectureDelete(lecSeq);
		return n;
	}

	// 댓글 달리면 바로 출석 'O'로 변경하고 총 출석점수 +3점 해주기
	@Override
	public void changeAttandC(HashMap<String, String> paraMap) {
		dao.getchangeAttandO(paraMap);
		dao.getchangeAttand3(paraMap);
		
	}

	// 이미 출석이 되어있는지 확인하기
	@Override
	public String findA(HashMap<String, String> paraMap) {
		String findA = dao.findA(paraMap);
		return findA;
	}



}
