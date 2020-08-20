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
		height: 810px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#pwdFind_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 800px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}

	div#pwdFind_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 570px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
	
	/* ------------------------------------------------------------ */
	form#information_form {
		border-top: solid 1px black;
		border-bottom: solid 1px black;
		margin: 0 auto;
		width: 1080px;
		height: 100%;
		background-color: white;
		margin-top: 15px;
		
	}
	
	table {
		border-collapse: collapse;
	}
	
	th {
		/* background-color: yellow; */
		width: 250px;
		text-align: left;
		padding-left: 10px;
		line-height: 60pt;
		
	}
	
	td {
		width: 900px;
		padding-left: 10px;
		text-align: left;
	}
	
	th, td {
		border-top: solid 1px #ddd;
		border-bottom: solid 1px #ddd;
	}
	
	/* 하단문구 */
	.sub_text {
		font-size: 9pt;
		padding-top: 5px;
	}
	
	/* 에러문구  */
	.error {
		font-size: 9pt;
		color: red;
		padding-left: 15px;
		
	}
		
	/* inputbox_short */
	.inputbox_short {
		width: 250px;
		line-height: 30pt;
		padding-left: 5pt;
		border: solid 1px #ddd;
		font-size: 12pt;
	}
	
	.inputbox_long {
		width: 890px;
		line-height: 30pt;
		padding-left: 5pt;
		border: solid 1px #ddd;
		font-size: 12pt;
		margin-top: 5px;
	}
	/* ------------------------------------------------------------ */	
	form#pwdchange_form {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 400px;
		background-color: white;	
	}


	div#changebtn {
		border: solid 1px #ddd;
		margin: 0 auto;
		width: 320px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		display: inline block;	
	}
	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){ 
		
		$(".error").hide();
		
		// 비밀번호 유효성 검사 --------------------------------------------
		$("#pwd").blur(function(){ 
			
			var data = $(this).val().trim();
			var regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
			var bool = regExp_pwd.test(data);
			
			if (data != "" && !bool ) { // 암호가 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
			}
			else {
				$(this).parent().find(".error").hide();
			}

		}); // -------------------------------------------------------
		
		
		// 비밀번호 일치여부 확인
		$("#pwdcheck").blur(function(){ 
			var pwd = $("#pwd").val();
			var pwdcheck = $(this).val().trim();

			if (pwd != pwdcheck) { // 암호가 일치하지 않는 경우
				$(this).parent().find(".error").show();
				$("#pwdcheck").val("");
				// $("#pwdcheck").focus();
			}
			else {
				$(this).parent().find(".error").hide();
			}

		}); // -------------------------------------------------------
		
		// 비밀번호 변경 버튼 클릭 시 
		$("#changebtn").click(function(){ 
			
			var pwd = $("#pwd").val().trim();
			var pwdcheck = $("#pwdcheck").val().trim();

			if (pwd != pwdcheck) { 
				$(this).parent().find(".error").show();
				alert("암호를 확인해주세요");
			}
			else {
				$(this).parent().find(".error").hide();
				func_pwdchange();
			}
			
		});
		
	}); // end of $(document).ready(function() -----------


	// 비밀번호 변경 함수
	function func_pwdchange() {
		
		var frm = document.pwdchange_form;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/login/pwdFind_end.up";
		frm.submit();
		
	}
</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">비밀번호 변경하기</h1>
			</div>
		</section>	
	</div>
	
	<div id="pwdFindcontent">
		<br/><br/><br/><br/>
		<div id="pwdFind_content">
			<div id="pwdFind_back">
				<form name="pwdchange_form" id="pwdchange_form">
					<h2 style="text-align: center;">비밀번호 변경하기</h2>
					<div style="text-align: center; ">새로운 비밀번호를 입력해주세요</div>
					<hr style="margin-bottom: 50px;">
					
					<input type="hidden" id="userid" name="userid"  value="${userid}" />
					<input type="hidden" id="mobile" name="mobile" value="${mobile}" />
					
					<table>
	
						<tr>
							<th>
								비밀번호
							</th>
							<td>
								<input type="password" name="pwd" id="pwd" class="requiredInfo inputbox_short" /> 
								<span class="error">비밀번호 조건에 부합하지 않습니다.</span>
								<div class="sub_text">비밀번호는 영문자, 숫자, 특수기호를 모두 포함하여 8~16자로 입력해 주세요.</div>
							</td>
						</tr>
						<tr>
							<th>
								비밀번호 확인
							</th>
							<td>
								<input type="password" id="pwdcheck" class="requiredInfo inputbox_short" /> 
								<span class="error">암호가 일치하지 않습니다.</span>
								<div class="sub_text">동일한 비밀번호를 다시 한 번 입력해주세요.</div>
							</td>
						</tr>

					</table>
					
				</form>
				
				<div id="changebtn" >비밀번호 변경</div>
				
				<!-- <div id="loginbtn" >로그인</div>
				<div id="mainbtn" >메인으로</div> -->
				
			</div>
		
		</div>
	</div>


</body>