package com.spring.eclass.aop;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.MyUtil;
import com.spring.kimeh.service.InterDonationService;
//=== #53. 공통 관심사 클래스(Aspect class)를 생성해야 한다.
@Aspect //공통관심사로 쓰이는 클래스 객체로 등록이 되어짐
@Component //bean으로 등록된다 
public class DonationAOP {
	/* == Before Advice 만들기 == 
	   주업무(<예: 글쓰기, 글수정, 댓글쓰기 등등>)를 실행하기 앞서서 이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로 주업무에
	   대한 보조업무<예:로그인 유무검사>객체로 로그인 여부를 체크하는 관심클래스(Aspect class)를 생성하여 포인트컷(주업무)과
	   어드바이스(보조업무)를 생성하여 동작하도록 한다
	*/

	// == Pointcut(주업무)을 생성한다. ==
	// pointcut이란 공통관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )")
	public void requiredLogin() {
	} // == Advice(공통관심사)를 구현한다.

	// == Before Advice(공통관심사, 보조업무)를 구현한다.
	@Before("requiredLogin()") // (pointcut)메소드가 작동하기 전에 코딩되어지는 메소드를 수행해라
	public void loginChk(JoinPoint joinPoint) { // 로그인 유무 검사 메소드 작성하기

		// 첫번째 파라미터는 HttpServletRequest이므로 리턴타입이 object니 캐스팅해준다
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0]; // 주업무의 메소드의 첫번재 파라미터를 얻어오는 것이다
																					// //argument가 파라미터다
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];
		HttpSession session = request.getSession();
		// 로그인 유무를 확인하기 위해서는 request를 통해 session을 얻어와야한다.
		if (session.getAttribute("loginuser") == null) {
			String msg = "로그인하신 후 이용하실 수 있습니다.";
			String loc = request.getContextPath() + "/login/login.up";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);

			// >>> 로그인 성공 후 로그인 하기 전 페이지로 돌아가는 작업 만들기 <<< //
			// === 현재 페이지의 주소(URL)알아오기 ===
			String url = MyUtil.getCurrentURL(request);
			// System.out.println("~~~ 확인용 현재페이지 URL:"+url);// 확인용 URL:add.action?null
			if (url.endsWith("?null")) {
				url = url.substring(0, url.indexOf("?")); // 처음부터 ?앞까지
			}
			session.setAttribute("gobackURL", url); // 세션에 url정보를 저장시켜 둔다.
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			// System.out.println("~~~ 확인용 현재페이지 URL:"+url);
			// ~~~ 확인용 현재페이지 URL:add.action
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}// end of public void loginChk(JoinPoint joinPoint) ------------
	

	// == After Advice 만들기 == 
	@Autowired
	InterDonationService service;
	
	@Pointcut("execution(public * com.spring..*Controller.pointPlus_*(..) )")
	public void pointPlus(){} //식별자 
	
	//== After Advice(공통관심사, 보조업무)를 구현한다.
	@SuppressWarnings("unchecked") //앞으로는 경고 표시를 하지말라 
	@After("pointPlus()") //(pointPlus)메소드가 작동한 후에  포인트를 업로드하는 메소드를 수행해라 
	public void userPointPlus(JoinPoint joinPoint) { //JoinPoint는 포인트컷 되어진 주업무의 메소드 
		 
		HashMap<String,String> paraMap = (HashMap<String,String>)joinPoint.getArgs()[0];//첫번째 파라미터는 해시맵으로 받아온다 
		service.pointPlus(paraMap); //로그인된 회원정보, 포인트 얼만큼 줄건지가 필요
		
	}//end of public void userPointPlus(JoinPoint joinPoint) ---------
	
	
}
