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

			$("#btnUpdate").click(function(){
				
				var statusSelectVal = $(".statusSelect").val().trim();
		    	  if(statusSelectVal == ""){
		    	  alert("이수구분을 선택하세요!!")
		    	  return;
		      }
				
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
			   	   
			     
			    	  
			         //폼(form) 을 전송(submit)
				   var frm = document.lectureModifyFm;
					frm.action = "<%=ctxPath%>/SubjectMatterModifyEnd.up";
					frm.method = "POST";
					frm.submit();
				
			   		
			   		
			   		
			   		
			});
      
   }); // end of $(document).ready();--------------
   
  
   
</script>

<div align="center" style="margin: 0 auto; width:930px;">

<div align="center" style="border: solid green 2px; width: 300px; margin-top: 20px; margin-left:0%; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
   <span style="font-size: 15pt; font-weight: bold;">교과목수정</span>   
</div>
<br/>

<!-- enctype="multipart/form-data" -->
<form name="lectureModifyFm"> 
      
<table id="tblProdInput" style="width: 80%;">
<tbody>
   <tr>
      <td width="25%"  class="prodInputName" style="padding-top: 10px; color:white;">이수구분</td>
      
      <td width="75%" align="left" style="padding-top: 1px;" >
        <c:if test="${lmiv.status == 1}">
        <select name="status" class="statusSelect">
            <option value="1">전공</option>
               <option value="2">교양</option>
               <option value="3">일반</option>
         </select>
          </c:if> 
          
          <c:if test="${lmiv.status == 2}">
        <select name="status" class="statusSelect">
       		 <option value="2">교양</option>
            <option value="1">전공</option>
             <option value="3">일반</option>
         </select>
          </c:if> 
          
          <c:if test="${lmiv.status == 3}">
        <select name="status" class="statusSelect">
             <option value="3">일반</option>
       		 <option value="2">교양</option>
            <option value="1">전공</option>
         </select>
          </c:if> 
		
      </td>   
   </tr>

   <tr style="line-height: 30px;">
      <td  class="prodInputName"  style="color:white;">교과목명</td>
    	<td><input type="text" style="width: 300px;" name="subName" value="${lmiv.subName}" id="subName" class="box infoData" /></td>
    
   </tr>

   <tr>
      <td width="25%" class="prodInputName" style="color:white;">과목소개</td>
		<td> <textarea name="subContent" id="subContent" rows="5" cols="60">${lmiv.subContent}</textarea></td>

   
   <tr style="height: 70px;">
		<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
		    <button type="button"style="width:46px; cursor:pointer;" id="btnUpdate">수정</button>
		    &nbsp;
		    <input type="reset" value="취소" style="width:46px; cursor:pointer;"onclick="javascript:location.href='<%= ctxPath%>/SubjectMatterList.up'"  style="width: 80px;" />	
		    
		    	<br/>
   	<br/>
   	<input type="hidden" name="subseq" value="${lmiv.subseq}"/> 
   	<input type="hidden" name="fk_userid" value="${loginuser.userid}"/> <!-- 교수님 아이디 -->
   	<!--<input type="text" name="university" value="${loginuser.university}"/>  로근인한 유저의 대학명 -->
		</td>
	</tr>
  
</tbody>
</table>


</form>

</div>

