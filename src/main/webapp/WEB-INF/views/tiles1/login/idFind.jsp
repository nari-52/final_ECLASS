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
	
	div#idFindcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 700px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#idFind_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 600px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#idFind_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 470px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#idFind_form {
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
	
	/* 메일 인증번호 받기 */
	div#mailbtn {
		border: solid 1px #ddd;
		margin: 0 auto;
		width: 140px;
		height: 100px;
		line-height: 100px;
		background-color: #00bcd4;
		color: white;
		font-size: 13pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		float: right;
		margin-top: -125px;
		cursor: pointer;
	}
	
	/* 아이디찾기 버튼 */
	div#idfindbtn {
		border: solid 1px #ddd;
		margin: 0 auto;
		width: 620px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		margin-top: 30px;
		cursor: pointer;
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
					url: "<%=ctxPath%>/login/idFind_mail.up",
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
		$("#idfindbtn").click(function(){ 
			
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
			
			 // alert("userid : " + userid);
			 goidFind(); // 아이디찾기

		}); // end of $("#idfindbtn").click(function() ------------


		
	}); // end of $(document).ready(function() -----------

	// 아이디찾기 클릭 함수		
	function goidFind() {
		
		var frm = document.idFind_form;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/login/idFind_end.up";
		frm.submit();
		
	} // function goidFind()-------------------------------
</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">아이디 찾기</h1>
			</div>
		</section>	
	</div>
	
	<div id="idFindcontent">
		<br/><br/><br/><br/>
		<div id="idFind_content">
			<div id="idFind_back">
				<form name="idFind_form" id="idFind_form">
					<h3 style="text-align: center;">메일 주소 인증하기</h3>
					<ul class="input_text">
						<li>
							<label for="name"></label>
							<input type="text" name="name" id="name" value="${name}" class="input_text" required autofocus placeholder="이름을 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						<li>
							<label for="email"></label>
							<input type="text" name="email" id="email" value="${email}" class="input_text" required placeholder="이메일을 입력해주세요." style="border: solid 1px #ddd; border-top:solid 0px;  width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
					</ul>
					<%-- <input type="hidden" name="identity" id="identity" value="${identity}"/> --%>
					<div id="mailbtn">인증번호 받기</div>
					
					<input type="hidden" id="namecheck" value="" />
					<input type="hidden" id="emailcheck" value="" />
					<input type="hidden" id="userid" name="userid" value="" />
					
					<label style="padding: 10px 50px 0px 40px; line-height: 50px">인증번호</label><input type="text" id="mailmessageCheck" name="mailmessageCheck" required placeholder="인증번호를 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt; margin-top: 10px;"/>
					<input type="hidden" id="mailmessage" name="mailmessage" value="${mailmessage}" />
					

					
					<div id="idfindbtn" >아이디찾기</div>
				
					<div style="color: #888; margin-top: 30px;">※ 회원가입시 사용하신 이름과 메일주소를 입력해주세요.</div>
					<div style="color: #888;">※ 인증메일 발송에 약간의 시간이 소요됩니다.</div>

				</form>
			</div>
		
		</div>
	</div>


</body>