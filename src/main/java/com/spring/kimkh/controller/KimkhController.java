package com.spring.kimkh.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.spring.common.MyUtil;
import com.spring.kimej.model.LectureVO;
import com.spring.kimkh.model.LecutreMatterInsertVO;
import com.spring.kimkh.service.InterKhService;
import com.spring.nari.model.MemberVO;

@Controller
public class KimkhController {

	@Autowired
	private InterKhService service;

	@Autowired
	private FileManager fileManager;

	// 교과목 등록하는 페이지 입니다.
	@RequestMapping(value = "/SubjectMatter_insert.up")
	public ModelAndView requiredLogin_SubjectMatter_insert(HttpServletRequest request, HttpServletResponse response , ModelAndView mav) {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if(loginuser.getUserid().equals("")) {
			
			String msg = "로그인 후 접속해주세요";
			String loc = request.getContextPath()+"/index.up";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		
		mav.setViewName("/forP/SubjectMatterInsert.tiles2");

		return mav;
	}

	// 교과목 등록하는 기능 입니다.
	@RequestMapping(value = "/SubjectMatter_insertEnd.up", method = { RequestMethod.POST })
	public String SubjectMatter_insertEnd(LecutreMatterInsertVO lmiv, HttpServletRequest request,MultipartHttpServletRequest mrequest) {

		HttpSession session1 = request.getSession();
		MemberVO loginuser = (MemberVO) session1.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
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
		//C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\eclass\resources
		  
		  //C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources 
		  String path = root+"resources" + File.separator +"files";
		  
		  /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	운영체제가 windows 이라면 File.separator는 "\"역슬레쒸이고,
		 	운영체제가 UNIX,Linux 이라면 File.separator 는"/" 이다.
		 */	 
		  
		  //path가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다. 
		  //System.out.println("~~~~~ 확인용 path => " + path);
		//~~~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files

	  
		  
		  
		 // 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
		  
		  
		  String newFilename = ""; //WAS(톰캣)의 디스크에 저장될 파일명
		  
		  byte[] bytes = null; //첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		  
		  try {
			  
		  bytes = attach.getBytes();//큰 파일을 절구통에 분해해서 lan선을 통해 내pc에서 was로 보낸다 //
		  // getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
		  // 예를 들어, 첨부한 파일이 "강아지.png"  이라면 
		  // 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
		 
		  //System.out.println("bytes : "+bytes);
		  //System.out.println("attach.getOriginalFilename() :" + attach.getOriginalFilename());
		  newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(),path);
		  
		  //위의 것이 파일올리기를 해주는 것읻 
		  // attach.getOriginalFilename()은 첨부된 파일의 파일명(강아지.PNG)이다.
		  
		  } catch (Exception e) {//wAS로 보내다가 오류가날수있기 떄문에 TRY CATHCH를 한다
		  e.printStackTrace(); }
		  
		  
		  //3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
		  
		  lmiv.setSaveSubImg(newFilename);
		  //newFilename을 vo에 넣어준다 
		  //was에 저장될파일명(20192929292.png)
		  
		  lmiv.setSubImg(attach.getOriginalFilename());
		  //진짜 파일명 강아지.png 게시판 페이지에서 첨부된 파일명(강아지.png)을 보여줄때 및
		//사용자가 파일을 다운로드 할때 사용되어지는 파일명

		 // System.out.println("~~~~확인용 newFilename ==>"+ newFilename);
		 // System.out.println("----확인용 subImg :" + lmiv.getSubImg());
		 // System.out.println("----확인용 SaveSubImg :" + lmiv.getSaveSubImg());
		  
		////////////////// 첨부파일 끝//////////////////////

		//String userid = request.getParameter("fk_userid");
		String university = request.getParameter("university");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("university", university);
		
		// 교과목 추가하기메소드
		int n = service.MatterInsert(lmiv);
		
		
		//교수마이페이지에 insert시키기	
		int m = service.ForPInter(paraMap);
		
		String subseq = lmiv.getSubseq();
		System.out.println("subseq : "+subseq);
		
		//LecutreMatterInsertVO subseq = service.selectOneMatterList();
		if(m > 0 || n > 0) {

			String msg = "교과목 등록이 완료되었습니다.";

			
			
		 	//String loc = request.getContextPath()+"/SubjectMatterDetail.up?subseq="+subseq;
			String loc = request.getContextPath()+"/SubjectMatterList.up";
		 	request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
		 	
			return "msg";
			///mypageMainP.up 교수마이페이지
		}else {
			String msg = "교과목 등록을 다시 시도하여주십시오.";

		 	String loc = request.getContextPath()+"/SubjectMatter_insert.up";
			
		 	request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			return "msg";
		}
		
		
		

	}

	// 교과목 목록을 보여주는 페이지 입니다.
	@RequestMapping(value = "/SubjectMatterList.up")
	public ModelAndView SubjectList(ModelAndView mav, HttpServletRequest request, LecutreMatterInsertVO lmiv) {

		List<LecutreMatterInsertVO> lmivList = null;

		String status = request.getParameter("status1");
		//System.out.println(status);
		if(status == null || status.trim().isEmpty()) {
			status = "";
		}
		
		/////////////////페이징 처리///////////////////////
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(searchType == null) {
			searchType = "";
		}
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("status", status);
		
		int totalCount = 0; //총 게시물 건수
		int sizePerPage	= 6;//한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0;//현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다
		int totalPage = 0;//총 페이지 수(웹브라우저상에 보여줄 총 페이지 개수,페이지바)
		
		int startRno = 0;//시작 행번호
		int endRno = 0;//끝 행번호
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야한다
					// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나누어진다
		totalCount = service.getTotalCount(paraMap);
		//System.out.println("totalCount :"+totalCount);
		
		//만약에 총 게시물 건수(totalCount)가 127개 이라면
		//총 페이지 수(totalPage)는 13개가 되어야 한다.
		totalPage = (int) Math.ceil ((double)totalCount/sizePerPage); 
		// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> (int)13.0 0아니면 얘보다 크게나온다
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> (int)12.0
		
		if(str_currentShowPageNo == null) {
			//게시판에 보여지는 초기화면
			
			currentShowPageNo =1;
			// 즉,초기화면인/list.action은 /list.action?currentShowPageNo=1로 하겠다는 말이다
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo< 1 || currentShowPageNo> totalPage) {
					currentShowPageNo =1;
				}
			}catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		
		  /*  currentShowPageNo      startRno     endRno
		    --------------------------------------------
		         1 page        ===>    1           10
		         2 page        ===>    11          20
		         3 page        ===>    21          30
		         4 page        ===>    31          40
		         ......                ...         ...*/
		 
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 


		paraMap.put("startRno",String.valueOf(startRno)); //startRno은 string타입이안맞기 때문에 올수없다(곱하기,빼기) String으로바꿔야한다
		paraMap.put("endRno",String.valueOf(endRno));
		
		lmivList = service.searchwWithPaging(paraMap);
		//service.selectMatterList(lmiv)
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap",paraMap);
		}
		// == #119.페이지바 만들기 ==
		String pageBar = "<ul style='list-style: none;'>";
		
		int blockSize = 5;
		//blockSize 는 1개블럭(토막)당 보여지는 페이지번호의 개수이다.
		
		  /* 1 2 3 4 5 6 7 8 9 10 다음 			 --1개블럭
		 이전 11 12 13 14 15 16 17 18 19 20 다음 --1개블럭
		 이전 21 22 23*/
		 
		
		int loop = 1;
		
		 	//loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[지금은 10개(==blockSize)까지만 증가하는 용도]
		 
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
	
		
		String url = "SubjectMatterList.up";//URL어느페이지로 가겠습니까? get방식이기때문에 뒤에?붙을수있다
		
		// ===[이전] 만들기 ===
		if(pageNo != 1) {//첫번째페이지가아니라 두번째페이지부터 이전을 만드렁라
		pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop > blockSize || pageNo > totalPage)) {//while문을 빠져나가는 좆건문
			
			//1 2 3 4 5 6 7 8 9 10 그다음에 11이되면 blockSize와 비교하고 빠져나간다
			//24가 끝이라 totalpage보다 크면 빠져나간다
			if(pageNo == currentShowPageNo) {//현재보고자하는 페이지넘버가
				pageBar += "<li style='display:inline-block; width:20px; font-size:12pt; color:pink; padding:2px 4px;'>"+pageNo+"</li>";
			}else {
				pageBar += "<li style='display:inline-block; width:20px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}//end while
		
		// ===[다음] 만들기 ===
		if(!(pageNo > totalPage)) {//맨마지막껄로 빠져나온게 아니라면
		pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);//request 영역에 담는다
		
		String gobackURL = MyUtil.getCurrentURL(request);
		// #121.페이징 처리되어진 후 특정글제목을 클릭하여 상세내용을 본 이후
		// 사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		// 현재 페이지 주소를 뷰단으로 넘겨준다.
		mav.addObject("gobackURL", gobackURL);
		//System.out.println("~~~~~확인용 gobackURL:"+gobackURL);	
		
		////////////////페이징 처리 끝 /////////////////////

		
		mav.addObject("lmivList", lmivList);

		mav.setViewName("/subjectMatterList/SubjectMatterList.tiles1");

		return mav;
	}

	// 교과목 상세보기 페이지 입니다
	@RequestMapping(value = "/SubjectMatterDetail.up")
	public ModelAndView SubjectDetail(ModelAndView mav, HttpServletRequest request) {

		String subseq = request.getParameter("subseq");

		LecutreMatterInsertVO lmivOne = service.selectOneMatterList(subseq);

		List<LectureVO> lvoList = service.selectLectureList(subseq);
		
		mav.addObject("lmivOne", lmivOne);
		mav.addObject("lvoList", lvoList);

		mav.setViewName("subjectMatterList/SubjectMatterDetail.tiles1");

		return mav;
	}
	
	// 교과목 상세페이지에서 수강신청 버튼을 클릭시 학생마이페이지로 insert 시키기
	@RequestMapping(value = "/sugangInsert.up")
	public ModelAndView requiredLogin_sugangInsert(HttpServletRequest request, HttpServletResponse response , ModelAndView mav) {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		
		//if(userid != null) {
		
		String fk_subSeq = request.getParameter("subseq");
	
		HashMap<String,String> paraMap = new HashMap<>();
		
		paraMap.put("fk_subSeq", fk_subSeq);
		paraMap.put("userid", userid);

		 //if() {
		try {
		 int n = service.sugangInsert(paraMap); 
		 
		
		 
		 if(n > 0) {
		 
			for(int i=1; i<11; i++) {
				paraMap.put("i", String.valueOf(i));
				
				service.insertAttand(paraMap);
			}
			 
		 	String msg = "수강신청이 완료되었습니다.";

		 	String loc = request.getContextPath()+"/mypageMain.up";
		 	
		 	mav.addObject("msg",msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		 }else {
			 String msg = "수강신청이 실패하였습니다 다시 시도하여 주십시오.";

			 	String loc = request.getContextPath()+"login/login.up";
			 	
			 	mav.addObject("msg",msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
		 }
		 
		 //}

		return mav;
		
		}catch(Exception e){
			String msg = "수강신청은 1회만 할수있습니다.";

		 	String loc = request.getContextPath()+"/SubjectMatterList.up";
		 	
		 	mav.addObject("msg",msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		return mav;
	}
	

	//교과목 수정하기
		@RequestMapping(value = "/SubjectMatterModify.up")
		public ModelAndView requiredLogin_SubjectMatterModify(HttpServletRequest request, HttpServletResponse response , ModelAndView mav) {
			//같은교수만 삭제할수있게
			String subseq = request.getParameter("subseq");
	
			
			//System.out.println("userid : "+fk_userid); null
			LecutreMatterInsertVO lmiv = service.getViewWithNoAddCount(subseq);
			
			HttpSession session1 = request.getSession();
			MemberVO loginuser = (MemberVO) session1.getAttribute("loginuser");
			//String userid = loginuser.getUserid();
			//System.out.println("유저알아보기 :"+loginuser.getUserid()); 
			//System.out.println("유저알아보기 :"+lmiv.getFk_userid());
			if( !loginuser.getUserid().equals(lmiv.getFk_userid())) {
				//글쓴사람의 아이디와 글쓰려고하는 사람의 아이디가 같지 않다면
					String msg = "본인이 등록한 교과목만 수정이 가능합니다";
					String loc = "javascript:history.back()";
					
					mav.addObject("msg",msg);
					mav.addObject("loc",loc);
					
					mav.setViewName("msg");//우선순위 2번째
				}
				else {
					// 자신의 글을 수정할 경우
					// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
					
					mav.addObject("lmiv",lmiv);
					
					mav.setViewName("subjectMatterList/SubjectModify.tiles1");
				}
			
			return mav;
		}
		
		//글 수정하기 요청
		@RequestMapping(value="/SubjectMatterModifyEnd.up", method= {RequestMethod.POST})
		public String editEnd(HttpServletRequest request,LecutreMatterInsertVO lmiv) { //form태그에 있는 vo에있는 필드명과 같으면 request.getparameter할 필요없다
			
			
			
			int n = service.edit(lmiv);
			
			
					
		
				request.setAttribute("msg","글 수정이 완료되었습니다");
			
				request.setAttribute("loc", request.getContextPath()+"/SubjectMatterList.up?subseq="+lmiv.getSubseq());
			
			
			return "msg";
		}
		
		@RequestMapping(value="/SubjectMatterDelete.up")
		public String requiredLogin_DeleteSubject(HttpServletRequest request, HttpServletResponse response) {

			
			String subseq = request.getParameter("subseq");
			String fk_userid = request.getParameter("fk_userid");

				HttpSession session = request.getSession();
				
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				//String userid = loginuser.getUserid();
				//System.out.println("유저알아보기 :"+loginuser.getUserid()); 
				//System.out.println("유저알아보기 :"+fk_userid);	
			
				//List<LecutreMatterInsertVO> lmivList = service.searchwWithPaging();
				//LecutreMatterInsertVO subjectDelete = service.viewDeleteLecutre(subseq);
				
				if(!loginuser.getUserid().equals(fk_userid)) {
					
					String msg = "다른 사용자의 글은 삭제할수 없습니다";
					String loc = "javascript:history.back()";
					
					request.setAttribute("msg",msg);
					request.setAttribute("loc",loc);
	
					return "msg";
			    }else {
		
					
					//System.out.println("subseq"+subseq);
					int n = service.DeleteSubject(subseq);
					
					String msg = "교과목 삭제가 완료되었습니다.";
					String loc = request.getContextPath()+"/SubjectMatterList.up";
					
					request.setAttribute("msg",msg);
					request.setAttribute("loc",loc);
					
					return "msg";
			  //  }
			
		
			
			
		}
		
		}
}

		