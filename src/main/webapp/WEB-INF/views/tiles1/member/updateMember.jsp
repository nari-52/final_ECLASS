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
	

	/* 가입정보 입력 ------------------------------------------ */
	div#signupcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 1250px;
		background: #fafafa;
		display: inline-block;
		
	}
	
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
		width: 100%;
	}
	
	.btnTnC {
		border: solid 1px #ddd;
		width: 150px;
		height: 42px;
		font-size: 14pt;
		margin: 0 10px;
		cursor: pointer;
		
	}
	
	.agree {
		background-color: #00bcd4;
		color: white;
		font-weight: bold;
		margin-left: 360px;
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
		
		// 아이디 수정 불가 ----------------------------
		$("#userid").mouseover(function(){ 
			$(this).parent().find(".error").show();
		}); 
		
		$("#userid").mouseout(function(){ 
			$(this).parent().find(".error").hide();
		});
		

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
				// $("#pwdcheck").focus();
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
				}); // end of ajax ------------------
			}
		}); 
		

		
		// 이메일 수정 불가 -------------------------------
		$("#email").mouseover(function(){ 
			$(this).parent().find(".error").show();
		}); 
		
		$("#email").mouseout(function(){ 
			$(this).parent().find(".error").hide();
		});
		
		
		
		// 주소 api
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
		
		// 회원정보 수정 버튼을 눌렀을 경우
		$("#goUpdateMember").click(function(){ 
			

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
			var mobileCheckVal = $("#mobileCheck").val().trim();
			
			if (mobileVal == "") {
				alert("휴대전화를 입력해주세요!");
				return false;
			}
			
			else if (mobileVal != mobileCheckVal && bMobileDuplicateCheck == false) {
				// 휴대전화를 변경했는데 중복확인을 하지 않은 경우
				alert("휴대전화 중복확인은 필수입니다!");
				return false;
			}

			func_goUpdateRegister();
			
		});
		
	}); // end of $(document).ready(function() -----------
	
	// 회원가입 함수
	function func_goUpdateRegister() {
		
		var frm = document.information_form;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/member/updateMember_end.up";
		frm.submit();
		
	}		
</script>

<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">회원정보 수정</h1>
			</div>
		</section>	
	</div>
	
	<div id="signupcontent">
		<br/>
	
		
		<div id="information_content">
			<div id="information_back">
				<span style="font-size: 16pt; ">가입정보를 입력해 주세요.</span><span class="required_red" style="margin-left: 630px;">*</span>
				<span style="font-size: 10pt;">표시는 필수 입력 항목입니다.</span>
				<form name="information_form" id="information_form">
					<table>
						<tr>
							<th>
								<span class="required_red">*</span>
								이름
							</th>
							<td>
								<input type="text" name="name" id="name" value="${mvo.name}" class="requiredInfo inputbox_short" readonly /> 
								<span class="error">이름은 수정할 수 없습니다.</span>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								아이디
							</th>
							<td>
								<input type="text" name="userid" id="userid" value="${mvo.userid}" class="requiredInfo inputbox_short" readonly/> 
								<span class="error iderror">아이디는 수정할 수 없습니다.</span>
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
								<input type="text" name="university" id="university" value="${mvo.university}" placeholder="OO대학교"  class="requiredInfo inputbox_short" /> 
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
								<input type="text" name="major" id="major" value="${mvo.major}" class="requiredInfo inputbox_short" /> 
								<span class="error"></span>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								학번
							</th>
							<td>
								<input type="text" name="student_num" id="student_num" value="${mvo.student_num}" class="requiredInfo inputbox_short" /> 
								<span class="error"></span>
							</td>
						</tr>
						
						<tr>
							<th>
								<span class="required_red">*</span>
								휴대전화
							</th>
							<td>
								<input type="text" name="mobile" id="mobile" value="${mvo.mobile}" class="requiredInfo inputbox_short" placeholder="숫자만 입력해 주세요." />
								<input type="text" name="mobileCheck" id="mobileCheck" value="${mvo.mobile}" class="requiredInfo inputbox_short" /> 
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
								<input type="text" name="email" id="email" value="${mvo.email}" class="requiredInfo inputbox_short" placeholder="eclass@eclass.com" readonly /> 
								<span class="error">이메일은 수정할 수 없습니다.</span>
								<div class="sub_text"></div>
							</td>
						</tr>
						
						<tr>
							<th>
								주소
							</th>
							<td style="padding: 5px 0px 5px 10px; ">
								<input type="text" id="postcode" name="postcode" value="${mvo.postcode}" size="6" maxlength="5" class="inputbox_short" />
								<span id="zipcodeSearch" class="pointer" style="display: inline-block; border: solid 1px #464646; width: 130px; line-height: 30pt; text-align: center; margin-left: 15px;">우편번호 검색</span>
								<input type="text" id="address" name="address" value="${mvo.address}" size="40" placeholder="주소" class="inputbox_long"/><br/>
								<input type="text" id=detailaddress name="detailaddress" value="${mvo.detailaddress}" size="40" placeholder="상세주소" class="inputbox_long"/>
								<input type="text" id="extraaddress" name="extraaddress" value="${mvo.extraaddress}" size="40" placeholder="참고항목" class="inputbox_long"/> 
								<span class="error"></span>
							</td>
						</tr>
						
						<input type="hidden" id="identity" name="identity" value="${mvo.identity}"/>
						<input type="hidden" id="filename" name="filename" value="${mvo.filename}"/>
						<input type="hidden" id="orgfilename" name="orgfilename" value="${mvo.orgfilename}"/>
						
					</table>
					
					<br/><br/><br/>
					<div id="buttonTnC">
						<button class="btnTnC agree pointer" id="goUpdateMember">수정</button>
						<button class="btnTnC reset pointer" onclick="alert('취소 (메인페이지로)')">취소</button>
					</div>	
						
				
				</form>
			</div>
		
		</div>
		
	</div>


</body>




















