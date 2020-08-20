package com.spring.kanghm.model;

import java.util.HashMap;
import java.util.List;

import com.spring.kimeh.model.DonPaymentVO;
import com.spring.kimeh.model.DonStoryVO;

public interface InterEclassDAO {

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
	int addFreeComment(FreeCommentVO freecommentvo);

	// 자유게시판 댓글불러오기
	List<FreeCommentVO> freecommentList(HashMap<String, String> paraMap);

	// 자유게시판 글번호에 해당하는 댓글의 총갯수를 알아오기
	int getCommentTotalCount(HashMap<String, String> paraMap);

	// 자유게시판 댓글 삭제하기
	int delFreeComment(String delseq);

	// 자유게시판 글 삭제 완료하기
	int delfreeboard(HashMap<String, String> paraMap);

	// 자유게시판 글을 삭제하면 딸린 댓글도 같이 삭제하기
	void delComment(HashMap<String, String> paraMap);

	// 자유게시판 글 수정하기 완료하기
	int editfreeboardEnd(FreeboardVO freeboardvo);

	// 자유게시판 조회수 증가하며 글 조회하기
	FreeboardVO getFreeView(String free_seq);

	// 조회수 1증가 시키기
	void addViewCount(String free_seq);

	// 공지사항 총게시물 개수 구하기
	int getNoticeTotalCount(HashMap<String, String> paraMap);

	// 공지사항 목록 가져오기
	List<NoticeboardVO> getNoticeboardList(HashMap<String, String> paraMap);

	// 첨부파일이 존재하지 않는 공지사항 글쓰기
	int addNoticeboard(NoticeboardVO noticeboardvo);

	// 첨부파일이 존재하는 공지사항 글쓰기
	int addNoticeboard_withFile(NoticeboardVO noticeboardvo);

	// 공지사항 조회수 증가하며 글 조회하기
	NoticeboardVO getNoticeView(String notice_seq);

	// 공지사항 조회수 1증가 시키기
	void addNoticeViewCount(String notice_seq);

	// 공지사항 조회수 증가 없이 글 조회하기
	NoticeboardVO getNoticeViewNoAdd(String notice_seq);

	// 공지사항 게시판 글 수정하기 완료하기
	int editnoticeboardEnd(NoticeboardVO noticeboardvo);

	// 공지사항 게시판 글 삭제하기
	int delNoticeboard(String notice_seq);

	// Q&A 게시판 총게시물 개수 구하기
	int getQuestionTotalCount(HashMap<String, String> paraMap);

	// Q&A 게시판 목록 가져오기
	List<QuestionVO> getQuestionboardList(HashMap<String, String> paraMap);

	// 첨부파일이 존재하지 않는 Q&A 글쓰기
	int addquestion(QuestionVO questionvo);

	// 첨부파일이 존재하는 Q&A 글쓰기
	int addquestion_withFile(QuestionVO questionvo);

	// groupno 컬럼의 최대값 구하기
	int getGroupnoMax(); 

	// Q&A 조회수 증가하며 글 조회하기
	QuestionVO getQuestionView(String question_seq);

	// Q&A 조회수 1증가 시키기
	void addQuestionViewCount(String question_seq);

	// Q&A 조회수 증가 없이 글 조회하기
	QuestionVO getQuestionViewNoAdd(String question_seq);

	// Q&A 게시판 글 수정하기 완료하기
	int editquestionboardEnd(QuestionVO questionvo);

	// Q&A 게시판 글 삭제 완료하기
	int delquestion(HashMap<String, String> paraMap);

	// 메인페이지에서 공지사항 띄워주기
	List<NoticeboardVO> getindexnotice();

	// 메인페이지에서 후원순위 보여주기	
	List<DonStoryVO> getindexdon();


}
