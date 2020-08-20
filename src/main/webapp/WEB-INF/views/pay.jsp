<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

$(document).ready(function() {	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp35132656'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	//결제 요청하기 
	IMP.request_pay({
	    pg : 'html5_inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : '${recieve}', /* localStorage.getItem("recieve"), */
	    buyer_email : '${sessionScope.loginuser.email}',
	    buyer_name : '${sessionScope.loginuser.name}',
	    buyer_tel : '${sessionScope.loginuser.mobile}',
	    buyer_addr : '${sessionScope.loginuser.address}',
	    buyer_postcode : '${sessionScope.loginuser.postcode}',
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        alert(msg);
	        window.opener.goSubmit();
	        self.close();
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	    }
	});// end of IMP.request_pay()----------------------------
});// end of $(document).ready()-----------------------------
</script>
</head>
<body>

</body>
</html>