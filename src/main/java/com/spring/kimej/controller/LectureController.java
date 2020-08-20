package com.spring.kimej.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.kimej.model.LectureCommentVO;
import com.spring.kimej.model.LectureVO;
import com.spring.kimej.service.InterLectureService;
import com.spring.nari.model.MemberVO;

//=== #30. 컨트롤러 선언 === 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
  그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
  여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class LectureController {

	// 의존객체 주입하기(DI: Dependency Injection)
	@Autowired
	private InterLectureService service;
	
	// 나의 강의실 - 나의 교과목 보여주기
	@RequestMapping(value="/lecture/myLecture.up")
	public ModelAndView requiredLogin_myLecture(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String identity = loginuser.getIdentity();
		
		HashMap<String, String> paraMap = new HashMap<>();
	    paraMap.put("identity", identity);
	    paraMap.put("userid", userid);
		
	    List<HashMap<String, String>> subjectList = service.getSubjectList(userid); // 학생 교과목 리스트 불러오기
	    List<HashMap<String, String>> subjectListforP = service.getSubjectListforP(userid); // 교수 교과목 리스트 불러오기
	    
	    mav.addObject("paraMap", paraMap);
	    
	    if("1".equals(identity)) { // 학생 나의 강의실
		    mav.addObject("subjectList", subjectList);
		    mav.setViewName("lecture/myLectureforS.tiles1");
	    }
	    if("2".equals(identity)) { // 교수 나의 강의실	
		    mav.addObject("subjectListforP", subjectListforP);
		    mav.setViewName("lecture/myLectureforP.tiles1");
	    }
	    
		return mav;
	}
	
	// 강의 등록 페이지 보여주기 (교수용)
	@RequestMapping(value="/lecture/lectureRegister.up")
	public ModelAndView lectureRegister(HttpServletRequest request, ModelAndView mav) {
		String fk_subSeq = request.getParameter("fk_subSeq");
		mav.addObject("fk_subSeq", fk_subSeq);
		mav.setViewName("lecture/lectureRegister.tiles1");		
		return mav;
	}
	
	// 강의 등록 !!완료!! 페이지 보여주기 (교수용)
	@RequestMapping(value="/lecture/lectureRegisterEnd.up")
	public String lectureRegisterEnd(HttpServletRequest request) {
		
		String fk_subSeq = request.getParameter("fk_subSeq");
		String lecNum = request.getParameter("lecNum");
		String lecTitle = request.getParameter("lecTitle");
		String lecLink = request.getParameter("lecLink");
		String lecStartday = request.getParameter("lecStartday");
		String lecEndday = request.getParameter("lecEndday");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_subSeq", fk_subSeq);
		paraMap.put("lecNum", lecNum);
		paraMap.put("lecTitle", lecTitle);
		paraMap.put("lecLink", lecLink);
		paraMap.put("lecStartday", lecStartday);
		paraMap.put("lecEndday", lecEndday);
		
		int n = service.lecture_insert(paraMap);
		
		if (n>0) {			
			return "redirect:/lecture/lectureList.up?fk_subSeq="+fk_subSeq;
			// 강의 목록 페이지로 이동
		}
		else {
			return "redirect:/lecture/myLecture.up";
			// 교수 마이페이지로 이동
		}
		
	}
	
	// 강의 목록 페이지 보여주기 (차수,제목)
	@RequestMapping(value="/lecture/lectureList.up")
	public ModelAndView lectureList(ModelAndView mav, HttpServletRequest request) {
		
		String searchWord = request.getParameter("searchWord");
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_subSeq", fk_subSeq);
		
		List<LectureVO> lectureList = service.lectureListSearch(paraMap);
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		mav.addObject("lectureList", lectureList);
		mav.setViewName("lecture/lectureList.tiles1");		
		return mav;
		
	}
	
	
	// 강의 상세 페이지 보여주기 (유튜브영상, 댓글)
	@RequestMapping(value="/lecture/lectureDetail.up")
	public ModelAndView lectureDetail(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		String identity = loginuser.getIdentity();
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("userid", userid);
		paraMap.put("identity", identity);
		
		// 조회하고자 하는 글번호 받아오기
		String lecSeq = request.getParameter("lecSeq");		
		LectureVO lecturevo = service.getView(lecSeq);
		
		// db에 입력된 링크 수정하기
		String link = lecturevo.getLecLink();
		String result = link.replace("watch?v=", "embed/");
		lecturevo.setLecLink(result);
		
		String startday = lecturevo.getLecStartday().substring(0, 10); // 시청 시작일 / 2020-08-01
		String endday = lecturevo.getLecEndday().substring(0, 10);  // 시청 마감 일 / 2020-08-01
		
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
		
		if( Integer.parseInt(startday.substring(0,4)) <= Integer.parseInt(today.substring(0,4)) &&
			Integer.parseInt(today.substring(0,4)) <= Integer.parseInt(endday.substring(0,4)) ) {
				yearbool = true;
		}
		
		if( Integer.parseInt(startday.substring(5,7)) <= Integer.parseInt(today.substring(5,7)) &&
			Integer.parseInt(today.substring(5,7)) <= Integer.parseInt(endday.substring(5,7)) ) {
				monthbool = true;
		}
		
		if( Integer.parseInt(startday.substring(8,10)) <= Integer.parseInt(today.substring(8,10)) &&
			Integer.parseInt(today.substring(8,10)) <= Integer.parseInt(endday.substring(8,10)) ) {
				daybool = true;
		}
		
		if("1".equals(identity)) {
			if(yearbool&&monthbool&&daybool) {
				mav.addObject("lecturevo", lecturevo);
				mav.addObject("paraMap", paraMap);
				mav.setViewName("lecture/lectureDetail.tiles1");
			}
			else {
				String msg = "수강이 불가능합니다.";
			 	String loc = request.getContextPath()+"/lecture/lectureList.up?fk_subSeq="+lecturevo.getFk_subSeq();
			 	
			 	mav.addObject("msg",msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
		}
		else {
			mav.addObject("lecturevo", lecturevo);
			mav.addObject("paraMap", paraMap);
			mav.setViewName("lecture/lectureDetail.tiles1");
		}
				
		return mav;
	}
	
	// 강의 수정 페이지 보여주기 (유튜브영상)
	@RequestMapping(value="/lecture/lectureEdit.up")
	public ModelAndView lectureEdit(HttpServletRequest request, ModelAndView mav) {
		
		String lecSeq = request.getParameter("lecSeq");		
		LectureVO lecturevo = service.getView(lecSeq);
		
		// db에 입력된 링크 수정하기
		String link = lecturevo.getLecLink();
		String result = link.replace("watch?v=", "embed/");
		lecturevo.setLecLink(result);
		lecturevo.setLecStartday(lecturevo.getLecStartday().substring(0, 10));
		lecturevo.setLecEndday(lecturevo.getLecEndday().substring(0, 10));
		
		mav.addObject("lecturevo", lecturevo);
		mav.setViewName("lecture/lectureEdit.tiles1");
		return mav;
	}
	
	// 강의 수정 !!완료!! 페이지 보여주기 (유튜브영상)
	@RequestMapping(value="/lecture/lectureEditEnd.up")
	public String lectureEditEnd(HttpServletRequest request) {
		
		String lecSeq = request.getParameter("lecSeq");
		String lecNum = request.getParameter("lecNum");
		String lecTitle = request.getParameter("lecTitle");
		String lecLink = request.getParameter("lecLink");
		String lecStartday = request.getParameter("lecStartday");		
		String lecEndday = request.getParameter("lecEndday");
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("lecSeq", lecSeq);
		paraMap.put("lecNum", lecNum);
		paraMap.put("lecTitle", lecTitle);
		paraMap.put("lecLink", lecLink);
		paraMap.put("lecStartday", lecStartday);
		paraMap.put("lecEndday", lecEndday);
		
		service.lectureEdit(paraMap);
		
		return "redirect:/lecture/lectureDetail.up?lecSeq="+lecSeq;
		// 해당 강의 페이지로 이동
		
	}
	
	// 강의 삭제하기
	@RequestMapping(value="/lecture/lectureDelete.up")
	public String lectureDelete(HttpServletRequest request) {
		
		String lecSeq = request.getParameter("lecSeq");
		String fk_subSeq = request.getParameter("fk_subSeq");
		
		int n = service.lectureDelete(lecSeq);
		
		if(n>0) {
			return "redirect:/lecture/lectureList.up?fk_subSeq="+fk_subSeq;
		}
		else {
			return "redirect:/lecture/lectureDetail.up?lecSeq="+lecSeq;
		}
		
	}
	
///////////////////////////////////////////////////////////////   댓글   ///////////////////////////////////////////////////////////////
	
	// 댓글쓰기(Ajax 로 처리) ===
	@ResponseBody
	@RequestMapping(value="/lecture/addComment.up", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")      
	public String addComment(HashMap<String, String> paraMap, LectureCommentVO commentvo, HttpServletRequest request) {
		
		String jsonStr = "";
		String fk_userid = request.getParameter("fk_userid");
		String fk_lecSeq = request.getParameter("fk_lecSeq");
		String fk_subSeq = request.getParameter("fk_subSeq");
		String lecNum = request.getParameter("lecNum");
		
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("fk_lecSeq", fk_lecSeq);
		paraMap.put("fk_subSeq", fk_subSeq);
		paraMap.put("lecNum", lecNum);
		
		// 이미 출석이 되어있는지 확인하기
		String findA = service.findA(paraMap);
		
		try {	      		
			int n = service.addComment(commentvo);
			
			if(findA != null) {
				service.changeAttandC(paraMap); // 댓글 달리면 바로 출석 'O'로 변경하고 총 출석점수 +3점 해주기
			}
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);		   	
		   
			jsonStr = jsonObj.toString();
	   
		} catch (Throwable e) {			
			e.printStackTrace();
		}
	   
		return jsonStr;
	}
		
	
	
	// 원게시물에 딸린 댓글들을 페이징처리해서 조회해오기(Ajax 로  처리) ===
	@ResponseBody
	@RequestMapping(value="/lecture/commentList.up", produces="text/plain;charset=UTF-8")
	public String commentList(HttpServletRequest request) {
	   
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String fk_lecSeq = request.getParameter("fk_lecSeq");
		String fk_subSeq = request.getParameter("fk_subSeq");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
	   
		int sizePerPage = 5; // 한 페이지당 5개의 댓글을 보여줄 것이다.
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
		int endRno = startRno + sizePerPage - 1;
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lecSeq", fk_lecSeq);
		paraMap.put("fk_subSeq", fk_subSeq);  
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
	   
	   List<LectureCommentVO> commentList = service.getCommentListPaging(paraMap);
	   
	   JSONArray jsonArr = new JSONArray();
	   
	   if(commentList != null) {
		   for(LectureCommentVO cmtvo : commentList) {
		       JSONObject jsonObj = new JSONObject();
		       jsonObj.put("loginuser", loginuser.getUserid());
		       jsonObj.put("fk_userid", cmtvo.getFk_userid());
		       jsonObj.put("comContent", cmtvo.getComContent());
	   		   jsonObj.put("writeday", cmtvo.getWriteday());
	   		   jsonObj.put("lecComSeq", cmtvo.getLecComSeq());
		    		
		       jsonArr.put(jsonObj);
		    }
	   }
	    
	   return jsonArr.toString();
	}
	
	// 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리)
	@ResponseBody
	@RequestMapping(value="/lecture/getCommentTotalPage.up") 
	public String getCommentTotalPage(HttpServletRequest request) {
		
		String fk_lecSeq = request.getParameter("fk_lecSeq");
	    String fk_subSeq = request.getParameter("fk_subSeq"); 
	    String sizePerPage = request.getParameter("sizePerPage"); 
	   
	    HashMap<String,String> paraMap = new HashMap<>();
	    paraMap.put("fk_lecSeq", fk_lecSeq);
	    paraMap.put("fk_subSeq", fk_subSeq);
	   
	    // 원글 에 해당하는 댓글의 총갯수를 알아오기 
	    int totalCount = service.getCommentTotalCount(paraMap);
	   
	    // 총페이지수(totalPage)구하기
	    int totalPage = (int) Math.ceil( (double)totalCount/ Integer.parseInt(sizePerPage) );
	   
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("totalPage", totalPage);
	   
	    return jsonObj.toString();
	}
	
	// 댓글 삭제하기
	@RequestMapping(value="/lecture/lectureCommentDelete.up") 
	public String lectureCommentDelete(HttpServletRequest request) {
		
		String lecSeq = request.getParameter("lecSeq");
		String lecComSeq = request.getParameter("lecComSeq");
		
		service.lectureCommentDelete(lecComSeq);
		
		return "redirect:/lecture/lectureDetail.up?lecSeq="+lecSeq;
		
	}
	
	
	
	
	
}
