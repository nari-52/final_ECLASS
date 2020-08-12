<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>donationStory</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
    .Mycontainer{
        border: solid 0px #ccc;
        width: 1080px;
        margin: 0 auto;
        /*background-color: #E5E5E5;*/
    }
    div.contentLine{
        padding-top: 0px;
        width: 1080px;
        border-bottom: solid 2px #00BCD4;         
    }
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
	}	
	.info{
        border: solid 0px pink;
		display:inline-block;
		width: 1000px;
	}	
	/*기부 이미지가 보이는 div*/
	.donImg{		
		display: inline-block;
		width: 600px;
        height: 400px;
        border:solid 0px red;
        float: left;
        margin-right: 40px;
	}	
	
	.donImg img{
		position: inherit; top:0; left: 0;
		width: 100%;
		height: 100%;
	}
		
	/*기부 이미지의 옆에 나오는 기부 정보가 들어가 있는 div*/
	.donInfo-table{
		display: inline-block;
		width:350px;
		text-align: left;
        font-size: 20pt;
        border: solid 1px #ccc;
        padding-left:30px;
        padding-bottom: 30px;
        margin-bottom: 20px;
        border-radius: 5px;
	}	
	
	/*기부 정보가 나열된 리스트에서 각각의 항목 부분의 태그*/
	dt{		
		display: inline-block;
		width: 300px;		
	}
	
	/*기부 정보가 나열된 리스트에서 각각의 내용 부분의 태그*/
	dd{
		margin-left:-10px;
		display: inline-block;
		width: 380px;		
	}
	
    .contentStoryImage{
        border: solid 1px #ccc;
        width: 1080px;
        height: 500px;
    }
    .contentStoryHeaderText{
    	margin-top:20px;
    	background-color: #fcfcfc;
    	text-align: left;
    	padding: 45px;
    	color: #333;
    	font-size : 10pt;
    	border: solid 0px orange;
    	border-bottom : solid 2px #00BCD4;
    	line-height: 23px;
    }
	.donInfo-div{
		background-color: #fcfcfc;
		text-align: left;
		line-height: 30px;
		border-top : solid 1px #f4f4f4;
		border-bottom : solid 1px #f4f4f4;
		margin-bottom: 5px;		
	}	
	
	.detail_img{
		display: inline-block;
		width: 100px;
		height: 100px;
		margin-left: 50px;
		border: solid 1px black;
	}
	
	.btn_area{
		margin-top:30px;
	}
    
    .btn_donation{
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
	}
    .btn_share{
        display: inline-block;
		width: 278px;
		height: 52px;
		padding-top: 12px;
		text-align: center;
		background-color: #fff;
		color: #aaa;
		font-size: 20px;
		font-weight: 550;
		border-radius: 5px;
        margin-top: 10px;
		cursor: pointer; 
        border:solid 1px #ccc;
    }    
    /* 스토리, 후원자 누르는 내비부분 */
    .contentNavi{
        height: 50px;
        border-bottom: solid 0px #ccc;
        margin: 0 auto;
        text-align: center;
        padding-top: 10px;
        background-color: #fcfcfc;
    }
    .contentNaviFont{
        font-size: 16pt;
        border: solid 0px #ccc;
        padding: 0 15px;
        margin: 0 30px;
    }
    .contentNaviFontClick{
        color: #00BCD4;
        padding-bottom: 8px;
        border-bottom: solid 3px #00BCD4;
    }
    a{
		text-decoration: none !important;
	}
	a:hover {
		text-decoration: none !important;
        color: #00BCD4;
	}	
    
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/util/myutil.js"></script>
<script type="text/javascript">
	
    $(document).ready(function(){
		
        /*스토리,후원자 내비게이션 효과*/
        $(".StoryNaviFnt").click(function(){
            $(this).addClass("contentNaviFontClick");
            $(".SopportNaviFnt").removeClass("contentNaviFontClick");
        });
        $(".SopportNaviFnt").click(function(){
            $(this).addClass("contentNaviFontClick");
            $(".StoryNaviFnt").removeClass("contentNaviFontClick");
        });
        
        //공유하기 버튼 클릭시 
        $("#copy_btn").click(function(){
    		$('#copy_text_input').select(); //복사할 텍스트를 선택
    		document.execCommand("copy"); //클립보드 복사 실행
    		alert('URL이 복사되었습니다');
    	})
        
	});//end of  $(document).ready(function(){}) ---------
	
	function goPayment(donseq){
	    location.href = "<%= ctxPath%>/donation/donationPayment.up?donseq="+donseq;
	}
	

	
</script>
</head>
<body>
	<div class="Mycontainer">
        <h2 style="margin-bottom: 1px; color:#00BCD4 "><a href='<%= ctxPath%>/donation/donationList.up' style="color:#00BCD4; text-decoration: none;">후원하기</a></h2>
        <div class="contentLine" align="center"></div>
        <div class="contentNavi">
            <span class="contentNaviFont StoryNaviFnt"><a href='<%= ctxPath%>/donation/donationStory.up?donseq=${donstoryPage[0].donseq}'>스토리</a></span>|            
            <span class="contentNaviFont SopportNaviFnt"><a href='<%= ctxPath%>/donation/donationSupporter.up?donseq=${donstoryPage[0].donseq}'>후원자</a></span>
        </div>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
				</div>
				<div class="info">				
					<%-- 준비중이 후원 상세 스토리가 없을 때 --%>
					<c:if test="${empty donstoryPage}">
						<tr> 
							<td colspan = "3" style="color:gray; font-size: 16px;">후원 스토리 준비중입니다...<br/>조금만 기다려주세요 :)</td>
						</tr>
					</c:if>
					<c:if test="${not empty donstoryPage}">
						<div class="donImg">
							<img src="<%= ctxPath%>/resources/images/${donstoryPage[0].storyImg}" />
						</div>
						<div class="donInfo-table">
	                        <dl style="margin: 20px 0;">
	                        <c:if test="${(donstoryPage[0].dDay-1)<0 && (donstoryPage[0].totalPayment)>=(donstoryPage[0].targetAmount)}">
	                        	<dt style="color:#00BCD4">후원 성공</dt>
	                        </c:if>
	                        <c:if test="${(donstoryPage[0].dDay-1)<0 && (donstoryPage[0].totalPayment)<(donstoryPage[0].targetAmount)}">
	                        	<dt style="color:#00BCD4">후원 종료</dt>
	                        </c:if>
	                        <c:if test="${(donstoryPage[0].dDay-1)==0}">
	                        	<dt style="color:#00BCD4">오늘 종료</dt>
	                        </c:if>
	                         <c:if test="${(donstoryPage[0].dDay-1)> 0}">
								<dt style="color:#00BCD4">${donstoryPage[0].dDay}일 남음</dt>
							</c:if>															
								<div style="border-bottom: solid 4px #00BCD4; width: 120px; padding-bottom: 3px" align="center"></div>
	                        </dl>
	                                               
							<dl class="underLine">
								<dt><fmt:formatNumber value="${(donstoryPage[0].totalPayment)/donstoryPage[0].targetAmount}" pattern="0.0%"/>달성</dt>
							</dl>
							<dl class="underLine">							
								<dt><fmt:formatNumber value="${donstoryPage[0].totalPayment}" pattern="###,###"/>원 펀딩</dt>
							</dl>                         
							<dl>
								<dt>${donstoryPage[0].totalSupporter}명의 후원자</dt>
							</dl>
	                        <span class="btn_donation" onclick="goPayment('${donstoryPage[0].donseq}')">후원하기</span>
	                        <span class="btn_share" id="copy_btn">공유하기</span>
	                        <input type="hidden" id="copy_text_input" value="http://localhost:9090<%= ctxPath%>/donation/donationStory.up?donseq=${donstoryPage[0].donseq}" class="form-control">
	                        
						</div> 
					</c:if> 
                </div>
                
				</div>
                <!--<div class="contentLine" align="center"></div> -->
                <div class="contentStoryHeaderText">
                	<span style="font-weight:bold; color:#00BCD4; font-size:12pt">
                	목표금액 : <fmt:formatNumber value="${donstoryPage[0].targetAmount}" pattern="###,###"/>원  <br/>                  
                	                	
                	<fmt:parseDate var="donDate" pattern="yyyy-MM-dd HH:mm:ss" value="${donstoryPage[0].donDate}" />
                	<fmt:parseDate var="donDueDate" pattern="yyyy-MM-dd HH:mm:ss" value="${donstoryPage[0].donDueDate}" />
                	<fmt:formatDate value="${donDate}" var="donDate" pattern="yyyy-MM-dd"/>
                	<fmt:formatDate value="${donDueDate}" var="donDueDate" pattern="yyyy-MM-dd"/>
                	펀딩기간 : <c:out value="${donDate}" /> - <c:out value="${donDueDate}" /> <br/> 
                	</span>
                	100% 이상 모이면 펀딩이 성공되는 프로젝트<br/>
					이 프로젝트는 펀딩 마감일까지 목표 금액이 100% 모이지 않으면 결제가 진행되지 않습니다.<br/>
                </div>
                
                <div class="contentStoryImage" style="border: solid 1px orange; margin-top:20px;">
						<c:if test="${empty donstoryPage}">
						<tr> 
							<td colspan = "3" style="color:gray; font-size: 16px;">후원 스토리 준비중입니다...조금만 기다려주세요 :)</td>
						</tr>
					</c:if>     
					<c:if test="${not empty donstoryPage}">   
						<c:forEach var="don" items="${donstoryPage}">												
						 		<dt><img style="width:100%; height:100%; overflow:auto" src="<%= ctxPath%>/resources/images/${don.donImg}" /><br/></dt>
						</c:forEach>
					</c:if>
				</div>
				<c:if test="${not empty donstoryPage}">
                <div class="donInfo-div" style="border: solid 0px red; padding: 45px; color:gray" > 
                	${donstoryPage[0].content} <br/>
				        서포터분들과 봉사자들의 따뜻한 마음 덕분에 경남 산청 참포도아동센터에서의 벽화활동을 무사히 마칠 수 있었습니다. <br/><br/>
				        서포터분들의 후원금은 2박 3일간 진행된 벽화봉사에 필요했던 벽화물품을 구입하고, 봉사자분들의 식비에 일부 지원이 되었습니다. <br/>
				        남은 후원금은 다음 여름활동에서 더욱 의미있게 사용하도록 하겠습니다. <br/>
				        아이들을 위한 벽화모임 Love On the Wall, 앞으로도 관심있게 지켜봐주세요:) <br/>
				</div> 
				</c:if>	              
		</div>
	</div>
</body>
</html>