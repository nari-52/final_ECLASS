package com.spring.kimkh.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class KhDAO implements InterKhDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	//교과목 insert하기
	@Override
	public int MatterInsert(LecutreMatterInsertVO lmiv) {

		int n = sqlsession.insert("kimkh.MatterInsert",lmiv);
		
		return n;
	}

	//교과목 select 하기
	@Override
	public List<LecutreMatterInsertVO> selectMatterList(LecutreMatterInsertVO lmiv) {

		List<LecutreMatterInsertVO> lmivList = sqlsession.selectList("kimkh.selectMatterList",lmiv);
		
		return lmivList;
	}

	//교과목 상세보기
	@Override
	public LecutreMatterInsertVO selectOneMatterList(String subseq) {

		LecutreMatterInsertVO lmivOne = sqlsession.selectOne("kimkh.selectOnekh",subseq);
		
		return lmivOne;
	}

	//수강신청 버튼 클릭시 학생마이페이지에 insert 시키기
	@Override
	public int sugangInsert(HashMap<String,String> paraMap) {
	
		int n = sqlsession.insert("kimkh.sugangInsert",paraMap);
		
		return n;
	}

	//교과목 등록후 교수마이페이지에 insert하기
	@Override
	public int ForPInter(HashMap<String, String> paraMap) {

		int m = sqlsession.insert("kimkh.ForPInter",paraMap);
		
		return m;
	}


}
