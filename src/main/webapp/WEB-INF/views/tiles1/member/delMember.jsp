<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#signuptitle {
		/* border: solid 1px gray; */
		max-width: 1080px;
		height: 100px;
		margin: 0 auto;
	}
	
	h1#head_main {
		color: #00bcd4; /* 메인컬러  */
		margin: 0 auto;
		text-align: center;
		width: 100%;
		height: 129px;
		font-size: 25pt;
		padding-top: 25px;	
	}
	
	/* 진행상황 시작 ------------------------------------------ */
	
	div#delMembercontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 650px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#delMember_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 400px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#delMember_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 400px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#delMember_form {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 300px;
		background-color: white;	
	}
	
	ul.input_text, ul.file_attach  {
		list-style: none;
		padding: 0;
		margin-bottom: 10px;
		width: 620px;
	}
	
	/* 가입하기 버튼 */
	div#delMemberbtn {
		/* border: solid 1px blue; */
		margin: 0 auto;
		width: 620px;
		height: 40px;
		background-color: #00bcd4;
		color: white;
		font-size: 13pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
	}
	
	/* 메일 인증번호 받기 */
	div#mailbtn {
		/* border: solid 1px blue; */
		margin: 0 auto;
		width: 140px;
		height: 100px;
		line-height: 100px;
		background-color: #00bcd4;
		color: white;
		font-size: 14pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		float: right;
		margin-top: -125px;
	}
	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){ 
						
		// 회원 탈퇴하기 버튼 클릭 시 확인하기
		$("#delMemberbtn").click(function(){ 
			
			// 1. 아이디와 비밀번호가 공란인지 확인한다. -------------------------------------------- 
			var useridVal = $("#userid").val().trim();
			var pwdVal = $("#pwd").val().trim();
			
			if (useridVal == "" || pwdVal == "") {
				alert("아이디와 비밀번호를 다시한번 입력해주세요!");
				return;
			}

			// 2. 로그인정보와 다시 입력한 정보가 일치하는지 확인한다. ---------------------------------------------
			var useridcheckVal = $("#useridcheck").val().trim();
			var pwdcheckVal = $("#pwdcheck").val().trim();
			
			if (useridVal == useridcheckVal && pwdVal == pwdcheckVal) {
				godelMember(); // 회원 탈퇴하기
			}
			else {
				alert("로그인한 정보와 입력하신 정보가 일치하지 않습니다.");
				return;
			}

		}); // end of $("#delMemberbtn").click(function() ------------


		
	}); // end of $(document).ready(function() -----------

	// 회원 탈퇴하기 버튼 클릭	
	function godelMember() {
		if(confirm("정말 탈퇴하시겠습니까?") == true){
			var frm = document.delMember_form;
			
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/member/delMember_end.up";
			frm.submit();
		}
	    else{
	         return;
	    }
	} // function godelMember()-------------------------------
</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">회원 탈퇴하기</h1>
			</div>
		</section>	
	</div>
	
	<div id="delMembercontent">
		<br/><br/><br/><br/>
		<div id="delMember_content">
			<div id="delMember_back">
				<form name="delMember_form" id="delMember_form">
					<h3 style="text-align: center;">로그인 정보 재입력</h3>
					<ul class="input_text">
						<li>
							<label for="userid"></label>
							<input type="text" name="userid" id="userid" value="" class="input_text" required autofocus placeholder="아이디를 입력해주세요." style="border: solid 1px #ddd; width: 605px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						<li>
							<label for="pwd"></label>
							<input type="password" name="pwd" id="pwd" value="" class="input_text" required placeholder="비밀번호를 입력해주세요." style="border: solid 1px #ddd; border-top:solid 0px;  width: 605px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
					</ul>
					
					<input type="hidden" id="useridcheck" value="${sessionScope.loginuser.userid}" /> <!-- 로그인 세션에서 불러와도 될듯 -->
					<input type="hidden" id="pwdcheck" value="${sessionScope.loginuser.pwd}" />

					
					<div id="delMemberbtn" style="margin-top: 30px; cursor: pointer;">회원 탈퇴하기</div>
				
					<div style="color: #888; margin-top: 30px;">※ 회원 탈퇴 시 재가입이 어려울 수 있습니다.</div>
					<div style="color: #888;">※ 안전한 회원탈퇴를 위해 로그인한 회원정보를 재확인합니다.</div>

				</form>
			</div>
		
		</div>
	</div>


</body>