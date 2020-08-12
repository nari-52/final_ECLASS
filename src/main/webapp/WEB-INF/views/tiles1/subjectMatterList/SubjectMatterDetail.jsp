<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% String ctxPath = request.getContextPath(); %>
    
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	
	<style>
	
	
	#container1{
		width:1080px;
		margin: 0 auto;
		/* border: solid 1px gray; */
		
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
		margin-top: -200px;
		margin-bottom: 200px;
		 width: 78%;
		height: 97%; 
		float:right;
		
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
      	line-height:25px;
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
	
	<script>
	
	$(document).ready(function(){
	
		$(".sugangBtn").click(function(){
							   sugangFm
			var frm = document.sugangFm;
			frm.action = "<%= ctxPath%>/sugangInsert.up";
			frm.submit();
			
			
		});
		
	})
	
	
	</script>
</head>
<body>

	<div id="container1">
	
	 <section id="contents">
		<aside id="side_menu">
			<ul id="side_nav">
                <li><a class="lecture1"href="">전공</a></li>
            <li><a class="lecture1" href="">교양</a></li> 
            <li><a class="lecture1" href="">일반</a></li>
      
			</ul>
		</aside>
	
		<article id="main_feed" >
		<img style="width:290px; height:250px; margin:80px 0 0 80px;" class="khimg"src="<%= ctxPath %>/resources/images/${lmivOne.subImg}" />
			<h3 style="margin-right:200px; text-align: right;">Eclass의 모든 것</h3>
			<h2 style="margin-right:200px; text-align: right;">교과목명 : ${lmivOne.subName} </h2>
			<button id="sugangBtn" class='sugangBtn'>수강신청 </button>
			<hr style="border:1px color: gray; width:90%;">
			<ul id="soga">
				<li style=" font-weight:bold">강의소개<br/></li>
				<li style="list-style-type: none;"> ${lmivOne.subContent} <br/></li>
			</ul>
			<br/>
		 
		 <form name="sugangFm">
		 	-교과목 시퀀스번호 넘길때 수강신청으로 넘길때 사용합니다-<input type="text" name="subseq" value="${lmivOne.subseq}"/> <br/>
			 -로그인한 학생의 아이디가 들어갑니다- <input type="text" name="fk_userid" value="${loginuser.userid}"/>
		 </form> 
			

		</article>
		
	 </section>
	 
	<hr style="border:1px color: gray; width:100%; margin-top:80px;">
	
	</div>
	

</body>
</html>
