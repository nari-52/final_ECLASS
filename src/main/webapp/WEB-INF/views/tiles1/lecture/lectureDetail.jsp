<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />

<script type="text/javascript">

	$(document).ready(function(){
	
		counter();
		
		var html = "<iframe width='1008' height='567' src='";
			html += "${lecturevo.lecLink}";
			html += "' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
		
		$("#lecture-youtube").html(html);
	
	}); ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 글자수 세주는 함수
	function counter() {
		document.getElementById("counting").innerHTML = document.getElementById("comContent").value.length;
	}
	
	// 강의목록으로 이동
	function goLectureList() {
		location.href="<%=ctxPath%>/lecture/lectureList.up";
	}
	
	// === 댓글쓰기 === //
	function goAddWrite() {
		var frm = document.commentFrm;
		var contentVal = frm.comContent.value.trim();
		if(contentVal=="") {
			alert("댓글 내용을 입력하세요.");
			return;
		}
		
		var form_data = $("form[name=commentFrm]").serialize();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/lecture/addComment.up",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				if(json.n == 1) {
					// goViewComment("1"); // 페이징처리 한 댓글 읽어오기 
				}
				else {
					alert("댓글쓰기 실패!!");
				}
				
				frm.comContent.value = "";
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function goAddWrite()----------------------
	
	// === #125. Ajax로 불러온 댓글내용을 페이징처리 하기  === //
	function goViewComment(currentShowPageNo) {
		$.ajax({
			url:"<%= request.getContextPath()%>/lecture/commentList.up",
			data:{"lecSeq":"${lecturevo.lecSeq}",
				  "fk_subSeq":"${lecturevo.fk_subSeq}",
				  "currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
						html += "<td style='text-align: center;'>"+(index+1)+"</td>";
						html += "<td>"+item.comCommnet+"</td>";
						html += "<td style='text-align: center;'>"+item.fk_userid+"</td>";
						html += "<td style='text-align: center;'>"+item.writeday+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' style='text-align: center;'>댓글이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#commentDisplay").html(html);
							
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});	
	}// end of function goViewComment(currentShowPageNo)--------------------
	
	// ==== 댓글내용 페이지바 Ajax로 만들기 ====
	function makeCommentPageBar(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/lecture/getCommentTotalPage.up",
			data:{"lecSeq":"${lecturevo.lecSeq}",
				  "fk_subSeq":"${lecturevo.fk_subSeq}",
				  "sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json) {
			//	console.log("전체페이지수 : " + json.totalPage);
				
				if(json.totalPage > 0) { // 댓글이 있는 경우 
					
					var totalPage = json.totalPage;
					var pageBarHTML = "<ul style='list-style: none;'>"; 
					var blockSize = 5;
					var loop = 1;
					
					if(typeof currentShowPageNo == "string") {
						currentShowPageNo = Number(currentShowPageNo);
					}
					
					var pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
					
					// === [이전] 만들기 === 
					if(pageNo != 1) {
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";
					}
					
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo++;
						
					}// end of while------------------------------
					
					// === [다음] 만들기 ===
					if( !(pageNo > totalPage) ) {
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>[다음]</a></li>";
					}
					
					pageBarHTML += "</ul>";
					
					$("#pageBar").html(pageBarHTML);
					pageBarHTML = "";
				}
				else {
					// 댓글이 없는 경우 
					$("#pageBar").empty();
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function makeCommentPageBar(currentShowPageNo)---------------- 


</script>

<div id="contentsWrap">

	<div id="leture-title">
		${lecturevo.lecTitle}
	</div>
	
	<div id="lecture-youtube"><%-- 유튜브 영상이 들어오는 곳 --%></div>
	
	<button id="goList" type="button" onclick="goLectureList();">강의목록</button>

	<div class="lecture-comment">	
	
    	<form name="commentFrm">
	   		<div style="margin-bottom: 10px;">댓글 작성&nbsp;(<span id="counting">0</span>자)</div>
	   		<div><input type="text" value="${sessionScope.loginuser}" readonly/></div>
			<div class="commentContent">
				<textarea name="comContent" id="comContent" placeholder=" 댓글 내용을 작성해주세요." onkeyup="counter()" required></textarea>
				<!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) -->
				<input type="hidden" name="lecSeq" value="${lecturevo.lecSeq}" />
				<input type="hidden" name="fk_subSeq" value="${lecturevo.fk_subSeq}" />
				<button type="button" id="btnCommentOK" onclick="goAddWrite()">작성</button>
			</div>
		</form>
		
		<div id="commentDisplay"><%-- 댓글 내용이 들어오는 곳 --%></div>
		
		<!-- 댓글 페이징 처리 -->
    	<div id="pageBar" style="border:solid 0px gray; width: 70%; margin: 10px auto; text-align: center;"></div>
    	

	</div>

</div>