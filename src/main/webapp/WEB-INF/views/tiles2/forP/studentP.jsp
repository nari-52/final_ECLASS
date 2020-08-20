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
	margin: 0 0 0 20px;
	color: gray;
}
#changeCss {
	background-color: #fafafa;
	width: 300px;
	height: 150px;
	border: solid 1px #00BCD4;
	padding: 10px;
	margin: 10px 0 0 75px;
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
	margin-bottom: 10px;
	width: 850px;
	text-align: center;
	border-radius: 10px;
}
#subjectSelect {
	margin: 20px 0;
}
#tableCss{
	text-align: center;
	font-size: 13pt;
}
#tableCss td, #tableCss th{
	padding: 10px;
}
.thCss {
	background-color: #FAFAFA;
	color: #00BCD4;
}
#btnCss {
	margin-top: 10px; 
}
#ajaxtbl{
	margin: 10px;
}
#ajaxtbl td, #ajaxtbl th {
	border: solid 0px gray;
	padding: 0 10px;
	text-align: center;
}
#myS {
	color: white;
	background-color: #00BCD4;
}
</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("option").each(function(index, item){
			if($(item).val() == "${subjectSelect}"){
				$(item).prop("selected",true);
			}
		})
		
		$("#subjectSelect").change(function(){
			
			var frm = document.studentPFrm;
			frm.method = "GET";
			frm.action = "studentP.up";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})---------------

	function func_changeG(){
		
		var bCkecked = false;
		var i=1;
		var userid = "";
		
		$(".slist").each(function(){
			bChecked = $(this).prop("checked");
			
			if(bChecked){ // true
				userid = $(this).parent().parent().find("#id"+[i]+"").val();
			
				$.ajax({
					url:"<%= request.getContextPath()%>/studentP2.up",
					data:{"userid":userid},
					dataType:"JSON",
					success:function(json){
						
						var html = "<div id='changeCss'>";
							html +="<span>[ "+json.Sname+"학생 학점 수정 ]</span><br/>";
							
							html +="<table id='ajaxtbl'><tr>";
							html +="<th><label for='gradeA'>A</label></th>";
							html +="<th><label for='gradeB'>B</label></th>";
							html +="<th><label for='gradeC'>C</label></th>";
							html +="<th><label for='gradeD'>D</label></th>";
							html +="<th><label for='gradeF'>F</label></th></tr><tr>";
							html +="<td><input type='radio' name='grade' class='grade' id='gradeA' value='A'/></td>";
							html +="<td><input type='radio' name='grade' class='grade' id='gradeB' value='B'/></td>";
							html +="<td><input type='radio' name='grade' class='grade' id='gradeC' value='C'/></td>";
							html +="<td><input type='radio' name='grade' class='grade' id='gradeD' value='D'/></td>";
							html +="<td><input type='radio' name='grade' class='grade' id='gradeF' value='F'/></td></tr></table>";
							
							html +="<button type='button' onclick='changeG();'>수정하기</button>";
							html +="</div>";
							
						$("#changeG").html(html);		   
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
			i++
		});
		
	}
	
	function go_changeA() {
		
		var bCkecked = false;
		var i=1;
		var userid = "";
		
		$(".slist").each(function(){
			bChecked = $(this).prop("checked");
			
			if(bChecked){ // true
				userid = $(this).parent().parent().find("#id"+[i]+"").val();

				$.ajax({
					url:"<%= request.getContextPath()%>/changeAttand.up",
					data:{"userid":userid,
						  "subjectSelect":"${subjectSelect}"},
					dataType:"JSON",
					success:function(json){
						var id = json.userid;
						var seq = json.subjectSelect;
						console.log(id+seq);
						location.href = "<%= request.getContextPath()%>/changeAttand2.up?userid="+id+"&subjectSelect="+seq+"";
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
			i++
		});
	}
	
	function changeG(){
		
		var bCkecked = false;
		var i=1;
		var userid = "";
		var bFlag = false;
		
		$(".slist").each(function(){
			bChecked = $(this).prop("checked");
			
			if(bChecked){ // true
				userid = $(this).parent().parent().find("#id"+[i]+"").val();
				
				$(".grade").each(function(){
					bFlag = $(this).prop("checked");
					
					if(bFlag){
						var grade = $(this).val();
						console.log(grade);
						
						$.ajax({
							url:"<%= request.getContextPath()%>/changeGradeEnd.up",
							data:{"finalG":grade,
								  "fk_userid":userid,
								  "fk_subSeq":"${subjectSelect}"},
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
					
				});
			}
			i++
		});
		
	}
	
</script>
</head>
<body>
	<div id="test">
	<form name="studentPFrm">
	<div id="mainCss">
	<span id="namecss">${sessionScope.loginuser.name}</span>교수님의 학생관리 페이지
	  </div>
  		<select name="subjectSelect" id="subjectSelect">
			<option value="">교과목명</option>
			<c:forEach var="sublist" items="${subjectListforP}">
				<option value="${sublist.subseq}">${sublist.subName}</option>
			</c:forEach>
		</select>
	</form>
		<table id="tableCss">
			<c:if test="${empty studentP}">
				<span style="color: red;">교과목을 선택해 주세요!</span>
			</c:if>
			<c:if test="${not empty studentP}">
			<tr style="background-color: #00BCD4;">
				<th class="thCss"></th>
				<th class="thCss">학생명</th>
				<th class="thCss">출석점수(30점 만점)</th>
				<th class="thCss">시험점수</th>
				<th class="thCss">학점</th>
			</tr>
			<c:forEach var="SList" items="${studentP}" varStatus="status">
				<tr>
					<td><input type="radio" name="slist" class="slist" /></td>
					<td>${SList.name}<input type="hidden" name="slistuserid" id="id${status.count}" value="${SList.fk_userid}" /></td>
					<td>${SList.attandG}</td>
					<td>
						<c:if test="${SList.examG == -1}">0</c:if>
						<c:if test="${SList.examG != -1}">${SList.examG}</c:if>
					</td>
					<td>${SList.finalG}</td> 
				</tr>
			</c:forEach>
			</c:if>
		</table>
		<div id="btnCss">
			<button type="button" onclick="go_changeA();">출석관리</button>
			<button type="button" onclick="func_changeG();">학점수정</button>
		</div>
		<div id="changeG"></div>
	</div> 
</body>
</html>