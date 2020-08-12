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
			html += "https://www.youtube.com/embed/bbgdY_Sx3z8'";
			html += "frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
		
		$("#lecture-youtube").html(html);
	
	});
	
	// 글자수 세주는 함수
	function counter() {
		document.getElementById("counting").innerHTML = document.getElementById("comContent").value.length;
	}
	
	// 강의목록으로 이동
	function goLectureList() {
		location.href="<%=ctxPath%>/lecture/lectureList.up";
	}

<%--

function goReviewListView() {

	   $.ajax({
		   url:"<%= ctxPath%>/lectureDetail.up",
		   type:"GET",
		   data:{"lecSeq":$('#fk_pnum').val()},
		   dataType:"JSON",
		   success:function(json) {
			    var html = "";
				
				if (json.length > 0) {
					
					$.each(json, function(index, item){
						
					  html += "<br><div style='color:#808080;'>"+item.Writeday+"</div>"
					    +"<div style='color:#808080;'>"+item.name+"</div>"
					    +"<div>"+item.comContent+"</div>";
					    
					  if ( item.logMemberidx != -1 && item.logMemberidx == item.fk_memberidx) {
						  html += "<div><span class='del' onclick='func_del("+item.fk_memberidx+","+item.reviewno+")'>삭제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br></div>"
						    	+ "<br><div style='border-bottom: 1px solid #b5b5b5; width:98%;'></div>";
					  }
					  else {
						  html += "<br><div style='border-bottom: 1px solid #b5b5b5; width:98%;'></div>";
					  }
					
					});
					
				}// end of if -----------------------
				
				$("#viewComments").html(html);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });
	   
} // function goReviewListView() ------------------------------------

--%>

</script>

<div id="contentsWrap">

	<div id="leture-title">
		오리엔테이션
	</div>
	
	<div id="lecture-youtube"><%-- 유튜브 영상이 들어오는 곳 --%></div>
	
	<button id="goList" type="button" onclick="goLectureList();">강의목록</button>

	<div class="lecture-comment">	
		<div id="viewComments"><%-- 댓글 내용이 들어오는 곳 --%></div>
		
		<!-- 댓글 페이징 처리 -->
    	
    	<form name="commentFrm">
    		<div style="margin-bottom: 10px;">댓글 작성&nbsp;(<span id="counting">0</span>자)</div>
			<div class="commentContent">
				<textarea name="comContent" id="comContent" placeholder="댓글 내용을 작성해주세요." onkeyup="counter()" required></textarea>
				<button type="button" id="btnCommentOK">작성</button>
			</div>

			<input type="hidden" name="lecSeq" id="lecSeq" value="" />
		</form>		
	</div>

</div>