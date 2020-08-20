package com.spring.kimkh.model;

import java.util.HashMap;
import java.util.List;

import com.spring.kimej.model.LectureVO;

public interface InterKhDAO {



	int MatterInsert(LecutreMatterInsertVO lmiv);//교과목 강의 등록하기

	List<LecutreMatterInsertVO> selectMatterList(LecutreMatterInsertVO lmiv);//교과목 목록 보여주기

	LecutreMatterInsertVO selectOneMatterList(String subseq);//교과목 상세보기

	int sugangInsert(HashMap<String,String> paraMap);//수강신청 버튼 클릭시 학생마이페이지에 insert 시키기

	int ForPInter(HashMap<String, String> paraMap);//교과목 등록후 교수마이페이지에 insert하기

	int getTotalCount(HashMap<String, String> paraMap);//검색기능

	List<LecutreMatterInsertVO> searchwWithPaging(HashMap<String, String> paraMap);//검색기능이 있든 없든 교과목 목록보여주기

	void insertAttand(HashMap<String, String> paraMap);

	LecutreMatterInsertVO getView(String subseq);//글수정 페이지보여주기

	int updateBoard(LecutreMatterInsertVO lmiv);//글 수정하기 요청

	int DeleteSubject(String subseq);//글 삭제

	int DeletemyPForS_tbl(String subseq);//글 삭제

	int Deleteattand_tbl(String subseq);//글 삭제

	List<LectureVO> selectLectureList(String subseq);//교과목상세보기 페이지에서 강의목록보여주기

	int DeleteExam(String subseq);//글 삭제

	List<LecutreMatterInsertVO> searchwWithPaging();

	int lectureComment_tbl(String subseq);

	int lecture_tbl(String subseq);



}
