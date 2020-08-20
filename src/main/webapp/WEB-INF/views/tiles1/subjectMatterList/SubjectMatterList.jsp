<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<head>
   <title>Home</title>
   
   <style>
   
   
   #container1{
      width:1080px;
      margin: 0 auto;
     /*   border: solid 1px gray; */
      
   }
   
   .title {
   	margin-bottom:20px;
   }
   
   #side_menu{
      width: 21%;
      height: 100%;
      background-color: #E5E5E5;
      display:inline-block;
      /* color: white; */
   }

   
   #side_nav{
      line-height: 130px;
      
   }
   
   #main_feed{
      /* border:solid 1px red; */
     
       width: 78%;
       
      float:right;
      
   }
   
      .atag1{
      		font:16px/16px "NanumSquareRound", "Nanum Gothic", "돋움", Dotum, "굴림", Gulim, Arial, sans-serif !important;
	        text-decoration: none !important;
	         color: black !important; 
	        margin-right:50px;
	      }
      
     .atag1:hover {
        color: #00BCD4 !important;
		text-decoration: none !important;
      }
   
        .ctext{
        font: 14px/20px "NanumSquareRound", "Nanum Gothic", "돋움", Dotum, "굴림", Gulim, Arial, sans-serif;
        color: #666;
        letter-spacing: -0.03em;
        text-align: left;
        padding-top: 15px;
        display: inline-block !important;
        overflow: hidden;}
        
        .list_li{
        font: 14px/20px "NanumSquareRound", "Nanum Gothic", "돋움", Dotum, "굴림", Gulim, Arial, sans-serif;
        color: #666;
        letter-spacing: -0.03em;
        text-align: left;
        margin: 0;
        list-style: none !important;
        display: inline-block !important;
        width: 1224px;
        padding: 0px 0px;
   }
   
   
        li.igan{
        font: 14px/20px "NanumSquareRound", "Nanum Gothic", "돋움", Dotum, "굴림", Gulim, Arial, sans-serif;
        color: #666;
        letter-spacing: -0.03em;
        list-style: none !important;
        float: left;
        display:inline-block !important;
        width: 280px;
        height: 380px;
        padding: 0px !important;
        margin: 10px 24px 10px 50px;
        border: 1px #dedede solid;}
        
        
        .cimg{
        font: 14px/20px "NanumSquareRound", "Nanum Gothic", "돋움", Dotum, "굴림", Gulim, Arial, sans-serif;
        color: #666;
        letter-spacing: -0.03em;
        list-style: none !important;
        width: 280px;
        
        height: 190px;}
        
        
        .test {
        	font-weight:bold;
        	font-size:16pt;
        	color: black !important;
        	margin-top:10px;
        }
        
        .test:hover {
        
        	text-decoration: none;
        }
        
        
       .khimg img {
       -webkit-transform:scale(1);
       -moz-transform:scale(1);
       -ms-transform:scale(1); 
       -o-transform:scale(1);  
       transform:scale(1);
       -webkit-transition:.3s;
       -moz-transition:.3s;
       -ms-transition:.3s;
       -o-transition:.3s;
       transition:.3s;
   }
   .khimg:hover img {
       -webkit-transform:scale(1.1);
       -moz-transform:scale(1.1);
       -ms-transform:scale(1.1);   
       -o-transform:scale(1.1);
       transform:scale(1.1);
       
   }
   .khimg {
      border: solid 0px skyblue;
      overflow: hidden;
   }

	/* .sugangBtn {
		font-weight:bold;
		text-decoration:none;
		font-family:Arial;
		background:linear-gradient(#2ef1ff, #3b9ceb);
		text-indent:0px;
		-moz-border-radius:25px;
		-webkit-border-radius:25px;
		border-radius:25px;
		text-align:center;
		vertical-align:middle;
		display:inline-block;
		font-size:20px;
		color:#ffffff;
		width:223px;
		margin-left:25px;
		margin-top:-12px;
		padding:13px;
		text-shadow:#6daac2 2px 2px 0px;
		
		border-width:2px;
		border-style:solid;
	}

	.sugangBtn:active {
	box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 0 2px;
	o-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 0 2px;
	-moz-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 0 2px;
	-webkit-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 0 2px;
	position:relative;
	top:3px;
	text-decoration: none;
	
	}
	
	.sugangBtn:hover {
		background:#3b9ceb;
		background:-o-linear-gradient(90deg, #3b9ceb, #2ef1ff);
		background:-moz-linear-gradient( center top, #3b9ceb 5%, #2ef1ff 100% );
		background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #3b9ceb), color-stop(1, #2ef1ff) );
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3b9ceb', endColorstr='#2ef1ff');
		background:-webkit-linear-gradient(#3b9ceb, #2ef1ff);
		background:-ms-linear-gradient(#3b9ceb, #2ef1ff);
		background:linear-gradient(#3b9ceb, #2ef1ff);
		text-decoration: none;
		color:#ffffff;
		
	} */
	
	
	#main_feed{
		margin-right: 120px;
		margin-bottom:50px;
	}
	.sugangBtn {
	font-family:monospace !important;
	    display: inline-block;
	    width: 230px;
	    height: 52px;
	    padding-top: 12px;
	    text-align: center;
	    background-color: #00BCD4;
		font-size: 20px;
    font-weight: 600;
	    border-radius: 5px;
	    margin-left:23px;
	    margin-top: -199px;
	    cursor: pointer;
	    margin-bottom:400px;
	}
	
</style>        
   
    <script>
    	
    	$(document).ready(function(){
    		
    		$("#searchWord").keydown(function(event){
    			if(event.keyCode == 13){
    				//엔터를 했을경우
    				goSearch();
    			}
    		});
    		
    		//검색시 검색조건 및 검색어 값유지시키기
    		if(${paraMap != null}){
    			$("#searchType").val("${paraMap.searchType}");
    			$("#searchWord").val("${paraMap.searchWord}");
    		}
    		
    		
    		function goSearch() {
    			var frm = document.searchFrm;
    			frm.method = "GET";
    			frm.action = "<%= ctxPath%>/SubjectMatterList.up";
    			frm.submit();
    		 }// end of function goSearch()-------------------------
    		
    	});
    
    </script>
   
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


</head>

   <div id="container1">
   
    <section id="contents">
     <%--  <aside id="side_menu">
         <ul id="side_nav" >
          
  
         </ul>
      </aside> --%>
   
      <article id="main_feed" >
          
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
      <div class="carousel-inner">
      <div class="item active">
        <img src="<c:url value="/resources/images/main1.PNG" />"  style="height:408px;">
      </div>

      <div class="item">
        <img src="<c:url value="/resources/images/main2.PNG" />" style="height:408px;">
      </div>
    
      <div class="item">
        <img src="<c:url value="/resources/images/main3.PNG" />" style="height:408px;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  
            
      </article>
      
    </section>

       <div style="display:inline-block !important;" >
 
           <div style=" margin-bottom:-40px; margin-right:90px;;" align=center >
           	<a class="atag1" href="<%=request.getContextPath()%>/SubjectMatterList.up">전체</a>  <a class="atag1" href="<%=request.getContextPath()%>/SubjectMatterList.up?status1=1">전공</a> <a class="atag1" href="<%=request.getContextPath()%>/SubjectMatterList.up?status1=2">교양</a> <a class="atag1" href="<%=request.getContextPath()%>/SubjectMatterList.up?status1=3">일반</a>
           </div>
           
           <hr style="border:solid 1px gray; margin-left:20px;width:90%; margin-top: 70px">
           
           <div class="ctext" style="display:inline-block !important;" >
           
           
		           <%-- === #99. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%> 
		           <div style="margin-right:100px;">
			<form name="searchFrm" style="margin-top: -15px; margin-bottom: 15px; float:right;">
			
				<select name="searchType" id="searchType" style="height: 26px;">
					<option value="subName">과목명</option>
				</select>
				<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
				<button type="button" class="btn" onclick="goSearch()">검색</button>
			</form>
			</div>
			<%-- 
			검색어 입력시 자동완성 하기
			<div id="displayList" style="border:solid 1px gray; width:316px; height:100px; margin-left: 70px; margin-top:-1px; overflow:auto;">
				
			</div> --%>
           
           
           <div class="chart" >
                <ul class="list_li" style="display:inline-block !important;">
                <c:if test="${empty lmivList}">
                <div style="text-align: center; margin: 50px 50px 50px 0">
                	<span style="font-size:20pt; ">현재 개설된 교과목이 없습니다.</span>
                	</div>
                </c:if>
                <c:if test="${not empty lmivList}">
                
                    
                    	<c:forEach var="lmivList" items="${lmivList}" >
                    	<li class="igan" style="display:inline-block !important; border-radius: 5px;  margin-bottom:60px;">
                        <div class="cimg" style="display:inline-block !important;">                            
                             <c:if test="${empty lmivList.saveSubImg}">
	                             <a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}'>
	                           	 <img style="width:278px; height:180px;" src="<%= ctxPath%>/resources/images/${lmivList.subImg}"/> 
	                           	 </a>
                           	 </c:if>
                             <c:if test="${not empty lmivList.saveSubImg}">
	                           	 <a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}'>
	                           	 <img style="width:278px; height:180px;" src="<%= ctxPath%>/resources/files/${lmivList.saveSubImg}"/> 
	                           	 </a>
                            </c:if>
                        </div>
                        
                        <div class="nayong" style="display:inline-block !important;">
                            <div class="title" style="font-family:Monospace; overflow: hidden; height:20px !important; margin-top:8px; text-align:center; "><a style="overflow: hidden; height:10px !important;"class="test" href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}'> ${lmivList.subName} </a></div>
                            <div class="text" style="font-weight:300; font-family:Monospace !important; overflow: hidden; height:39px !important; padding-left: 10px; padding-right: 10px;"> ${lmivList.subContent}</div>
                        </div>
                        <hr style="border:solid 1px #e6e6e6; width:80%; margin-top: 10px; margin-bottom:-10px;">
                        <div class="suBtn" style="margin-top:30px;">
                        	 <c:if test="${sessionScope.loginuser.identity != 2 || empty sessionScope.loginuser}">
                        		<h2 style="margin-bottom: 20px;color:#00BCD4 "><a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}' class="sugangBtn" style="color:white !important;  text-decoration: none !important;">수강신청</a></h2>
                        
                        	 </c:if>
                        	<c:if test="${sessionScope.loginuser.identity == 2}">
                        		<h2 style="margin-bottom: 20px; color:#00BCD4 "><a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}' class="sugangBtn" style="color:white !important; text-decoration: none !important;">상세보기</a></h2>
                        	</c:if>
                        </div>
                        </li>
                        </c:forEach>
                  </c:if>
               </ul>
       
           </div>
           
           </div>
           
          <!-- // == #119.페이지바 만들기 == -->
	
	<div align="center" style="margin-right:120px;">
		${pageBar}
	</div>
	
	
	
	 <!-- 돌아갈 페이지를 알려주기위해 현재 페이지 주소를 뷰단으로 넘겨준다 -->
		<form name="goViewFrm">
			<input type="hidden" name="seq"/>
			<input type="hidden" name="gobackURL" value="${gobackURL}"/>
		</form> 
           
        </div>
        
    </div>


