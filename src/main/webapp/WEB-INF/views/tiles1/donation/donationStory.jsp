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
		/*background-color: #fcfcfc;*/
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
    #copy_btn{
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
    .contentStoryStart img{
		width : 1000px;
		position: inherit; top:0; left: 0;
		height: 100%;
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
        $("#copy_btn1").click(function(){
    		$('#copy_text_input').select(); //복사할 텍스트를 선택
    		document.execCommand("copy"); //클립보드 복사 실행
    		alert('URL이 복사되었습니다');
    	})
    	
    	
    	$("#del").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
				goDel();
			}
			else{
				alert("삭제가 취소되었습니다.");
				return;
			}			
		});
        
	});//end of  $(document).ready(function(){}) ---------
	
	function goPayment(donseq){
		var strdDay = ${donstoryPage[0].dDay};
		console.log("strdDay"+strdDay);
		if(strdDay <= 0){
			alert("후원 모집기간이 끝났습니다. 감사합니다");
			return;
		}
		location.href = "<%= ctxPath%>/donation/donationPayment.up?donseq="+donseq;
	}
	
	//글 삭제하기 
	function goDel(){	
		
		
		// 폼(form) 을 전송(submit)
		var frm = document.delFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/donation/donationStoryDel.up";
		frm.submit();
		
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
						<c:if test="${empty donstoryPage[0].storyImg}">
						<div class="donImg">
							<img src="<%= ctxPath%>/resources/images/donation/${donstoryPage[0].orgStoryImg}" />
						</div>
						</c:if> 
						
						<c:if test="${not empty donstoryPage[0].storyImg}">
						<div class="donImg">
							<img src="<%= ctxPath%>/resources/files/${donstoryPage[0].storyImg}" />
						</div>
						</c:if> 
						
						<div class="donInfo-table">						
						<dl style="margin: 20px 0;">
	                    <c:choose>
	                       <c:when test="${(donstoryPage[0].dDay-1)> 0}">
							<dt style="color:#00BCD4">${donstoryPage[0].dDay}일 남음 </dt>
						   </c:when>
						   <c:when test="${(donstoryPage[0].dDay-1)==0}">
	                       	<dt style="color:#00BCD4">오늘 종료</dt>
	                       </c:when>  
	                      <%--  <c:when test="${(donstoryPage[0].dDay-1)<0 && (donstoryPage[0].totalPayment >= donstoryPage[0].targetAmount) }">
	                       	<dt style="color:#00BCD4">후원 성공</dt>
	                       </c:when>  --%> 
						   <c:when test="${(donstoryPage[0].dDay-1)<0 && (donstoryPage[0].dDay-1)!=0}">
	                       	<dt style="color:#00BCD4">후원 종료</dt>
	                       </c:when>            
	                      </c:choose>
	                      <div style="border-bottom: solid 4px #00BCD4; width: 120px; padding-bottom: 3px;"></div>
	                    </dl>
	                    	                                               
						<dl class="underLine">
							<dt><fmt:formatNumber value="${(donstoryPage[0].totalPayment)/donstoryPage[0].targetAmount}" pattern="0.0%"/>달성</dt>
						</dl>
						<dl class="underLine">							
							<dt><fmt:formatNumber value="${donstoryPage[0].totalPayment}" pattern="###,###"/>원 후원</dt>
						</dl>                         
						<dl>
							<dt>${donstoryPage[0].totalSupporter}명의 후원자</dt>
						</dl>
                        <span class="btn_donation" onclick="goPayment('${donstoryPage[0].donseq}')">후원하기</span>
                        
                        <!-- modal 구동 버튼 (trigger) -->
						<button type="button" id="copy_btn" class="btn btn-primary btn_share" data-toggle="modal" data-target="#myModal">
						  공유하기
						</button>
						
						<!-- Modal -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        <h4 class="modal-title" id="myModalLabel">공유하기 URL</h4>
						      </div>
						      <div class="modal-body">
       		                  <input type="text" id="copy_text_input" value="localhost:9090/eclass/donation/donationStory.up?donseq=${donstoryPage[0].donseq}" class="form-control" />
                       		  </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal" id="copy_btn1">복사하기</button>
						      </div>
						    </div>
						  </div>
						 </div>
                        
                        
                        
						</div> 
					</c:if> 
                </div>
                
				</div>
                <div class="contentStoryStart">
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
                
                <div class="donInfo-div" style="border: solid 0px red; padding: 30px; color:gray" >
                <div class="contentStoryImage" style="display: inline-block; border: solid 0px orange; margin-top:20px; width:1000px;">
					<c:if test="${empty donstoryPage}">
						<tr> 
							<td colspan = "3" style="color:gray; font-size: 16px;">후원 스토리 준비중입니다...조금만 기다려주세요 :)</td>
						</tr>
					</c:if>     
					<c:if test="${not empty donstoryPage}">   
						<c:forEach var="don" items="${donstoryPage}">		
						
							<c:if test="${empty don.donImg}">								
						 		<dt></dt>
							</c:if>	
							<c:if test="${not empty don.donImg}">	
														
						 		<dt><img style="display:block; width:1000px; height:100%; position: inherit; top:0; left: 0; overflow:auto" src="<%= ctxPath%>/resources/images/donation/${don.donImg}" /></dt>
							</c:if>	
						</c:forEach>
					</c:if>
				</div>
				
				<c:if test="${not empty donstoryPage}">
					<h3>${donstoryPage[0].content}</h3>
					<!--
					후원은 교육을 이어나갈수 있는 동기가 되기도 합니다.
					후원은 희망교실 아이들에게 소중한 한 끼입니다.<br />3살이 채 안된 아이가 급식을 먹기 위해 
					언니의 손을 잡고 학교에 오기도 합니다. 먼 거리를 걸어 희망교실에 오는 아이들은 <br />
					친구들과 즐거운 시간을 보내기도 하고, 두 눈을 반짝이며 수업을 듣기도 하지만 제일 기다리는 것은 바로 학교 점심 시간입니다.<br />
					희망교실에 다니는 아이들은 대부분 넉넉하지 않은 형편 때문에 집에서 제대로 된 식사가 어려워 희망교실에서 주는 급식으로 한 끼를
					해결하곤 합니다. <br/> 학교 급식은 아이들의 성장 뿐 아니라 학교에 와야하는 이유가 되어 출석률을 높이고 학습 능력을 향상
					시키는데 중요한 역할을 합니다.
					<br /> 아이들을 위한 남은 후원금은 다음 활동에 더욱 의미있게 사용하도록 하겠습니다.

					<h3>코로나19 아이들의 든든한 하루를 응원해주세요</h3>
					아프리카아시아난민교육후원회는 희망교실 아이들이 균형잡힌 식단으로 건강하게 성장할 수 있도록 14개국 희망교실 아이들의
					급식을 지원하고 있지만 <br/>그 많은 아이들에게 충분한 급식을 제공하기엔 여전히 어려운 상황입니다. 자라나는 아이들에게 균형
					잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 <br />건강하게 공부할 수 있도록 아이들의 든든한 하루를 함께 응원해주세요.
					다른 지원을 통해 더 큰 피해를 막고, 피해 지역 아동과 가정이 재난상황을  <br /> 하루빨리 극복할 수 있도록 많은 관심과 후원
					부탁드립니다. 자라나는 아이들에게 균형 잡힌 따뜻한 한 끼를 선물해 끼니 걱정 없이 건강하게 공부할 수 있도록 <br />아이들의 든든한 하루를 함께 응원해주세요.<br /> <br /> 
					 -->
				</div>
				</c:if>	  
				</div>
				<c:if test="${sessionScope.loginuser.identity==3}">
				<div style="margin: 0 auto;">
				<button type="button" style="margin:20px 5px; width: 100px; border:solid 1px #ddd; background-color:#fafafa; color:gray; border-radius:3px">
					<a href="<%=ctxPath%>/donation/donationStoryEdit.up?donseq=${donstoryPage[0].donseq}" style="color:gray; text-decoration: none;">글수정</a>
				</button>
				<button id="del" type="button" style="margin:20px 5px; width: 100px; border:solid 1px #ddd; background-color:#fafafa; color:gray; border-radius:3px">
					글삭제
				</button>
				<form name="delFrm">
					<input type="hidden" name="donseq" value="${donstoryPage[0].donseq}"/>
				</form>
				</div>	
			    </c:if>       
		</div>
	</div>
</body>
</html>