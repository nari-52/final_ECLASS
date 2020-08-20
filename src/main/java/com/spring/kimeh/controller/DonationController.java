package com.spring.kimeh.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.kimeh.model.DonPaymentVO;
import com.spring.kimeh.model.DonStoryVO;
import com.spring.kimeh.service.InterDonationService;
import com.spring.nari.model.MemberVO;
import com.spring.common.FileManager;
import com.spring.kanghm.model.FreeboardVO;

//=== 컨트롤러 선언 === 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
  그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
  여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class DonationController {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
		@Autowired
		private InterDonationService service;
		
		@Autowired // Type에 따라 알아서 Bean을 주입해준다.
		private FileManager fileManager; 
				
		// 후원하기 리스트 페이지 
		@RequestMapping(value="/donation/donationList.up")
		public ModelAndView donationList(HttpServletRequest request, ModelAndView mav) {
			
			List<DonStoryVO> donstoryList = null;
			
	    	String searchType = request.getParameter("searchType");
	    	String searchWord = request.getParameter("searchWord");
	    	String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	    	
	    	if(searchWord ==null|| searchWord.trim().isEmpty()) {
	    		searchWord = "";
	    	}
	    	if(searchType ==null|| searchType.trim().isEmpty()) {
	    		searchType = "";
	    	}
	    	
	    	HashMap <String,String> paraMap = new HashMap<>();
	    	paraMap.put("searchType", searchType);
	    	paraMap.put("searchWord", searchWord);
	    	paraMap.put("str_currentShowPageNo", str_currentShowPageNo);
	    	
	    	int totalCount = 0;
	    	int sizePerPage = 6; //한페이지당 6개 
	    	int currentShowPageNo = 0;  //현재 보여주는 페이지 번호로써, 초기치는 1페이지로 설정한다. 
	    	int totalPage = 0; //총 페이지 수 (웹프라우저상에 보여줄 총 페이지 개수, 페이지바)
	    	int startRno = 0; //시작 행번호
	    	int endRno = 0; //끝 행번호 
			
	    	totalCount = service.getTotalCount(paraMap);
			
	    	totalPage = (int)Math.ceil((double)totalCount/sizePerPage); //(double)127/10 -->12.7 --> Math.ceil(12.7)-->(int)13.0 -> 13 
	    	
	    	if(str_currentShowPageNo==null) {
	    		//게시판에 보여지는 초기화면
	    		currentShowPageNo =1; //즉, 초기화면 1페이지로 설정  	
	    	}else {
	    		try { //user가 현재페이지를 장난치면 1페이지 나오게 해라! or 음수, 전체페이지보다 많을 때
		    		currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		    		if(currentShowPageNo <1 || currentShowPageNo > totalPage) {
		    			currentShowPageNo = 1;
		    		}
				} catch (NumberFormatException  e) {
					currentShowPageNo = 1;
				}    		
	    	}
	    	
	    	startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
			endRno = startRno + sizePerPage - 1; 

			//계산된 int값을 String으로 바꾸기 
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));

			donstoryList = service.donationList(paraMap);  	
	    	//페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
			
	    	if(!"".equals(searchWord)) {
				mav.addObject("paraMap", paraMap);
			} 	
	    	// == 119. 페이지 바 만들기 ==
	    	String pageBar = "<ul style='list-style:none;'>";
	    	int blockSize = 10;
	    	
	    	int loop = 1;
	    	//loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 갯수[지금은 10개(==blockSize)]10까지만 증가하는 용도이다 
	    	int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
	    	String url = "donationList.up"; //get방식 위해 url가져오기 
	    	// == [이전]만들기 ==
	    	if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:60px; font-size:11pt'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
	    	
	    	while(!(loop > blockSize || pageNo > totalPage)) {
	    		//블럭사이즈보다 loop수가 커지면 하지마~ 
	   		
	    		//== 현재 페이지 처리 보여주기 
	    		if(pageNo == currentShowPageNo) {
	    			pageBar += "<li style='display:inline-block; width:30px; font-size:11pt; color:#00BCD4; padding:2px;'>"+pageNo+"</li>";
	    		}
	    		else {
	    			pageBar += "<li style='display:inline-block; width:30px; font-size:11pt'><a style='color:gray; text-decoration: none;' href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	    		}
	    		
	    		loop++;
	    		pageNo++; //마지막페이지가 13이 끝이라면(totalPage), pageNo증가 멈추기 
	    	}//end of while --------------------  	
	    	
	    	// == [다음]만들기 ==
	    	if( !(pageNo > totalPage)) { //맨 마지막으로 빠져나온게 아니라면 [다음]보여라!
	    		pageBar += "<li style='display:inline-block; width:60px; font-size:11pt'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	    	}
	    	pageBar += "</ul>";
	    	mav.addObject("pageBar",pageBar);
	    	
			mav.addObject("donstoryList",donstoryList);
			mav.setViewName("donation/donationList.tiles1");
			return mav;
		}
		
		//== 후원하기 리스트페이지(검색어 자동완성 기능) == //
	    @ResponseBody //뷰단이 필요없다. 그대로 보여준다.
	    @RequestMapping(value="/donation/wordSearchShow.up", produces="text/plain;charset=UTF-8")
	    public String wordSearchShow(HttpServletRequest request) {
	    	
	    	String searchType = request.getParameter("searchType");
	    	String searchWord = request.getParameter("searchWord");
	    	
	    	HashMap<String,String> paraMap = new HashMap<>();
	    	paraMap.put("searchType", searchType);
	    	paraMap.put("searchWord", searchWord);
	    	
	    	List<String> wordList = service.wordSearchShow(paraMap);
	    	
	    	JSONArray jsonArr = new JSONArray();
	    	if(wordList!=null) {
	    		
	    		for(String word :wordList) {
	    			JSONObject jsonobj = new JSONObject();
	    			jsonobj.put("word", word);    			
	    			jsonArr.put(jsonobj);    			
	    		}    		
	    	}  	
	    	return jsonArr.toString(); //뷰단이 없이 글자 그대로 보여만 줄 뿐. 
	    }   
		
		
		// 후원하기 상세페이지(스토리) 
		@RequestMapping(value="/donation/donationStory.up")
		public ModelAndView donationStory(ModelAndView mav, HttpServletRequest request) {
			String donseq = request.getParameter("donseq");
			
			//직접 /donation/donationStory.up쳤을 때 --> List로 가게 하는 방법!!!
			if(donseq==null) {
				String msg = "존재하지 않는 페이지입니다"; 
				String loc = "javascript:history.back()";
				
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("msg");
			}
			else {
				List<DonStoryVO> donstoryPage = service.donationStory(donseq);
				//seq가 없을 때
				if(donstoryPage.isEmpty()) {
					mav.setViewName("donation/donationList.tiles1");
				}
				else {
					mav.addObject("donseq",donseq);
					mav.addObject("donstoryPage",donstoryPage);
					mav.setViewName("donation/donationStory.tiles1");
				}
			}
			
			
			return mav;
		}
		
		// 후원하기 상세페이지(후원하기) 
		@RequestMapping(value="/donation/donationSupporter.up")
		public ModelAndView donationSupporter(ModelAndView mav, HttpServletRequest request) {
			
			String donseq = request.getParameter("donseq");
			//직접 /donation/donationSupporter.up쳤을 때 --> List로 가게 하는 방법!!!
			if(donseq==null) {
				String msg = "존재하지 않는 페이지입니다"; 
				String loc = "javascript:history.back()";
				
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("msg");
			}
			else {
				List<DonStoryVO> donsupporterPage = service.donationSupporter(donseq);
				
				if(donsupporterPage.isEmpty()) {
					mav.setViewName("donation/donationList.tiles1");
					
				}else {
					mav.addObject("donseq",donseq);
					mav.addObject("donsupporterPage",donsupporterPage);
					mav.setViewName("donation/donationSupporter.tiles1");
				}
			}
			return mav;
		}
		
		
		// 후원하기 상세페이지(후원하기) - 더보기 페이징 처리  
		@ResponseBody
		@RequestMapping(value="/donation/donationSupporterMoreJSON.up", produces="text/plain;charset=UTF-8")
		public String donationSupporterMoreJSON(HttpServletRequest request, HttpServletResponse response) {
			
			String donseq = request.getParameter("donseq");
			String start = request.getParameter("start");
			String len = request.getParameter("len");
			System.out.println("");
			
			//직접 /donation/donationSupporterMoreJSON.up쳤을 때 --> List로 가게 하는 방법!!!
		/*	if(donseq==null) {
				String msg = "존재하지 않는 페이지입니다"; 
				String loc = "javascript:history.back()";
								
				request.setAttribute("msg",msg);
				request.setAttribute("loc",loc);				
				return "msg";
			}
			else {*/
				
				
				HashMap<String,String> paraMap = new HashMap<>();
				
				String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
				
		    	paraMap.put("donseq", donseq);		    		
		    	paraMap.put("startRno", start); // startRno 1	9	17	25		 
				paraMap.put("endRno", end);		// endRno   8	16	24	32	
		    	
				List<DonStoryVO> donsupporterPage = service.donationSupporterMoreJSON(paraMap);	
				
				JSONArray jsonArr = new JSONArray();		
				
				for(DonStoryVO vo : donsupporterPage) {
					
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("donseq", vo.getDonseq()); //글번호					
					jsonObj.put("name", vo.getName());	   //이름				
					jsonObj.put("noName", vo.getNoName()); //이름 비공개					
					jsonObj.put("sumPayment", vo.getSumPayment()); //금액 공개
					jsonObj.put("noDonpmt", vo.getNoDonpmt());     //금액 비공개
					jsonObj.put("showDate", vo.getShowDate()); //결제시간 
															
					jsonArr.put(jsonObj);
				}	
				return jsonArr.toString();
			/*}*///end of else -----------
			
		}
		
		
		// 후원하기 결제페이지 (GET)
		@RequestMapping(value="/donation/donationPayment.up")
		public ModelAndView requiredLogin_donationPayment(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
			
			String donseq = request.getParameter("donseq");	//조회하고자 하는 글번호 
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			request.setAttribute("loginuser", loginuser);
			
			if(donseq==null) {
				String msg = "존재하지 않는 페이지입니다"; 
				String loc = "javascript:history.back()";
				
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("msg");
			}
			else {
		    	mav.addObject("donseq",donseq);
				mav.setViewName("donation/donationPayment.tiles1");
			}
			return mav;
		}
		
		// 후원하기 결제페이지 (POST)
		@RequestMapping(value="/donation/donationPaymentEnd.up" , method= {RequestMethod.POST})
		public String pointPlus_donationPaymentEnd(HashMap<String,String> paraMap,HttpServletRequest request, DonPaymentVO donpaymentvo) throws Throwable{
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			request.setAttribute("loginuser", loginuser);	
			String name = request.getParameter("name");
			String payment = request.getParameter("payment");
			String donSeq = request.getParameter("fk_donSeq");
								    	
			//결제하기 (insert) + 포인트 차감 (update)
			int n = service.donationPayment(donpaymentvo);	
			
			//포인트 주기 (update)
			paraMap.put("userid", donpaymentvo.getFk_userid());	
	    	if(n==1) { //결제가 성공되어지면 -> 후원서포터 페이지로 이동 
	    		paraMap.put("pointPlus", String.valueOf(((Integer.parseInt(donpaymentvo.getPayment())*0.1)))); // after Advice용 (글을 작성하면 포인트 100을 주기로 한다)
	    		request.setAttribute("name", name);
	    		request.setAttribute("payment", payment);
	    		request.setAttribute("fk_donSeq", donSeq);
	    		return "redirect:/donation/donationSupporter.up?donseq="+donSeq;
	    	}
	    	else { //결재 실패시 
	    		paraMap.put("pointPlus", "0");
	    		return "redirect:/donation/donatqionPayment.up?donseq="+donSeq;
	    	}				
		}
		
		
		@RequestMapping(value="/donation/pay.up")
		public ModelAndView Pay(ModelAndView mav, HttpServletRequest request) {
			
			String recieve = request.getParameter("recieve");
			
			mav.addObject("recieve",recieve);
			mav.setViewName("pay");
			return mav;
			
		}
		
		// == 후원하기 등록(관리자 GET) == --> 로그인 처리 requiredLogin_ 추가하기!  
		@RequestMapping(value="/donation/donationStoryAdd.up")
		public ModelAndView donationStoryAdd(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			request.setAttribute("loginuser", loginuser);
			
			mav.setViewName("donation/donationStoryAdd.tiles1");			
			return mav;
		}
		
		// == 후원하기 등록(관리자 POST) == --> 로그인 처리 requiredLogin_ 추가하기!  
		@RequestMapping(value="/donation/donationStoryAddEnd.up", method= {RequestMethod.POST})
		public String donationStoryAdd(HttpServletRequest request, DonStoryVO donstoryvo, MultipartHttpServletRequest mrequest) {
							
				
			MultipartFile attach = donstoryvo.getAttach();
			MultipartFile attach2 = donstoryvo.getAttach2();
				
		    if( !attach.isEmpty() ) { 				
	    		HttpSession session = mrequest.getSession();
	    		String root = session.getServletContext().getRealPath("/");
	    		String path = root + "resources" + File.separator +"files";	
	    		System.out.println("확인용 path=>" + path);
			
	    		String newFilename = ""; //WAS톰캣의 디스크에 저장될 파일명(20200727120920486361952359300.jpg)	
	    		String newFilename2 = "";
	    		byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용되는 용도	    		
	    		//long fileSize = 0;// 파일 크기를 읽어오기 위한 용도.    		
		    
	    		try {
	    			bytes = attach.getBytes(); 
	    			
	    			// fileManager.업로드할수있는메소드(바이트, 첨부되어진 파일네임.getOriginalFilename(), 경로)
	    			 newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
	    			 newFilename2 = fileManager.doFileUpload(bytes, attach2.getOriginalFilename(), path);
			        //newFilename는 파일올리기를 해주는 것이다.
	    			//attach.getOriginalFilename()은 첨부된 파일의 파일명(강아지.png)이다. 
	    			System.out.println(">>> 확인용 newFilename =>"+ newFilename);
	    			//>>> 확인용 newFilename =>20200727120920486361952359300.jpg
	    			
				} catch (Exception e) { //출력도중에 에러가 날 수 있으니 익셉션 처리! 				
					e.printStackTrace();
				}
		    
	    		/* 3. Boardvo boardvo에  fileName값과 orgFileName값과 fileSize값을 넣어줘야한다.  
		   		 	파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기   */
	    		donstoryvo.setListMainImg(newFilename); 
	    		donstoryvo.setStoryImg(newFilename2); 
	    		//WAS톰캣의 디스크에 저장될 파일명(20200727120920486361952359300.jpg)
	    		
	    		donstoryvo.setOrgListMainImg(attach.getOriginalFilename());	    		
	    		donstoryvo.setOrgStoryImg(attach2.getOriginalFilename());
	    		//게시판 페이지에서 첨부된 파일명(강아지.png)을 보여주기 및 사용자가 파일 다운시 사용되어지는 파일명
	    			    	
		    }
			
		    //== !! 첨부파일이 있는지, 없는지 알아오기 !! 끝 ==
	    	int n = 0;
	    	
	    	if(attach.isEmpty() && attach2.isEmpty()) {
	    		//첨부파일이 없는 경우라면 
	        	n = service.donationStoryAdd(donstoryvo);   
	    	}
	    	else {
	    		n = service.donationStoryAdd_withFile(donstoryvo);
	    	}

	    	if(n==1) { 	    	
	    		return "redirect:/donation/donationList.up";
				//		/donation/donationList.up페이지로 redirect(페이지이동)해라.     		
	    	}
	    	else { 	    		
	    		return "redirect:/donation/donationStoryAdd.up";
	    	}    			    
		}
		
		// == 후원하기 글수정(관리자 GET) == 
		@RequestMapping(value="/donation/donationStoryEdit.up")
		public ModelAndView editfreeboard(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
			
			// 글 수정해야할 글번호 가져오기 
			String donseq = request.getParameter("donseq");
			
			DonStoryVO donstoryvo = service.donationStoryEdit(donseq);
			
			//HttpSession session = request.getSession();
			//MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			//관리자만 보이게 하기!
			mav.addObject("donstoryvo", donstoryvo);
			mav.setViewName("donation/donationStoryEdit.tiles1");				
			
								
			return mav;
		}
		
		// == 후원하기 글수정 완료(관리자 POST) == 
		@RequestMapping(value="donation/donationStoryEditEnd.up", method= {RequestMethod.POST})
		public ModelAndView editfreeboardEnd(HttpServletRequest request, DonStoryVO donstoryvo, ModelAndView mav,MultipartHttpServletRequest mrequest) {
			
			MultipartFile attach = donstoryvo.getAttach();
			MultipartFile attach2 = donstoryvo.getAttach2();
				
		    if( !attach.isEmpty() ) { 				
	    		HttpSession session = mrequest.getSession();
	    		String root = session.getServletContext().getRealPath("/");
	    		String path = root + "resources" + File.separator +"files";	
	    		System.out.println("확인용 path=>" + path);
			
	    		String newFilename = ""; //WAS톰캣의 디스크에 저장될 파일명(20200727120920486361952359300.jpg)	
	    		String newFilename2 = "";
	    		byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용되는 용도	    	
		    
	    		try {
	    			bytes = attach.getBytes(); 
	    			
	    			 newFilename = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
	    			 newFilename2 = fileManager.doFileUpload(bytes, attach2.getOriginalFilename(), path);
	    			System.out.println(">>> 확인용 newFilename =>"+ newFilename);
	    			
				} catch (Exception e) { //출력도중에 에러가 날 수 있으니 익셉션 처리! 				
					e.printStackTrace();
				}		    
	    		donstoryvo.setListMainImg(newFilename); 
	    		donstoryvo.setStoryImg(newFilename2); 
	    		
	    		donstoryvo.setOrgListMainImg(attach.getOriginalFilename());	    		
	    		donstoryvo.setOrgStoryImg(attach2.getOriginalFilename());   			    	
		    }
			
		    //String donseq = request.getParameter("donseq");
		    //donstoryvo.setDonseq(donseq);
		    
			int n = service.donationStoryEditEnd(donstoryvo);
			
			if(n == 1) {
				mav.addObject("msg", "글수정이 성공하였습니다");
			}
			else {
				mav.addObject("msg", "글수정이 실패하였습니다");
			}
			
			mav.addObject("loc", request.getContextPath()+"/donation/donationList.up?donseq="+donstoryvo.getDonseq());
			mav.setViewName("msg");
			
			return mav;
		}

		
		// 후원스토리 댓글 삭제하기
		@ResponseBody
		@RequestMapping(value="/donation/donationStoryDel.up", method= {RequestMethod.POST})
	    public ModelAndView donationStoryDel(HttpServletRequest request,HttpServletResponse response, ModelAndView mav, DonStoryVO donstoryvo) throws Throwable { 
	    	
	    	String donseq = request.getParameter("donseq"); //글 삭제해야할 글번호 가져오기 
	    	
    		int n = service.donationStoryDel(donseq);
        	
        	if(n==1) {
        		mav.addObject("msg","삭제가 완료되었습니다");
        		mav.addObject("loc", request.getContextPath()+"/donation/donationList.up");
        		mav.setViewName("msg");
        	}
        	else {
        		mav.addObject("msg","삭제가 실패되었습니다");
        		mav.addObject("loc", request.getContextPath()+"/donation/donationList.up?donseq="+donstoryvo.getDonseq());
        		mav.setViewName("msg");
        	}        	
	    	  	
	    	return mav;
	    }    
	    
		
		
		
}