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
		border-bottom: solid 1px #ccc;
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
		<h2 style="color: black; font-weight: bold; margin-left: 40px;">공지사항</h2>
	</div>	
	<br>
	
	<div id="viewHead">
		<h3 style="border-top: solid 1px #ccc; width: 100%;"><br>&nbsp;&nbsp;${noticeboardvo.title}</h3>
		<div style="float: right; margin:20px;">		
		<span style="font-weight: bold; font-size: 13pt;">작성일 &nbsp;</span>${noticeboardvo.writedate} 
		<span style="font-weight: bold; font-size: 13pt;">조회수&nbsp;</span>${noticeboardvo.viewcount} 
		</div>
	</div>
	
	<div id="viewContent">
		<div style="height: 50%;">
			<br>
			${noticeboardvo.content}
			<br><br><br>
		</div>
	</div>

	<div id="addedFile">
		<table>
			<tr>
				<th style="background-color: #e0e0e0; float: left; width: 200px;">첨부파일</th>
				<td style="text-align: left;">
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
				<th style="background-color: #e0e0e0; float: left; width: 200px;">이전글</th>
				<td><span style="float: left; cursor: pointer;" onclick="javascript:location.href='<%=ctxPath%>/board/noticeview.up?notice_seq=${noticeboardvo.previousseq}'">${noticeboardvo.previoussubject}</span></td>
			</tr>
			
			<tr>
				<th style="background-color: #e0e0e0; float: left; width: 200px;">다음글</th>
				<td><span style="float: left; cursor: pointer;" onclick="javascript:location.href='<%=ctxPath%>/board/noticeview.up?notice_seq=${noticeboardvo.nextseq}'">${noticeboardvo.nextsubject}</span></td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView" style="height: 40px; background-color: white;">
	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/board/editNoticeboard.up?notice_seq=${noticeboardvo.notice_seq}'">글수정</span>
		<form name="delNoticeFrm">
			<input type="hidden" name="notice_seq" value="${noticeboardvo.notice_seq}" >
			<span class="button" onclick="delNotice();">글삭제</span>
		</form>
	</c:if>	
		<span class="button" onclick="javascript:location.href='<%=ctxPath%>/${gobackURL}'">목록</span>
	</div><br>
	<br>
</div>	
</div>