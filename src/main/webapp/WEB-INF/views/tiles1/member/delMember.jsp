<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#signuptitle {
		border: solid 1px gray;
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
		border: solid 1px red;
		width: 100%;
		height: 1500px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#delMember_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 800px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#delMember_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 570px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#delMember_form {
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
	div#delMemberbtn {
		border: solid 1px blue;
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
		border: solid 1px blue;
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
		
		// AJAX로 메일 인증번호 받기
		$("#mailbtn").click(function(){
			
			var nameVal = $("#name").val().trim();
			var emailVal = $("#email").val().trim();
			
			// alert(nameVal);
						
			if(nameVal != "" && emailVal != "") {
				// alert("이름, 이메일 작성 성공!")
				alert(nameVal+ "님, 인증번호가 발송되었습니다. 입력하신 메일의 인증번호를 작성해주세요.");
 				
				$.ajax({
					url: "<%=ctxPath%>/login/delMember_mail.up",
					data: {"name" : nameVal,
						   "email" : emailVal},
					type: "POST",
					dataType:"JSON",
					success: function(json) {	
						$("#mailmessage").val(json.mailmessage);
						$("#namecheck").val(json.name);
						$("#emailcheck").val(json.email);
						$("#userid").val(json.userid);
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); 
			} 
			else {
				alert("이름과 메일주소를 확인해주세요!");				
			}

		}); // end of  $("#mailbtn").click(function()-------------------------------
		
				
		// 아이디찾기 버튼 클릭 시 확인하기
		$("#delMemberbtn").click(function(){ 
			/* 
			// 1. 이름과 메일주소가 공란인지 확인한다. -------------------------------------------- 
			var nameVal = $("#name").val().trim();
			var emailVal = $("#email").val().trim();
			
			if (nameVal == "" || emailVal == "") {
				alert("이름과 이메일을 입력해주세요!");
				return;
			}
			
			// 2. 발송한 인증번호 일치 여부 확인한다. -----------------------------------------------
			var mailmessageCheckVal = $("#mailmessageCheck").val().trim(); // 회원이 입력한 인증번호
			var mailmessageVal = $("#mailmessage").val().trim(); // 메일 발송된 인증번호
			
			if(mailmessageVal == "") {
				alert("메일 인증을 진행해주세요.");
				return;
			}
			
			if (mailmessageCheckVal != mailmessageVal) {
				alert("인증번호가 일치하지 않습니다. \n인증번호를 확인해주세요.");
				return;
			}
			
			// 3. 인증받은 이름과 이메일이 동일한지 확인한다. ---------------------------------------------
			var namecheckVal = $("#namecheck").val().trim();
			var emailcheckVal = $("#emailcheck").val().trim();
			
			if (nameVal != namecheckVal) {
				alert("메일인증 시 작성한 이름과 일치하지 않습니다.");
				return;
			}
			if (emailVal != emailcheckVal) {
				alert("메일인증 시 작성한 이메일과 일치하지 않습니다.");
				return;
			}
			 */

			 
			 // alert("userid : " + userid);
			 godelMember(); // 아이디찾기
			
			
			
		}); // end of $("#delMemberbtn").click(function() ------------


		
	}); // end of $(document).ready(function() -----------

	// 회원 탈퇴하기 버튼 클릭	
	function godelMember() {
		
		var frm = document.delMember_form;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/member/delMember_end.up";
		frm.submit();
		
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
					<h3 style="text-align: center;">아이디 비밀번호 재 입력</h3>
					<ul class="input_text">
						<li>
							<label for="userid"></label>
							<input type="text" name="userid" id="userid" value="" class="input_text" required autofocus placeholder="아이디를 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						<li>
							<label for="pwd"></label>
							<input type="text" name="pwd" id="pwd" value="" class="input_text" required placeholder="비밀번호를 입력해주세요." style="border: solid 1px #ddd; border-top:solid 0px;  width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
					</ul>
					<%-- <input type="hidden" name="identity" id="identity" value="${identity}"/> --%>
					<div id="mailbtn">인증번호 받기</div>
					
					<input type="text" id="useridcheck" value="${SessionScope.loginuser.userid}" /> <!-- 로그인 세션에서 불러와도 될듯 -->
					<input type="text" id="pwdcheck" value="${SessionScope.loginuser.pwd}" />

					
					<div id="delMemberbtn" >회원 탈퇴하기</div>
				
					<div style="color: #888; margin-top: 30px;">※ 회원 탈퇴 </div>
					<div style="color: #888;">※ 안전한 회원탈퇴를 위해 로그인한 회원정보를 재 확인합니다.</div>

				</form>
			</div>
		
		</div>
	</div>


</body>