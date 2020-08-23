package com.spring.nari.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.kanghm.service.InterEclassService;


@Controller
public class SmsController {

   @Autowired
   private InterEclassService service;
   
   
   // 휴대전화 인증번호 받기
   @RequestMapping(value = "/login/pwdFind_mobile.up")
       public ModelAndView pwdFind_mobile (HttpServletRequest request, ModelAndView mav) throws Exception {
	   

	   String userid = request.getParameter("userid");
	   String mobile = request.getParameter("mobile");
		
	   String api_key = "NCSBMSQZABNPGDPO"; //위에서 받은 api key를 추가
       String api_secret = "QHXYZADHUCOSMQY92BVQ6AP12SBKKINJ";  //위에서 받은 api secret를 추가

       Coolsms coolsms = new Coolsms(api_key, api_secret);

       // 인증키를 랜덤하게 생성하도록 한다.
		Random rnd = new Random();
		String certificationCode = "";

		int randnum = 0;
		for(int i=0; i<4; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			certificationCode += randnum;
		}
		
		String mobilemessage = certificationCode;
		// System.out.println("~~~~~~~~~~~~~랜덤번호 보자 "+mobilemessage);

       
	   HashMap<String, String> set = new HashMap<String, String>();
	   set.put("to", mobile); // 수신번호
	
	   set.put("from", "01052649067"); // 발신번호
	   set.put("text", "ECLASS 인증번호 : "+mobilemessage); // 문자내용
	   set.put("type", "sms"); // 문자 타입

	   System.out.println(set);
	   
       org.json.simple.JSONObject result = coolsms.send(set); // 보내기&전송결과받기

       if ((boolean)result.get("status") == true) {
         // 메시지 보내기 성공 및 전송결과 출력
         System.out.println("성공");
         System.out.println(result.get("group_id")); // 그룹아이디
         System.out.println(result.get("result_code")); // 결과코드
         System.out.println(result.get("result_message")); // 결과 메시지
         System.out.println(result.get("success_count")); // 메시지아이디
         System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
       } else {
         // 메시지 보내기 실패
         System.out.println("실패");
         System.out.println(result.get("code")); // REST API 에러코드
         System.out.println(result.get("message")); // 에러메시지
       }
       
       mav.addObject("mobilemessage", mobilemessage);
       mav.addObject("userid", userid);
       mav.addObject("mobile", mobile);
       mav.addObject("useridcheck", userid);
	   mav.addObject("mobilecheck", mobile);
         
       
       mav.setViewName("/login/pwdFind.tiles1");
       
       // return "member/number"; //문자 메시지 발송 성공했을때 number페이지로 이동함
       return mav;
     }
   
}