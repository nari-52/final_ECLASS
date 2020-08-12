package com.spring.kimeh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.kimeh.model.DonPaymentVO;
import com.spring.kimeh.model.DonStoryVO;
import com.spring.kimeh.model.InterDonationDAO;
import com.spring.nari.model.MemberVO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service  
public class DonationService implements InterDonationService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterDonationDAO dao;
	
	//후원리스트 보여주기 
	@Override
	public List<DonStoryVO> donationList(HashMap<String, String> paraMap) {
		List<DonStoryVO> donstoryList = dao.donationList(paraMap);
		return donstoryList;
	}
	
	//후원 스토리 보여주기 
	@Override
	public List<DonStoryVO> donationStory(String donseq) {
		List<DonStoryVO> donstoryPage = dao.donationStory(donseq);
		return donstoryPage;
	}

	//포인트 주기 
	@Override
	public void pointPlus(HashMap<String, String> paraMap) {
		dao.pointPlus(paraMap);		
	}

	//결제하기 insert + 포인트 차감(update) 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int donationPayment(DonPaymentVO donpaymentvo) throws Throwable {
		//해당 메소드를 호출하는 쪽에서 에러를 처리해라 
		int result = 0;
		int n = 0;
		n = dao.donationPayment(donpaymentvo); // 결제하기(insert)
		
		if(n < 1) {
			throw new Exception("test");
		}
		
		//insert가 성공하여 n=1값이 나오면 사용한 포인트를 차감해주기(update) 
		//if(n==1) {
		result = dao.updateUsePoint(donpaymentvo); // Member테이블에 포인트 차감(update) 
		//}
		
		return result;
	}

	//후원 서포터 보여주기 
	@Override
	public List<DonStoryVO> donationSupporter(String donseq) {
		List<DonStoryVO> donsupporterPage = dao.donationSupporter(donseq);
		return donsupporterPage;
	}

	//총 페이지수 알아오기 
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	//검색어 자동완성 기능 
	@Override
	public List<String> wordSearchShow(HashMap<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}

	//더보기 페이징 처리 
	@Override
	public List<DonStoryVO> donationSupporterMoreJSON(HashMap<String, String> paraMap) {
		List<DonStoryVO> donstoryPage = dao.donationSupporterMoreJSON(paraMap);
		return donstoryPage;
	}

	
}
