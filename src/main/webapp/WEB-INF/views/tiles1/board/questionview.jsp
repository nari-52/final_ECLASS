<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<style>
	

	#wholeNotice{
		width: 1080px;
		margin: 0 auto;
		/* border: solid 1px black; */
		/* background-color: #fafafa; */
	}
	
	#viewHead{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		padding: 20px 0 0 0;
		border-bottom: solid 1px gray;
		height: 160px;
	}
	
	#viewContent{
	 	width: 1000px;
		margin: 0 auto;
		background-color: white;
		padding: 20px 0 20px 40px;
	}
	
	#addedFile{
		width: 1000px;
		margin: 0 auto;
		background-color: white;		
	}
	
	#addReply{
		width: 1000px;
		margin: 0 auto;
		background-color: white;	
	}
	
	#updownView{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		
	}	
	
	table{
		width: 1000px;
		border-collapse: collapse;
	}
	
	 tr,th,td{
		text-align: center;
		padding: 10px;
		border-bottom: solid 1px #ccc;
		border-top: solid 1px #ccc;
	} 
	
	#goReply{
		display: inline-block;
		border: solid 1px gray;
		width: 100px;
		height: 100px;
		line-height: 100px;
		background-color: #ccc;
		color: white;
		cursor: pointer;
	}
	
	.button{
		display: inline-block;
		width: 70px;
		height: 40px;
		background-color: #ccc;
		float: right;
		margin-left: 20px;
		text-align: center;
		line-height: 40px;
		cursor: pointer;
	}
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		goViewComment("1");
		
	})

	// 댓글쓰기
	function goaddComment(){
		var frm = document.addComment;
		var contentVal = frm.content.value.trim();
		if(contentVal ==""){
			return;			
		}
		
		var form_data = $("form[name=addComment]").serialize();
		
		var loginuser = $("#loginuser").val();
		
		if(loginuser == ""){
			alert("먼저 로그인하세요");
			return;
		}
		else{
			$.ajax({
				url:"<%=ctxPath%>/board/addFreeComment.up",
				data: form_data,
				type:"POST",
				dataType:"JSON",
				success:function(json){
					if(json.n == 1) {
						goViewComment("1"); // 페이징처리 한 댓글 읽어오기 
					}
					else {
						alert("댓글쓰기 실패!!");
					}
					
					frm.content.value = "";			
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}			
			});
		}
	}// end of function goaddComment() --------------------
	
	// 댓글 삭제하기
	function goDelComment(delseq){
		/* var delseq = delseq;
		alert(delseq);
		 */
		 
		$.ajax({
			url:"<%=ctxPath%>/board/delFreeComment.up",
			data:{"delseq":delseq},
			dataType:"JSON",
			success:function(json){
				alert("댓글이 삭제되었습니다.")
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		goViewComment("1");
	}// end of goDelComment() ----------------------------------
	
	// 댓글 내용 불러오기
	 function goViewComment(currentShowPageNo) {
			$.ajax({
				url:"<%= request.getContextPath()%>/board/commentList.up",
				data:{"parentSeq":"${freeboardvo.free_seq}",
					  "currentShowPageNo":currentShowPageNo},
				dataType:"JSON",
				success:function(json){
					var html = "";
					if(json.length > 0) {
						$.each(json, function(index, item){
							html += "<tr>";
							html += "<td style='text-align: center;'>"+(index+1)+"</td>";
							html += "<td>"+item.content+"</td>";
							html += "<td style='text-align: center;'>"+item.name+"</td>";
							html += "<td style='text-align: center;'>"+item.writedate+"</td>";
							html += "<td style='text-align: center;' onclick='goDelComment(\""+item.comment_seq+"\")'><span>삭제</span></td>";
							html += "</tr>";
						});
					}
					else {
						html += "<tr>";
						html += "<td colspan='5' style='text-align: center;'>댓글이 없습니다.</td>";
						html += "</tr>";
					}
					
					$("#commentDisplay").html(html);
				
					makeCommentPageBar(currentShowPageNo);
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});	
		}// end of function goReadComment()-------------------- 
		
	// 댓글 내용 페이지바 만들기
	function makeCommentPageBar(currentShowPageNo){
			
		$.ajax({
			url:"<%= request.getContextPath()%>/board/getFreeTotalPage.up",
			data:{"parentSeq":"${freeboardvo.free_seq}",
				  "sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json){
				
				if(json.totalPage >0){
					// 댓글이 있는 경우
					
					var totalPage = json.totalPage;
					
					var pageBarHTML = "<ul style='list-style:none;'>";
					
					var blockSize = 10;
				    // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
				    
					var loop = 1;
					// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[지금은 10개(= blockSize)] 까지만 증가하는 용도이다.
					
					if(typeof currentShowPageNo == "string"){
						currentShowPageNo = Number(currentShowPageNo);
					}
					
					var pageNo = Math.floor((currentShowPageNo - 1)/blockSize)* blockSize + 1;
									/*  (2-1)/10  1/10  ==> Math.floor(0.1) ==> 0
										(11-1)/10 10/10 ==> Math.floor(1) ==> 1
										(12-1)/10 11/10 ==> Math.floor(1.1) ==> 1 */
					
					
				      
				      // === [이전] 만들기 ===
				      if(pageNo != 1) {				    	  				    	  
				    	  
				    	  pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";
				      }
				      
				      while( !(loop > blockSize || pageNo > totalPage) ) {
				         
				         if(pageNo == currentShowPageNo) {
				        	 pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
				         }
				         else {
				        	 pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
				         }
				         
				         loop++;
				         pageNo++;
				         
				      } // end of while -----------------------------------------------
				      
				      // === [다음] 만들기 ===
				      if(!(pageNo > totalPage)) {
				    	  pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+(pageNo)+"\")'>[다음]</a></li>";
				      }
				      
				      pageBarHTML += "</ul>";
					
				      $("#pageBar").html(pageBarHTML);
				      pageBarHTML += "";
				}
				else{
					// 댓글이 없는 경우
					$("#pageBar").empty();
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
			
			
		}// end of makeCommentPageBar(currentShowPageNo) ------------------------
	
		
</script>



<div id ="container"><br>
<div id="wholeNotice">
	<div style="text-align: center;">
		<h2 style="color: black; font-weight: bold; margin-left: 40px;">Q&A</h2>
	</div>	
	<br>
	
	<div id="viewHead">
		<h3 style="border-top: solid 1px #ccc; width: 100%;"><br>&nbsp;&nbsp;${questionvo.title}</h3>
		<div style="float: right; margin:20px;">
		<span style="font-weight: bold; font-size: 13pt;">작성자 &nbsp;</span> <span>${questionvo.name}</span>&nbsp;
		<span style="font-weight: bold; font-size: 13pt;">작성일 &nbsp;</span> <span>${questionvo.writedate}</span>&nbsp;
		<span style="font-weight: bold; font-size: 13pt;">조회수 &nbsp;</span> <span>${questionvo.viewcount}</span>&nbsp;
		</div>
	</div>
	
	<div id="viewContent">
		<div style="height: 50%;">
			<br>
			${questionvo.content}
			<br><br><br>			
		</div>
	</div>

	<div id="addedFile">
		<table>
			<tr>
				<th style="background-color: #e0e0e0; float: left; width: 200px;">첨부파일</th>
				<td style="text-align: left;">
					<c:if test="${not empty questionvo.orgFilename}">
						<a href="<%=request.getContextPath()%>/download.up?free_seq=${questionvo.question_seq}">${questionvo.orgFilename}</a>
					</c:if>
					
					<c:if test="${empty questionvo.orgFilename}">
						첨부파일이 없습니다.
					</c:if>
					
				</td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView">
		<table>
		<%-- <c:if>로 윗글아랫글로 처리 --%>
			<tr>
				<th style="background-color: #e0e0e0; float: left; width: 200px;">이전글</th>
				<td><span style="float: left;" onclick="javascript:location.href='<%=ctxPath%>/board/questionview.up?question_seq=${questionvo.previousseq}'">${questionvo.previoussubject}</span></td>
			</tr>
			
			<tr>
				<th style="background-color: #e0e0e0; float: left; width: 200px;">다음글</th>
				<td><span style="float: left;" onclick="javascript:location.href='<%=ctxPath%>/board/questionview.up?question_seq=${questionvo.nextseq}'">${questionvo.nextsubject}</span></td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView" style="height: 40px; background-color: white;">
	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
		<span class="button" onclick="javascript:location.href='<%= ctxPath%>/board/addQuestion.up?fk_seq=${questionvo.question_seq}&groupno=${questionvo.groupno}&depthno=${questionvo.depthno}'">답변등록</span>
	</c:if>
	<c:if test="${not empty sessionScope.loginuser}">
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/board/editQuestion.up?question_seq=${questionvo.question_seq}'">글수정</span>
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/board/delQuestion.up?question_seq=${questionvo.question_seq}'">글삭제</span>
	</c:if>	
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/${gobackURL}'">목록</span>
	</div><br>
	

</div>	
</div>