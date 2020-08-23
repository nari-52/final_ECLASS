<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% String ctxPath = request.getContextPath(); %>
    
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<head>
	<title>Home</title>
	
	<style>
	
	
	#container1{
		width:1080px;
		margin: 0 auto;
		/* border: solid 1px gy; */
		
	}
	
	#contents{
		height: 55%;
        clear: both;
	}
	
	#side_menu{
		width: 21%;
		height: 100%;
		background-color: #E5E5E5;
		color: white;
	}

	
	#side_nav{
		line-height: 50px;
		
	}
	
	#main_feed{
		/* ///border:solid 1px red; */
		margin-top: 80px;
		margin-bottom: 20px;
		 
		height: 97%; 
		
		
	}
	
	a {
        text-decoration: none;
      }
      
      a.lecture1:hover {
        color: #00BCD4;
        font-weight: bold;
        font-size:14pt;
      }
      
      #soga{
     	list-style-type:none;
     	/* width:500px; */
     	 height:100px;
      	line-height:50px; 
      	
      }
	
	.sugangBtn {
    display: inline-block;
    width: 278px;
    height: 52px;
    padding-top: 12px;
    text-align: center;
    background-color: #00BCD4;
    color: white;
    font-size: 20px;
    font-weight: 600;
    border-radius: 5px;
    margin-top: 10px;
    cursor: pointer;
    margin:0 auto;
    text-align: center;
    margin:-30px -30px 30px 100px; 
}
	
	
	.lecture{
		text-align:cneter;
		margin-top:90px;
	}
	
	.donInfo-table {
    display: inline-block;
    width: 500px;
    text-align: left;
   /*  font-size: 12pt; */
    border: solid 1px #ccc;
    padding-left: 0px;
    padding-bottom: 30px;
    margin-bottom: 20px;
    border-radius: 5px;
    margin-left: -50px;
}
	
	
</style>
	
	<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
 
	
	<script>
	
	$(document).ready(function(){
	
		$(".sugangBtn").click(function(){
			
			sugangInsertCon();
			
		});
		
		$("#delSubject").click(function(){
			
			delSubject();
			
		});
		
	});
	
	
	function delSubject(){
		
		if(confirm("교과목을 삭제 하시겠습니까?") == true){
			
			var frm = document.sugangFm;
			frm.action = "<%= ctxPath%>/SubjectMatterDelete.up";
			frm.submit();
			
		}
		else{
			return;
		}
		
	}
	
	function sugangInsertCon(){

		
				if(confirm("수강신청은 한번 신청시 변경이 불가능합니다.신청 하시겠습니까?") == true){
					
					var frm = document.sugangFm;
					frm.action = "<%= ctxPath%>/sugangInsert.up";
					frm.submit();
					
				}else{
					return;
				}
	  	  
	}

	
	</script>
</head>


	<div id="container1">
	
	 <section id="contents">
		<!-- <aside id="side_menu">
			<ul id="side_nav">
                <li><a class="lecture1"href="">전공</a></li>
            <li><a class="lecture1" href="">교양</a></li> 
            <li><a class="lecture1" href="">일반</a></li>
      
			</ul>
		</aside> -->

		<article id="main_feed" >
	
		<hr style="border:1px color: gray; width:90%; margin-bottom:50px; margin-top:-20px;">
		<div class="nana">
		<form name="SubjectModfyFm">
					<c:if test="${empty lmivOne.saveSubImg}">
	                            
	                           	 <img style="width:450px; display:inline-block; border-radius: 2px; height:430px; margin:-260px 90px 10px 30px;" src="<%= ctxPath%>/resources/images/${lmivOne.subImg}"/>

                           	 </c:if>
                             <c:if test="${not empty lmivOne.saveSubImg}">
	                           	
	                           	 <img style="width:450px; display:inline-block; border-radius: 2px; height:430px; margin:-260px 90px 10px 30px;" class="khimg"src="<%= ctxPath%>/resources/files/${lmivOne.saveSubImg}"/>
	                           	
                            </c:if>
                            
         <!--    <h3 style="margin-left:150px; margin-top:-500px; algin-text:right; display:inline-block;"></h3><br/>
			<h2 style="margin-left:350px; margin-top:-500px; algin-text:right; display:inline-block;"></h2><br/>
             -->
             <div class="donInfo-table">
		            <ul id="soga" style="display:inline-block; ">
			            <li style=" font-weight: 700; font-size:18pt; margin-right:70px;text-align:center; margin-top:30px;color:#00BCD4;" >- Eclass의 모든 것 -</li>
			            <hr style="border:2px solid #00BCD4; width:350px;margin-right:80px; margin-bottom:30px; margin-top:0px;">
			            <li><span style="font-weight: 700; margin-top:20px; font-size:16pt;">교과목명    </span>  <span style="font-size: 14pt;">${lmivOne.subName}</span> <br/></li>
			            <li></li>
						<li style=" font-weight:bold; font-size:16pt; ">강의소개<br/></li>
						<li class="subContent" style="width: 450px; line-height:25px; height:150px; overflow:auto; margin-bottom:30px;"> ${lmivOne.subContent} <br/></li>
						
						
					</ul>
					<c:if test="${sessionScope.loginuser.identity == 1  || empty sessionScope.loginuser}">
		                    <!-- <a class='sugangBtn' >수강신청</a> -->
		             	<span class="sugangBtn" >수강신청</span>
		
		             </c:if>
		             
		             <c:if test="${sessionScope.loginuser.identity == 3}">
		                      <!-- <a class='sugangBtn' >수강신청</a> -->
		                      <span class="sugangBtn">수강신청</span>
		             		<div style=" float:right; ">
								<button type="button" class="btn" style="margin-right:30px !important;"onclick="javascript:location.href='<%= ctxPath%>/SubjectMatterModify.up?subseq=${lmivOne.subseq}&userid=${sessionScope.loginuser.userid}'">수정하기</button><button type="button" id="delSubject" class="btn">삭제하기</button>
							</div>
		             </c:if>
		             
		             <c:if test="${sessionScope.loginuser.identity == 2}">
						<div style="margin-bottom:30px;">
							<button type="button" class="btn" style="margin-right:30px !important; margin-left:150px; "onclick="javascript:location.href='<%= ctxPath%>/SubjectMatterModify.up?subseq=${lmivOne.subseq}'">수정하기</button><button type="button" id="delSubject" class="btn">삭제하기</button>
						</div>
					</c:if>
 		 	</div>
			<hr style="border:1px color: gray; width:90%; margin-top:80px;">

			<input type="hidden" name="subseq" value="${lmivOne.subseq}"/>
			<input type="hidden" name="fk_userid" value="${lmivOne.fk_userid }"/>
			
		 </form>
			 <div style="text-align:right; margin:20px 50px 0px 0px;">
					<button class="btn" onclick="javascript:location.href='<%= ctxPath%>/SubjectMatterList.up'" >목록보기</button>
			</div>
		 </div>
			<div align=center class="lecture">
			  <h2 style="margin-bottom:40px; margin-top:-40px;">- 강의목차 -</h2>
			  <table class="table">
			    <thead>
			      <tr>
			        <th>차시</th>
			        <th>강의제목</th>
			      </tr>
			    </thead>
			    <tbody>  
			     <c:if test="${not empty lvoList}"> 
				    <c:forEach var = "i" items="${lvoList}" begin="0" end = "11" varStatus="status">
				      <tr>
				        <td>${status.count}차시</td>
				        <td>${i.lecTitle}</td>
				      </tr>
				     </c:forEach>
			   </c:if>  
			         
			    </tbody>
			  </table>
			  <c:if test="${empty lvoList}"> 
				    	<span style="text-align:center; margin-top:80px; font-weight:bold; font-size:16pt;">강의 등록이 되어있지 않습니다.</span>
			      </c:if> 
			</div>

			<br/>
		
		 <form name="sugangFm">
		 	<input type="hidden" name="subseq" value="${lmivOne.subseq}"/> <br/>
		 	<input type="hidden" name="fk_userid" value="${lmivOne.fk_userid }"/>
			<input type="hidden" name="userid" class="userid"value="${loginuser.userid}"/>
		 </form> 
			

		</article>
		
	 </section>
	 
	 


	</div>

