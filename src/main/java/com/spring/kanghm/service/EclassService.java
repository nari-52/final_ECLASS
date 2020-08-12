package com.spring.kanghm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.kanghm.model.FreeCommentVO;
import com.spring.kanghm.model.FreeboardVO;
import com.spring.kanghm.model.InterEclassDAO;
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

	
	
}
