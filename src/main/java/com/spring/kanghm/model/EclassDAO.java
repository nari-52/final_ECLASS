package com.spring.kanghm.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.kimeh.model.DonPaymentVO;
import com.spring.kimeh.model.DonStoryVO;

//=== #32. DAO 선언 ===
@Repository  
public class EclassDAO implements InterEclassDAO{
	
	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	@Resource
	private SqlSessionTemplate sqlsession;

	// 첨부파일이 존재하지 않는 자유게시판 글쓰기
	@Override
	public int addFreeboard(FreeboardVO freeboardvo) {
		int n = sqlsession.insert("kanghm.addFreeboard", freeboardvo);
		return n;
	}

	// 첨부파일이 존재하는 자유게시판 글쓰기
	@Override
	public int addFreeboard_withFile(FreeboardVO freeboardvo) {
		int n = sqlsession.insert("kanghm.addFreeboard_withFile", freeboardvo);
		return n;
	}

	// 자유게시판 총게시물 개수 구하기
	@Override
	public int getFreeTotalCount(HashMap<String, String> paraMap) {
		
		int freeTotalCount = sqlsession.selectOne("kanghm.getFreeTotalCount",paraMap); 

		return freeTotalCount;
	}

	// 자유게시판 목록 가져오기
	@Override
	public List<FreeboardVO> getFreeboardList(HashMap<String, String> paraMap) {
		
		List<FreeboardVO> freeboardList = sqlsession.selectList("kanghm.getFreeboardList",paraMap);	
		
		return freeboardList;
	}

	// 자유게시판 조회수 증가 없이 글 조회하기
	@Override
	public FreeboardVO getFreeViewNoAdd(String free_seq) {
		
		FreeboardVO freeboardvo = sqlsession.selectOne("kanghm.getFreeViewNoAdd",free_seq);
		
		return freeboardvo;
	}

	// 자유게시판 댓글쓰기
	@Override
	public int addFreeComment(FreeCommentVO freecommentvo) {

		int n = sqlsession.insert("kanghm.addFreeComment",freecommentvo);
		
		return n;
	}

	// 자유게시판 댓글불러오기
	@Override
	public List<FreeCommentVO> freecommentList(HashMap<String, String> paraMap) {
		
		List<FreeCommentVO> freecommentList = sqlsession.selectList("kanghm.freecommentList",paraMap);
		
		return freecommentList;
	}

	// 자유게시판 글번호에 해당하는 댓글의 총갯수를 알아오기
	@Override
	public int getCommentTotalCount(HashMap<String, String> paraMap) {
		
		int totalcount = sqlsession.selectOne("kanghm.getCommentTotalCount",paraMap);
		
		return totalcount;
	}

	// 자유게시판 댓글 삭제하기
	@Override
	public int delFreeComment(String delseq) {
		
		int n = sqlsession.update("kanghm.delFreeComment", delseq);
		
		return n;
	}

	// 자유게시판 글 삭제 완료하기
	@Override
	public int delfreeboard(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("kanghm.delfreeboard",paraMap);
		
		return n;
	}

	// 자유게시판 글을 삭제하면 딸린 댓글도 같이 삭제하기
	@Override
	public void delComment(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("kanghm.delComment",paraMap);
		
	}

	// 자유게시판 글 수정하기 완료하기
	@Override
	public int editfreeboardEnd(FreeboardVO freeboardvo) {
		
		int n = sqlsession.update("kanghm.editfreeboardEnd",freeboardvo);
		
		return n;
	}

	// 자유게시판 조회수 증가하며 글 조회하기
	@Override
	public FreeboardVO getFreeView(String free_seq) {
		
		FreeboardVO freeboardvo = sqlsession.selectOne("kanghm.getFreeView",free_seq);
		
		return freeboardvo;
	}

	// 조회수 1증가 시키기
	@Override
	public void addViewCount(String free_seq) {
		sqlsession.update("kanghm.addViewCount",free_seq);
		
	}

	// 공지사항 총게시물 개수 구하기
	@Override
	public int getNoticeTotalCount(HashMap<String, String> paraMap) {
		
		int noticeTotalCount = sqlsession.selectOne("kanghm.getNoticeTotalCount",paraMap);
		
		return noticeTotalCount;
	}

	// 공지사항 목록 가져오기
	@Override
	public List<NoticeboardVO> getNoticeboardList(HashMap<String, String> paraMap) {
		
		List<NoticeboardVO> noticeboardList = sqlsession.selectList("kanghm.getNoticeboardList",paraMap);
		
		return noticeboardList;
	}

	// 첨부파일이 존재하지 않는 공지사항 글쓰기
	@Override
	public int addNoticeboard(NoticeboardVO noticeboardvo) {
		
		int n = sqlsession.insert("kanghm.addNoticeboard", noticeboardvo);
		
		return n;
	}

	// 첨부파일이 존재하는 공지사항 글쓰기
	@Override
	public int addNoticeboard_withFile(NoticeboardVO noticeboardvo) {
		
		int n = sqlsession.insert("kanghm.addNoticeboard_withFile", noticeboardvo);
		
		return n;
	}

	// 공지사항 조회수 증가하며 글 조회하기
	@Override
	public NoticeboardVO getNoticeView(String notice_seq) {
		
		NoticeboardVO noticeboardvo = sqlsession.selectOne("kanghm.getNoticeView",notice_seq);
		
		return noticeboardvo;
	}

	// 공지사항 조회수 1증가 시키기
	@Override
	public void addNoticeViewCount(String notice_seq) {
		
		sqlsession.update("kanghm.addNoticeViewCount",notice_seq);
	}

	// 공지사항 조회수 증가 없이 글 조회하기
	@Override
	public NoticeboardVO getNoticeViewNoAdd(String notice_seq) {
		
		NoticeboardVO noticeboardvo = sqlsession.selectOne("kanghm.getNoticeViewNoAdd",notice_seq);
		
		return noticeboardvo;
	}

	// 공지사항 게시판 글 수정하기 완료하기
	@Override
	public int editnoticeboardEnd(NoticeboardVO noticeboardvo) {
		
		int n = sqlsession.update("kanghm.editnoticeboardEnd",noticeboardvo);
		
		return n;
	}

	// 공지사항 게시판 글 삭제하기
	@Override
	public int delNoticeboard(String notice_seq) {
		
		int n = sqlsession.update("kanghm.delNoticeboard",notice_seq);
		
		return n;
	}

	// Q&A 게시판 총게시물 개수 구하기
	@Override
	public int getQuestionTotalCount(HashMap<String, String> paraMap) {
		
		int questionTotalCount = sqlsession.selectOne("kanghm.getQuestionTotalCount",paraMap);
		
		return questionTotalCount;
	}

	// Q&A 게시판 목록 가져오기
	@Override
	public List<QuestionVO> getQuestionboardList(HashMap<String, String> paraMap) {
		
		List<QuestionVO> questionboardList = sqlsession.selectList("kanghm.getQuestionboardList",paraMap);
		
		return questionboardList;
	}

	// 첨부파일이 존재하지 않는 Q&A 글쓰기
	@Override
	public int addquestion(QuestionVO questionvo) {

		int n = sqlsession.insert("kanghm.addquestion", questionvo);
		
		return n;
	}

	// 첨부파일이 존재하는 Q&A 글쓰기
	@Override
	public int addquestion_withFile(QuestionVO questionvo) {
		
		int n = sqlsession.insert("kanghm.addquestion_withFile", questionvo);
		
		return n;
	}

	// groupno 컬럼의 최대값 구하기
	@Override
	public int getGroupnoMax() {
		
		int max = sqlsession.selectOne("kanghm.getGroupnoMax");
		
		return max;
	}

	// Q&A 조회수 증가하며 글 조회하기
	@Override
	public QuestionVO getQuestionView(String question_seq) {
		
		QuestionVO questionvo = sqlsession.selectOne("kanghm.getQuestionView",question_seq);
		
		return questionvo;
		
	}

	// Q&A 조회수 1증가 시키기
	@Override
	public void addQuestionViewCount(String question_seq) {
		
		sqlsession.update("kanghm.addQuestionViewCount",question_seq);
		
	}

	// Q&A 조회수 증가 없이 글 조회하기
	@Override
	public QuestionVO getQuestionViewNoAdd(String question_seq) {
		
		QuestionVO questionvo = sqlsession.selectOne("kanghm.getQuestionViewNoAdd",question_seq);
		
		return questionvo;
	}

	// Q&A 게시판 글 수정하기 완료하기
	@Override
	public int editquestionboardEnd(QuestionVO questionvo) {
		
		int n = sqlsession.update("kanghm.editquestionboardEnd",questionvo);
		
		return n;
	}

	// Q&A 게시판 글 삭제 완료하기
	@Override
	public int delquestion(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("kanghm.delquestion",paraMap);
		
		return n;
	}

	// 메인페이지에서 공지사항 띄워주기
	@Override
	public List<NoticeboardVO> getindexnotice() {

		List<NoticeboardVO> noticevo = sqlsession.selectList("kanghm.getindexnotice");
		
		return noticevo;
	}

	// 메인페이지에서 후원순위 보여주기	
	@Override
	public List<DonStoryVO> getindexdon() {
		
		List<DonStoryVO> paymentvo = sqlsession.selectList("kanghm.getindexdon");
		
		return paymentvo;
	}
	
}
