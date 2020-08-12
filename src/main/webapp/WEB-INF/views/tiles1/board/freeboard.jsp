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
	
	table,tr,th,td{
		border: solid 1px black;
		border-collapse: collapse;
		text-align: center;
		padding: 20px;
	}
	
	.titleStyle{
		font-weight: bold;
		color: navy;
		cursor: pointer;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
	
		// 제목에 마우스 커서를 갔다대었을 떄
		$(".title").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("titleStyle");
		});
		
		$(".title").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("titleStyle");
		});	
		
		// 검색어를 입력 후 엔터를 하는 경우
		$("#searchWord").keydown(function(event) {
			 if(event.keyCode == 13) {
				 // 엔터를 했을 경우
				 goSearch();
			 }
		 });
		
		// 검색시 검색조건 및 검색어 값 유지시키기 
		if(${paraMap != null}) {
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		}
		
	});// end of $(document).ready() -------------------------------------
	

	// 글을 보여주는 함수
	function goView(free_seq){
		 
		 <%-- location.href="<%=ctxPath%>/view.action?seq="+seq; --%>

		 // === #122.페이징 처리되어진 후 특정글제목을 클릭하여 상세내용을 본 이후
	     // 		  사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	     //          현재 페이지 주소를 뷰단으로 넘겨준다.	 
		 
		 var frm = document.goViewFrm;
		 frm.free_seq.value = free_seq;
		 
			frm.method = "GET";
			frm.action = "freeboardview.up";
			frm.submit();
	     
	 }// end of goView(seq) ------------------------------------
	
	
	// 글을 검색하는 함수
	function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/freeboard.up";
			frm.submit();
	}// end of function goSearch()-------------------------
	 
	
	
</script>


<div id ="container"><br>
<div id="wholeNotice">

	<div style="text-align: center;">
		<h2 style="color: #00BCD4; font-weight: bold;">자유게시판</h2>
	</div>	
	<br>
	
	<span style="margin-left: 40px; color: black;">Total: ${totalCount}</span>
	
	<div>
		<table style="margin: 0 auto; width: 1000px; background-color: white;">
			<tr style="background-color: #f2f2f2">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
				<th>첨부파일</th>
			</tr>
			
				<c:forEach var="boardList" items="${freeboardList}" varStatus="status">
					<tr>
						<td align="center">${boardList.free_seq}</td>
						<td align="left"><span class="title" onclick="goView('${boardList.free_seq}')">${boardList.title}</span></td>
						<td align="center">${boardList.name}</td>
						<td align="center">${boardList.writedate}</td>
						<td align="center">${boardList.viewcount}</td>
						<c:if test="${not empty boardList.fileName}">
							<td align="center"><img src="<c:url value="/resources/images/disk.gif" />"></td>
						</c:if>
						
						<c:if test="${empty boardList.fileName}">
							<td></td>
						</c:if>
				</c:forEach>
			</tr>	
		</table>
		
		<!-- 페이지바  -->
		<div align="center" style="width: 60%; margin: 20px auto;">
			${pageBar}
		</div>
			
	</div>
	
	<form name="searchFrm" style="margin-top: 20px; margin-left: 40px;">
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="title">글제목</option>
			<option value="name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<button type="button" onclick="goSearch()">검색</button>
	</form>
	
	<div>
		<button type="button" style="margin-left: 980px;">
			<a href="<%=ctxPath%>/addfreeboard.up">글쓰기</a>
		</button>
	</div>	
	<br>
	
	<form name="goViewFrm">
		<input type="hidden" name="free_seq"/>
		<input type="hidden" name="gobackURL" value="${gobackURL}"/>
	</form>
	
	
	
</div>
</div>