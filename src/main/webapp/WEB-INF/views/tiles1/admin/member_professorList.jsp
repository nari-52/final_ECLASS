<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	// /board
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수 회원 관리자 페이지</title>

<!-- meta가 제일 위로 오게 한다.  -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<%-- <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script> --%>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>

<style type="text/css">
	div#adminContainer {
		/* border: solid 1px red; */
		width: 1080px;
		margin: 0 auto;
	}
</style>

<script type="text/javascript">

/*
	== datatables 처리모드 ==
		  
	datatables에는 두 가지 처리 방법이 있습니다
	datatables 뿐만 아니라 게시판 처리 방식에 두 가지 방법이 있는 것입니다.
	
	"클라이언트 사이드 렌더링" 과  "서버사이드 렌더링" 2 가지 방법입니다.
	
	- 게시판 관점에서 바라 본 클라이언트 사이드 렌더링 -
	  => 게시판 관점에서 바라봤을 때 "클라이언트 사이드 렌더링" 은 
	           초기 페이지 로딩 시 모든 데이터를 가져와서 페이지 블럭단위만 보여준 후 나머지는 가리는 방식입니다. 
	           따라서 페이지 전환 시 서버 호출이 일어나지 않으며 오버헤드가 없기 때문에 초기 로딩을 제외하면 속도 이슈가 없습니다.
	
	- 게시판 관점에서 바라 본 서버 사이드 렌더링 - 
	  => 일반적으로 게시판을 만들게 되면 "서버 사이드 렌더링"으로 만들게 됩니다.
	           쉽게 페이지 전환이 일어날 경우 페이지 번호를 서버측으로 넘긴 후 특정 블럭만 가져와서 출력해주는 방식입니다.
	           초기 로딩시에도 페이지 단위의 데이터만 가져오기 때문에 리퀘스트 오버헤드를 제외하면 평균적인 속도를 얻어낼 수 있습니다. 
	
	  위와 같이 datatables 또한 두 가지 방식을 제공합니다.
	
	if you are working with less than 10,000 rows use client-side processing, for greater than 100,000 rows use server-side processing
	
	datatables 공식 메뉴얼에서는 데이터가 10000건 이하일 때는 클라이언트 사이드 렌더링을 사용해도 된다고 권장하고있습니다.
	  하지만 데이터가 100,000건 이상이 넘어가면 무조건 서버 사이드 렌더링을 사용하라고 권장하고있습니다. 
*/

	$(document).ready(function(){ 
		
		$("#exampleTbl").DataTable({ 
			
			 "dom": '<"top"lf>rt<"bottom"ip>',  // 페이지바가 우측하단에 위치, 검색이 우측상단에 위치하는 것임.  
			//	"dom": '<"top"lp>rt<"bottom"if>',  // 페이지바가 우측상단에 위치, 검색이 우측하단에 위치하는 것임. 
			
				"paging"    : true,                // 우측하단에 페이지바를 보여줄것인지 아닌지를 결정하는 것
			//	"paging"    : false,               // 우측하단에 페이지바를 보여줄것인지 아닌지를 결정하는 것 
				"ordering"  : true,                // th에 나오는 값에 따라서 오름차순, 내림차순 정렬을 할것인지 말것인지를 결정하는 것  
				"info"      : true,                // 좌측하단에 보여지는 Showing 1 to 10 of 22 entries 를 보여줄것인지 말것인지를 결정하는 것       
				"filter"    : true,                // 우측상단에 보여지는 검색을 보여줄것인지 말것인지를 결정하는 것       
				"lengthChange"   : true,           // 좌측상단에 보여지는 한페이지당 행의갯수를 결정하는 것  
				// "order"     : [[2, "asc"],[0, "desc"]], // 기본 컬럼 정렬 설정  숫자 0은 첫번째 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다.
				"order"     : [[0, "asc"]], // 기본 컬럼 정렬 설정  숫자 0은 첫번째 컬럼을 말하며, "asc" 또는 "desc"를 설정할 수 있다.
				"stateSave" : false,
			//	"stateSave" : true, 
				/*
				    클라이언트 사이드 렌더링의 경우 새고로침 시 페이징 현재 상태가 저장되지 않으나
                  stateSave를 true로 활성화할 경우 새로고침 시에도 페이징 되어진 현재 상태가 저장되어 그대로 보여지게 된다.
                  stateSave를 false로 활성화할 경우 새로고침 시에는 초기화 되어 처음의 상태로 보여지게 된다.
				*/
				"pagingType" : "full_numbers",  // "numbers" , "simple" , "simple_numbers" , "full" , "full_numbers" , "first_last_numbers" 
			//	"scrollX" : false,   // x 축 스크롤을 활성화 할지의 여부 
			//	"scrollY" : "250px", // y 축의 스크롤의 크기 
			//	"scrollCollapse" : true // y 축의 스크롤을 활성화 여부. 당연히 y축의 스크롤이 활성화 되면 paging이 안 일어나게 할 수도 있으므로  그렇게 하려면 "paging" 을 false로 바꿀수도 있다.  

		});
		
		// 회원 탈퇴하기 버튼 클릭	
		$(".professor_delMember").click(function(){
			
			var useridVal = $(this).val();
			
			if(confirm("탈퇴처리 하시겠습니까?") == true){
				$.ajax({
					url: "<%=ctxPath%>/admin/professor_delMember.up",
					data: {"userid" : useridVal},
					type: "POST",
					dataType:"JSON",
					success: function(json) {	
						if(json.n == 1) {
							alert("탈퇴처리 되었습니다.");
							var userid = json.userid;
							
							$("#"+userid).text("탈퇴").css('color','red');
						}
						else {
							alert("탈퇴처리 실패");
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				}); 
			} 
		    else{
		         return;
		    }


		});
		
		
	});

</script>

</head>
<body>
<div id="adminContainer" style="margin-bottom: 70px;">
	<h2 style="text-align: center;">교수회원 리스트</h2>
	<h6 style="text-align: right; margin-right: 110px;">※ 회원 탈퇴 처리 시 수정 불가합니다.</h6>
	<br/>
	<div style="width: 80%; margin: 0 auto;">
	<table id="exampleTbl" style="width: 100%; margin-bottom: 20px;" class="table table-bordered">
		<thead>
			<tr>
				<th>아이디</th>
				<th>성명</th>
				<th>대학교</th>
				<th>가입일자</th>
				<th>회원상태</th>
				<th>회원관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="membervo" items="${memberList}" varStatus="status">
				<tr>
					<td>${membervo.userid}</td>
					<td>${membervo.name}</td>
					<td>${membervo.university}</td>
					<td>${membervo.registerday}</td>
					<c:if test="${membervo.status eq '1'}">
						<td><span id="${membervo.userid}">가입</span></td>
					</c:if>
					<c:if test="${membervo.status eq '0'}">
						<td style="color: red;">탈퇴</td>
					</c:if>
					<td>
						<form name="delMember">
							<input type="hidden" name="userid" value="${membervo.userid}">
							<button name="professor_delMember" class="professor_delMember" value="${membervo.userid}"  style="margin-left: 70px; margin-right: -30px;">탈퇴처리</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>
</body>
</html>