<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<style>
	
	#container{
		background-color: #fafafa;
	}
	
	#wholeNotice{
		width: 1080px;
		margin: 0 auto;
		/* border: solid 1px black; */
		background-color: #fafafa;
	}
	
	#viewHead{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		padding: 20px 0 20px 40px;
		border-bottom: solid 1px gray;
		height: 130px;
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
		background-color: #f2f2f2;		
	}
	
	#addReply{
		width: 1000px;
		margin: 0 auto;
		background-color: #f2f2f2;	
	}
	
	#updownView{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		
	}	
	
	table{
		width: 1000px;
	}
	
	 tr,th,td{
		text-align: center;
		padding: 10px;
		border-bottom: solid 1px #5E5E5E;
		border-top: solid 1px #5E5E5E;
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

	function delNotice(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			var frm = document.delNoticeFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/board/delNoticeboard.up";
			frm.submit();			
		}
		else{
			return;
		}
		
	}

</script>

<div id ="container"><br>
<div id="wholeNotice">
	<div style="text-align: center;">
		<h3 style="color: #00BCD4; font-weight: bold;">공지사항</h3>
	</div>	
	<br>
	
	<div id="viewHead">
		<h3>${noticeboardvo.title }</h3>
		<div style="float: right; margin:20px;">		
		<span style="font-weight: bold; font-size: 13pt;">작성일 &nbsp;</span>${noticeboardvo.writedate} 
		<span style="font-weight: bold; font-size: 13pt;">조회수&nbsp;</span>${noticeboardvo.viewcount} 
		</div>
	</div>
	
	<div id="viewContent">
		<div>
			${noticeboardvo.content}
		</div>
	</div>

	<div id="addedFile">
		<table>
			<tr>
				<th>첨부파일</th>
				<td>
					<c:if test="${not empty noticeboardvo.orgFilename}">
						<a href="<%=request.getContextPath()%>/board/noticedownload.up?notice_seq=${noticeboardvo.notice_seq}">${noticeboardvo.orgFilename}</a>
					</c:if>
					
					<c:if test="${empty noticeboardvo.orgFilename}">
						첨부파일이 없습니다.
					</c:if>
					
				</td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView">
		<table>
			<tr>
				<th>이전글</th>
				<td><span onclick="javascript:location.href='<%=ctxPath%>/board/noticeview.up?notice_seq=${noticeboardvo.previousseq}'">${noticeboardvo.previoussubject}</span></td>
			</tr>
			
			<tr>
				<th>다음글</th>
				<td><span onclick="javascript:location.href='<%=ctxPath%>/board/noticeview.up?notice_seq=${noticeboardvo.nextseq}'">${noticeboardvo.nextsubject}</span></td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView" style="height: 40px; background-color: #fafafa;">
	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/board/editNoticeboard.up?notice_seq=${noticeboardvo.notice_seq}'">글수정</span>
		<form name="delNoticeFrm">
			<input type="hidden" name="notice_seq" value="${noticeboardvo.notice_seq}" >
			<span class="button" onclick="delNotice();">글삭제</span>
		</form>
	</c:if>	
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/${gobackURL}'">목록</span>
	</div><br>
	
	<div id="addReply">
		<table style="margin: 0 auto;">
			<tr>
				<td><textarea rows="5" cols="110" style="height: 100px;"></textarea></td>
				<td><span id="goReply">댓글달기</span></td>
			</tr>
		</table>
	</div>
	<br>
</div>	
</div>