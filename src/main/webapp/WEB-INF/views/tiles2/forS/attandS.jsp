<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
#test{
	display: inline-block;
	border: solid 0px red;
	margin: 0 20px;
	height: 500px;
}

</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("option").each(function(index, item){
			if($(item).val() == "${subjectSelect}"){
				$(item).prop("selected",true);
			}
		})
		
		var total = $("#total").text();
		var html = 10*total+"%";
				
		$("#persent").html(html);
		
		
		$("#subjectSelect").change(function(){
			
			var frm = document.attandFrm;
			frm.method = "GET";
			frm.action = "attandS.up";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})-----------------
	
	
	
</script>
</head>
<body>
	<div id="test">
	<form name ="attandFrm">
		  <h2>${sessionScope.loginuser.name} 님의 출석현황</h2>
			<select name="subjectSelect" id="subjectSelect">
				<option value="0">교과목명</option>
				<c:forEach var="sublist" items="${subjectList}">
					<option value="${sublist.fk_subseq}">${sublist.subName}</option>
				</c:forEach>
			</select>
		</form>
		<table id="tblcss">
			<tr style="background-color: #00BCD4;">
				<th style="color: white;">챕터</th>
				<th style="color: white;">출석현황</th>
			</tr>
			<c:forEach var="AList" items="${attandList}">
				<tr>
					<td>${AList.lecNum}강</td>
					<td>${AList.attand}</td>
				</tr>
			</c:forEach>
			
			<tr>
				<td style="background-color: #E5E5E5;">총 출석수</td>
				<td id="total">${attandOX}</td><!-- count로 총 개수 알아오기/ select count(*) from tbl_attendanct where attend = 1(출석) -->
			</tr>
			<tr>
				<td style="background-color: #E5E5E5;">출석률 (%)</td>
				<td id="persent"></td>
			</tr>
		</table>
	</div>  
</body>
</html>