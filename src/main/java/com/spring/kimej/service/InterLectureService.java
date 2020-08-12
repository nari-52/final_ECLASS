package com.spring.kimej.service;

import java.util.HashMap;
import java.util.List;

import com.spring.kimej.model.LectureCommentVO;
import com.spring.kimej.model.LectureVO;
import com.spring.nari.model.MemberVO;

public interface InterLectureService {

	int lecture_insert(HashMap<String, String> paraMap);
	// 강의 등록 !!완료!! 페이지 보여주기 (교수용)

	List<LectureVO> lectureListSearch(HashMap<String, String> paraMap);
	// 강의 목록 페이지 보여주기 (차수,제목)

	LectureVO getView(String lecSeq);
	// 강의 상세 페이지 보여주기 (유튜브영상, 댓글)

	int addComment(LectureCommentVO commentvo);
	// 강의 댓글 달기

	List<LectureCommentVO> getCommentListPaging(HashMap<String, String> paraMap);
	// 원게시물에 딸린 댓글들을 페이징처리해서 보여주기(Ajax 로 처리)

	int getCommentTotalCount(HashMap<String, String> paraMap);
	// 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리)

	List<HashMap<String, String>> getSubjectList(String userid);
	List<HashMap<String, String>> getSubjectListforP(String userid);
	// 나의 강의실 - 나의 교과목 보여주기


}
