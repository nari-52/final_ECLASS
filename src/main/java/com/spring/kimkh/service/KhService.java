package com.spring.kimkh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
