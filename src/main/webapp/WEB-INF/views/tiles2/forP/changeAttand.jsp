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
		
		var total = $("#total").text();
		var html = 10*total+"%";
				
		$("#persent").html(html);
		
	});

	function attandChange(){
		
		var lecNum = $("#lectureSelect").val();
		var attand = $("#attandSelect").val();
		var fk_userid = "${userid}";
		var fk_subSeq = "${subjectSelect}";
		
		$.ajax({
			url:"<%= request.getContextPath()%>/changeAttandEnd.up",
			data:{"lecNum":lecNum,
				  "attand":attand,
				  "fk_userid":fk_userid,
				  "fk_subSeq":fk_subSeq},
			dataType:"JSON",
			success:function(json){
				if(json.n==1) {
					alert("수정 되었습니다!");
				}
				else {
					alert("수정 오류!");
				}
				location.reload();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
</script>
</head>
<body>
	<div id="test">
	  	<h3>수정할 학생명 : ${Sname}</h3>
		<table id="tblcss" >
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
		<select name="lectureSelect" id="lectureSelect">
			<option value="1">1강</option>
			<option value="2">2강</option>   
			<option value="3">3강</option>
			<option value="4">4강</option>
			<option value="5">5강</option>
			<option value="6">6강</option>
			<option value="7">7강</option>
			<option value="8">8강</option>
			<option value="9">9강</option>
			<option value="10">10강</option>
		</select>
		<select name="attandSelect" id="attandSelect">
			<option value="O">O</option>
			<option value="X">X</option>   
		</select>
		<button type="button" onclick="attandChange();">수정하기</button>
		<button type="button" onclick="location.href='javascript:history.back()'">이전으로</button>
	</div>  
</body>
</html>