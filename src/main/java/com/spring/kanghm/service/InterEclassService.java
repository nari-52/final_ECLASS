package com.spring.kanghm.service;

import java.util.HashMap;
import java.util.List;

import com.spring.kanghm.model.FreeCommentVO;
import com.spring.kanghm.model.FreeboardVO;
import com.spring.kimeh.model.DonStoryVO;

public interface InterEclassService {

	// 첨부파일이 존재하지 않는 자유게시판 글쓰기
	int addFreeboard(FreeboardVO freeboardvo);

	// 첨부파일이 존재하는 자유게시판 글쓰기
	int addFreeboard_withFile(FreeboardVO freeboardvo);
	
	// 자유게시판 총게시물 개수 구하기
	int getFreeTotalCount(HashMap<String, String> paraMap);

	// 자유게시판 목록 가져오기
	List<FreeboardVO> getFreeboardList(HashMap<String, String> paraMap);

	// 자유게시판 조회수 증가 없이 글 조회하기
	FreeboardVO getFreeViewNoAdd(String free_seq);

	// 자유게시판 댓글쓰기
	int addFreeComment(FreeCommentVO freecommentvo) throws Throwable;

	// 자유게시판 댓글불러오기
	List<FreeCommentVO> freecommentList(HashMap<String, String> paraMap);

	// 자유게시판 글번호에 해당하는 댓글의 총갯수를 알아오기
	int getCommentTotalCount(HashMap<String, String> paraMap);

	// 자유게시판 댓글 삭제하기
	int delFreeComment(String delseq);

	// 자유게시판 글 삭제 완료하기
	int delfreeboard(HashMap<String, String> paraMap) throws Throwable;

	// 자유게시판 글 수정하기 완료하기
	int editfreeboardEnd(FreeboardVO freeboardvo);

	// 자유게시판 조회수 증가하며 글 조회하기
	FreeboardVO getFreeView(String free_seq,String userid);

	

	

}
