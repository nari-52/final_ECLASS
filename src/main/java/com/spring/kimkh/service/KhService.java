package com.spring.kimkh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.kimej.model.LectureVO;
import com.spring.kimkh.model.InterKhDAO;
import com.spring.kimkh.model.LecutreMatterInsertVO;

@Service
public class KhService implements InterKhService {

	@Autowired
	private InterKhDAO dao;
	

	//교과목 insert
	@Override
	public int MatterInsert(LecutreMatterInsertVO lmiv) {

		int n = dao.MatterInsert(lmiv);
		
		return n;
	}


	//교과목 목록에 select
	@Override
	public List<LecutreMatterInsertVO> selectMatterList(LecutreMatterInsertVO lmiv) {

		List<LecutreMatterInsertVO> lmivList = dao.selectMatterList(lmiv);
		
		return lmivList;
	}

	//교과목 상세보기 select
	@Override
	public LecutreMatterInsertVO selectOneMatterList(String subseq) {

		LecutreMatterInsertVO lmivOne = dao.selectOneMatterList(subseq);
		
		
		
		return lmivOne;
	}


	////수강신청 버튼 클릭시 학생마이페이지에 insert 시키기
	@Override
	public int sugangInsert(HashMap<String,String> paraMap) {
		
		int n = dao.sugangInsert(paraMap);
		
		
		
		return n;
	}


	//교과목 등록후 교수마이페이지에 insert하기
	@Override
	public int ForPInter(HashMap<String, String> paraMap) {

		int m = dao.ForPInter(paraMap);
		
		return m;
	}


	//검색기능
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {

		int n = dao.getTotalCount(paraMap);
		
		return n;
	}


	//교과목 목록보이기
	@Override
	public List<LecutreMatterInsertVO> searchwWithPaging(HashMap<String, String> paraMap) {
		List<LecutreMatterInsertVO> lmivList = dao.searchwWithPaging(paraMap);
		return lmivList;
	}

	//학생마이페이지에 기본 x값 10번넣기
	@Override
	public void insertAttand(HashMap<String, String> paraMap) {
		dao.insertAttand(paraMap);
		
	}

	//글수정하기 페이지 보여주기
	@Override
	public LecutreMatterInsertVO getViewWithNoAddCount(String subseq) {

		LecutreMatterInsertVO lmiv = dao.getView(subseq);
		
		return lmiv;
	}


	//글 수정하기 요청
	@Override
	public int edit(LecutreMatterInsertVO lmiv) {
		int n = dao.updateBoard(lmiv);
		return n;
	}


	//글 삭제
	@Override
	@Transactional
	public int DeleteSubject(String subseq) {
	
		//dao.DeleteExam(subseq);
		//int w = dao.Deleteattand_tbl(subseq);
		//int m = dao.DeletemyPForS_tbl(subseq);
		//dao.lectureComment_tbl(subseq);
		//dao.lecture_tbl(subseq);
		int n = dao.DeleteSubject(subseq);
		
		
		
		return n;
	}


	//교과목상세보기 페이지에서 강의목록보여주기
	@Override
	public List<LectureVO> selectLectureList(String subseq) {
		List<LectureVO> lvo = dao.selectLectureList(subseq);
		return lvo;
	}


	@Override
	public List<LecutreMatterInsertVO> searchwWithPaging() {
		List<LecutreMatterInsertVO> lmivList = dao.searchwWithPaging();
		return lmivList;
	}
}
