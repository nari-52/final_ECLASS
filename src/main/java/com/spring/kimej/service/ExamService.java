package com.spring.kimej.service;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.kimej.model.InterExamDAO;

//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service  
public class ExamService implements InterExamService {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterExamDAO dao;

	// 시험 등록 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@Override
	public int exam_insert(HashMap<String, String> paraMap) {
		int n = dao.exam_insert(paraMap);
		return n;
	}
	
}
