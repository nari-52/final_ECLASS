<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
   table#tblProdInput {border: solid gray 1px; 
                       border-collapse: collapse;  }
                       
    table#tblProdInput td {border: solid gray 1px; 
                          padding-left: 10px;
                          height: 50px; 
                          }
                          
    .prodInputName {background-color: #00BCD4; 
                    font-weight: bold; }                                                 
   
 
   
</style>

<script type="text/javascript">

   $(document).ready(function(){
          
      $("#btnRegister").click(function(){
           
    	  var subNameVal = $("#subName").val().trim();
   	   if(subNameVal == ""){
   					   
   		   alert("교과목명을 입력해주세요!!");
   		   return;
   	   }
   	   
   	   var subContentVal = $("#subContent").val().trim();
   	   if(subContentVal == ""){
   		   
   		   alert("교과목 소개를 입력해주세요!!");
   		   return;
   	   }
   	   
   	   var subContentVal = $("#subContent").val().trim();
   	   if(subContentVal == ""){
   		   
   		   alert("교과목 소개를 입력해주세요!!");
   		   return;
   	   }
    	  
         //폼(form) 을 전송(submit)
   		var frm = document.lectureFm;
   		frm.method = "POST";
   		frm.action = "<%= ctxPath%>/SubjectMatter_insertEnd.up";
   		frm.submit();
			
      });
  
      
    
      
   }); // end of $(document).ready();--------------
   
  
   
</script>

<div style="margin-bottom: 20px; width:930px; float:right;">

<div align="center" style="border: solid green 2px; width: 300px; margin-top: 20px; margin-left:25%; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
   <span style="font-size: 15pt; font-weight: bold;">교과목등록</span>   
</div>
<br/>

<!-- enctype="multipart/form-data" -->
<form name="lectureFm" enctype="multipart/form-data"> 
      
<table id="tblProdInput" style="width: 80%;">
<tbody>
   <tr>
      <td width="25%"  class="prodInputName" style="padding-top: 10px; color:white;">이수구분</td>
      
      <td width="75%" align="left" style="padding-top: 1px;" >
         <select name="status" class="infoData">
            <option value="">:::필수입력:::</option>
               <option value="1">전공</option>
               <option value="2">교양</option>
               <option value="3">일반</option>
         </select>
		
      </td>   
   </tr>

   <tr style="line-height: 30px;">
      <td  class="prodInputName"  style="color:white;">교과목명</td>
    	<td><input type="text" style="width: 300px;" name="subName" id="subName" class="box infoData" />
    
   </tr>

   <tr>
      <td width="25%" class="prodInputName" style="color:white;">과목소개</td>
		<td> <textarea name="subContent" id="subContent" rows="5" cols="60"></textarea></td>
   <tr>
      <td width="25%" class="prodInputName" style="color:white;">교과목이미지</td>
  		<td> <input type="file" name="attach"/>
  		
   </tr>
   
   <tr style="height: 70px;">
		<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
		    <input type="button" value="교과목등록" id="btnRegister" style="width: 80px; margin-top:30px;" /> 
		    &nbsp;
		    <input type="reset" value="취소"  style="width: 80px;" />	
		    
		    	<br/>
   	<br/>
   	이곳은 로그인한 유저의 아이디 들어가는 값입니다.
   	<input type="text" name="fk_userid" value="${loginuser.userid}"/> <!-- 교수님 아이디 -->
   	<input type="text" name="university" value="${loginuser.university}"/> <!-- 로근인한 유저의 대학명 -->
		</td>
	</tr>
  
</tbody>
</table>


</form>

</div>

