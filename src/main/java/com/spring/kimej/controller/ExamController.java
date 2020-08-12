package com.spring.kimej.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.kimej.model.ExamQuestionVO;
import com.spring.kimej.model.ExamVO;
import com.spring.kimej.service.InterExamService;
import com.spring.nari.model.MemberVO;


//=== #30. 컨트롤러 선언 === 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
  그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
  여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class ExamController {

	// 의존객체 주입하기(DI: Dependency Injection)
	@Autowired
	private InterExamService service;
	
	// 시험 출제 페이지 보여주기 (교수가 시험 게시글 쓰는 것)
	@RequestMapping(value="/exam/examRegister.up")
	public ModelAndView examRegister(ModelAndView mav) {		
		mav.setViewName("exam/examRegister.tiles2");		
		return mav;
	}
	
	// 시험 출제 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@RequestMapping(value="/exam/examRegisterEnd.up")
	public ModelAndView examRegisterEnd(HttpServletRequest request, ModelAndView mav) {		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String subSeq = request.getParameter("subSeq");
		String userid = loginuser.getUserid();
		String examTitle = request.getParameter("examTitle");
		String examDate = request.getParameter("examDate");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("subSeq", subSeq);
		paraMap.put("userid", userid);
		paraMap.put("examTitle", examTitle);
		paraMap.put("examDate", examDate);
		
		int n = service.exam_insert(paraMap);
		
		if (n>0) {
			
			ExamVO examvo = service.exam_select(examTitle);
			
			mav.addObject("examvo", examvo);
			mav.setViewName("exam/examWrite.tiles2");
			// 시험 문제 출제 페이지로 이동
		}
		else {
			mav.setViewName("exam/examRegister.tiles2"); // 교수 마이페이지로 수정
		}
		
		return mav;
	}
	
	// 시험 문제 출제 페이지 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	@RequestMapping(value="/exam/examWrite.up")
	public ModelAndView examWrite(ModelAndView mav) {		
		mav.setViewName("exam/examWrite.tiles2");		
		return mav;
	}
	
	// 시험 문제 출제 페이지 !!완료!! 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	@RequestMapping(value="/exam/examWriteEnd.up")
	public ModelAndView examWriteEnd(HttpServletRequest request, ModelAndView mav) {
				
		String sQuestion = request.getParameter("sQuestion");
		String sAnswer = request.getParameter("sAnswer");
		String exam_seq = request.getParameter("exam_seq");
		
		String[] arrQuestion = sQuestion.split(",");
		String[] arrAnswer = sAnswer.split(",");
		
		for (int i=0; i<arrQuestion.length; i++) {
			HashMap<String,String> paraMap = new HashMap<>();
			paraMap.put("question", arrQuestion[i]);
			paraMap.put("answer", arrAnswer[i]);
			paraMap.put("exam_seq", exam_seq);
			
			int n = service.question_insert(paraMap);
		}
		
		mav.setViewName("exam/examSubmit.tiles2");
		// 교수 마이페이지로 수정하기
		
		return mav;
	}
	

	
	//////////////////////////////////// 미완성. 0811 ////////////////////////////////////
	/*
	
	// 시험 제출 페이지 보여주기 (학생이 시험 제출하는 것)
	@RequestMapping(value="/exam/examSubmit.up")
	public ModelAndView examSubmit(HttpServletRequest request, ModelAndView mav) {
		
		String exam_seq = request.getParameter("exam_seq");
		List<ExamQuestionVO> questionList = service.questionList(exam_seq);
		
		mav.addObject("questionList", questionList);
		mav.setViewName("exam/examSubmit.tiles2");		
		return mav;
	}
	
	
	// 시험 제출 페이지 !!완료!! 보여주기 (학생이 시험 제출하는 것)
	@RequestMapping(value="/exam/examSubmitEnd.up")
	public ModelAndView examSubmitEnd(HttpServletRequest request, ModelAndView mav) {
		
		String examG = request.getParameter("examG");
		
		mav.setViewName("exam/examSubmit.tiles2");		
		return mav;
	}
	
	*/
	
	
	
}
