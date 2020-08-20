<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<% String ctxPath = request.getContextPath(); %>

<style>
	#container{
		/* background-color: #fafafa; */
	}

	#wholeNotice{
		width: 900px;
		margin: 0 auto;
		border : solid 0px #ccc;
	}
	
	#container table,tr,th,td{
		border-collapse: collapse;
		padding: 20px;
		font-size: 10pt;
		color : gray;
		text-align: left;
	}
	
	#container th{
		width: 150px;
		text-align: left;
		padding : 10px 20px;
	}
	#container input[type=text] {
		border: solid 1px #ccc;
		border-radius: 2px;
		height: 20px;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examRegister.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- 데이트 피커 --%>		
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
		
				
		<%-- 스마트에디터 --%>
	 	//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });	   	   	 
	   
	   <%-- 스마트에디터 --%>
	   // 작성버튼
	      $("#write").click(function(){
	         
	    	 <%-- 스마트에디터 --%>
				//id가 content인 textarea에 에디터에서 대입
		        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			 <%-- 스마트에디터 --%>

	         // 글제목 유효성 검사 
	         var subjectVal = $("#title").val().trim();
	         if(subjectVal == "") {
	            alert("글제목을 입력하세요");
	            return;
	         }
	         	         
	         <%-- === 스마트에디터 구현 시작 === --%>
				//스마트에디터 사용시 무의미하게 생기는 p태그 제거
		        var contentval = $("#content").val();
			        
		        // === 확인용 ===
		        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
		        // "<p>&nbsp;</p>" 이라고 나온다.
		        
		        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
		        // 글내용 유효성 검사 
		        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		        	alert("글내용을 입력하세요!!");
		        	return;
		        }
		        
		        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
		        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
		    /*    
		              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                     그리고 뒤의 gi는 다음을 의미합니다.

		        	g : 전체 모든 문자열을 변경 global
		        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		    */    
		        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
		        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
		        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
		    
		        $("#content").val(contentval);
		     // alert(contentval);
			 <%-- === 스마트에디터 구현 끝 === --%>
	     
			// 글제목 유효성 검사 
	         var title = $("#title").val().trim();
	         if(title == "") {
	            alert("글제목을 입력하세요");
	            return;
	         }
	         
	         //첨부파일 유효성 검사 
	 	    if($('#attachfile').val().trim() == "") {
	 	    	alert("메인이미지 첨부파일을 등록해주세요");
	 	        return;
	 	    }
	 	    
	 	    if($('#attach2file').val().trim() == "") {
	 	    	alert("상세이미지 첨부파일을 등록해주세요");
	 	        $("#attach2file").focus();
	 	        return;
	 	    }
		 	    
	 		// 첨부파일 이미지 유효성 검사 
	         var fileNm = $("#attachfile").val();	         
	         if (fileNm != "") {	          
	             var ext = fileNm.slice(fileNm.lastIndexOf(".") + 1).toLowerCase();	          
	             if (!(ext == "gif" || ext == "jpg" || ext == "png")) {
	                 alert("이미지파일 (.jpg, .png, .gif ) 만 업로드 가능합니다.");
	                 return false;
	             }	          
	         }
	         
	       // 첨부파일 이미지 유효성 검사 
	         var fileNm = $("#attach2file").val();	         
	         if (fileNm != "") {	          
	             var ext = fileNm.slice(fileNm.lastIndexOf(".") + 1).toLowerCase();	          
	             if (!(ext == "gif" || ext == "jpg" || ext == "png")) {
	                 alert("이미지파일 (.jpg, .png, .gif ) 만 업로드 가능합니다.");
	                 return false;
	             }	          
	         }
	         
	         // 글내용 유효성 검사 
	         var contentVal = $("#content").val().trim();
	         if(contentVal == "") {
	            alert("글내용을 입력하세요");
	            return;
	         }	         
	        
	         
	         // 폼(form) 을 전송(submit)
	         var frm = document.addFrm;
	         frm.method = "POST";
	         frm.action = "<%= ctxPath%>/donation/donationStoryAddEnd.up";
	         frm.submit();
	      });
	   
	});
	
	function goReset(){
		location.href='<%= ctxPath%>/donation/donationList.up';
	}

</script>



<div id ="container"><br>
	<div id="wholeNotice">
		<div style="text-align: center;">
			<h3 style="color: gray; font-size: 13pt; font-weight:bold;">후원스토리 등록</h3>
		</div>	
		<br>
			
		<div>
		<form name="addFrm" enctype="multipart/form-data">
			<table id="table" style="margin: 0 auto; width: 1040px; background-color: white;">
				<tr>
					<th>후원제목</th>
					<td><input type="text" size="50" id="title" name="subject"/></td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input type="text" name="name" style="color: gray;" value="${sessionScope.loginuser.name}"/></td>
				</tr>
				
				<tr>
					<th>후원기간 </th>
					<td>
					<span id="inputDate" style="margin-right: 10px;">후원시작</span><input style="margin-right: 5px;" type="text" name="donDate" class="datepicker"/>
					<span id="inputDate" style="margin-right: 10px;"> - 후원마감</span><input style="margin-right: 5px;" type="text" name="donDueDate" class="datepicker"/>
					</td>					
				</tr>
				
				<tr>
					<th>목표금액 </th>
					<td><input type="text" name="targetAmount" value=""/></td>
				</tr>
				
								
				<tr>
					<th>메인 이미지 첨부파일</th>
					<td><input type="file" name="attach" id="attachfile" /></td>
				</tr>
				
				<tr>
					<th>상세 이미지 첨부파일</th>
					<td><input type="file" name="attach2" id="attach2file" /></td>
				</tr>
				
				<tr>
					<th>후원내용</th>
					<td><textarea rows="15" cols="110" id="content" name="content" style="width:680px;"></textarea></td>
				</tr>
										
			</table>
		</form>
		
		</div>
		
		<br>
		<div style="margin: 0 auto; width: 300px; margin-bottom: 20px; margin-top: 20px">
			<button type="button" style="width: 140px; border:solid 1px #ddd; border-radius:3px" id="write">작성</button>
			<button type="reset" style="width: 140px; border:solid 1px #ddd; border-radius:3px" onclick="goReset()">취소</button>
		</div>	
		<br>		
	</div>
</div>