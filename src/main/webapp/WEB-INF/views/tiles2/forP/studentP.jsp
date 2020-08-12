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
#changeG{
	border: solid 0px red;
	background-color: #fafafa;
	margin: 20px;
	font-weight: bold;
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
						
						var html = "<div id='changeG'>";
							html +="<span>"+json.Sname+"학생 학점 수정</span><br/>";
							
							html +="<label for='gradeA'>A</label>&nbsp";
							html +="<label for='gradeB'>B</label>&nbsp";
							html +="<label for='gradeC'>C</label>&nbsp";
							html +="<label for='gradeD'>D</label>&nbsp";
							html +="<label for='gradeF'>F</label><br/>";
							html +="<input type='radio' name='grade' class='grade' id='gradeA' value='A'/>";
							html +="<input type='radio' name='grade' class='grade' id='gradeB' value='B'/>";
							html +="<input type='radio' name='grade' class='grade' id='gradeC' value='C'/>";
							html +="<input type='radio' name='grade' class='grade' id='gradeD' value='D'/>";
							html +="<input type='radio' name='grade' class='grade' id='gradeF' value='F'/><br/>";
							
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
	  <h2>${sessionScope.loginuser.name} 교수님</h2>
  		<select name="subjectSelect" id="subjectSelect">
			<option value="">교과목명</option>
			<c:forEach var="sublist" items="${subjectListforP}">
				<option value="${sublist.subseq}">${sublist.subName}</option>
			</c:forEach>
		</select>
	</form>
	  <h3></h3>
		<table id="tblcss">
			<c:if test="${empty studentP}">
				교과목을 선택해 주세요!
			</c:if>
			<c:if test="${not empty studentP}">
			<tr style="background-color: #00BCD4;">
				<th style="color: white;">체크박스</th>
				<th style="color: white;">학생명</th>
				<th style="color: white;">출석점수(30점 만점)</th>
				<th style="color: white;">시험점수</th>
				<th style="color: white;">학점</th>
			</tr>
			<c:forEach var="SList" items="${studentP}" varStatus="status">
				<tr>
					<td><input type="radio" name="slist" class="slist" /></td>
					<td>${SList.name}<input type="hidden" name="slistuserid" id="id${status.count}" value="${SList.fk_userid}" /></td>
					<td>${SList.attandG}</td>
					<td>${SList.examG}</td>
					<td>${SList.finalG}</td> 
				</tr>
			</c:forEach>
			</c:if>
		</table>
		<button type="button" onclick="go_changeA();">출석관리</button>
		<button type="button" onclick="func_changeG();">학점수정</button>
		<div id="changeG"></div>
	</div> 
</body>
</html>