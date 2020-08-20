<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
	String ctxPath = request.getContextPath(); 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>후원하기 메인리스트 페이지</title>
</head>
<style>
    .Mycontainer{
        border: solid 0px #ccc;
        width: 1080px;
        margin: 0 auto;
        margin-top:0px;
        /* background-color: #FAFAFA; */
    }
	
    div.contentLine{
        padding-top: 3px;
        /* width: 120px; */
        width: 1080px;
        border-bottom: solid 3px #00BCD4;       
    }
	div#smallT, .productList {
		border: solid 0px #ccc;
		display: inline-block;
		margin: 30px;
		margin-top: 20px;
	}
	
	.smallT{
		color: purple;
	    border-bottom: 2px solid 00BCD4;
	    width: 70px;
		font-weight: normal;
		font-size: 15px;
		margin-top: 10px;
	}	
    
	.contents h3{
		margin-left: 30px;
	}
	.sub {
		font-size: 12pt;
		padding: 0px 15px;
		cursor: pointer;
		color: gray;
	} 
	#pList {
		border: solid 0px gray;
		display: inline-block;	
		margin: 0 auto;
		margin-top: 30px;
		/* margin: 50px 0 40px 50px !important; */
		
	}
	tr, td {
		border: solid 0px red;
		display: inline-block;
	}
	td {
		width: 270px;
		height: 450px;
		margin-bottom: 10px;		
		margin-right: 13px;
		margin-left: 13px;
	}
	table {
		text-align: center;
	}

	.sample_image img {
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
	.sample_image:hover img {
	    -webkit-transform:scale(1.1);
	    -moz-transform:scale(1.1);
	    -ms-transform:scale(1.1);   
	    -o-transform:scale(1.1);
	    transform:scale(1.1);
	}
	.sample_image {
		border: solid 0px skyblue;
		overflow: hidden;
	}
	.pricecolor {
		text-align: left;
	}
    a{
		text-decoration: none !important;
	}
	a:hover {
		text-decoration: none !important;
	}	
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/util/myutil.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
			
		
		// 검색 엔터시 실행가능하게 하기 
		$("#searchWord").bind("keydown", function(event){
			 if(event.keyCode == 13) {
				goSearch();
			  }
		});

   	  // 검색시 검색조건 및 검색어 값 유지시키기 
	  if(${paraMap != null}) {
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		}
		 
	  <%-- == #105. 검색어 자동완성 기능 만들기 == --%>
      $("#displayList").hide();
      
      $("#searchWord").keyup(function(){         
    	  var wordLength = $(this).val().length;
         //검색어의 길이를 알아온다          
         if( wordLength == 0 ){
       	  	$("#displayList").hide();       	 	
         }else{
        	 //ajax로 알아오기 
        	 $.ajax({
        		url:"<%= request.getContextPath()%>/donation/wordSearchShow.up", 
        		type: "GET",
        		data: {searchType:$("#searchType").val()
        			  ,searchWord:$("#searchWord").val()},
        		dataType:"JSON",
        		success : function(json){
        			<%-- == #110. 검색어 입력시 자동글 완성 기능 만들기 7 == --%>
        			if(json.length>0){ //검색된 데이터가 있는 경우  (배열안에 값이 있다라면)        				
        			
        				var html = "";
        			
        				$.each(json, function(entryIndex, item){ 
        					<%-- index는 배열 순서, item은 키값 --%>
        					<%-- item.키값  // 색주기 : word.toLowerCase().indexOf(검색어에 입력한 값)이 몇번째위치하는지 알아야함 --%>
        					var word = item.word;
        					var index = word.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() );
        					var len = $("#searchWord").val().length;
        					
        					var result = "";        					
        					        					
        					result = "<span style='color:gray'>"+word.substr(0,index)+"</span>"
        					       + "<span style='color:#00BCD4'>"+word.substr(index,len)+"</span>"
        					       + "<span style='color:gray'>"+word.substr(index+len)+"</span>";
        					
        					html += "<span style='cursor:pointer;' class='result'>"+result+"</span><br/>";
        				});
        			        			
        				$("#displayList").html(html);	
        				$("#displayList").show();
        			}
        			else{//검색된 데이터가 존재하지 않는 경우 
        				$("#displayList").hide();
        			}        			
        		},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
        	 });
        	 $("#displayList").show();
        	 
         }            
      });//end of $("#searchWord").keyup(function(){}--------------
   	  
      <%-- == #111. 검색어 입력시 자동글 완성하기 8 == --%>
      //($(document).on(이벤트,선택자,함수(){})
      $(document).on("click",".result",function(){
    	  //이벤트 버블링..관련..! 
    	  var word= $(this).text();  // alert("word: "+word); //word: JAVA로 웹페이지 만들기~
    	  $("#searchWord").val(word); //클릭시 글이 검색어에 올라옴
    	  $("#displayList").hide(); //올라오면 숨기기 
    	  goSearch();
      });         		
   	  
    });	 // end of $(document).ready(function(){})----- 
	
	//검색하기 
    function goSearch(){
    	
    	var frm = document.searchFrm;
    	frm.method = "GET";
    	frm.action = "<%= ctxPath%>/donation/donationList.up";    		
    	frm.submit();
    	
    }
</script>
<body>
	<div class="Mycontainer">
		<h2 style="margin-bottom: 1px; color:#00BCD4 "><a href='<%= ctxPath%>/donation/donationList.up' style="color:#00BCD4; text-decoration: none;">후원하기</a></h2>
        <div class="contentLine" align="center"></div>
		<div class="section" align="center">			
		<div class="productList" align="center">		
			
			<%-- === 글검색 폼 추가하기 : 글제목, 글내용으로 검색 --%> 
			<div style="height:50px; width:1000px; ">
			<form name="searchFrm" align="right" style="margin-bottom:50px;">
				<select name="searchType" id="searchType" style="height: 27px; border:solid 1px #ccc; border-radius: 2px; color:#bbb">
					<option value="subject">글제목</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchWord" id="searchWord" size="30" style="height: 25px; border-radius: 2px; border:solid 1px #ccc"autocomplete="off" /> 
				<button type="button" style="height: 25px; border:solid 1px #ccc; color:gray; border-radius: 2px" onclick="goSearch()">검색</button>
				
				 <div id="displayList" style="position: relative; z-index:1; background-color:#fff; border:solid 1px #ccc; font-size:10pt; text-align: left; border-top:0px; width:242px; height:100%; margin-left:710px; overflow:auto;">
            	 </div>
				<%-- 노트북용 자동완성 맞는 길이 
				<div id="displayList" style="position: relative; z-index:1; background-color:#fff; border:solid 1px #ccc; font-size:10pt; text-align: left; border-top:0px; width:230px; height:100%; margin-left:727px; overflow:auto;">
				</div>--%> 
			</form>
			</div>
				
			<!-- === 검색어 입력시 자동글 완성하기 ===  -->
			
			
            <table>
                <tbody id="pList" align="center">                
				
               		 <%-- 준비중이 후원 스토리가 없을 때 --%>
						<c:if test="${empty donstoryList}">
							<tr> 
								<td colspan = "3" style="color:gray; font-size: 16px;">후원 스토리 준비중입니다...<br/>조금만 기다려주세요 :)</td>
							</tr>
						</c:if>
						<c:if test="${not empty donstoryList}">
                        	<tr>    
                        	<c:forEach var="don" items="${donstoryList}" varStatus="status">                  
                                <td class="pricecolor">
                                    <a href='<%= ctxPath%>/donation/donationStory.up?donseq=${don.donseq}'>     
                                                                       
                                        <c:if test="${empty don.listMainImg}">  
                                        <div style="width:250px; height:350px;" class="sample_image">                                    
                                        	<img style="width:100%; height:100%;" src="<%= ctxPath%>/resources/images/donation/${don.orgListMainImg}" />
										</div>
										</c:if>  
										
										<c:if test="${not empty don.listMainImg}">   
										<div style="width:250px; height:350px;" class="sample_image">                                   
                                        	<img style="width:100%; height:100%;" src="<%= ctxPath%>/resources/files/${don.listMainImg}" />
										</div>
										</c:if> 
										
                                        <br/><span style="font-size:12.5pt; letter-spacing: 0.4px; color:#333;">
                                        	${don.subject}</span>
                                        
                                        <div style="border-bottom: solid 2px #00BCD4; width: 248px; padding: 3px 0 0 0"></div>
                                            
                                        
                                       	<c:if test="${don.dDay<=0}">
                                       	<span style="color: #00BCD4; font-weight: bold; font-size: 18px;">후원종료</span>
                                       	</c:if>
                                       	<c:if test="${don.dDay>0}">
                                       	<span style="color: #00BCD4; font-weight: bold; font-size: 18px;">D-${don.dDay}</span>
                                       	</c:if>                                            
										<%-- <fmt:formatNumber value="${(don.totalPayment)/don.targetAmount}" pattern="0.0%"/>  --%>  
                                        <span style="float:right; padding-top:3px; padding-right:25px; color: #bbb; font-weight: bold; font-size: 16px;">목표금액 <fmt:formatNumber value="${don.targetAmount}" pattern="###,###"/>원 </span>                                                                                        
                                        
                                    </a>
                                </td> 
                                
                               <c:if test="${(status.count)%3 == 0 }">
                                    </tr>
                                     <tr style="margin-top:40px;">
                                </c:if> 
							</c:forEach>
                        	</tr> 
                    	</c:if>
                </tbody>
            </table>
			
			<%-- === 페이지바 === --%>
			<div align="center" style="width:70%; border:solid 0px gray; margin:13px auto;">${pageBar}</div>
			<%-- === 글쓰기 === --%>
			<c:if test="${sessionScope.loginuser.identity==3}">
			<div>
				<button type="button" style="margin-left: 700px; width: 100px; border:solid 1px #ddd; background-color:#fafafa; color:gray; border-radius:3px">
					<a href="<%=ctxPath%>/donation/donationStoryAdd.up" style="color:gray; text-decoration: none;">글쓰기</a>
				</button>
			</div>	
			</c:if>
			
				</div>
			</div>		
		</div>
	</div>
</body>