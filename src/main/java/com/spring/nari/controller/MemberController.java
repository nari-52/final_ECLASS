package com.spring.nari.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
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

import com.spring.common.Sha256;
import com.spring.kanghm.model.NoticeboardVO;
import com.spring.kanghm.service.InterEclassService;
import com.spring.kimeh.model.DonStoryVO;
import com.spring.nari.model.MemberVO;
import com.spring.nari.service.InterMemberService;

import net.nurigo.java_sdk.Coolsms;

 
@Component

@Controller
public class MemberController {

	@Autowired
	private InterMemberService service; // 의존객체 service

	@Autowired
	private InterEclassService mservice;
	
	// 로그인 페이지 보여주기
	@RequestMapping (value="/login/login.up")
	public ModelAndView login(HttpServletRequest request, ModelAndView mav) {
		
		//String userid = "";
		
/*		HttpSession session = request.getSession();
		
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if(loginuser.getUserid() == "") {
        	userid = (String)loginuser.getUserid();
        	System.out.println("~~~~~~~~~~~~~~~~~~~~~"+userid);
        }
        */
        
		
 /*       if(userid != "") {
        	String msg = "이미 로그인 하셨습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
        }
		
        else {
        	mav.setViewName("/login/login.tiles1");
        }*/
        mav.setViewName("/login/login.tiles1");
		return mav;
	}
	
	// 로그인 처리하기
	@RequestMapping (value="/login/loginEnd.up", method= {RequestMethod.POST})
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid"); // loginform.jsp 에서 name값 가져오기
		String pwd = request.getParameter("pwd");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd); // pwd를 암호화해서 넣어주겠다
		
		MemberVO loginuser = service.getLoginMember(paraMap); // HashMap에 있는 것을 담아서 보내준다.
		
		HttpSession session = request.getSession();
		
		if (loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg"); // 2순위
			// /WEB-INF/views/msg.jsp 파일을 생성한다.
		} else {
			// 올바른 loginuser 값을 불러왔을 때
			
			if (loginuser.isIdleStatus() == true) {
				// 로그인을 한지 1년이 지나서 휴면상태에 빠진 경우
				String msg = "로그인을 한지 1년이 지나 휴면상태에 빠졌습니다. 관리자에게 문의 바랍니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg"); // 2순위
			}

			else {
				if (loginuser.isRequirePwdChange() == true) {
					// 암호를 최근 3개월동안 변경하지 않은 경우
					session.setAttribute("loginuser", loginuser);

					String msg = "암호를 최근 3개월동안 변경하지 않으셨습니다. 암호변경을 위해 나의정보 페이지로 이동합니다.";
					String loc = request.getContextPath() + "/myinfo.action";
					// /board/myinfo.action
					
					mav.addObject("msg", msg);
					mav.addObject("loc", loc);

					mav.setViewName("msg"); // 2순위
				}

				else {
					// 아무런 이상없이 로그인 하는 경우
					session.setAttribute("loginuser", loginuser);
					
					if (session.getAttribute("gobackURL") != null) {
						// 세션에 저장된 돌아갈 페이지 주소(gobackURL)가 있는 경우
						String gobackURL = (String) session.getAttribute("gobackURL");
						mav.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것.

						session.removeAttribute("gobackURL"); // 중요!!!! 반드시 제거해 주어야 한다.
					}
					
					List<NoticeboardVO> noticevo = mservice.getindexnotice();
					List<DonStoryVO> paymentvo = mservice.getindexdon();
	                  
		            mav.addObject("noticevo", noticevo);
		            mav.addObject("paymentvo", paymentvo);
		            
					mav.setViewName("/main/index.tiles1");
					
				}
			}
		}
		return mav;
	}


	// 로그아웃 처리하기 
	@RequestMapping(value = "/login/logout.up")
	public ModelAndView logout(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		session.invalidate(); // session 전체 정보 삭제
		
		String msg = "로그아웃 되었습니다.";
		String loc = request.getContextPath() + "/index.up";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);

		mav.setViewName("msg"); 
		
		return mav;		
	}
	
	// 회원가입_약관동의 페이지 보여주기
	@RequestMapping (value="/member/signup_step1.up")
	public ModelAndView signup_step1(HttpServletRequest request, ModelAndView mav) {
		
		// 회원 구분 값 가져오기
		String identity = request.getParameter("identity");
		
		mav.addObject("identity", identity);
		mav.setViewName("/member/signup_TnC.tiles1");
		
		return mav;
	}
	
	// 회원가입_메일 인증 페이지 보여주기
	@RequestMapping (value="/member/signup_step2.up")
	public ModelAndView signup_step2(HttpServletRequest request, ModelAndView mav) {
		
		// 회원 구분 값 가져오기
		String identity = request.getParameter("identity");
		
		mav.addObject("identity", identity);
		
		mav.setViewName("/member/signup_mailAuthentication.tiles1");
		
		return mav;
	}
	
	// AJAX를 이용하여 회원가입_메일 인증 페이지에서 인증메일 보내기
	@ResponseBody
	@RequestMapping (value="/member/signup_step2_mail.up", produces="text/plain; charset=UTF-8")
	public String signup_step3_mail(HttpServletRequest request, ModelAndView mav) {
		
		// 입력한 이름 가져오기
		String name = request.getParameter("name");
		// 입력한 이메일 값 가져오기
		String email = request.getParameter("email");
		
		GoogleMail mail = new GoogleMail();
		
		// 인증키를 랜덤하게 생성하도록 한다.
		Random rnd = new Random();
		String certificationCode = "";
		
		char randchar = ' ';
		for(int i=0; i<5; i++) {
		/*
		    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
		    int rndnum = rnd.nextInt(max - min + 1) + min;
		       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
		 */
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
		}
		
		int randnum = 0;
		for(int i=0; i<7; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			certificationCode += randnum;
		}
		
		// System.out.println(certificationCode);
		// cayta8010732
		String mailmessage = certificationCode;
		
		try {
			mail.sendmail(email, mailmessage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// json으로 데이터 넘겨주기 
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("mailmessage", mailmessage);
		jsonObj.put("name", name);
		jsonObj.put("email", email);

		return jsonObj.toString();
	}
	
	
	// AJAX를 이용하여 회원가입_메일 인증 페이지에서 파일이름 보내주기
	@ResponseBody
	@RequestMapping (value="/member/signup_step2_attach.up", produces="text/plain; charset=UTF-8")
	public String signup_step2_attach(HttpServletRequest request, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		mrequest.getFile("a").getOriginalFilename();
		// 진짜 파일 이름 알아오기
		// String orgfilename = request.getParameter("attach"); 
		String orgfilename = mrequest.getParameter("attach");
		
		System.out.println("~~~~~~~~~~~~~~~ 진짜파일이름: " + orgfilename);
		
/*		// === 사용자가 쓴 글에 파일 첨부 여부를 구분지어 주어야 한다.
		// === !!! 첨부파일 여부 알아오기 시작 !!!
		MultipartFile attach = mrequest.getAttach();
		if (!attach.isEmpty()) { // 첨부파일이 비어있지 않다.
	
		// WAS의 webapp 의 절대경로를 알아와댜 한다.
		HttpSession session = mrequest.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "files";
		
		 * File.separator는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 "\"이고 운영체제가
		 * UNIX, Linux 이라면 "/" 이다.
		 
		// path 가 첨부파일을 저장할 WAS(톱캣)의 폴더가 된다.
		// System.out.println("~~~ 확인용 path => " + path);
		// ~~~ 확인용 path =>
		// C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
		
		 * 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
		 
		String newFileName = "";
		// WAS(톰캣)의 디스크에 저장할때 사용되는 용도
		byte[] bytes = null;
		// 첨부파일을 WAS(톰캣)의 디스크에 저장할 떄 사용되는 용도 // 첨부파일을 byte로 분해하여 보내준다.
		long fileSize = 0;
		// 파일크기를 읽어오기 위한 용도
		try {
			bytes = attach.getBytes();
			// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다.
			// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
			// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
			newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
			// 위에 것은 이제 파일 올리기를 해주는 것이다.
			// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
			System.out.println("~~~ >>> 확인용 newFileName " + newFileName);
			
			 * 3. BoardVO boardvo에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주어야 한다.
			 
			boardvo.setFileName(newFileName);
			// WAS(톰캣)에 저장될 파일명(20200727092715353243254235235234.png)
			boardvo.setOrgFilename(attach.getOriginalFilename());
			// 게시판 페이지에서 첨부된 파일명(강아지.png)을 보여줄 때 및
			// 사용자가 파일을 다운로드 할 때 사용되어지는 파일명
			fileSize = attach.getSize(); // 파일크기
			boardvo.setFileSize(String.valueOf(fileSize));
			// 게시판 페이지에서 첨부한 파일의 크기를 보여줄 때 String 타입으로 변경해서 저장한다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// === !!! 첨부파일 여부 알아오기 끝 !!!
*/

		
		return "";
	}
	
		
		
	
	// 회원가입_정보입력 페이지 보여주기
	@RequestMapping (value="/member/signup_step3.up")
	public ModelAndView signup_step3(HttpServletRequest request, ModelAndView mav) {
		// 회원 구분 값 가져오기
		String identity = request.getParameter("identity");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		// System.out.println("name " + name);
		// System.out.println("email " + email);
		
		
		mav.addObject("identity", identity);
		mav.addObject("name", name);
		mav.addObject("email", email);
		
		mav.setViewName("/member/signup_information.tiles1");
		
		return mav;
	}
	
	
	// AJAX를 이용하여 회원가입 아이디 중복검사
	@ResponseBody
	@RequestMapping (value="/member/idDuplicateCheck.up", produces="text/plain; charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		// System.out.println("~~~~~~~~~~~~~userid: " + userid);
		
		String isUse = service.idDuplicateCheck(userid);
		
		// System.out.println("~~~~~~~~~~~~~isUse: " + isUse);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isUse", isUse);
		
		return jsonObj.toString();
		
	}
	
	// AJAX를 이용하여 휴대전화 중복검사
	@ResponseBody
	@RequestMapping (value="/member/mobileDuplicateCheck.up", produces="text/plain; charset=UTF-8")
	public String mobileDuplicateCheck(HttpServletRequest request, ModelAndView mav) {
		
		String mobile = request.getParameter("mobile");
		// System.out.println("~~~~~~~~~~~~~mobile: " + mobile);
		
		String isUseMobile = service.mobileDuplicateCheck(mobile);
		
		System.out.println("~~~~~~~~~~~~~isUse: " + isUseMobile);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isUseMobile", isUseMobile);
		
		return jsonObj.toString();
		
	}

	// 회원가입_정보입력 완료 (회원가입!)
	@RequestMapping (value="/member/signup_step3_end.up", method= {RequestMethod.POST})
	public String signup_step3_end(HttpServletRequest request, ModelAndView mav, MemberVO mvo) {
		
		// 회원가입 값 가져오기 // VO로 가져오는 경우 name값과 colum 값이 일치하면 따로 값을 가져오지 않아도 자동 matching 된다
		
		// 회원가입 하기
		int n = service.registerMember(mvo);
		// System.out.println("~~~~~~N: "+n); 
		
		String msg = "";
		String loc = "";
		
		if(n==1) {
			
			request.setAttribute("userid", mvo.getUserid());
			request.setAttribute("name", mvo.getName());
			request.setAttribute("university", mvo.getUniversity());
			request.setAttribute("major", mvo.getMajor());
			request.setAttribute("student_num", mvo.getStudent_num());
			request.setAttribute("mobile", mvo.getMobile());
			
			return "/member/signup_end.tiles1";
			// 
		}
		else {
			msg = "회원가입  실패";
			loc = "javascript:history.back()";	// 자바스크립트를 이용한 이전페이지로 이동하는 것이다.
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			return "msg"; //msg.jsp 페이지로 이동
		}

	}
	
	
	
	// 회원가입 완료 화면 보여주기
	@RequestMapping (value="/member/signup_end.up")
	public ModelAndView signup_end(ModelAndView mav) {
		
		mav.setViewName("/member/signup_end.tiles1");
		
		return mav;
	}
	
	
	// 아이디찾기 화면 보여주기
	@RequestMapping (value="/login/idFind.up")
	public ModelAndView idFind(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("/login/idFind.tiles1");
		
		return mav;
	}
	
	
	// AJAX를 이용하여 아이디찾기 페이지에서 인증메일 보내기 
	@ResponseBody
	@RequestMapping (value="/login/idFind_mail.up", produces="text/plain; charset=UTF-8")
	public String idFind_mail(HttpServletRequest request, ModelAndView mav) {
		
		// 입력한 이름 가져오기
		String name = request.getParameter("name");
		// 입력한 이메일 값 가져오기
		String email = request.getParameter("email");
		
		GoogleMail mail = new GoogleMail();
		
		// 인증키를 랜덤하게 생성하도록 한다.
		Random rnd = new Random();
		String certificationCode = "";
		
		char randchar = ' ';
		for(int i=0; i<5; i++) {
		/*
		    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
		    int rndnum = rnd.nextInt(max - min + 1) + min;
		       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
		 */
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
		}
		
		int randnum = 0;
		for(int i=0; i<7; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			certificationCode += randnum;
		}
		
		// System.out.println(certificationCode);
		// cayta8010732
		String mailmessage = certificationCode;
		
		try {
			mail.sendmail(email, mailmessage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		// name과 email 넘겨주기
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("name", name);
		paraMap.put("email", email);
		
		String userid = service.idFind(paraMap);
		
		// System.out.println("~~~~~~~~~~~~userid : " + userid);
		
		// json으로 데이터 넘겨주기 
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("mailmessage", mailmessage);
		jsonObj.put("name", name);
		jsonObj.put("email", email);
		jsonObj.put("userid", userid);
		
		return jsonObj.toString();
	}
	
	// 아이디찾기 완료 화면 보여주기
	@RequestMapping (value="/login/idFind_end.up")
	public ModelAndView idFind_end(HttpServletRequest request, ModelAndView mav) { 
		
		String userid = request.getParameter("userid");
		
		// System.out.println("~~~~~~~~~~~~~~userid : " + userid);
		
		mav.addObject("userid", userid);
		mav.setViewName("/login/idFind_end.tiles1");
		
		return mav;
	}
	
	// 비밀번호 찾기 화면 보여주기
	@RequestMapping (value="/login/pwdFind.up")
	public ModelAndView pwdFind(HttpServletRequest request, ModelAndView mav) {
	
		mav.setViewName("/login/pwdFind.tiles1");
		
		return mav;
	}
	

	// 비밀번호찾기 비밀번호 변경 화면 보여주기
	@RequestMapping (value="/login/pwdFind_update.up")
	public ModelAndView pwdFind_update(HttpServletRequest request, ModelAndView mav) { 
		
		String userid = request.getParameter("userid");
		String mobile = request.getParameter("mobile");
		
		// System.out.println("~~~~~~~~~~~~~~userid : " + userid);
		// System.out.println("~~~~~~~~~~~~~~mobile : " + mobile);
		
		mav.addObject("userid", userid);
		mav.addObject("mobile", mobile);
		mav.addObject("useridcheck", userid);
		mav.addObject("mobilecheck", mobile);
		
		mav.setViewName("/login/pwdFind_update.tiles1");
		
		return mav;
	}
	
	// 비밀번호 찾기 완료 화면 보여주기
	@RequestMapping (value="/login/pwdFind_end.up")
	public String pwdFind_end(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		// System.out.println("~~~~~~~~~~변경할 userid: "+userid);
		// System.out.println("~~~~~~~~~~변경할 pwd: "+pwd);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		
		int n = service.pwd_update(paraMap); // 비밀번호 찾기 시 비밀번호 변경 하기
		
		// System.out.println("업데이트 실행 후");
		String msg = "";
		String loc = "";
		
		if(n==1) {
			
			return "/login/pwdFind_end.tiles1";
		}
		else {
			msg = "비밀번호 변경 실패";
			loc = "javascript:history.back()";	// 자바스크립트를 이용한 이전페이지로 이동하는 것이다.
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			return "msg"; //msg.jsp 페이지로 이동
		}

	}
	
	
	// 회원 탈퇴 페이지 보여주기
	@RequestMapping (value="/member/delMember.up")
	public ModelAndView delMember(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("delUserid");
		String pwd = request.getParameter("delPwd");
		
		
		
		mav.addObject("userid",userid);
		mav.addObject("pwd",pwd);
		
		mav.setViewName("/member/delMember.tiles1");
		
		return mav;
	}
	
	
	// 회원 탈퇴 완료 화면 보여주기
	@RequestMapping (value="/member/delMember_end.up")
	public ModelAndView delMember_end(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		// 회원 탈퇴하기 (status = 0)
		int n = service.delMember(userid); 

		// 회원 탈퇴 시 로그아웃 처리
		HttpSession session = request.getSession();
		session.invalidate(); // session 전체 정보 삭제
		
		mav.setViewName("/member/delMember_end.tiles1");
		
		return mav;
	}

	
	// 회원정보  수정하기 페이지 보여주기
	@RequestMapping (value="/member/updateMember.up")
	public ModelAndView select_updateMember(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        String userid = loginuser.getUserid();
        
        // System.out.println("~~~~~~~~~~~~~~userid: "+userid);
		
        // 회원정보 수정하기 위한 정보 가져오기
        MemberVO mvo = service.select_updateMember(userid);
        
        mav.addObject("mvo",mvo);
		mav.setViewName("/member/updateMember.tiles1");
		
		return mav;
	}
	
	// 회원 정보 수정하기
	@RequestMapping (value="/member/updateMember_end.up")
	public ModelAndView updateMember_end(HttpServletRequest request, ModelAndView mav, MemberVO mvo) {
		
		// 회원정보 수정하기
		int n = service.updateMember(mvo);

		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        String identity = loginuser.getIdentity();

		
		if(n==1) {
			mav.addObject("msg","정보가 수정되었습니다");
			mav.addObject("loc", request.getContextPath() + "/mypageMain.up");

		}
		else {			
			mav.addObject("msg","회원 수정 실패");
			mav.addObject("loc","javascript:history.back()");
			
			// return "msg"; //msg.jsp 페이지로 이동
		}
		
		mav.setViewName("msg");
		return mav;

	}
	
	
	// 관리자페이지 학생관리 보여주기
	@RequestMapping (value="/admin/member_studentList.up")
	public ModelAndView member_studentList(HttpServletRequest request, ModelAndView mav) {
	
		List<MemberVO> memberList = service.member_studentList();
		
		
		mav.addObject("memberList",memberList);
		mav.setViewName("/admin/member_studentList.tiles1");
		
		return mav;
	}
	
	// 관리자페이지 학생 탈퇴 하기 AJAX
	@ResponseBody
	@RequestMapping (value="/admin/student_delMember.up")
	public String student_delMember(HttpServletRequest request, ModelAndView mav) {
	
		
		String userid = request.getParameter("userid");

		
		// 회원 탈퇴하기 (status = 0)
		int n = service.delMember(userid); 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		jsonObj.put("userid", userid);

		return jsonObj.toString();

	}
	
	// 관리자페이지 교수관리 보여주기
	@RequestMapping (value="/admin/member_professorList.up")
	public ModelAndView member_professorList(HttpServletRequest request, ModelAndView mav) {
	
		List<MemberVO> memberList = service.member_professorList();
		
		mav.addObject("memberList",memberList);
		mav.setViewName("/admin/member_professorList.tiles1");
		
		return mav;
	}
	
	// 관리자페이지 교수 탈퇴 하기 AJAX
	@ResponseBody
	@RequestMapping (value="/admin/professor_delMember.up")
	public String professor_delMember(HttpServletRequest request, ModelAndView mav) {
	
		
		String userid = request.getParameter("userid");

		
		// 회원 탈퇴하기 (status = 0)
		int n = service.delMember(userid); 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		jsonObj.put("userid", userid);

		return jsonObj.toString();

	}
	
				
				
}

