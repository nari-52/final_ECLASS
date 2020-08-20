<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<%-- ======= #27. tile1 중 footer 페이지 만들기  ======= --%>

<!-- footer 전체를 감싸는 div -->
<div>
<div style="width: 1080px; height:250px;  margin: 0 auto; border-top: solid 1px #ccc; padding-top: 20px; ">

<div style="width: 1080px; height:250px;">
   <div style=" width: 535px; float: left; height: 300px; padding-left:10px">   
   <img style="width: 250px; height:83px;" onclick="javascript:location.href='<%=ctxPath%>/index.up'" src="<c:url value="/resources/images/index/logo.png" />"><br>
   <span style="color: gray; line-height: 30px; letter-spacing: 0.8px;">상호명: ECLASS &nbsp;|&nbsp;
       사업자등록번호 : 123-45-67890 <br/>
       본사: 서울특별시 중구 남대문로 120 대일빌딩 2F<br/>
   Copyright ⓒ 2020 ECLASS Educational All Right Reserved
   </span>
   </div>
   
   <div style="width: 500px; float: right; height: 300px;  padding-left: 32px; letter-spacing: 1px">
   
   <span style="color: gray; line-height: 30px; margin-top: -20px; display: inline-block;"><br>
   <span style="color: gray; font-size: 25pt; ">고객센터</span>&nbsp;
   <img style="padding-top:2px;" src="<c:url value="/resources/images/index/phone.png" />">&nbsp;<span style="font-size: 23pt; color: gray;">1544-1544</span><br> <br />
   Email: eclass@gmail.com | 관리자: 오구오구 <br/>
      상담시간 10:00 ~ 17:00  (점심시간  12:00 ~ 13:00) <br>
      일요일/공휴일 휴무<br/>
   </span>
   </div>
</div>
</div>

</div>    
</html>