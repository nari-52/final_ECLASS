package com.spring.kanghm.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
}
