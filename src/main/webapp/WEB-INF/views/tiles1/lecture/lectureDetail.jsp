<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureDetail.css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		var html = "<iframe width='1008' height='567' src='";
			html += "${lecturevo.lecLink}";
			html += "' frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
		
		if( html.indexOf('www.youtube.com/embed/')<0 ) {
			html = "<div>${lecturevo.lecLink}</div>";
		}
			
		$("#lecture-youtube").html(html);
		
		goViewComment("1");
	
	}); ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	// 강의목록으로 이동
	function goLectureList(fk_subSeq){
		var frm = document.ViewFrm;
		frm.fk_subSeq.value = fk_subSeq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureList.up";
		frm.submit();		 
	}
	
	// 강의수정으로 이동
	function goEdit(lecSeq){
		var frm = document.EditFrm;
		frm.lecSeq.value = lecSeq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureEdit.up";
		frm.submit();		 
	}
	
	// 강의삭제로 이동
	function goDelete(lecSeq, fk_subSeq) {
		if(confirm("정말 삭제하시겠습니까?") == true) {
			var frm = document.DeleteFrm;
			frm.lecSeq.value = lecSeq;
			frm.fk_subSeq.value = fk_subSeq;
			frm.method = "POST";
			frm.action="<%=request.getContextPath()%>/lecture/lectureDelete.up";
			frm.submit();         
		}
		else {
			return;
		}
	      
	}
	
	// 댓글쓰기
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
					goViewComment("1"); // 페이징처리 한 댓글 읽어오기 
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
		
	} // end of function goAddWrite()----------------------
	
	// 강의 댓글 삭제로 이동
	function goRemove(lecComSeq, lecSeq) {
		if(confirm("정말 삭제하시겠습니까?") == true) {
			var frm = document.RemoveFrm;
			frm.lecComSeq.value = lecComSeq;
			frm.lecSeq.value = lecSeq;
			frm.method = "POST";
			frm.action="<%=request.getContextPath()%>/lecture/lectureCommentDelete.up";
			frm.submit();         
		}
		else {
			return;
		}
	      
	}
	
	// Ajax로 불러온 댓글내용을 페이징처리
	function goViewComment(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/lecture/commentList.up",
			data:{"fk_lecSeq":"${lecturevo.lecSeq}",
				  "fk_subSeq":"${lecturevo.fk_subSeq}",
				  "currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<div>"+
									"<br><span style='margin-right:100px; clear:both;'>"+item.fk_userid+"</span><span style='margin-right:50px; color: gray;'>"+item.writeday+"</span>" 
								+"</div>"
								+"<div>"+item.comContent;
								
								if( item.loginuser == item.fk_userid ) {
									html += "<span style='float:right; color:red; cursor:pointer;' onclick='goRemove("+item.lecComSeq+","+${lecturevo.lecSeq}+")'>삭제</span></div><br><div style='border-bottom: 1px solid #b5b5b5;'></div>";
								}
								else {
									html += "</div><br><div style='border-bottom: 1px solid #b5b5b5;'></div>";
								}
					});
				}
				else {
					html += "<div>댓글이 없습니다.</div>";
				}
				
				$("#commentDisplay").html(html);
							
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	} // end of function goViewComment(currentShowPageNo)--------------------
	
	// 댓글내용 페이지바 Ajax로 만들기
	function makeCommentPageBar(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/lecture/getCommentTotalPage.up",
			data:{"fk_lecSeq":"${lecturevo.lecSeq}",
				  "fk_subSeq":"${lecturevo.fk_subSeq}",
				  "sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json) {
				
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
							pageBarHTML += "<li style='display:inline-block; width:20px; font-size:11pt; color:#00BCD4; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:20px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
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
	
	<div id="buttons">
		<button id="goList" type="button" onclick="goLectureList('${lecturevo.fk_subSeq}');">강의목록</button>
		<c:if test="${paraMap.identity == 2}">
			<button id="goList" type="button" onclick="goEdit('${lecturevo.lecSeq}');">강의수정</button>
			<button id="goList" type="button" onclick="goDelete('${lecturevo.lecSeq}', '${lecturevo.fk_subSeq}');">강의삭제</button>
		</c:if>
	</div>

	<div class="lecture-comment">	
	
    	<form name="commentFrm">
	   		<div style="margin-bottom: 10px;">댓글 작성</div>
	   		<div><input type="hidden" name="fk_userid" value="${paraMap.userid}" readonly/></div>
			<div class="commentContent">
				<textarea name="comContent" id="comContent" placeholder=" 댓글 내용을 작성해주세요." required></textarea>
				<!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) -->
				<input type="hidden" name="fk_lecSeq" value="${lecturevo.lecSeq}" />
				<input type="hidden" name="fk_subSeq" value="${lecturevo.fk_subSeq}" />
				<input type="hidden" name="lecNum" value="${lecturevo.lecNum}" />
				<button type="button" id="btnCommentOK" onclick="goAddWrite()">작성</button>
			</div>
		</form>
		
		<div id="commentDisplay"><%-- 댓글 내용이 들어오는 곳 --%></div>
		
		<!-- 댓글 페이징 처리 -->
    	<div id="pageBar" style="border:solid 0px gray; width: 70%; margin: 10px auto; text-align: center;"></div>
    	
	</div>
	
	<form name="ViewFrm">
		<input type="hidden" name="fk_subSeq"/>
		<input type="hidden" name="lecSeq"/>
	</form>
	
	<form name="EditFrm">
		<input type="hidden" name="lecSeq"/>
	</form>
	
	<form name="DeleteFrm">
		<input type="hidden" name="fk_subSeq"/>
		<input type="hidden" name="lecSeq"/>
	</form>
	
	<form name="RemoveFrm">
		<input type="hidden" name="lecComSeq"/>
		<input type="hidden" name="lecSeq"/>
	</form>

</div>