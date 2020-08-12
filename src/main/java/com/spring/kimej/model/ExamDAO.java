package com.spring.kimej.model;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 ===
@Repository  
public class ExamDAO implements InterExamDAO{
	
	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	
	@Resource
	private SqlSessionTemplate sqlsession;

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@Override
	public int exam_insert(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("exam.exam_insert", paraMap);
		return n;
	}
	
}
