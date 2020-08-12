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
  width: 190px; 
  height: 40px;
  background-color: #00BCD4; 
  /* margin-left: 30px; */
  line-height: 40px;
 /*  margin-top: 18px; */
  cursor: pointer;
  color: white;
  font-weight: bold;
  font-size: 15pt;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 190px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  padding: 12px 16px;
  cursor: pointer;
  color: #ccc;
  
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
   color: #fafafa; 
   font-weight: bold; 
   background-color: #00BCD4;
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

<!-- header 전체를 감싸는 div / 가로사이즈 지정 -->
<div style=" width: 1080px;  height: 200px; margin: 0 auto; padding-top:10px;"><br>

<!-- header 중앙에 표시되는 로고  -->
   <img class="logo" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/logo.png" />">

<!-- 우측상단 미니메뉴바  -->
<c:if test="${sessionScope.loginuser != null}">
<span class="minimenu"><a href="<%=ctxPath%>/login/logout.up">로그아웃</a></span>
</c:if>
<c:if test="${sessionScope.loginuser == null}">
<span class="minimenu"><a href="<%=ctxPath%>/login/login.up">로그인</a></span>
</c:if>
<span class="minimenu"><a>1:1상담</a></span>
<span class="minimenu"><a href="admin.up">관리자</a></span><br>
<c:if test="${sessionScope.loginuser != null}">

<div style="border: solid 1px red; width: 300px; text-align: right;">
   <span style="color: navy; font-weight: bold; font-size: 10pt;">${sessionScope.loginuser.name}</span> 님 로그인중..
</div>

</c:if>

   <!-- =====================================================================  -->
   
   <!-- 메뉴바가 담겨져 있는 div -->
   <div style="width: 1000px; height:70px; margin: 0 auto; text-align: center; margin-top: 20px;">
      
      <div class="dropdown">
        <span>강의리스트</span>
        <div class="dropdown-content">
           <p class="downmenu">내용</p>
           <p class="downmenu">내용</p>
        </div>
      </div>      
      
      <div class="dropdown">
        <span>내 강의실</span>
        <div class="dropdown-content">
        <!-- 학생이라면 -->
        <p class="downmenu">나의 수업</p>
        <p class="downmenu">시험</p>
        
        <!-- 교수라면 -->
        <p class="downmenu">강의 개설</p>
        <p class="downmenu">시험 출제</p>
        </div>
      </div>
      
      <div class="dropdown">
        <span>커뮤니티</span>
        <div class="dropdown-content">
        <span class="downmenu"><a href="<%=ctxPath%>/freeboard.up">자유게시판</a></span><br>
        <span class="downmenu"><a href="<%=ctxPath%>/notice.up">공지사항</a></span><br>
        <span class="downmenu"><a href="<%=ctxPath%>/question.up">Q&A</a></span>
        </div>
      </div>
      
      <div class="dropdown">
        <span>후원</span>
        <div class="dropdown-content">
        <p class="downmenu">내용</p>
        <p class="downmenu">내용</p>
        </div>
      </div>
      
      <div class="dropdown">
        <span>마이페이지</span>
        <div class="dropdown-content">
        <!-- 학생이라면 -->
         <c:if test="${sessionScope.loginuser.identity == 1}">
               <p class="downmenu"><a href="<%=ctxPath%>/mypageMain.up">마이페이지</a></p>
             <p class="downmenu"><a href="<%=ctxPath%>/attandS.up">출석현황</a></p>
             <p class="downmenu"><a href="<%=ctxPath%>/gradeS.up">성적관리</a></p>
             <p class="downmenu"><a href="<%=ctxPath%>/">정보수정</a></p>
          </c:if>
        
        <!-- 교수라면 -->
        <c:if test="${sessionScope.loginuser.identity == 2}">
            <p class="downmenu"><a href="<%=ctxPath%>/mypageMain.up">마이페이지</a></p>
            <p class="downmenu"><a href="<%=ctxPath%>/studentP.up">학생관리</a></p>
            <p class="downmenu"><a href="<%=ctxPath%>/">시험출제</a></p>
            <p class="downmenu"><a href="<%=ctxPath%>/">강의등록</a></p>
            <p class="downmenu"><a href="<%=ctxPath%>/">교과목등록</a></p>
            <p class="downmenu"><a href="<%=ctxPath%>/">정보수정</a></p>
          </c:if>
          
        </div>
      </div>
      
   </div>   
   <br>
         
</div>
<br>