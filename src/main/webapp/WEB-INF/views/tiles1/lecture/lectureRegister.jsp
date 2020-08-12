<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examRegister.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>

	$(document).ready(function(){
		
		// === jQuery UI 의 datepicker === //
		$(".datepicker").datepicker({
			dateFormat: 'yy-mm-dd'  //Input Display Format 변경
			,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
			,changeYear: true        //콤보박스에서 년 선택 가능
			,changeMonth: true       //콤보박스에서 월 선택 가능
			,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
			,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		});                    
            
		//초기값을 오늘 날짜로 설정
		$('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		
		// === 전체 datepicker 옵션 일괄 설정하기 ===  
		//     한번의 설정으로 $("#fromDate"), $('#toDate')의 옵션을 모두 설정할 수 있다.
		$(function() {
			//모든 datepicker에 대한 공통 옵션 설정
			$.datepicker.setDefaults({
				dateFormat: 'yy-mm-dd' //Input Display Format 변경
				,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
				,changeYear: true //콤보박스에서 년 선택 가능
				,changeMonth: true //콤보박스에서 월 선택 가능                
				,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
				,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
				,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
				,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
				,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
				,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
				,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트                  
			});
     
			//input을 datepicker로 선언
			$("#fromDate").datepicker();
			$("#toDate").datepicker();
			
			//From의 초기값을 오늘 날짜로 설정
			$('#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
			//To의 초기값을 내일로 설정
			$('#toDate').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		});
		
	}); // end of $(document).ready(function()
	
	function goSubmit() {
		var frm = document.registerFrm;
        frm.method = "POST";
        frm.action = "<%=ctxPath%>/exam/examRegisterEnd.up";
        frm.submit(); 
	}

</script>


<div id="contentsWrap">

	<div id="register-title">강의 등록</div>
	
	<form id="registerFrm" name="registerFrm">
		<span id="inputTitle" style="margin-right: 10px;">강의 제목</span><input type="text" name="lecTitle" style="width: 930px;">
		<br><br>
		<span id="inputTitle" style="margin-right: 10px;">강의 영상 주소</span>
		<br>
		<input type="text" name="lecLink" style="height: 200px; width: 1000px;" />
		<br><br>
		<span id="inputDate" style="margin-right: 10px;">시청 시작 일자</span><input type="text" class="datepicker" name="lecStartday"/>
		<br><br>
		<span id="inputDate" style="margin-right: 10px;">시청 마감 일자</span><input type="text" class="datepicker" name="lecEndday"/>
		<br><br><div>--------------------- 여기밑에부터 hidden ---------------------</div><br>
		<span style="margin-right: 10px;">교과목시퀀스</span><input type="text" name="subSeq" />
	</form>
	
	<div id="buttons">
		<button type="button" onclick="goSubmit();">등록</button>
		<button type="reset">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>