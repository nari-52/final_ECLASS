<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
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
      		font-size: 16pt !important;
	        text-decoration: none !important;
	         font-weight: bold !important;
	        color: #00BCD4 !important;
	      }
      
     .atag1:hover {
        color: #00BCD4 !important;
        font-weight: bold !important;
        font-size:20pt !important;
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
   
   .sugangBtn {
		text-decoration:none !important;
		font-family:Arial;
		box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 3px 2px;
		o-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 3px 2px;
		-moz-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 3px 2px;
		-webkit-box-shadow:inset #ffffff 0px 5px 8px -1px,#d6d6d6 1px 3px 2px;
		background:#545fff;
		background:-o-linear-gradient(90deg, #545fff, #3b9ceb);
		background:-moz-linear-gradient( center top, #545fff 5%, #3b9ceb 100% );
		background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #545fff), color-stop(1, #3b9ceb) );
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#545fff', endColorstr='#3b9ceb');
		background:-webkit-linear-gradient(#545fff, #3b9ceb);
		background:-ms-linear-gradient(#545fff, #3b9ceb);
		background:linear-gradient(#545fff, #3b9ceb);
		text-indent:0px;
		line-height:30px;
		-moz-border-radius:25px;
		-webkit-border-radius:25px;
		border-radius:25px;
		text-align:center;
		margin-left:80px;
		margin-top:40px;
		font-size:23px;
		color:#ffffff;
		width:173px;
		height:30px;
		padding:13px;
		text-shadow:#6daac2 2px 2px 0px;
		border-color:#659dab;
		border-width:2px;
		border-style:solid;
	}
</style>        
   
    
   
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


</head>
<body>

   <div id="container1">
   
    <section id="contents">
      <aside id="side_menu">
         <ul id="side_nav" >
            <li><a class="atag1" href="">전공</a></li>
            <li><a class="atag1" href="">교양</a></li> 
            <li><a class="atag1" href="">일반</a></li>
  
         </ul>
      </aside>
   
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
           
           <hr style="border:solid 1px gray; width:100%; margin-top: 70px">
           
           <div class="ctext" style="display:inline-block !important;">
           <div class="chart" >
                <ul class="list_li" style="display:inline-block !important;">
                <c:if test="${empty lmivList}">
                	<span style="font-size:20pt; align-text:center;">현재 개설된 교과목이 없습니다.</span>
                </c:if>
                <c:if test="${not empty lmivList}">
                
                    
                    	<c:forEach var="lmivList" items="${lmivList}" >
                    	<li class="igan" style="display:inline-block !important;  margin-bottom:60px;">
                        <div class="cimg" style="display:inline-block !important;">
                            <a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}'><img style="width:278px; height:180px;" src="<%= ctxPath %>/resources/images/${lmivList.subImg}"/></a>
                        </div>
                        
                        <div class="nayong" style="display:inline-block !important;">
                            <div class="title"><a class="test" href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}'> ${lmivList.subName} </a></div>
                            <div class="text" style="font-weight:bold; overflow: hidden; height:39px !important;"> ${lmivList.subContent}</div>
                        </div>
                        <hr style="border:solid 1px #e6e6e6; width:80%; margin-top: 10px">
                        <div class="suBtn" style="margin-top:30px;">
                        	<a href='<%= ctxPath%>/SubjectMatterDetail.up?subseq=${lmivList.subseq}' class='sugangBtn' >수강신청</a>
                        </div>
                        </li>
                        </c:forEach>
                  </c:if>
               </ul>
       
           </div>
           
           </div>
           
           <!-- <div class="pagebar" align="center";>
            1 2 3 4 5 [다음]
           </div> -->
           
        </div>
        
    </div>

</body>
</html>
