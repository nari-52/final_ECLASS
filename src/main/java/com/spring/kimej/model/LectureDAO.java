package com.spring.kimej.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.nari.model.MemberVO;

//=== #32. DAO 선언 ===
@Repository 
public class LectureDAO implements InterLectureDAO {
	
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Resource
	private SqlSessionTemplate sqlsession;

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@Override
	public int lecture_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("lecture.lecture_insert", paraMap);
		return n;
	}

	// 강의 목록 페이지 보여주기 (차수,제목)
	@Override
	public List<LectureVO> lectureListSearch(HashMap<String, String> paraMap) {
		List<LectureVO> lectureList = sqlsession.selectList("lecture.ListSearch", paraMap);
		return lectureList;
	}

	// 강의 상세 페이지 보여주기 (유튜브영상, 댓글)
	@Override
	public LectureVO getView(String lecSeq) {
		LectureVO lecturevo = sqlsession.selectOne("lecture.getView", lecSeq);
		return lecturevo;
	}

	// 댓글 작성하기
	@Override
	public int addComment(LectureCommentVO commentvo) {
		int n = sqlsession.insert("lecture.addComment", commentvo);
		return n;
	}
	
	// 댓글 지우기
	@Override
	public int lectureCommentDelete(String lecComSeq) {
		int n = sqlsession.delete("lecture.lectureCommentDelete", lecComSeq);
		return n;
	}

	// 원게시물에 딸린 댓글들을 페이징처리해서 보여주기(Ajax 로 처리)
	@Override
	public List<LectureCommentVO> getCommentListPaging(HashMap<String, String> paraMap) {
		List<LectureCommentVO> commentList = sqlsession.selectList("lecture.getCommentListPaging", paraMap);
		return commentList;
	}

	// 총 댓글 갯수 계산
	@Override
	public int getCommentTotalCount(HashMap<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("lecture.getCommentTotalCount", paraMap);
		return totalCount;
	}

	// 나의 강의실 - 나의 교과목 보여주기
	@Override
	public List<HashMap<String, String>> getSubjectList(String userid) {
		List<HashMap<String, String>> subjectList = sqlsession.selectList("mypage.getSubjectList", userid);
		return subjectList;
	}
	@Override
	public List<HashMap<String, String>> getSubjectListforP(String userid) {
		List<HashMap<String, String>> subjectListforP = sqlsession.selectList("mypage.getSubjectListforP", userid);
		return subjectListforP;
	}

	// 강의 수정 페이지 보여주기 (유튜브영상)
	@Override
	public int lectureEdit(HashMap<String, String> paraMap) {
		int n = sqlsession.update("lecture.lectureEdit", paraMap);
		return n;
	}

	// 강의 삭제하기
	@Override
	public int lectureDelete(String lecSeq) {
		int n = sqlsession.delete("lecture.lectureDelete", lecSeq);
		return n;
	}
	
	// 댓글 달리면 바로 출석 'O'로 변경하고 총 출석점수 +3점 해주기
	@Override
	public void getchangeAttandO(HashMap<String, String> paraMap) {
		sqlsession.update("mypage.getchangeAttandO", paraMap);
		
	}
	@Override
	public void getchangeAttand3(HashMap<String, String> paraMap) {
		sqlsession.update("mypage.getchangeAttand3", paraMap);
		
	}

	// 이미 출석이 되어있는지 확인하기
	@Override
	public String findA(HashMap<String, String> paraMap) {
		String findA = sqlsession.selectOne("mypage.AAA", paraMap);
		return findA;
	}

}
