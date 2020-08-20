package com.spring.moonsa.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.MyUtil;
import com.spring.moonsa.model.AttandVO;
import com.spring.moonsa.service.InterMypageService;
import com.spring.nari.model.MemberVO;

@Component

@Controller
public class MoonsaController {
	
	@Autowired
	private InterMypageService service;
	
	// 메인페이지 요청
	@RequestMapping(value="/mypageMain.up")
	public ModelAndView requiredLogin_index(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		HashMap<String, String> paraMap = new HashMap<>();
	    paraMap.put("identity", loginuser.getIdentity());
	    paraMap.put("userid", userid);
		
	    MemberVO membervo = service.getSInfo(paraMap); // 로그인한 정보 불러오기
	    List<HashMap<String, String>> subjectList = service.getSubjectList(userid); // 학생 교과목 리스트 불러오기
	    List<HashMap<String, String>> subjectListforP = service.getSubjectListforP(userid); // 교수 교과목 리스트 불러오기
	    
	    mav.addObject("membervo", membervo);
	    
		if("1".equals(loginuser.getIdentity())) {
			mav.addObject("subjectList", subjectList);
			mav.setViewName("forS/main.tiles2");
		}
		if("2".equals(loginuser.getIdentity())) {
			mav.addObject("subjectListforP", subjectListforP);
			mav.setViewName("forP/main.tiles2");
		}
		
		return mav;
	}
	
	// 출석현황 (학생)
	@RequestMapping(value="/attandS.up")
	public ModelAndView requiredLogin_attandS(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String subjectSelect = request.getParameter("subjectSelect");
		
		if(subjectSelect == null) {
			subjectSelect = "0";
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		HashMap<String, String> paraMap = new HashMap<>();
	    paraMap.put("identity", loginuser.getIdentity());
	    paraMap.put("userid", userid);
	    paraMap.put("subjectSelect", subjectSelect);
	    
	    List<HashMap<String, String>> subjectList = service.getSubjectList(userid); // 교과목 리스트 불러오기
	    
	    List<AttandVO> attandList = service.getAttandList(paraMap); // 해당 학생의 출석 리스트 불러오기
	    
	    String attandOX = service.getAttandOX(paraMap); // 총 출석 수 가져오기
	    
	    mav.addObject("subjectSelect", subjectSelect);
	    mav.addObject("subjectList", subjectList);
	    mav.addObject("attandList", attandList);
	    mav.addObject("attandOX", attandOX);
		mav.setViewName("forS/attandS.tiles2");
		
		return mav;
	}
	
	// 성적관리 (학생)
	@RequestMapping(value="/gradeS.up")
	public ModelAndView requiredLogin_gradeS(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		
		List<HashMap<String, String>> gradeList = service.getSubjectList(userid); // 해당 학생의 성적 불러오기
		
		mav.addObject("gradeList", gradeList);
		mav.setViewName("forS/gradeS.tiles2");
		
		return mav;
	}
	
	
	// 학생관리 (교수)
	@RequestMapping(value="/studentP.up")
	public ModelAndView requiredLogin_studentP(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		String subjectSelect = request.getParameter("subjectSelect");
		
		if(subjectSelect == null) {
			subjectSelect = "0";
		}
		
		List<HashMap<String, String>> subjectListforP = service.getSubjectListforP(userid); // 교수 교과목 리스트 불러오기
		List<HashMap<String, String>> studentP  = service.getStudentP(subjectSelect); // 해당 과목의 학생정적 모두 불러오기 
		
		HashMap<String, String> paraMap = new HashMap<>();
	    paraMap.put("userid", userid);
	    paraMap.put("subjectSelect", subjectSelect);
		
	    mav.addObject("subjectSelect", subjectSelect);
		mav.addObject("subjectListforP", subjectListforP);
		mav.addObject("studentP", studentP);
		mav.setViewName("forP/studentP.tiles2");
		
		return mav;
	}
	
	// 학생관리 (교수) ajax 부분
	@ResponseBody // view단이 필요 없다는것. 여긴 ajax이므로 필요없음
	@RequestMapping(value="/studentP2.up", produces="text/plain;charset=UTF-8")
	public String requiredLogin_studentP2(HttpServletRequest request, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		
		System.out.println(userid);
		String Sname = service.getSName(userid); // 수정할 학생명 가져오기
   
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("Sname", Sname);
	    
		return jsonObj.toString();
	}
	
	// 출석수정 (교수)
	@ResponseBody // view단이 필요 없다는것. 여긴 ajax이므로 필요없음
	@RequestMapping(value="/changeAttand.up", produces="text/plain;charset=UTF-8")
	public String requiredLogin_changeAttand(HttpServletRequest request, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String subjectSelect = request.getParameter("subjectSelect");
   
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("userid", userid);
	    jsonObj.put("subjectSelect", subjectSelect);
	    
		return jsonObj.toString();
	}
	
	// 출석수정 (교수) 페이지 이동
	@RequestMapping(value="/changeAttand2.up")
	public ModelAndView requiredLogin_changeAttand2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String subjectSelect = request.getParameter("subjectSelect");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
	    paraMap.put("subjectSelect", subjectSelect);
	    
	    List<AttandVO> attandList = service.getAttandList(paraMap); // 해당 학생의 출석 리스트 불러오기
	    String Sname = service.getSName(userid); // 수정할 학생명 가져오기
	    
	    String attandOX = service.getAttandOX(paraMap); // 총 출석 수 가져오기
	    
	    mav.addObject("userid", userid);
	    mav.addObject("subjectSelect", subjectSelect);
	    mav.addObject("Sname", Sname);
	    mav.addObject("attandList", attandList);
	    mav.addObject("attandOX", attandOX);
		mav.setViewName("forP/changeAttand.tiles2");
		
	    return mav;
	}
	
	// 출석수정 (교수) -- 수정버튼 누른 후 ajax
	@ResponseBody // view단이 필요 없다는것. 여긴 ajax이므로 필요없음
	@RequestMapping(value="/changeAttandEnd.up", produces="text/plain;charset=UTF-8")
	public String requiredLogin_changeAttandEnd(HttpServletRequest request, HttpServletResponse response) {
		
		String lecNum = request.getParameter("lecNum");
		String attand = request.getParameter("attand");
		String fk_userid = request.getParameter("fk_userid");
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("lecNum", lecNum);
		paraMap.put("attand", attand);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("fk_subSeq", fk_subSeq);
		
		int n = service.getChangeA(paraMap); // 출석 정보 수정하기(update)
		
		if(n == 1) {
			service.getChangeAtotal(paraMap); // 'O'로 변경될 경우 출석점수 변경
		}
		
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("n", n);
	    
		return jsonObj.toString();
	}

	// 성적수정 (교수) -- 수정버튼 누른 후 ajax
	@ResponseBody // view단이 필요 없다는것. 여긴 ajax이므로 필요없음
	@RequestMapping(value="/changeGradeEnd.up", produces="text/plain;charset=UTF-8")
	public String requiredLogin_changeGradeEnd(HttpServletRequest request, HttpServletResponse response) {
		
		String finalG = request.getParameter("finalG");
		String fk_userid = request.getParameter("fk_userid");
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("finalG", finalG);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("fk_subSeq", fk_subSeq);
		
		int n = service.getChangeG(paraMap); // 성적 정보 수정하기(update)
		
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("n", n);
	    
		return jsonObj.toString();
	}
	
}
