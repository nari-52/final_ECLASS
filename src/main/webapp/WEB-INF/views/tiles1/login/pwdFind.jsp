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
	
	div#pwdFindcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 700px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#pwdFind_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 600px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#pwdFind_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 480px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#pwdFind_form {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 400px;
		background-color: white;	
	}
	
	ul.input_text, ul.file_attach  {
		list-style: none;
		padding: 0;
		margin-bottom: 10px;
	}
	
	/* 가입하기 버튼 */
	div#pwdFind {
		/* border: solid 1px blue; */
		margin: 0 auto;
		width: 620px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
	}
	/* 비밀번호 찾기 버튼 */
	div#pwdFindbtn {
		/* border: solid 1px blue; */
		margin: 0 auto;
		width: 620px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
	}
	
	/* 휴대폰 인증번호 받기 */
	div#mobilebtn {
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

		
		// 휴대전화 인증번호 받기
		$("#mobilebtn").click(function(){
			
			alert("인증번호가 발송되었습니다. 인증번호를 확인해주세요.");
			// alert("인증서비스 종료.");
			// 유효성 검사
			var useridVal = $("#userid").val().trim();
			var mobileVal = $("#mobile").val().trim();
			
			
			// gopwdFind_mobile();
			


		}); // end of  $("#mobilebtn").click(function()-------------------------------
		
				
		// 비밀번호 찾기 버튼 클릭 시 확인하기
		$("#pwdFindbtn").click(function(){ 
			
			// 1. 아이디와 전화번호가 공란인지 확인한다. -------------------------------------------- 
			var useridVal = $("#userid").val().trim();
			var mobileVal = $("#mobile").val().trim();
			
			if (useridVal == "" || mobileVal == "") {
				alert("아이디와 전화번호를 입력해주세요!");
				return;
			}
			
			// 2. 발송한 인증번호 일치 여부 확인한다. -----------------------------------------------
			var mobilemessageCheckVal = $("#mobilemessageCheck").val().trim(); // 회원이 입력한 인증번호
			var mobilemessageVal = $("#mobilemessage").val().trim(); // 발송된 인증번호
			
			if(mobilemessageVal == "") {
				alert("핸드폰 인증을 진행해주세요.");
				return;
			}
			
			if (mobilemessageCheckVal != mobilemessageVal) {
				alert("인증번호가 일치하지 않습니다. \n인증번호를 확인해주세요.");
				return;
			}
			
			// 3. 인증받은 아이디와 번호가 동일한지 확인한다. ---------------------------------------------
			var useridcheckVal = $("#useridcheck").val().trim();
			var mobilecheckVal = $("#mobilecheck").val().trim();
			
			if (useridVal != useridcheckVal) {
				alert("핸드폰 인증 시 작성한 아이디와 일치하지 않습니다.");
				return;
			}
			if (mobileVal != mobilecheckVal) {
				alert("핸드폰 인증 시 작성한 번호와 일치하지 않습니다.");
				return;
			}
			 

			 
			 // alert("userid : " + userid);
			 gopwdFind(); // 비밀번호 변경하기
			
			
			
		}); // end of $("#pwdFindbtn").click(function() ------------


		
	}); // end of $(document).ready(function() -----------

	// 휴대전화 인증번호 받기 함수		
	function gopwdFind_mobile() {
		
		var frm = document.pwdFind_form;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/login/pwdFind_mobile.up";
		frm.submit();
		
	}
			
	// 비밀번호 찾기 클릭 함수		
	function gopwdFind() {
		
		var frm = document.pwdFind_form;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/login/pwdFind_update.up";
		frm.submit();
		
	} // function gopwdFind()-------------------------------
</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">비밀번호 찾기</h1>
			</div>
		</section>	
	</div>
	
	<div id="pwdFindcontent">
		<br/><br/><br/><br/>
		<div id="pwdFind_content">
			<div id="pwdFind_back">
				<form name="pwdFind_form" id="pwdFind_form">
					<h3 style="text-align: center;">휴대전화  인증하기</h3>
					<ul class="input_text">
						<li>
							<label for="userid"></label>
							<input type="text" name="userid" id="userid" value="${userid}" class="input_text" required autofocus placeholder="아이디를 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						<li>
							<label for="mobile"></label>
							<input type="text" name="mobile" id="mobile" value="${mobile}" class="input_text" required placeholder="휴대전화 번호를 입력해주세요. (-제외)" style="border: solid 1px #ddd; border-top:solid 0px;  width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
					</ul>
					<%-- <input type="hidden" name="identity" id="identity" value="${identity}"/> --%>
					<div id="mobilebtn">인증번호 받기</div>
				
					<input type="hidden" id="useridcheck" name="userid" value="${userid}" />
					<input type="hidden" id="mobilecheck" name="mobilecheck" value="${mobile}" />
					
					<label style="padding: 10px 50px 0px 40px; line-height: 50px">인증번호</label><input type="text" id="mobilemessageCheck" name="mobilemessageCheck" required placeholder="인증번호를 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt; margin-top: 10px;"/>
					<input type="hidden" id="mobilemessage" name="mobilemessage" value="${mobilemessage}" />
					

					
					<div id="pwdFindbtn" style="margin-top: 30px; cursor: pointer;" >비밀번호 변경하기</div>
				
					<div style="color: #888; margin-top: 30px;">※ 인증번호 받기 버튼은 한번만 눌러주세요.</div>
					<div style="color: #888;">※ 회원가입 시 사용하신 아이디와 핸드폰번호를 입력해주세요.</div>
					<div style="color: #888;">※ 비밀번호 변경하기 버튼을 누르면 새로운 비밀번호로 변경 가능합니다.</div>

				</form>
			</div>
		
		</div>
	</div>


</body>