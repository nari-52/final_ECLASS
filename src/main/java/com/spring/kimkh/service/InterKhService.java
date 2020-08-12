package com.spring.kimkh.service;

import java.util.HashMap;
import java.util.List;

import com.spring.kimkh.model.LecutreMatterInsertVO;

public interface InterKhService {


	int MatterInsert(LecutreMatterInsertVO lmiv);//교과목 등록하기

	List<LecutreMatterInsertVO> selectMatterList(LecutreMatterInsertVO lmiv);//교과목 목록에 보여주기

	LecutreMatterInsertVO selectOneMatterList(String subseq);//교과목 상세보기 페이지

	int sugangInsert(HashMap<String,String> paraMap);//수강신청 버튼 클릭시 학생마이페이지에 insert 시키기

	int ForPInter(HashMap<String, String> paraMap);//교과목 등록후 교수마이페이지에 insert하기
	

	


}
