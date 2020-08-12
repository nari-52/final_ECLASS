package com.spring.kanghm.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.common.MyUtil;
import com.spring.kanghm.model.FreeCommentVO;
import com.spring.kanghm.model.FreeboardVO;
import com.spring.kanghm.service.InterEclassService;
import com.spring.nari.model.MemberVO;

//=== #30. 컨트롤러 선언 === 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
  그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
  여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class EclassController {

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
		@Autowired
		private InterEclassService service;
	
	// ===== #150. 파일업로드 및 다운로드를 해주는  FileManager 클래스 의존객체 주입하기(DI:Dependency Injection)  =====
	@Autowired // Type에 따라 알아서 Bean을 주입해준다.
	private FileManager fileManager; 
		
		// 메인페이지 요청
		@RequestMapping(value="/index.up")
		public ModelAndView index(ModelAndView mav) {
			mav.setViewName("main/index.tiles1");
			
			return mav;
		}	
		
		// 관리자페이지
		@RequestMapping(value="/admin.up")
		public ModelAndView test(ModelAndView mav) {
			
			mav.setViewName("admin");
			
			return mav;
		}
							
		// 공지사항 목록 
		@RequestMapping(value="/notice.up")
		public ModelAndView notice(ModelAndView mav) {
			
			mav.setViewName("board/notice.tiles1");
			
			return mav;
		}
		
		// 공지사항 글쓰기
		@RequestMapping(value="/addnotice.up")
		public ModelAndView addnotice(ModelAndView mav) {
			
			mav.setViewName("board/addnotice.tiles1");
			
			return mav;
		}
		
		// 공지사항 게시판 글 상세보기
		@RequestMapping(value="/noticeview.up")
		public ModelAndView noticeview(ModelAndView mav) {
			
			mav.setViewName("board/noticeview.tiles1");
			
			return mav;
		}
		
		// 자유게시판 목록
		@RequestMapping(value="/freeboard.up")
		public ModelAndView freeboard(HttpServletRequest request,ModelAndView mav) {
			
			List<FreeboardVO> freeboardList = null;
			
			String searchType = request.getParameter("searchType");
		    String searchWord = request.getParameter("searchWord");
		    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		    
		    if(searchWord == null || searchWord.trim().isEmpty()) {
		         searchWord = "";
		    }
		      
		    if(searchType == null) {
		         searchType = "";
		    }
		    
		    
		    HashMap<String, String> paraMap = new HashMap<>();
		    paraMap.put("searchType", searchType);
		    paraMap.put("searchWord", searchWord);
		    
		    // 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		    // 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
		    int totalCount = 0;       // 총게시물 건수
		    int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 건수
		    int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함. 
		    int totalPage =0;          // 총 페이지 수 (웹브라우저상에 보여줄 총 페이지 개수, 페이지바)
	      
		    int startRno = 0;         // 시작 행번호
		    int endRno = 0;            // 끝 행번호
			
		    // 먼저 총 게시물 건수(totalCount)
		    totalCount = service.getFreeTotalCount(paraMap);
		    
		    totalPage = (int) Math.ceil ( (double)totalCount/sizePerPage );
		    
		    if(str_currentShowPageNo == null) {
		         currentShowPageNo = 1; //   즉 초기화면인 /list.action은 /list.action?currentShowPageNo=1로 하겠다는 말이다.
		      } else {
		         try {
		            currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		            if(currentShowPageNo <= 0 || currentShowPageNo > totalPage) {
		               currentShowPageNo = 1;
		            }
		         } catch(NumberFormatException e) {
		            currentShowPageNo = 1;
		         }
		      }
		    
		    startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		    endRno = startRno + sizePerPage - 1; 

		    paraMap.put("startRno", String.valueOf(startRno));
		    paraMap.put("endRno", String.valueOf(endRno));
		    
		    
		    freeboardList = service.getFreeboardList(paraMap);
		    // 자유게시판 목록 가져오기
		    		    	    
		    if(!"".equals(searchWord)) {
		         mav.addObject("paraMap", paraMap);
		      }
		    
		    // 페이지바 생성
		    String pageBar = "<ul style='list-style:none;'>";
		      
		    int blockSize = 10;
		    int loop = 1;
		    int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		    
		    String url = "freeboard.up";
		    
		    // === [이전] 만들기 ===
		    if(pageNo != 1) {
		    	pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	      	}
	      
	      	while( !(loop > blockSize || pageNo > totalPage) ) {
	         
	         if(pageNo == currentShowPageNo) {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
	         }
	         else {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	         }
	         
	         loop++;
	         pageNo++;
	         
	      	} // end of while -----------------------------------------------
	      
	      	// === [다음] 만들기 ===
	      	if(!(pageNo > totalPage)) {
	    	  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	      	}
		      
		    pageBar += "</ul>";
		      
		    mav.addObject("pageBar", pageBar);		        
		    
		    ////////////////////////////////
		    String gobackURL = MyUtil.getCurrentURL(request);
		    
		    mav.addObject("gobackURL", gobackURL);    
		    
		    HttpSession session = request.getSession();
		    session.setAttribute("readCountPermission", "yes");
		    session.setAttribute("gobackURL", gobackURL);
		    
		    //////////////////////////////////////////
		    
		    mav.addObject("totalCount",totalCount);
		    mav.addObject("freeboardList",freeboardList);
			mav.setViewName("board/freeboard.tiles1");
			
			return mav;
		}
		
		// 자유게시판 글쓰기
		@RequestMapping(value="/addfreeboard.up")
		public ModelAndView requiredLogin_addfreeboard(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
			
			mav.setViewName("board/addfreeboard.tiles1");
			
			return mav;
		}
		
		// 자유게시판 글쓰기 요청
		@RequestMapping(value="/addfreeboardEnd.up", method= {RequestMethod.POST})
		public String addfreeboard(HashMap<String, String> paraMap,FreeboardVO freeboardvo, MultipartHttpServletRequest mrequest) {
				
			// 첨부파일 여부 확인
			MultipartFile attach = freeboardvo.getAttach();			
			
			if( !attach.isEmpty() ) { 
				
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "files";        
			
			
			System.out.println("~~~ 확인용 path => " + path);
			
			 String newFileName = "";
	         // WAS(톰캣)의 디스크에 저장할때 사용되는 용도
	         
	         byte[] bytes = null;
	         // 첨부파일을 WAS(톰캣)의 디스크에 저장할 떄 사용되는 용도 // 첨부파일을 byte로 분해하여 보내준다.
	         	         
	         try {
		            bytes = attach.getBytes();
		            // getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
		            // 예를 들어, 첨부한 파일이 "강아지.png" 이라면
		            // 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.

		            newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
		            // 위에 것은 이제 파일 올리기를 해주는 것이다.
		            // attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
		            
		          //  System.out.println("~~~ >>> 확인용 newFileName :" + newFileName);
		         //   System.out.println("~~~ >>> 확인용 OrgFilename :" + attach.getOriginalFilename());
		            
		            //   3. BoardVO boardvo에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주어야 한다.
		             
		            freeboardvo.setFileName(newFileName);
		            // WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
		            
		            freeboardvo.setOrgFilename(attach.getOriginalFilename());
		            // 게시판 페이지에서 첨부된 파일명(강아지.png)을 보여줄 때 및 
		            // 사용자가 파일을 다운로드 할떄 사용되어지는 파일명
		            
		         } catch (Exception e) {
		            e.printStackTrace();
		         }
		         	         
			}
			
			// 첨부파일 알아오기 끝
				
			int n = 0;
			
			if(attach.isEmpty()) {
				// 첨부파일이 존재하지 않는 경우
				n = service.addFreeboard(freeboardvo);
				
			}			
			else {
		    	// 첨부파일이 존재하는 경우
		    	n = service.addFreeboard_withFile(freeboardvo);
		    }
			
			
			if(n==1) {

				return "redirect:/freeboard.up";	
				//      /list.action 페이지로 redirect(페이지이동)해라는 말이다.
			}
			else {

				return "redirect:/addfreeboard.up";
	            //	   /add.action 페이지로 redirect(페이지이동)해라는 말이다.
			}
			

		}
		
		
		// 자유게시판 글 상세보기
		@RequestMapping(value="/freeboardview.up")
		public ModelAndView freeboardview(HttpServletRequest request, ModelAndView mav) {
			
			String free_seq = request.getParameter("free_seq");

			String gobackURL = request.getParameter("gobackURL");
			mav.addObject("gobackURL",gobackURL);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String userid = null;
			
			if(loginuser != null) {
				userid = loginuser.getUserid();
				// userid 는 로그인 되어진 사용자의 userid 이다.
			}
			
			FreeboardVO freeboardvo = null;
			
			if("yes".equals(session.getAttribute("readCountPermission"))) {
				
				// 조회수 증가와 함께 글 조회
				freeboardvo = service.getFreeView(free_seq,userid);
				
				session.removeAttribute("readCountPermission");
			}
			else {
				freeboardvo = service.getFreeViewNoAdd(free_seq);
			}
					
			mav.addObject("freeboardvo",freeboardvo);
			mav.setViewName("board/freeboardview.tiles1");
	
			return mav;
		}
		
		
		// 자유게시판 상세글의 첨부파일 다운로드
		@RequestMapping(value="/download.up")
		public void download(HttpServletRequest request, HttpServletResponse response) {
			
			String free_seq = request.getParameter("free_seq");	
			
			FreeboardVO freeboardvo = service.getFreeViewNoAdd(free_seq);
			
			String filename = freeboardvo.getFileName();
			String orgFilename = freeboardvo.getOrgFilename();
			
			HttpSession session = request.getSession();
			
			String root = session.getServletContext().getRealPath("/"); 
			String path = root + "resources"+File.separator+"files";
			
			boolean flag = false;
			
			flag = fileManager.doFileDownload(filename, orgFilename, path, response);
			
			if(!flag) {
				// 다운로드가 실패할 경우 메시지를 띄워준다.
				
				response.setContentType("text/html; charset=UTF-8"); 
				PrintWriter writer = null;
				
				try {
					writer = response.getWriter();
					// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
				} catch (IOException e) {
					
				}
				
				writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");       
				
			}
		}// end of download()------------------------------------------------------------
		
		
		// 자유게시판 글 삭제하기
		@RequestMapping(value="/board/delfreeboard.up")
		public ModelAndView requiredLogin_delfreeboard(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
			
			// 삭제해야할 글번호를 받아온다.
			String free_seq = request.getParameter("free_seq");
			
			FreeboardVO freeboardvo = service.getFreeViewNoAdd(free_seq);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( !loginuser.getUserid().equals(freeboardvo.getFk_userid()) ) {
				String msg = "다른 사용자의 글은 삭제가 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				mav.setViewName("msg");			
			}
			else {
				mav.addObject("free_seq", free_seq);
				mav.setViewName("board/delfreeboard.tiles1");				
			}
			
			return mav;
		}
		
		
		// 자유게시판 글 삭제 완료하기
		@RequestMapping(value="/delFreeboardEnd.up", method= {RequestMethod.POST})
		public ModelAndView delFreeboardEnd(HttpServletRequest request, ModelAndView mav) throws Throwable{
			
			String free_seq = request.getParameter("free_seq");
			String password = request.getParameter("password");
			
			HashMap<String, String> paraMap = new HashMap<>();
			paraMap.put("free_seq", free_seq);
			paraMap.put("password", password);
			
			int n = service.delfreeboard(paraMap);
			
			if(n == 0) {
				mav.addObject("msg", "암호가 일치하지 않아 글 삭제가 불가합니다.");
				mav.addObject("loc", request.getContextPath()+"/freeboardview.up?free_seq="+free_seq);
			}
			else {
				mav.addObject("msg", "글삭제 성공!!");
				mav.addObject("loc", request.getContextPath()+"/freeboard.up"); 
			}
			
			mav.setViewName("msg");
			
			return mav;
		}
		
		// 자유게시판 글 수정하기 
		@RequestMapping(value="/board/editfreeboard.up")
		public ModelAndView requiredLogin_editfreeboard(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
			
			// 글 수정해야할 글번호 가져오기 
			String free_seq = request.getParameter("free_seq");
			
			FreeboardVO freeboardvo = service.getFreeViewNoAdd(free_seq);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( !loginuser.getUserid().equals(freeboardvo.getFk_userid()) ) {
				String msg = "다른 사용자의 글은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				mav.setViewName("msg");			
			}
			else {
				mav.addObject("freeboardvo", freeboardvo);
				mav.setViewName("board/editfreeboard.tiles1");				
			}
								
			return mav;
		}
		
		// 자유게시판 글 수정하기 완료하기
		@RequestMapping(value="/editfreeboardEnd.up", method= {RequestMethod.POST})
		public ModelAndView editfreeboardEnd(HttpServletRequest request, FreeboardVO freeboardvo, ModelAndView mav) {
			
			int n = service.editfreeboardEnd(freeboardvo);
			
			if(n == 0) {
				mav.addObject("msg", "암호가 일치하지 않아 글 수정이 불가합니다.");
			}
			else {
				mav.addObject("msg", "글수정 성공!!");
			}
			
			mav.addObject("loc", request.getContextPath()+"/freeboard.up?free_seq="+freeboardvo.getFree_seq());
			mav.setViewName("msg");
			
			return mav;
		}

		
		// 자유게시판 댓글쓰기
		@ResponseBody
		@RequestMapping(value="/board/addFreeComment.up", method= {RequestMethod.POST})
		public String addFreeComment(HashMap<String, String> paraMap, FreeCommentVO freecommentvo) {
			
			String jsonStr = "";
			
			try {
				int n = service.addFreeComment(freecommentvo);
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n", n);
				
				jsonStr = jsonObj.toString();
				
			} catch (Throwable e) {
				e.printStackTrace();
			}						
			
			return jsonStr;
		}
		
		
		// 자유게시판 댓글 불러오기
		@ResponseBody
		@RequestMapping(value="/board/commentList.up",  produces="text/plain;charset=UTF-8")
		public String freecommentList(HttpServletRequest request) {
			
			String parentSeq = request.getParameter("parentSeq");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(currentShowPageNo == null) {
				   currentShowPageNo = "1";
			   }
			   
			int sizePerPage = 5;
			
			int startRno = ((Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
		    int endRno = startRno + sizePerPage - 1; 
			
		    HashMap<String,String> paraMap = new HashMap<>();
		    paraMap.put("parentSeq", parentSeq);   
		    paraMap.put("startRno", String.valueOf(startRno));
		    paraMap.put("endRno", String.valueOf(endRno));
		      
			List<FreeCommentVO> freecommentList = service.freecommentList(paraMap);
			
			JSONArray jsonArr = new JSONArray();
			
			if(freecommentList != null) {
				for(FreeCommentVO fcvo : freecommentList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("content",fcvo.getContent());
					jsonObj.put("name", fcvo.getName());
					jsonObj.put("writedate", fcvo.getWritedate());
					jsonObj.put("comment_seq", fcvo.getComment_seq());
					
					jsonArr.put(jsonObj);								
				}			
			}
	
			return jsonArr.toString();
		}
		
		// 자유게시판 댓글 페이징처리
		 @ResponseBody
		 @RequestMapping(value="/board/getFreeTotalPage.up")
		 public String getcommenTotalPage(HttpServletRequest request) {
			   
			  String parentSeq = request.getParameter("parentSeq");
			  String sizePerPage = request.getParameter("sizePerPage");
			   
			  HashMap<String, String> paraMap = new HashMap<>();
			  paraMap.put("parentSeq", parentSeq);
			    
			  // 원글 글번호(parentSeq)에 해당하는 댓글의 총갯수를 알아오기
			  int totalCount = service.getCommentTotalCount(paraMap);
			    
			  // 총페이지수(totalPage) 구하기
			  int totalPage = (int) Math.ceil ( (double)totalCount/Integer.parseInt(sizePerPage));
			  // ex) (double)23/5 ==> 4.6 ==> Math.ceil(4.6) ==> (int)4.0 ==> 4
			    
			  JSONObject jsonObj = new JSONObject();
			  jsonObj.put("totalPage", totalPage);
			   
			  return jsonObj.toString();
		   }
		
		 
		 
		// 자유게시판 댓글 삭제하기
		@ResponseBody
		@RequestMapping(value="/board/delFreeComment.up")
		public String delFreeComment(HttpServletRequest request) {
			
			String delseq =request.getParameter("delseq");
			
			int n = service.delFreeComment(delseq);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			   
			return jsonObj.toString();
		}
		
		
		
		// Q&A게시판 목록
		@RequestMapping(value="/question.up")
		public ModelAndView question(ModelAndView mav) {
			
			mav.setViewName("board/question.tiles1");
			
			return mav;
		}
		
		// Q&A게시판 글쓰기
		@RequestMapping(value="/addquestion.up")
		public ModelAndView addquestion(ModelAndView mav) {
			
			mav.setViewName("board/addquestion.tiles1");
			
			return mav;
		}			
				
		// Q&A게시판 글 상세보기
		@RequestMapping(value="/questionview.up")
		public ModelAndView questionview(ModelAndView mav) {
			
			mav.setViewName("board/questionview.tiles1");
			
			return mav;
		}
				
		
		// 스마트에디터 드래그앤드롭을 사용한 다중사진 파일업로드
		@RequestMapping(value="/image/multiplePhotoUpload.up", method= {RequestMethod.POST}) 
		public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
			/*
			  1. 사용자가 보낸파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
			  >>> 파일이 업로드 되어질 특정 경로(폴더) 지정해주기
			   	    우리는 WAS의 webapp/resources/photo_upload 라는 폴더로 지정해준다.  
			 */
			
			// WAS의 webapp의 절대경로를 알아와야 한다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "photo_upload";
			 /*
		        File.separator는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		                  운영체제가 Windows 이라면 "\"이고 
		                  운영체제가 UNIX, Linux 이라면 "/" 이다. 
			 */
	     
				System.out.println(root);
		     // path 가 첨부파일을 저장할 WAS(톱캣)의 폴더가 된다.
		        System.out.println("~~~ 확인용 Eclass path => " + path);
		     // ~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload
			
		     File dir = new File(path);
		     if(!dir.exists()) { // 폴더가 없는 경우
		    	 dir.mkdirs(); // 폴더가 없으면 만들어라 / mkdirs - 하위폴더까지 만들어라
		     }
			
		     String strURL = "";
				
		 	try {
		 		if(!"OPTIONS".equals(request.getMethod().toUpperCase())) {
		 		    String filename = request.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명
		 	    		
		 	        System.out.println(">>>> 확인용 filename ==> " + filename); 
		 	        // >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg
		 	    		
		 	    	   InputStream is = request.getInputStream();
		 	    	/*
				 	          요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
				 	          혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
				 	          이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.

		                                      서블릿에서 payload body는 Request.getParameter()가 아니라 
		                 Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
		 	    	*/
		 	       String newFilename = fileManager.doFileUpload(is, filename, path);
		 	    	
		 		   int width = fileManager.getImageWidth(path+File.separator+newFilename);
		 			
		 		   if(width > 600)
		 		      width = 600;
		 				
		 		// System.out.println(">>>> 확인용 width ==> " + width);
		 		// >>>> 확인용 width ==> 600
		 		// >>>> 확인용 width ==> 121
		 	    	
		 		   String CP = request.getContextPath(); // board
		 			
		 		   System.out.println("cp"+CP);
		 		   
		 		   strURL += "&bNewLine=true&sFileName="; 
		             	   strURL += newFilename;
		             	   strURL += "&sWidth="+width;
		             	   strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
		 	    	}
		 		
		 	       /// 웹브라우저상에 사진 이미지를 쓰기 ///
		 		   PrintWriter out = response.getWriter();
		 		   out.print(strURL);
		 	} catch(Exception e){
		 			e.printStackTrace();
		 	}
		     
		}// end of multiplePhotoUpload() -----------------------------------------------------------------
		
		
}
