<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style type="text/css">

	.sidenav {
	  width: 200px;
	  background: #fafafa;
	  overflow-x: hidden;
	  padding: 8px 0;
	  display: inline-block;
	  border: solid 0px blue;
	  float: left;
	  height: 700px;
	}
	
	.sidenav a {
	  padding: 6px 8px 6px 16px;
	  text-decoration: none;
	  font-size: 20px;
	  color: #00BCD4;
	  display: block;
	}
	
	.sidenav a:hover {
	  color: #064579;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		
	}); // end of ready(); ---------------------------------
</script>
 	<c:if test="${sessionScope.loginuser.identity == 1}">
		<div class="sidenav">
		  <a href="<%=ctxPath%>/mypageMain.up"><span id="myM">마이페이지</span></a>
		  <a href="<%=ctxPath%>/attandS.up"><span id="myA">출석현황</span></a>
		  <a href="<%=ctxPath%>/gradeS.up"><span id="myG">성적관리</span></a>
		  <a href="<%=ctxPath%>/member/updateMember.up">정보수정</a>
		  <a href="<%=ctxPath%>/member/delMember.up">회원탈퇴</a>
		</div>
	</c:if>

 	<c:if test="${sessionScope.loginuser.identity == 2}">
		<div class="sidenav">
		  <a href="<%=ctxPath%>/mypageMain.up"><span id="mym">마이페이지</span></a>
		  <a href="<%=ctxPath%>/studentP.up"><span id="myS">학생관리</span></a>
		  <a href="<%=ctxPath%>/SubjectMatter_insert.up"><span id="mySI">교과목등록</span></a>
		  <a href="<%=ctxPath%>/member/updateMember.up">정보수정</a>
		  <a href="<%=ctxPath%>/member/delMember.up">회원탈퇴</a>
		</div>
	</c:if>
    