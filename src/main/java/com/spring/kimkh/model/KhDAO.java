package com.spring.kimkh.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.kimej.model.LectureVO;


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

	//검색기능
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("kimkh.getTotalCount",paraMap);
		return n;
	}

	//검색기능이 있든 없든 교과목 목록보여주기
	@Override
	public List<LecutreMatterInsertVO> searchwWithPaging(HashMap<String,String> paraMap){
		List<LecutreMatterInsertVO> lmivList = sqlsession.selectList("kimkh.searchwWithPaging",paraMap);
		
		return lmivList;
	}

	//학생마이페이지에 기본 x값 10번넣기
	@Override
	public void insertAttand(HashMap<String, String> paraMap) {

		sqlsession.insert("kimkh.insertAttand",paraMap);
		
	}

	//글수정 페이지 보여주기
	@Override
	public LecutreMatterInsertVO getView(String subseq) {

		LecutreMatterInsertVO lmiv = sqlsession.selectOne("kimkh.getView",subseq);
		
		return lmiv;
	}

	//글 수정하기 요청
	@Override
	public int updateBoard(LecutreMatterInsertVO lmiv) {
		int n = sqlsession.update("kimkh.updateBoard",lmiv);
		return n;
	}
	
	@Override
	public int DeleteExam(String subseq) {
		int q = sqlsession.delete("kimkh.DeleteEaxm_tbl",subseq);
		return q;
		
	}
	
	//글 삭제
		@Override
		public int Deleteattand_tbl(String subseq) {

			int w = sqlsession.delete("kimkh.Deleteattand_tbl",subseq);
			return w;
		}

		//글 삭제
		@Override
		public int DeletemyPForS_tbl(String subseq) {

			int m = sqlsession.delete("kimkh.DeletemyPForS_tbl",subseq);
			return m;
		}
		
		@Override
		public int lectureComment_tbl(String subseq) {
			int b = sqlsession.delete("kimkh.lectureComment_tbl",subseq);
			return b;
			
		}
		
		@Override
		public int lecture_tbl(String subseq) {
			int u = sqlsession.delete("kimkh.lecture_tbl",subseq);
			return u;
			
		}

	//글 삭제		
	@Override
	public int DeleteSubject(String subseq) {
		//System.out.println("subseq"+subseq);
		int n = sqlsession.delete("kimkh.DeleteSubject",subseq);
		
		return n;
	}


	
	
	

	

	//교과목상세보기 페이지에서 강의목록보여주기
	@Override
	public List<LectureVO> selectLectureList(String subseq) {
		List<LectureVO> lvo = sqlsession.selectList("kimkh.selectLectureList",subseq);
		return lvo;
	}

	

	@Override
	public List<LecutreMatterInsertVO> searchwWithPaging() {
		List<LecutreMatterInsertVO> lmivList = sqlsession.selectList("kimkh.searchwWithPaging2");
		return lmivList;
	}

	


}
