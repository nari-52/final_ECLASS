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
		height: 1200px;
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
	
	div#TermsAndConditions {
		width: 1080px;
		margin: 0 auto;
	}
	
	.TnCcheck {
		font-size: 10pt;
		color: gray;
	}
	
	/* 동의/취소 버튼 --------------------------------------------  */
	div#buttonTnC {
		border: solid 1px blue;
		width: 100%;
	}
	
	.btnTnC {
		border: solid 1px red;
		width: 150px;
		height: 42px;
		font-size: 14pt;
		margin: 0 10px;
		
		
	}
	
	.agree {
		background-color: #00bcd4;
		color: white;
		font-weight: bold;
		margin-left: 370px;
	}
	
	.reset {
		background-color: #666;
		color: white;
		font-weight: bold;
	}
	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){ 
		
		var identity = $("#identity").val();
		
		// 체크박스 전체 선택/해제
		$("#allCheck").click(function(){ 
			$("input:checkbox[name=TnC]").prop("checked", true);
			if(this.checked == false) {
				$("input:checkbox[name=TnC]").prop("checked", false);
			}

		});
		
		// 체크박스 전체 동의 아니면 전체동의 체크박스 해제
		$("input:checkbox[name=TnC]").click(function(){
	         var bFlag = false;
	         $("input:checkbox[name=TnC]").each(function(){
	            var bool = $(this).prop("checked");
	            if(!bool){
	               $("input:checkbox[id=allCheck]").prop("checked",false);
	               bFlag = true;
	               return false;
	            }
	         });
	         if(!bFlag)
	            $("input:checkbox[id=allCheck]").prop("checked",true);
	      });
		
		
		// 동의 버튼을 눌렀을 떄 
		$("#goStep2").click(function(){ 
			
			// 필수 체크박스 동의여부 확인하기 -----------------
			var TnC01CheckedLen = $("input:checkbox[id=TnC01]:checked").length;
			var TnC02CheckedLen = $("input:checkbox[id=TnC02]:checked").length;
			
			// alert(TnC01CheckedLen);
			// 1
			
			if ( !(TnC01CheckedLen * TnC02CheckedLen > 0) ) {
				alert("필수 항목은 반드시 동의하셔야 합니다.");
				return false; // 넘어가지 말아야 한다.
				
			}
			else {
				location.href="<%= ctxPath%>/member/signup_step2.up?identity="+identity;
				
			}
						
		});
		
		
	}); // end of $(document).ready(function() -----------

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
				<li class="processBar currentProcess currentstep">
					<div class="pracessTitle">step 01</div>
					<div class="processContent">약관동의</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess">
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
		<div id="TermsAndConditions">
			<input type="checkbox" id="allCheck" /><label for="allCheck">모든 약관을 확인하고 모두 동의합니다.</label>
			<hr>
			<br/>
			<h3>ECLASS 웹사이트 이용약관 (필수)</h3>
				<div id="TnC1">
					<iframe src="<c:url value="/resources/iframeAgree/tnc1.html" />" width="100%" height="150px" style="border: solid 1px gray; margin: 20px 0px; background-color: white;"></iframe>
				</div>
				<input type="checkbox" name="TnC" id="TnC01" /><label for="TnC01" class="TnCcheck">ECLASS 웹사이트 이용약관에 동의합니다.</label>
			<h3>개인정보처리방침 (필수)</h3>
				<div id="TnC2">
					<iframe src="<c:url value="/resources/iframeAgree/tnc2.html" />" width="100%" height="150px" style="border: solid 1px gray; margin: 20px 0px; background-color: white;"></iframe>
				</div>
				<input type="checkbox" name="TnC" id="TnC02" /><label for="TnC02" class="TnCcheck">개인정보처리방침에 동의합니다.</label>
			<h3>개인정보위탁동의 (선택)</h3>
				<div id="TnC3">
					<iframe src="<c:url value="/resources/iframeAgree/tnc3.html" />" width="100%" height="150px" style="border: solid 1px gray; margin: 20px 0px; background-color: white;"></iframe>
				</div>
				<input type="checkbox" name="TnC" id="TnC03" /><label for="TnC03" class="TnCcheck">개인정보 위탁에 동의합니다.</label>
			<input type="hidden" name="identity" id="identity" value="${identity}"/>
			<br/><br/><br/>
			<div id="buttonTnC">
				<button class="btnTnC agree" id="goStep2" >동의</button>
				<button class="btnTnC reset" onclick="javascript:location.href='<%= ctxPath%>/index.up'">취소</button>
			</div>	
		</div>	
	</div>
</body>

    
    