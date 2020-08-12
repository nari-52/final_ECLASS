package com.spring.kimkh.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.kimkh.model.LecutreMatterInsertVO;
import com.spring.kimkh.service.InterKhService;
import com.spring.nari.model.MemberVO;

@Controller
public class KimkhController {

	@Autowired
	private InterKhService service;

	@Autowired
	private FileManager fileManager;

	// 강의를 등록하는 페이지 입니다.
	@RequestMapping(value = "/SubjectMatter_insert.up")
	public ModelAndView SubjectMatter_insert(ModelAndView mav, HttpServletRequest request) {

		mav.setViewName("/forP/SubjectMatterInsert.tiles2");

		return mav;
	}

	// 강의를 등록하는 기능 입니다.
	@RequestMapping(value = "/SubjectMatter_insertEnd.up", method = { RequestMethod.POST })
	public String SubjectMatter_insertEnd(LecutreMatterInsertVO lmiv, HttpServletRequest request,MultipartHttpServletRequest mrequest) {

		List<LecutreMatterInsertVO> lmivList = service.selectMatterList(lmiv);

		////////////////// 첨부파일 시작//////////////////////
		
		  MultipartFile attach = lmiv.getAttach();
		  
		  /*
		  1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		  >>>파일이 업로드 되어질 특정 경로(폴더) 지정해주기
		  	  우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
		 */
		//WAS의 webapp 의 절대경로를 알아와야 한다.
		  HttpSession session = mrequest.getSession();
		  
		  String root = session.getServletContext().getRealPath("/");
		//C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources
		  
		  //C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources 
		  String path = root+"resources" + File.separator +"files";
		  
		  /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	운영체제가 windows 이라면 File.separator는 "\"역슬레쒸이고,
		 	운영체제가 UNIX,Linux 이라면 File.separator 는"/" 이다.
		 */	 
		  
		  //path가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다. 
		  System.out.println("~~~~~ 확인용 path => " + path);
		//~~~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files

	  
		  
		  
		 // 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
		  
		  
		  String newFilename = ""; //WAS(톰캣)의 디스크에 저장될 파일명
		  
		  byte[] bytes = null; //첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		  
		  try {
			  
		  bytes = attach.getBytes();//큰 파일을 절구통에 분해해서 lan선을 통해 내pc에서 was로 보낸다 //
		  // getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
		  // 예를 들어, 첨부한 파일이 "강아지.png"  이라면 
		  // 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
		  System.out.println("마지노선");
		  System.out.println("bytes : "+bytes);
		  System.out.println("attach.getOriginalFilename() :" + attach.getOriginalFilename());
		  newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(),path); 
		  //위의 것이 파일올리기를 해주는 것읻 
		  // attach.getOriginalFilename()은 첨부된 파일의 파일명(강아지.PNG)이다.
		  
		  System.out.println("~~~~확인용 newFilename ==>"+ newFilename);
		  
		  
		  } catch (Exception e) {//wAS로 보내다가 오류가날수있기 떄문에 TRY CATHCH를 한다
		  e.printStackTrace(); }
		  
		  
		  //3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
		  
		  lmiv.setSaveSubImg(newFilename);
		  //newFilename을 vo에 넣어준다 
		  //was에 저장될파일명(20192929292.png)
		  
		  lmiv.setSubImg(attach.getOriginalFilename());
		  //진짜 파일명 강아지.png 게시판 페이지에서 첨부된 파일명(강아지.png)을 보여줄때 및
			//사용자가 파일을 다운로드 할때 사용되어지는 파일명

		////////////////// 첨부파일 끝//////////////////////

		String fk_userid = request.getParameter("fk_userid");
		String university = request.getParameter("university");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("university", university);
		
		// 교과목 추가하기메소드
		int n = service.MatterInsert(lmiv);
		
		
		//교수마이페이지에 insert시키기	
		int m = service.ForPInter(paraMap);
		
		if(m > 0 || n > 0) {

			return "redirect:/SubjectMatterList.up";
			///mypageMainP.up 교수마이페이지
		}else {
			return "redirect:/SubjectMatter_insert.up";
		}
		
		
		

	}

	// 교과목 목록을 보여주는 페이지 입니다.
	@RequestMapping(value = "/SubjectMatterList.up")
	public ModelAndView SubjectList(ModelAndView mav, HttpServletRequest request, LecutreMatterInsertVO lmiv) {

		List<LecutreMatterInsertVO> lmivList = service.selectMatterList(lmiv);

		mav.addObject("lmivList", lmivList);

		mav.setViewName("/subjectMatterList/SubjectMatterList.tiles1");

		return mav;
	}

	// 교과목 상세보기 페이지 입니다
	@RequestMapping(value = "/SubjectMatterDetail.up")
	public ModelAndView SubjectDetail(ModelAndView mav, HttpServletRequest request) {

		String subseq = request.getParameter("subseq");

		LecutreMatterInsertVO lmivOne = service.selectOneMatterList(subseq);

		mav.addObject("lmivOne", lmivOne);

		mav.setViewName("subjectMatterList/SubjectMatterDetail.tiles1");

		return mav;
	}
	
	// 교과목 상세페이지에서 수강신청 버튼을 클릭시 학생마이페이지로 insert 시키기
	@RequestMapping(value = "/sugangInsert.up")
	public ModelAndView sugangInsert(ModelAndView mav,HttpServletRequest request) {

		String fk_subSeq = request.getParameter("subseq");
		String fk_userid = request.getParameter("fk_userid");
		
		HashMap<String,String> paraMap = new HashMap<>();
		
		paraMap.put("fk_subSeq", fk_subSeq);
		paraMap.put("fk_userid", fk_userid);
		
		 service.sugangInsert(paraMap);
	 
		 
		/*//login되어진 멤버를 가지고있어야한다 membervo 만들기
		MemberVO loginuser = service.getLoginMember(paraMap);*/
		
		/*/mypageMainS.up insert 시킨후 이동할 학생마이페이지*/
		
		//mav.addObject(attributeName, attributeValue)
		mav.setViewName("forS/main.tiles2");
		
		return mav;
		
	}

}
