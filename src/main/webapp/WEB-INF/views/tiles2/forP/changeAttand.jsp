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
	color: gray;
}
#namecss{
	color: #00BCD4;
	font-weight: bold;
}
#mainCss{
	font-size: 15pt;
	background-color: #FAFAFA;
	border: solid 1px #00BCD4;
	padding: 10px;
	margin-bottom: 20px;
	width: 600px;
	text-align: center;
	border-radius: 10px;
}
#tableCss{
	text-align: center;
	font-size: 12pt;
	width: 300px;
}
.sidecss{
	color: white;
	text-align: center;
}
#selectCSS {
	margin-top: 20px; 
}
#lectureSelect {
	width: 100px;
	margin-right: 20px;
	height: 25px;
}
#attandSelect {
	width: 100px;
	margin-right: 13px;
	height: 25px;
}
td {
	padding: 5px;
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
	  <div id="mainCss">
		수정할 학생명 : <span id="namecss">${Sname}</span>
	  </div>
		<table id="tableCss" >
			<tr style="background-color: #00BCD4;">
				<th class="sidecss">챕터</th>
				<th class="sidecss">출석현황</th>
			</tr>
			<c:forEach var="AList" items="${attandList}">
				<tr>
					<td>${AList.lecNum}강</td>
					<td>${AList.attand}</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="background-color: #E5E5E5; border-top: solid 2px #E5E5E5;">총 출석수</td>
				<td id="total" style="border-top: solid 2px #E5E5E5;">${attandOX}</td><!-- count로 총 개수 알아오기/ select count(*) from tbl_attendanct where attend = 1(출석) -->
			</tr>
			<tr>
				<td style="background-color: #E5E5E5;">출석률 (%)</td>
				<td id="persent"></td>
			</tr>
		</table>
		<div id="selectCSS">
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
	</div>  
</body>
</html>