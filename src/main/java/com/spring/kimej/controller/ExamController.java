package com.spring.kimej.controller;

import java.util.Calendar;
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
import com.spring.kimej.model.LectureVO;
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
	
	// 시험 페이지 보여주기
	@RequestMapping(value="/exam/examView.up")
	public ModelAndView examView(ModelAndView mav, HttpServletRequest request) {
		
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		List<ExamVO> examvo = service.examList(fk_subSeq);
		
		mav.addObject("examvo", examvo);
		mav.addObject("fk_subSeq", fk_subSeq);
		mav.setViewName("exam/examView.tiles1");
		return mav;
	}
	
	// 시험 출제 페이지 보여주기 (교수가 시험 게시글 쓰는 것)
	@RequestMapping(value="/exam/examRegister.up")
	public ModelAndView examRegister(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		String fk_subSeq = request.getParameter("fk_subSeq");
		paraMap.put("fk_subSeq", fk_subSeq);
		
		mav.addObject("paraMap", paraMap);
		mav.setViewName("exam/examRegister.tiles1");		
		return mav;
	}
	
	// 시험 출제 페이지 !!완료!! 보여주기 (교수가 시험 게시글 쓰는 것)
	@RequestMapping(value="/exam/examRegisterEnd.up")
	public ModelAndView examRegisterEnd(HttpServletRequest request, ModelAndView mav) {
		
		String subSeq = request.getParameter("subSeq");
		String userid = request.getParameter("userid");
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
			mav.setViewName("exam/examWrite.tiles1");
			// 시험 문제 출제 페이지로 이동
		}
		else {
			mav.setViewName("redirect:/lecture/myLecture.up");
			// 교수 마이페이지로 수정
		}
		
		return mav;
	}
	
	// 시험 수정 페이지 보여주기
	@RequestMapping(value="/exam/examEdit.up")
	public ModelAndView examEdit(HttpServletRequest request, ModelAndView mav) {
		
		String exam_seq = request.getParameter("exam_seq");
		
		ExamVO examvo = service.examDetail(exam_seq);
		examvo.setExamDate(examvo.getExamDate().substring(0, 10));
		
		mav.addObject("examvo", examvo);
		mav.setViewName("exam/examEdit.tiles1");
		return mav;
	}
	
	// 시험 수정 !!완료!! 페이지 보여주기 
	@RequestMapping(value="/exam/examEditEnd.up")
	public String examEditEnd(HttpServletRequest request) {
		
		String subSeq = request.getParameter("subSeq");
		String exam_seq = request.getParameter("exam_seq");
		String examTitle = request.getParameter("examTitle");
		String examDate = request.getParameter("examDate");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("exam_seq", exam_seq);
		paraMap.put("examTitle", examTitle);
		paraMap.put("examDate", examDate);
		
		int n = service.examEdit(paraMap);
		
		return "redirect:/exam/examView.up?fk_subSeq="+subSeq;
		// 해당 강의 페이지로 이동
		
	}
	
	// 시험 삭제하기
	@RequestMapping(value="/exam/examDelete.up")
	public String lectureDelete(HttpServletRequest request) {
		
		String exam_seq = request.getParameter("exam_seq");
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		int n = service.examDelete(exam_seq);
		
		return "redirect:/exam/examView.up?fk_subSeq="+fk_subSeq;
		
	}
	
	// 시험 문제 출제 페이지 보여주기 (교수가 시험 문제랑 정답 출제하는 것)
	@RequestMapping(value="/exam/examWrite.up")
	public ModelAndView examWrite(ModelAndView mav) {		
		mav.setViewName("exam/examWrite.tiles1");		
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
			
			service.question_insert(paraMap);
		}
		
		String msg = "출제가 완료되었습니다.";
		String loc = request.getContextPath()+"/lecture/myLecture.up";
	 	
	 	mav.addObject("msg",msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// 시험 문제 수정 페이지 보여주기
	@RequestMapping(value="/exam/examQuestionEdit.up")
	public ModelAndView examQuestionEdit(HttpServletRequest request, ModelAndView mav) {
		
		String exam_seq = request.getParameter("exam_seq");
		
		List<String> questionArr = service.getQuestions(exam_seq);
		List<String> answerArr = service.getAnswers(exam_seq);
		List<String> question_seqArr = service.getQuestionSeqs(exam_seq);
		
		mav.addObject("questionArr", questionArr);
		mav.addObject("answerArr", answerArr);
		mav.addObject("question_seqArr", question_seqArr);
		mav.addObject("exam_seq", exam_seq);
		mav.setViewName("exam/examQuestionEdit.tiles1");
		return mav;
	}
	
	// 시험 문제 수정 !!완료!! 페이지 보여주기
	@RequestMapping(value="/exam/examQuestionEditEnd.up")
	public ModelAndView examQuestionEditEnd(HttpServletRequest request, ModelAndView mav) {
		
		String sQuestion = request.getParameter("sQuestion");
		String sAnswer = request.getParameter("sAnswer");
		String sQuestion_seq = request.getParameter("sQuestion_seq");
		String exam_seq = request.getParameter("exam_seq");
		
		String[] arrQuestion = sQuestion.split(",");
		String[] arrAnswer = sAnswer.split(",");
		String[] arrQuestion_seq = sQuestion_seq.split(",");
		
		for (int i=0; i<arrQuestion.length; i++) {
			HashMap<String,String> paraMap = new HashMap<>();
			paraMap.put("question", arrQuestion[i]);
			paraMap.put("answer", arrAnswer[i]);
			paraMap.put("exam_seq", exam_seq);
			paraMap.put("question_seq", arrQuestion_seq[i]);
			
			service.question_update(paraMap);
		}
		
		String msg = "수정이 완료되었습니다.";
		String loc = request.getContextPath()+"/lecture/myLecture.up";
	 	
	 	mav.addObject("msg",msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// 시험 제출 페이지 보여주기 (학생이 시험 제출하는 것)
	@RequestMapping(value="/exam/examSubmit.up")
	public ModelAndView examSubmit(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String subSeq = request.getParameter("fk_subSeq");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_subSeq", subSeq);
		paraMap.put("userid", userid);		
		
		String examG = service.examG_select(paraMap);
		// 시험 점수 알아오기. -1이면 시험 안 본 것임.
		
		ExamVO examvo = service.examDate(subSeq);
		
		try {
			
			String examDate = examvo.getExamDate().substring(0, 10); // 시험일 / 2020-08-01
			
			Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간
			int year = currentDate.get(Calendar.YEAR); // 현재 년도
			int month = currentDate.get(Calendar.MONTH)+1;
		    String strMonth = month<10?"0"+month:String.valueOf(month); // 현재 월
		    int day = currentDate.get(Calendar.DATE);
		    String strDay = day<10?"0"+day:String.valueOf(day); // 현재 일
		    
		    String today = year+"-"+strMonth+"-"+strDay; // 오늘 / 2020-08-16
		    
		    boolean yearbool = false;
			boolean monthbool = false;
			boolean daybool = false;
			
			if( Integer.parseInt(examDate.substring(0,4)) == Integer.parseInt(today.substring(0,4)) ) {
				yearbool = true;
			}
			
			if( Integer.parseInt(examDate.substring(5,7)) == Integer.parseInt(today.substring(5,7)) ) {
				monthbool = true;
			}
			
			if( Integer.parseInt(examDate.substring(8,10)) == Integer.parseInt(today.substring(8,10)) ) {
				daybool = true;
			}
			
			if(yearbool&&monthbool&&daybool) {
				if(Integer.parseInt(examG)>=0) {
					String msg = "이미 응시한 시험입니다.";
				 	String loc = request.getContextPath()+"/lecture/myLecture.up";
				 	
				 	mav.addObject("msg",msg);
					mav.addObject("loc", loc);
					
					mav.setViewName("msg");
				}
				else {
					List<ExamQuestionVO> questionList = service.questionList(subSeq);
					mav.addObject("questionList", questionList);
					mav.addObject("subSeq", subSeq);
					mav.setViewName("exam/examSubmit.tiles1");
				}
			}
			else {
				String msg = "시험 응시일이 아닙니다.";
			 	String loc = request.getContextPath()+"/lecture/myLecture.up";
			 	
			 	mav.addObject("msg",msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			
			return mav;
			
		} catch (Exception e) {
			String msg = "시험이 없습니다.";
		 	String loc = request.getContextPath()+"/lecture/myLecture.up";
		 	
		 	mav.addObject("msg",msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
			return mav;
		}
		
			
	}
	
	
	// 시험 제출 페이지 !!완료!! 보여주기 (학생이 시험 제출하는 것)
	@RequestMapping(value="/exam/examSubmitEnd.up")
	public ModelAndView examSubmitEnd(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String examG = request.getParameter("examG");
		String subSeq = request.getParameter("subSeq");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("examG", examG);
		paraMap.put("subSeq", subSeq);
		
		int n = service.examG_insert(paraMap);
		
		// attandG 값 알아오기
		String attandG = service.getAttandG(paraMap);
		paraMap.put("attandG", attandG);
		
		// 최종 성적 입력하기
		int m = service.finalG_insert(paraMap);
		
		String msg = "제출이 완료되었습니다.";
		String loc = request.getContextPath()+"/lecture/myLecture.up";
	 	
	 	mav.addObject("msg",msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
}
