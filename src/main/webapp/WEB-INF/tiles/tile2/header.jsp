<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value="/resources/css/font.css" />" rel="stylesheet" type="text/css" />

<%-- ======= #27. tile1 중 header 페이지 만들기  ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #158. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기   ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
   //System.out.println("serverIP : " + serverIP);
   // serverIP : 192.168.56.50
   
   serverIP = "192.168.50.45";
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
   //System.out.println("portnumber : " + portnumber);
   // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
   //System.out.println("serverName : " + serverName);
   //serverName : http://192.168.50.65:9090 
%>


<style type="text/css">
.dropdown {
  position: relative;
  display: inline-block;
  /* border: solid 1px gray;  */
  width: 210px; 
  height: 40px;
  background-color: white; 
  /* margin-left: 30px; */
  line-height: 40px;
 /*  margin-top: 18px; */
  cursor: pointer;
  color: #333;
  font-weight: bold;
  font-size: 15pt;
  border-left: solid 1px #ccc; 
}

.dropdown:hover{
	text-decoration: underline;
	color: #00BCD4;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 180px;
  /* box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); */
  padding: 12px 16px;
  cursor: pointer;
  color: #333;
  opacity: 0.9;
  
}

.dropdown:hover .dropdown-content {
  display: block;
}

.minimenu{
   display: inline-block; 
   float: right; 
   /* border: solid 1px red;  */
   margin-right: 20px;
   cursor: pointer;
   font-weight: bold;
   text-align: center;
}

.logo:hover{
   text-decoration: none;
   color:black;
   cursor: pointer;
}

.logo{
   width: 250px; 
   margin-left:405px; 
   height: 75px; 
   display: inline-block;
}

.moveColor {
   color: #00BCD4; 
   font-weight: bold; 
   /* background-color: #00BCD4; */
}

a{
	text-decoration: none;
	color: #333;
}


a.minim{
	text-decoration: none;
	font-size: 10pt;
	display: inline-block; 
	text-align: center; 
}

a:link{
	color: #333;
}

a:visited{
	color: #333;	
}

a:hover{
   color: #00BCD4; 
}


</style>

<script type="text/javascript">
   
   $(document).ready(function(){
      
      $(".downmenu").hover(function(){
                     $(this).addClass("moveColor");
                       }, 
                       function(){
                          $(this).removeClass("moveColor"); 
                       }
      );
      
   });

</script>

<html>
<body style="margin: 0;">
<!-- header 전체를 감싸는 div / 가로사이즈 지정 -->
<div style="width:1080px; height: 200px; margin: 0 auto; padding-top:10px;"><br>

<!-- header 중앙에 표시되는 로고  -->
<c:if test="${sessionScope.loginuser.identity == 1}">
   <img class="logo" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/index/logo.png" />">
</c:if>

<c:if test="${sessionScope.loginuser.identity == 2}">
   <img class="logo" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/index/logo.png" />">
</c:if>

<c:if test="${empty sessionScope.loginuser}">
   <img class="logo" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/index/logo.png" />">
</c:if>

<c:if test="${sessionScope.loginuser.identity == 3}">   
   <img class="logo" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/index/adminlogo.jpg" />">
</c:if>

<!-- 우측상단 미니메뉴바  -->

<c:if test="${sessionScope.loginuser != null}">
	<span class="minimenu"><a class="minim" href="<%=ctxPath%>/login/logout.up"><img  src="<c:url value="/resources/images/index/logout.png" />"><br>로그아웃</a></span>
</c:if>
<c:if test="${sessionScope.loginuser == null}">
	<div class="minimenu"><a class="minim" href="<%=ctxPath%>/login/login.up"><img src="<c:url value="/resources/images/index/login.png" />"><br>로그인</a></div>
</c:if>
<div class="minimenu"><a class="minim" href="<%=ctxPath%>/board/question.up"><img style="width: 24px; height: 24px;" src="<c:url value="/resources/images/index/qa3.png" />"><br>Q&A</a></div>
<c:if test="${sessionScope.loginuser.userid == 'admin'}">
	<span class="minimenu"><a class="minim" href="<%=ctxPath%>/admin.up""><img  src="<c:url value="/resources/images/index/admin.png" />"><br>관리자</a></span>
</c:if>

   <!-- =====================================================================  -->
   
   <!-- 메뉴바가 담겨져 있는 div -->
   <div style="width: 1080px; height:70px; margin: 0 auto; text-align: center; margin-top: 20px; position: relative; z-index:1;" >
      
      <div class="dropdown">
        <span onclick="javascript:location.href='<%=ctxPath%>/SubjectMatterList.up'">강의목록</span>
      </div>      
      
      <div class="dropdown">
         <span onclick="javascript:location.href='<%=ctxPath%>/lecture/myLecture.up'">내 강의실</span> 
      </div>
      
      <div class="dropdown">
        <span>커뮤니티</span>
        <div class="dropdown-content">
        <a class="downmenu" href="<%=ctxPath%>/freeboard.up">자유게시판</a><br>
        <a href="<%=ctxPath%>/board/notice.up">공지사항</a><br>
        <a href="<%=ctxPath%>/board/question.up">Q&A</a>
        </div>
      </div>
      
      <div class="dropdown">      
        <span onclick="javascript:location.href='<%=ctxPath%>/donation/donationList.up'">후원하기</span>
      </div>
      
      <div class="dropdown" style="border-right: solid 1px #ccc;">
      	<c:if test="${empty sessionScope.loginuser}">
           <span onclick="javascript:location.href='<%=ctxPath%>/mypageMain.up'">마이페이지</span>
           </c:if>
      	
      	<c:if test="${sessionScope.loginuser.identity == 1}">
           <span onclick="javascript:location.href='<%=ctxPath%>/mypageMain.up'">마이페이지</span>
        </c:if>
           
        <c:if test="${sessionScope.loginuser.identity == 2}">
          <span onclick="javascript:location.href='<%=ctxPath%>/mypageMain.up'">마이페이지</span>
        </c:if>
          
          <!-- 관리자 라면 -->    
           <c:if test="${sessionScope.loginuser.identity == 3}">
           <span>회원관리</span>
           <div class="dropdown-content">
		       <a href="<%=ctxPath%>/admin/member_studentList.up">학생관리</a><br>
		       <a href="<%=ctxPath%>/admin/member_professorList.up">교수관리</a>
	       </div>
           </c:if> 
                   
        </div>
      </div>
      
   </div>  
         
</div>
