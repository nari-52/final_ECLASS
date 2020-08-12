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
	
	div#signupcontent {
		border: solid 1px red;
		width: 100%;
		height: 1500px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	div#processBar {
		border: solid 1px yellow;
		display: inline-block;
		padding: 20px 0 20px 180px;
		/* overflow: hidden; *//* div 태그 상위 태그 크기에 맞추기 */
		align-content: center; 
	}
	
	ul.processBar, li.processBar {
		list-style: none;
		display: inline-block;
		margin: 0 10px;
	}
	
	li.currentProcess {
		border: solid 1px blue;
		width: 180px;
		background-color: yellow;
	}
	
	.pracessTitle {
		color: gray;
		text-align: center;
		width: 100%;
		padding: 0;
	}
	
	.processContent {
		font-size: 18px;
		text-align: center;
		padding: 0;
	}
	
	li.currentstep {
		background-color: #00bcd4;
	}
	
	/* 진행상황 끝 ------------------------------------------ */
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#mailAuthentication_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 800px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#mailAuthentication_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 570px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#mailAuthentication_form {
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
	div#authenticationbtn{
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
			
			// alert(nameVal+","+emailVal);
			// 김나리,676952@naver.com
			
			if(nameVal != "" && emailVal != "") {
				// alert("이름, 이메일 작성 성공!")
				alert(nameVal+ "님, 인증번호가 발송되었습니다. 입력하신 메일의 인증번호를 작성해주세요.");
 				$.ajax({
					url: "<%=ctxPath%>/member/signup_step2_mail.up",
					data: {"name" : nameVal,
						   "email" : emailVal},
					type: "POST",
					dataType:"JSON",
					success: function(json) {	
						$("#mailmessage").val(json.mailmessage);
						$("#namecheck").val(json.name);
						$("#emailcheck").val(json.email);
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
		
				
		// 가입하기 버튼 클릭 시 확인하기
		$("#authenticationbtn").click(function(){ 
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
			 
			 
			// 4. 파일 첨부 여부 확인한다. --------------------------------------------------------
			var filecheck = $("#attach").val();
			if(!filecheck) {
				alert("사진파일 첨부는 필수입니다.");
				return;
			}
			else {
				// 파일 첨부가 되었을 경우
				
				// AJAX로 파일 이름 넘겨주기 ------------------------------
		 
				var attachVal = $("#attach").val().trim();
				
				<%-- $.ajax({
					url: "<%=ctxPath%>/member/signup_step2_attach.up",
					data: {"attach" : attachVal},
					type: "POST",
					dataType:"JSON",
					success: function(json) {	
						
						/* $("#mailmessage").val(json.mailmessage);
						$("#namecheck").val(json.name);
						$("#emailcheck").val(json.email); */
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				 --%>
				
				
				goJoin(); // 가입
			} // end of else ---------
			
			
			
			
			
		}); // end of $("#authenticationbtn").click(function() ------------
		

		

		
	}); // end of $(document).ready(function() -----------

	// 가입버튼 클릭 함수		
	function goJoin() {
		
		var frm = document.mailAuthentication_form;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/member/signup_step3.up";
		frm.submit();
		
	} // function goJoin(identity)-------------------------------
</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">회원가입</h1>
			</div>
		</section>	
	</div>
	
	<div id="signupcontent">
		<div id="processBar">
			<ul class="processBar">
				<li class="processBar currentProcess ">
					<div class="pracessTitle">step 01</div>
					<div class="processContent">약관동의</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess currentstep">
					<div class="pracessTitle">step 02</div>
					<div class="processContent">본인인증</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess">
					<div class="pracessTitle">step 03</div>
					<div class="processContent">정보입력</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess">
					<div class="pracessTitle">step 04</div>
					<div class="processContent">가입완료</div>
				</li>
			</ul>
		</div>
		<br/><br/><br/><br/>
		<div id="mailAuthentication_content">
			<div id="mailAuthentication_back">
				<form name="mailAuthentication_form" id="mailAuthentication_form">
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
					<input type="hidden" name="identity" id="identity" value="${identity}"/>
					<div id="mailbtn">인증번호 받기</div>
					
					<input type="hidden" id="namecheck" value="" />
					<input type="hidden" id="emailcheck" value="" />
					
					<label style="padding: 10px 50px 0px 40px; line-height: 50px">인증번호</label><input type="text" id="mailmessageCheck" name="mailmessageCheck" required placeholder="인증번호를 입력해주세요." style="border: solid 1px #ddd; width: 450px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt; margin-top: 10px;"/>
					<input type="text" id="mailmessage" name="mailmessage" value="${mailmessage}" />
					
					<ul class="file_attach">
						<li>
							<c:if test="${identity == 1}"> 
						
							<label>학생증 사진파일을 첨부해주세요.</label>
							</c:if>
							<c:if test="${identity == 2}"> 
						
							<label>재직증명서 사진파일을 첨부해주세요.</label>
							</c:if>
							<input type="file" id="attach" name="attach" style="border: solid 1px red; width: 610px; height: 50px; vertical-align: middle;" />
							<input type="text" id="filename" value="" />
						</li>
					</ul>
					
					<div id="authenticationbtn" >가입하기</div>
				
					<div style="color: #888; margin-top: 30px;">※ 인증메일 발송에 약간의 시간이 소요됩니다.</div>
					<div style="color: #888;">※ 유효하지 않은 파일 첨부 시 회원가입이 거절될 수 있습니다.</div>
					<div style="color: #888;">※ 작성하신 이름과 이메일은 회원가입에 사용됩니다.</div>

				</form>
			</div>
		
		</div>
	</div>


</body>