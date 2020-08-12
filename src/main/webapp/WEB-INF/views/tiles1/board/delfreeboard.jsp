<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    
    
<style type="text/css">
	
	div#login_container {
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
	
	/* 로그인 만들기  ----------------------------------------------------- */
	
	div#login_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 800px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 로그인 배경 만들기 */
	div#login_back {
		border: solid 1px  #ddd;
		width: 1080px;
		height: 450px;
		background: white;
		margin: 0 auto;
		margin-top: 50px;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}	
	
	form#loginFrm {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 400px;
		background-color: white;
	}
	
	ul.input_text {
		list-style: none;
		padding: 0;
	}
	
	li.saveID {
		margin: 20px 0px 30px 0px;
		text-align: right;
	}

	div#loginbtn{
		border: solid 1px blue;
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
	
	#loginbtn:hover{
		cursor: pointer;
	}
	
	div.login_footer {
		border: solid 1px #ddd;
		margin: 0 auto;
		margin-top: 10px;
		line-height: 60px;
		text-align: center;
		width: 620px;
		height: 60px;
	}

</style>

<script type="text/javascript">
	
	function goDel(){
		
		// 글암호 유효성 검사
		var pwVal = $("#password").val().trim();
		if(pwVal == "") {
			alert("글암호를 입력하세요!!");
			return;
		}
		
		// 폼(form) 을 전송(submit)
		var frm = document.delFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/delFreeboardEnd.up";
		frm.submit();
		
	}


</script>


<body>
	<div id="login_content">	
		<div id="login_back">
			<form name="delFrm" id="loginFrm">
				<div id="login">
					<h3>글 삭제하기</h3>
					<ul class="input_text">
						<li >
							<label for="userid"></label>
							<input type="text" name="password" id="password" class="input_text" required autofocus placeholder="삭제할 글의 암호를 입력해 주세요" style="border: solid 1px #ddd; width: 610px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
							<input type="text" name="free_seq" value="${free_seq}">
						</li>
					</ul>
					
					<div id="loginbtn" onclick="goDel()" >삭제하기</div>		
				</div>
			</form>
		</div>	
	</div>
</body>