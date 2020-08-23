package com.spring.kanghm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.kanghm.model.FreeCommentVO;
import com.spring.kanghm.model.FreeboardVO;
import com.spring.kanghm.model.InterEclassDAO;
import com.spring.kanghm.model.NoticeboardVO;
import com.spring.kanghm.model.QuestionVO;
import com.spring.kimeh.model.DonPaymentVO;
import com.spring.kimeh.model.DonStoryVO;

//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service  
public class EclassService implements InterEclassService {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterEclassDAO dao;

	// 첨부파일이 존재하지 않는 자유게시판 글쓰기
	@Override
	public int addFreeboard(FreeboardVO freeboardvo) {
		int n = dao.addFreeboard(freeboardvo);
		return n;
	}

	// 첨부파일이 존재하는 자유게시판 글쓰기
	@Override
	public int addFreeboard_withFile(FreeboardVO freeboardvo) {
		int n = dao.addFreeboard_withFile(freeboardvo);
		return n;
	}

	// 자유게시판 총게시물 개수 구하기
	@Override
	public int getFreeTotalCount(HashMap<String, String> paraMap) {
		
		int freeTotalCount = dao.getFreeTotalCount(paraMap);
				
		return freeTotalCount;
	}

	// 자유게시판 목록 가져오기
	@Override
	public List<FreeboardVO> getFreeboardList(HashMap<String, String> paraMap) {
		
		List<FreeboardVO> freeboardList = dao.getFreeboardList(paraMap);
		
		return freeboardList;
	}

	// 자유게시판 조회수 증가 없이 글 조회하기
	@Override
	public FreeboardVO getFreeViewNoAdd(String free_seq) {
		
		FreeboardVO freeboardvo = dao.getFreeViewNoAdd(free_seq);
		
		return freeboardvo;
	}

	// 자유게시판 댓글쓰기
	@Override
	public int addFreeComment(FreeCommentVO freecommentvo) throws Throwable {
		
		int n = 0;
		
		n = dao.addFreeComment(freecommentvo);
		
		return n;
	}

	// 자유게시판 댓글불러오기
	@Override
	public List<FreeCommentVO> freecommentList(HashMap<String, String> paraMap) {
		
		List<FreeCommentVO> freecommentList = dao.freecommentList(paraMap);
		
		return freecommentList;
	}

	// 자유게시판 글번호에 해당하는 댓글의 총갯수를 알아오기
	@Override
	public int getCommentTotalCount(HashMap<String, String> paraMap) {
		
		int totalcount = dao.getCommentTotalCount(paraMap);
		
		return totalcount;
	}

	// 자유게시판 댓글 삭제하기
	@Override
	public int delFreeComment(String delseq) {

		int n = dao.delFreeComment(delseq);
		
		return n;
	}

	// 자유게시판 글 삭제 완료하기
	@Override
	public int delfreeboard(HashMap<String, String> paraMap) throws Throwable {
		
		int n = dao.delfreeboard(paraMap);
		
		if(n==1) {
			dao.delComment(paraMap);
		}
		
		return n;
	}

	// 자유게시판 글 수정하기 완료하기
	@Override
	public int editfreeboardEnd(FreeboardVO freeboardvo) {
		
		int n = dao.editfreeboardEnd(freeboardvo);
		
		return n;
	}


	// 자유게시판 조회수 증가하며 글 조회하기
	@Override
	public FreeboardVO getFreeView(String free_seq,String userid) {
		
		FreeboardVO freeboardvo = dao.getFreeView(free_seq);
		
		if(freeboardvo != null && userid != null &&
				!freeboardvo.getFk_userid().equals(userid)) {
			
			// 조회수 1 증가시키기
			dao.addViewCount(free_seq);
			freeboardvo = dao.getFreeView(free_seq);
		}
		
		return freeboardvo;
	}

	// 공지사항 총게시물 개수 구하기
	@Override
	public int getNoticeTotalCount(HashMap<String, String> paraMap) {
		
		int noticeTotalCount = dao.getNoticeTotalCount(paraMap);
		
		return noticeTotalCount;
	}

	// 공지사항 목록 가져오기
	@Override
	public List<NoticeboardVO> getNoticeboardList(HashMap<String, String> paraMap) {
		
		List<NoticeboardVO> noticeboardList = dao.getNoticeboardList(paraMap);
		
		return noticeboardList;
	}

	// 첨부파일이 존재하지 않는 공지사항 글쓰기
	@Override
	public int addNoticeboard(NoticeboardVO noticeboardvo) {
		
		int n = dao.addNoticeboard(noticeboardvo);
		
		return n;
	}

	// 첨부파일이 존재하는 공지사항 글쓰기
	@Override
	public int addNoticeboard_withFile(NoticeboardVO noticeboardvo) {
		
		int n = dao.addNoticeboard_withFile(noticeboardvo);
		
		return n;
	}

	// 공지사항 조회수 증가하며 글 조회하기
	@Override
	public NoticeboardVO getNoticeView(String notice_seq, String userid) {
		
		NoticeboardVO noticeboardvo = dao.getNoticeView(notice_seq);			
		
		// 조회수 1 증가시키기
		dao.addNoticeViewCount(notice_seq);
	
		return noticeboardvo;
	}

	// 공지사항 조회수 증가 없이 글 조회하기
	@Override
	public NoticeboardVO getNoticeViewNoAdd(String notice_seq) {
		
		NoticeboardVO noticeboardvo = dao.getNoticeViewNoAdd(notice_seq);
		
		return noticeboardvo;
	}

	
	// 공지사항 게시판 글 수정하기 완료하기
	@Override
	public int editnoticeboardEnd(NoticeboardVO noticeboardvo) {
		
		int n = dao.editnoticeboardEnd(noticeboardvo);
		
		return n;
	}
	
	// 공지사항 게시판 글 삭제하기
	@Override
	public int delNoticeboard(String notice_seq) {
		
		int n = dao.delNoticeboard(notice_seq);
		
		return n;
	}

	// Q&A 게시판 총게시물 개수 구하기
	@Override
	public int getQuestionTotalCount(HashMap<String, String> paraMap) {

		int questionTotalCount = dao.getQuestionTotalCount(paraMap);
		
		return questionTotalCount;
	}

	// Q&A 게시판 목록 가져오기
	@Override
	public List<QuestionVO> getQuestionboardList(HashMap<String, String> paraMap) {
		
		List<QuestionVO> questionboardList = dao.getQuestionboardList(paraMap);
		
		return questionboardList;
	}

	// 첨부파일이 존재하지 않는 Q&A 답변 글쓰기
	@Override
	public int addquestion(QuestionVO questionvo) {
		
		if(questionvo.getFk_seq() == null || questionvo.getFk_seq().trim().isEmpty() ) {
			int groupno = dao.getGroupnoMax();
			groupno = groupno + 1;
			questionvo.setGroupno(String.valueOf(groupno));
		}
			
		int n = dao.addquestion(questionvo);
		
		return n;
	}

	// 첨부파일이 존재하는 Q&A 글쓰기
	@Override
	public int addquestion_withFile(QuestionVO questionvo) {
		
		if(questionvo.getFk_seq() == null || questionvo.getFk_seq().trim().isEmpty() ) {
			int groupno = dao.getGroupnoMax();
			groupno = groupno + 1;
			questionvo.setGroupno(String.valueOf(groupno));			
		}
		
		int n = dao.addquestion_withFile(questionvo);
		
		return n;
	}

	// Q&A 조회수 증가하며 글 조회하기
	@Override
	public QuestionVO getQuestionView(String question_seq, String userid) {
		
		QuestionVO questionvo = dao.getQuestionView(question_seq);			
		
		// 조회수 1 증가시키기
		dao.addQuestionViewCount(question_seq);
	
		return questionvo;
	}

	// Q&A 조회수 증가 없이 글 조회하기
	@Override
	public QuestionVO getQuestionViewNoAdd(String question_seq) {
		
		QuestionVO questionvo = dao.getQuestionViewNoAdd(question_seq);
		
		return questionvo;
	}

	// Q&A 게시판 글 수정하기 완료하기
	@Override
	public int editquestionboardEnd(QuestionVO questionvo) {
		
		int n = dao.editquestionboardEnd(questionvo);
		
		return n;
	}

	// Q&A 게시판 글 삭제 완료하기
	@Override
	public int delquestion(HashMap<String, String> paraMap) {
		
		int n = dao.delquestion(paraMap);
		
		return n;
	}

	// 메인페이지에서 공지사항 띄워주기
	@Override
	public List<NoticeboardVO> getindexnotice() {

		List<NoticeboardVO> noticevo = dao.getindexnotice();
		
		return noticevo;
	}

	// 메인페이지에서 후원순위 보여주기	
	@Override
	public List<DonStoryVO> getindexdon() {
		
		List<DonStoryVO> paymentvo = dao.getindexdon();
		
		return paymentvo;
	}

	// 비밀글 글쓴이 알아오기
	@Override
	public String getQnAid(String groupno) {
		
		String qnaid = dao.getQnAid(groupno);
		
		return qnaid;
	}

	
	
}
