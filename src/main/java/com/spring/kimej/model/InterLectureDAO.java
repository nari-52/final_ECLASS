package com.spring.kimej.model;

import java.util.HashMap;
import java.util.List;

import com.spring.nari.model.MemberVO;

public interface InterLectureDAO {

	int lecture_insert(HashMap<String, String> paraMap);
	// 시험 등록 페이지 보여주기 (교수가 시험 게시글 쓰는 것)

	List<LectureVO> lectureListSearch(HashMap<String, String> paraMap);
	// 강의 목록 페이지 보여주기 (차수,제목)

	LectureVO getView(String lecSeq);
	// 강의 상세 페이지 보여주기 (유튜브영상, 댓글)

	int addComment(LectureCommentVO commentvo);
	// 강의 댓글 달기
	
	int lectureCommentDelete(String lecComSeq);
	// 강의 댓글 지우기

	List<LectureCommentVO> getCommentListPaging(HashMap<String, String> paraMap);
	// 원게시물에 딸린 댓글들을 페이징처리해서 보여주기(Ajax 로 처리)

	int getCommentTotalCount(HashMap<String, String> paraMap);
	// 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리)

	List<HashMap<String, String>> getSubjectList(String userid);
	List<HashMap<String, String>> getSubjectListforP(String userid);
	// 나의 강의실 - 나의 교과목 보여주기

	int lectureEdit(HashMap<String, String> paraMap);
	// 강의 수정 페이지 보여주기 (유튜브영상)

	int lectureDelete(String lecSeq);
	// 강의 삭제하기

	void getchangeAttandO(HashMap<String, String> paraMap);
	void getchangeAttand3(HashMap<String, String> paraMap);
	// 댓글 달리면 바로 출석 'O'로 변경하고 총 출석점수 +3점 해주기

	String findA(HashMap<String, String> paraMap);


}
