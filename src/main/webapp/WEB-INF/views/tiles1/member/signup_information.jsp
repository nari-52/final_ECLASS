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
	
	div#signupcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 1400px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	div#processBar {
		/* border: solid 1px yellow; */
		display: inline-block;
		padding: 40px 0 20px 180px;
		/* overflow: hidden; *//* div 태그 상위 태그 크기에 맞추기 */
		align-content: center; 
	}
	
	ul.processBar, li.processBar {
		list-style: none;
		display: inline-block;
		margin: 0 10px;
	}
	
	li.currentProcess {
		border: solid 1px #ddd;
		width: 180px;
		background-color: white;
		padding: 5px;
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
	
	/* 가입정보 입력 ------------------------------------------ */
	div#information_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 950px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 가입정보 form 배경 만들기 */
	div#information_back {
		/* border: solid 1px #ddd; */
		width: 1080px;
		height: 100%;
		background: #fafafa;
		margin: 0 auto;
		padding-top: 40px; /* 가입정보를 입력해주세요 위 공간 */
	}
		
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
		width: 160px;
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
		border-bottom: solid 1px #ddd;
	}
	
	/* 필수입력항목 */
	.required_red {
		color: red;
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
	
	
	/* 가입/취소 버튼 --------------------------------------------  */
	div#buttonTnC {
		/* border: solid 1px blue; */
		width: 100%;
	}
	
	.btnTnC {
		border: solid 1px #ddd;
		width: 150px;
		height: 42px;
		font-size: 14pt;
		margin: 0 10px;
		
	}
	
	.agree {
		background-color: #00bcd4;
		color: white;
		font-weight: bold;
		margin-left: 400px;
	}
	
	.reset {
		background-color: #666;
		color: white;
		font-weight: bold;
	}
	
	.pointer {
		cursor: pointer;
	}
	
	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소 api -->
<script type="text/javascript">

	$(document).ready(function(){ 
		
		// 엔터를 누를 경우 다음 input 태그로 이동하기
		$('input').keydown(function(e) {
			var idx = $('input').index(this); // index가 바로 eq 값을 알려주는 친구
			if (e.keyCode === 13) {
				event.preventDefault(); // input 태그에서 엔터 누를 시 submit 방지하기
				$('input').eq(idx+1).focus();
				
			};
		}); 
		
		// 아이디 중복확인 클릭 여부
		var bIdDuplicateCheck = false; 
		// 휴대전화 중복확인 클릭 여부
		var bMobileDuplicateCheck = false; 
		
		$(".error").hide();
		
		// 이름 수정 불가 ----------------------------
		$("#name").mouseover(function(){ 
			$(this).parent().find(".error").show();
		}); 
		
		$("#name").mouseout(function(){ 
			$(this).parent().find(".error").hide();
		});
		
		// 아이디 유효성 검사 ---------------------------
		$("#userid").blur(function(){ 

			var data = $(this).val().trim();
			
			// 유효성 검사 해야함 (영소문자 + 숫자 조합 4 ~ 20)
			var regExp_userid = /^(?=.*[a-z])+[a-z0-9_]{4,20}$/;
			var bool = regExp_userid.test(data);
			
			if(data == "" && bool) {
				$(this).parent().find(".iderror").show();
				$(this).parent().find(".idregex").hide();
			}
			else if (!bool) {
				$(this).parent().find(".idregex").show();
				$(this).parent().find(".iderror").hide();
			}
			else {
				$(this).parent().find(".iderror").hide();
				$(this).parent().find(".idregex").hide();
			}
		});

		// AJAX로 아이디 중복 검사 --------------------------
		$("#idcheck").click(function(){ 
			// alert("아이디 중복검사 체크");
			var useridVal = $("#userid").val().trim();
			
			$("#idcheckResult").html("");
			var regExp_userid = /^(?=.*[a-z])+[a-z0-9_]{4,20}$/;
			var bool = regExp_userid.test(useridVal);
			
			// 빈칸으로 아이디 중복검사 버튼을 누른 경우
			if(useridVal == "") {
				$(".iderror").show();
			}
			// 아이디 중복검사 버튼을 잘 누른 경우
			else if (useridVal != "") {
				bIdDuplicateCheck = true; // 아이디 중복검사 클릭함 (true)
				
				$(".iderror").hide();
				
				$.ajax({ 
					url: "<%= ctxPath%>/member/idDuplicateCheck.up",
					type: "POST",
					data: {"userid":$("#userid").val()},
					dataType: "JSON",
					success: function(json) {						
						if(json.isUse == null && useridVal != "" && bool ) {
							$("#idcheckResult").html("사용가능합니다.").css({"color":"navy", "font-size":"9pt"});
						}
						else if (useridVal != "" & bool) {
							$("#idcheckResult").html($("#userid").val()+" 은 중복된 ID라 사용 불가능합니다.").css({"color":"red", "font-size":"9pt"});
							$("#userid").val("");
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); // end of ajax
			}
		}); // end of $("#idcheck").click(function(){ ----------------------------------------------
		
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

			if (pwd != pwdcheck) { // 암호가 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
				$("#pwdcheck").val("");
				// $("#pwdcheck").focus(); // focus()시 비밀번호 새로 쓰기 불가능
			}
			else {
				$(this).parent().find(".error").hide();
			}

		}); // -------------------------------------------------------
		

		// 휴대전화 유효성 검사 ------------------------------------------
		$("#mobile").keyup(function(){  
			
			var keycode = event.keyCode;
			
			
			// 숫자 이외의 문자를 입력 시 에러 문구 보여준다.
			if( !((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105))){
				$(this).parent().find(".error").show(); 
				$("#mobilecheckResult").val("");
		    }
			
			$(this).parent().find(".error").hide();
			var data = $(this).val().trim();
			var regExp_mobile = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	
			var bool = regExp_mobile.test(data);
			
			if (!bool ) { // 암호가 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
				$("#mobilecheckResult").val("");
			}
			else {
				$(this).parent().find(".error").hide();
			}
		
		});
		
			
		// AJAX로 휴대전화 중복 검사 --------------------------
		$("#mobilecheck").click(function(){ 
			// alert("모바일 중복검사 체크");
			var mobileVal = $("#mobile").val().trim();
			var keycode = event.keyCode;
			
			// 숫자 이외의 문자를 입력 시 에러 문구 보여준다.
			if( !((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105))){
				$(".mberror").show();
				$("#mobilecheckResult").val("");
		    }
			
			// 빈칸으로 모바일 중복검사 버튼을 누른 경우
			if(mobileVal == "" || ((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105))) {
				$(".mberror").show();
			}
			// 모바일 중복검사 버튼을 잘 누른 경우
			else if (mobileVal != "") {
				bMobileDuplicateCheck = true; // 아이디 중복검사 클릭함 (true)
				
				$(".mberror").hide();
				
				$.ajax({ 
					url: "<%= ctxPath%>/member/mobileDuplicateCheck.up",
					type: "POST",
					data: {"mobile":$("#mobile").val()},
					dataType: "JSON",
					success: function(json) {
						if(json.isUseMobile == null && mobileVal != "" ) {
							$("#mobilecheckResult").html("사용가능합니다.").css({"color":"navy", "font-size":"9pt"});
						}
						else if (mobileVal != "") {
							$("#mobilecheckResult").html($("#mobile").val()+" 은 중복된 번호라 사용 불가능합니다.").css({"color":"red", "font-size":"9pt"});
							$("#mobile").val("");
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); // end of ajax
			}
		}); 
		
		
		// 이메일 수정 불가 -------------------------------
		$("#email").mouseover(function(){ 
			$(this).parent().find(".error").show();
		}); 
		
		$("#email").mouseout(function(){ 
			$(this).parent().find(".error").hide();
		});
		
		// 주소 api ----------------------------------------
		$("#zipcodeSearch").click(function(){
			// alert("주소 api");
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraaddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraaddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailaddress").focus();
	            }
	        }).open();	
		});

		
		// 가입 버튼을 눌렀을 경우 ------------------------------------
		$("#goRegister").click(function(){ 
			
			// 아이디 공백 여부 --------------------------------
			var useridVal = $("#userid").val().trim();
			
			if (useridVal == "") {
				alert("아이디를 입력해주세요!");
				return false;
			}

			// 아이디 중복확인 클릭 여부 --------------------------------
			if (bIdDuplicateCheck == false) {
				alert("아이디 중복확인은 필수입니다!");
				return false;
			}
			
			// 비밀번호 공백 여부 --------------------------------
			var pwdVal = $("#pwd").val().trim();
			var pwdcheckVal = $("#pwdcheck").val().trim();
			
			if (pwdVal == "" || pwdcheckVal == "" ) {
				alert("비밀번호를 입력해주세요!");
				return false;
			}
			
			// 대학명 공백 여부 --------------------------------
			var universityVal = $("#university").val().trim();
			
			if (universityVal == "") {
				alert("대학명을 입력해주세요!");
				return false;
			}
			
			// 학과명 공백 여부 --------------------------------
			var majorVal = $("#major").val().trim();
			
			if (majorVal == "") {
				alert("학과명을 입력해주세요!");
				return false;
			}
			
			// 학번 공백 여부 --------------------------------
			var student_numVal = $("#student_num").val().trim();
			
			if (student_numVal == "") {
				alert("학번을 입력해주세요!");
				return false;
			}
			
			// 휴대전화 공백 여부 --------------------------------
			var mobileVal = $("#mobile").val().trim();
			
			if (mobileVal == "") {
				alert("휴대전화를 입력해주세요!");
				return false;
			}
			
			// 휴대전화 중복확인 클릭 여부 --------------------------------
			if (bMobileDuplicateCheck == false) {
				alert("휴대전화 중복확인은 필수입니다!");
				return false;
			}
			
			func_goRegister();
			
		});
		
	}); // end of $(document).ready(function() -----------
	
	// 회원가입 함수
	function func_goRegister() {
		
		var frm = document.information_form;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/member/signup_step3_end.up";
		frm.submit();
		
	}		
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
				<li class="processBar currentProcess">
					<div class="pracessTitle">step 02</div>
					<div class="processContent">본인인증</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess currentstep">
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
		<br/>
	
		
		<div id="information_content">
			<div id="information_back">
				<span style="font-size: 16pt; ">가입정보를 입력해 주세요.</span><span class="required_red" style="margin-left: 630px;">*</span>
				<span style="font-size: 10pt;">표시는 필수 입력 항목입니다.</span>
				<form name="information_form" id="information_form" >
					<table>
						<tr>
							<th>
								<span class="required_red">*</span>
								이름
							</th>
							<td>
								<input type="text" name="name" id="name" value="${name}" class="requiredInfo inputbox_short" readonly /> 
								<span class="error">이름은 수정할 수 없습니다.</span>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								아이디
							</th>
							<td>
								<input type="text" name="userid" id="userid" class="requiredInfo inputbox_short" /> 
								<span id="idcheck" class="pointer" style="display: inline-block; border: solid 1px #464646; width: 100px; line-height: 30pt; text-align: center; margin-left: 15px;">중복확인</span>
								<span id="idcheckResult"></span>
								<span class="error iderror">아이디는 필수입력 사항입니다.</span>
								<span class="error idregex">아이디는 영소문자, 숫자를 포함하여 4~20글자로 입력해주세요.</span>
								<div class="sub_text">아이디는 '영소문자' 또는 '영소문자 + 숫자'를 포함하여 4~20글자로 입력해주세요. 중복확인을 눌러주세요. </div>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
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
								<span class="required_red">*</span>
								비밀번호 확인
							</th>
							<td>
								<input type="password" id="pwdcheck" class="requiredInfo inputbox_short" /> 
								<span class="error">암호가 일치하지 않습니다.</span>
								<div class="sub_text">동일한 비밀번호를 다시 한 번 입력해주세요.</div>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								대학명
							</th>
							<td>
								<input type="text" name="university" id="university" placeholder="OO대학교" class="requiredInfo inputbox_short" /> 
								<!-- <span id="universitycheck" style="display: inline-block; border: solid 1px #464646; width: 100px; line-height: 30pt; text-align: center; margin-left: 15px;">대학검색</span> -->
								<span class="error"></span>
								<div class="sub_text">예: 한국대학교</div>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								학과
							</th>
							<td>
								<input type="text" name="major" id="major" class="requiredInfo inputbox_short" /> 
								<span class="error"></span>
								<div class="sub_text">학과명을 입력해주세요.</div>
							</td>
						</tr>
						
						<c:if test="${identity eq '1'}">
							<tr>
								<th>
									<span class="required_red">*</span>
									학번
								</th>
								<td>
									<input type="text" name="student_num" id="student_num" class="requiredInfo inputbox_short" /> 
									<span class="error"></span>
									<div class="sub_text">학번을 입력해주세요.</div>
								</td>
							</tr>
						</c:if>
						<c:if test="${identity eq '2'}">
							<tr>
								<th>
									학번
								</th>
								<td>
									<input type="text" name="student_num" id="student_num" class="requiredInfo inputbox_short" /> 
									<span class="error"></span>
									<div class="sub_text">교수로 회원가입 시 입력하지 않으셔도 됩니다.</div>
								</td>
							</tr>
						</c:if>
						<tr>
							<th>
								<span class="required_red">*</span>
								휴대전화
							</th>
							<td>
								<input type="text" name="mobile" id="mobile" class="requiredInfo inputbox_short" placeholder="숫자만 입력해 주세요." /> 
								<span id="mobilecheck" class="pointer" style="display: inline-block; border: solid 1px #464646; width: 100px; line-height: 30pt; text-align: center; margin-left: 15px;">중복확인</span>
								<span id="mobilecheckResult"></span>
								<span class="error mberror">휴대전화 형식이 아닙니다.</span>
								<div class="sub_text">중복확인을 눌러주세요.</div>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								이메일
							</th>
							<td>
								<input type="text" name="email" id="email" value="${email}" class="requiredInfo inputbox_short" placeholder="eclass@eclass.com" readonly /> 
								<span class="error">이메일은 수정할 수 없습니다.</span>
								<div class="sub_text"></div>
							</td>
						</tr>
						
						<tr>
							<th>
								주소
							</th>
							<td style="padding: 5px 0px 5px 10px; ">
								<input type="text" id="postcode" name="postcode" size="6" maxlength="5" class="inputbox_short" />
								<span id="zipcodeSearch" class="pointer" style="display: inline-block; border: solid 1px #464646; width: 130px; line-height: 30pt; text-align: center; margin-left: 15px;">우편번호 검색</span>
								<input type="text" id="address" name="address" size="40" placeholder="주소" class="inputbox_long"/><br/>
								<input type="text" id=detailaddress name="detailaddress" size="40" placeholder="상세주소" class="inputbox_long"/>
								<input type="text" id="extraaddress" name="extraaddress" size="40" placeholder="참고항목" class="inputbox_long"/> 
								<span class="error"></span>
							</td>
						</tr>
						
						<input type="hidden" id="identity" name="identity" value="${identity}"/>
						<input type="hidden" id="filename" name="filename" value="${filename}"/>
						<input type="hidden" id="orgfilename" name="orgfilename" value="${orgfilename}"/>	
					</table>
					
					<br/><br/><br/>
					<div id="buttonTnC">
						<button class="btnTnC agree pointer" id="goRegister">가입</button>
						<button class="btnTnC reset pointer" onclick="alert('취소 (메인페이지로)')">취소</button>
					</div>	
				</form>
			</div>
		</div>
	</div>

</body>

