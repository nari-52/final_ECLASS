<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<% 
   String ctxPath = request.getContextPath();
   //       /board
%>

<style>

ul { list-style:none;
padding-inline-start: 0px;}
a { text-decoration:none;}
img { border:none; vertical-align:top;}

.carousel{
    width: 550px; margin: 0 auto;
    position: relative;
}

.carousel .view{
    width: 450px; margin: 0 auto;
    background-color: white;
    overflow: hidden;
}

.carousel .view .list{
    width: 3240px; margin-left: -1080px;
}
.carousel .view .list:after{content: "";display: block;clear: both;}

.carousel .view .list > li{
    float:left;
}
.carousel .view .list > li ul:after{content: "";display: block;clear: both;}

.carousel .view .list > li ul li{
    float: left;
    width: 333px; height: 333px;
   /*  margin-left: 10px; margin-right: 10px; */
}
.carousel .view .list > li ul li.a1{background-color: red;} 
.carousel .view .list > li ul li.a2{background-color: green;} 
.carousel .view .list > li ul li.a3{background-color: gray;} 
.carousel .view .list > li ul li.a4{background-color: darkgray;}
.carousel .view .list > li ul li.a5{background-color: firebrick;} 
.carousel .view .list > li ul li.a6{background-color: purple;} 
.carousel .view .list > li ul li.a7{background-color: orange;} 
.carousel .view .list > li ul li.a8{background-color: blue;} 
.carousel .view .list > li ul li.a9{background-color: blueviolet;} 

.carousel .prev{
    position: absolute; width: 50px; height: 25px; color:#black;
    left: 0; top: 48%;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    -o-transform:translateY(-50%);
    transform: translateY(-50%);
    opacity: 0.5;
}

.carousel .next{
    position: absolute; width: 50px; height: 25px;  color:#black;
    right: 0; top: 48%;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    -o-transform:translateY(-50%);
    transform: translateY(-50%);
    opacity: 0.5;
    text-align: right;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


.c_wrap {
  width: 1438px;
  margin: 0 auto;
  padding: 0px;
  position: relative;
  margin-top: -40px;
  margin-left: -8px;
}

.carousel2 {
  width: 1438px;
  margin: 0 auto;
  overflow: hidden;
}

.carousel2 .list2 {
  width: 5752px;
  margin-left: -1438px;
}

.carousel2 .list2:after {
  content: "";
  display: block;
  clear: both;
}

.carousel2 .list2 li {
  float: left;
  height: 429px;
  width: 1438px;
  color: white;
  font-size: 50px;
}

.carousel2 .list2 li.a1 {
  background-color: red;
}

.carousel2 .list2 li.a2 {
  background-color: blue;
}

.carousel2 .list2 li.a3 {
  background-color: green;
}

.carousel2 .list2 li.a4 {
  background-color: gray;
}

.prev2 {
  position: absolute;
  left: 0px;
  width: 70px;
  height: 420px;
  top: 10%;
  color: #fff;
  margin-top: -25px;

}

.next2 {
  position: absolute;
  right: 0px;
  top: 10%;
  width: 70px;
  height: 420px;
  color: #fff;
  margin-top: -25px;
}

.next2:hover{
 background-color: #ccc;
 opacity: 0.1;
 cursor: pointer;
}

.prev2:hover{
 background-color: #ccc;
 opacity: 0.1;
 cursor: pointer;
}

#wholeMain{
   
   width: 1080px;
   margin: 0 auto;
}


table,th,td,tr{
   border-collapse: collapse;
   border-top: solid 1px #ccc;
   border-bottom: solid 1px #ccc;
   
}   
   
td:hover{
   color: #00BCD4;
   cursor: pointer;
}   

td{
}
   
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    
      $('.prev').click(function(){
          $('.list').stop().animate({'margin-left':'-2160px'},function(){
              $('.list>li').eq(0).appendTo('.list');
              $('.list').css({'margin-left':'-1080px'});
          });
      });
      $('.next').click(function(){
          $('.list').stop().animate({'margin-left':'0px'},function(){
              $('.list>li').eq(2).prependTo('.list');
              $('.list').css({'margin-left':'-1080px'});
          });
      });
      
      var auto = setInterval(function(){
            $('.list').stop().animate({'margin-left':'0px'},function(){
              $('.list>li').eq(2).prependTo('.list');
              $('.list').css({'margin-left':'-1080px'});
          });
      },2000);
      
      /* 마우스 올렸을때 캐러셀 자동 멈춤 */
      $('.carousel').mouseenter(function(){
           clearInterval(auto);  
      });
      
      /* 마우스 내렸을때 캐러셀 자동 다시실행 */
      $('.carousel').mouseleave(function(){
           auto = setInterval(function(){
                  $('.list').stop().animate({'margin-left':'0px'},function(){
              $('.list>li').eq(2).prependTo('.list');
              $('.list').css({'margin-left':'-1080px'});
           });
       },4000);
      });
      
      
      
/*////////////////////////////////////////////////////  */
      
       $('.prev2').click(function() {
             $('.list2').stop().animate({
               'margin-left': '-2876px'
             }, function() {
               $('.list2 li:first-child').appendTo('.list2');
               $('.list2').css({
                 'margin-left': '-1438px'
               });
             });
           });
           
        $('.next2').click(function() {
          $('.list2').stop().animate({
            'margin-left': '0px'
          }, function() {
            $('.list2 li:last-child').prependTo('.list2');
            $('.list2').css({
              'margin-left': '-1438px'
            });
          });
        });
      
      
      /*   var auto2 = setInterval(function(){
               $('.list2').stop().animate({'margin-left':'0px'},function(){
                 $('.list2>li').eq(2).prependTo('.list2');
                 $('.list2').css({'margin-left':'-1438px'});
             });
         },5000);
         */
   });



</script>

<body style="width: 1440px;">
<div style="width: 1438px; margin: 0 auto;">   
   <div class="c_wrap">
     <div class="carousel2">
       <ul class="list2">
         <li class="a1"><img style="width: 1438px; height: 429px;" src="<c:url value="/resources/images/index/banner3.png" />"> </li>
         <li class="a2"><img style="width: 1438px; height: 429px;" src="<c:url value="/resources/images/index/banner3.png" />"></li>
         <li class="a3"><img style="width: 1438px; height: 429px;" src="<c:url value="/resources/images/index/banner3.png" />"></li>
         <li class="a4"><img style="width: 1438px; height: 429px;" src="<c:url value="/resources/images/index/banner3.png" />"></li>
       </ul>
     </div>
     <p class="prev2"></p>
     <p class="next2"></p>
   </div>


<div id="wholeMain" >
<%--    <div align="center" style="margin: 0 auto;">
         <div style="border: solid 1px black; height: 400px; width: 1080px;">
         <img src="<c:url value="/resources/images/원더플레이스.png" />">
         </div>   
   </div>
    --%>

   
   <%-- <div style="width: 1000px; border: solid 1px black; margin: 0 auto; text-align: center;">
      <h3>인기강의</h3>
      
      <div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
         <div><img src="<c:url value="/resources/images/동원.png" />" style="width: 240px; height: 240px;" ></div>
      </div>
      
      
      <div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
         <div><img src="<c:url value="/resources/images/미샤.png" />" style="width: 240px; height: 240px;" ></div>
      </div>
      
      <div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
         <div><img src="<c:url value="/resources/images/레노보.png" />" style="width: 240px; height: 240px;" ></div>
      </div>
   </div> --%>
   
      <br>
      
      <div style="width: 1080px; margin: 0 auto; text-align: center;">
      
      <div style=" float:left; width: 490px; height: 200px; display: inline-block;">
         <div style="text-align: left; border-left: 10px;"><h2>&nbsp;&nbsp;&nbsp;공지사항</h2>
            <table>
            <c:forEach var="notice" items="${noticevo}">
               <tr>
               <td style="width: 350px; text-align: left; line-height: 30px;" onclick="javascript:location.href='<%=ctxPath%>/board/noticeview.up?notice_seq=${notice.notice_seq}'">&nbsp;&nbsp;&nbsp;${notice.title}</td>
               <td style="width: 140px;">${notice.writedate}</td>
               </tr>         
            </c:forEach>
         </table>
         </div>
      </div>
      
      <div style="border: width: 450px; height: 300px; display: inline-block; margin:0 20px 0 20px; ">
         <div style="text-align: left; border-left: 10px;"><h2>&nbsp;&nbsp;후원순위</h2>
            <table>
            <c:forEach var="don" items="${paymentvo}" varStatus="status">
               <tr>
               <td style="width: 100px;">&nbsp;&nbsp;&nbsp;${status.count}</td>
               <c:choose>
                  <c:when test="${status.count == 1}"><td style="width: 200px; text-align: left; line-height: 30px;">&nbsp;&nbsp;&nbsp;<img src="<c:url value="/resources/images/index/medal01.png" />">${don.name}</td></c:when>
                  <c:when test="${status.count == 2}"><td style="width: 200px; text-align: left; line-height: 30px;">&nbsp;&nbsp;&nbsp;<img src="<c:url value="/resources/images/index/medal02.png" />">${don.name}</td></c:when>
                  <c:when test="${status.count == 3}"><td style="width: 200px; text-align: left; line-height: 30px;">&nbsp;&nbsp;&nbsp;<img src="<c:url value="/resources/images/index/medal03.png" />">${don.name}</td></c:when>
                  <c:when test="${status.count != 1 and status.count != 2 and status.count != 3}"><td style="width: 200px; text-align: left; line-height: 30px; padding-left: 25px;">&nbsp;&nbsp;&nbsp;${don.name}</td></c:when>
               </c:choose>
               <td style="width: 150px;"><fmt:formatNumber value="${don.sumPayment}" pattern="###,###"/> 원</td>               
               </tr>         
            </c:forEach>
         </table>
         </div>
      </div>   
   
   </div>
   
    <div class="carousel" style="width: 1080px; margin-top: -20px; margin-left: -10px;">
    <h2 style="margin-left: 30px;">인기강의</h2>
        <div class="view" style="width: 1080px; margin-top: -20px;">
            <ul class="list">
                <li style="width: 1080px;">
                   <ul>
                       <li class="a1" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class04.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a2" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class05.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a3" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class06.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                   </ul>
                </li>
                <li style="width: 1080px;">
                    <ul>
                       <li class="a4" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class01.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a5" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class02.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a6" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class03.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                   </ul>
                </li>
                <li style="width: 1080px;">
                    <ul>
                       <li class="a7" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class07.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a8" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class08.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                       <li class="a9" style="margin-left: 20px;"><a href="#"><img src="<c:url value="/resources/images/class/class09.PNG" />" style="width: 333px; height: 333px;" ></a></li>
                   </ul>
                </li>
            </ul>
        </div>
        <p class="prev">◁</p>
        <p class="next">▷</p>
    </div>
   <br>
   

   
</div>
</div>



  
   