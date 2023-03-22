<%@page import="java.util.ArrayList"%>
<%@page import="com.puppycafe.root.Dto.ReservedCellDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

 <head>
 <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reservedcalView.css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>PUPPY CAFE</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
function yesno(){
   Swal.fire({
        title: '예약하시겟습니까?',
        showDenyButton: true,
        confirmButtonText: '네',
        denyButtonText: '취소',
        customClass: {
          actions: 'my-actions',
          cancelButton: 'order-1 right-gap',
          confirmButton: 'order-2',
          denyButton: 'order-3',
        }
      }).then((result) => {
        if (result.isConfirmed) {
           document.reservedform.submit()
        }
      })
   
}

</script>
 </head>
 <body style="background-color: #D2DBE9">
 <%@ include file="include/header.jsp"%>
 <%
    String shour=request.getParameter("starthour");
    
 %>
 
    
  <%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
  %>
 
   <table class ="div0" align="left" border="0" height="100%"  cellspacing="0" cellpadding="0">
   <tr><td align="right">
  <div align="right"  class="div1" style="width:85%; ">
  <table border=0 width=100%> <!-- 달력 상단 부분 -->
   <tr>
    <td align=right width=33%> <!-- 년 도-->
    <a class="chyear" href="reservedView?year=<%out.print(year-1);%>&month=<%out.print(month);%>&day=${day}">◀</a>
    <span style="text-align: right: ;" class="chyear01"><% out.print(year); %>년</span>
    <a class="chyear" href="reservedView?year=<%out.print(year+1);%>&month=<%out.print(month);%>&day=${day}">▶</a>
    </td>
    <td align=center width=33%> <!-- 월 -->
    <a class="chmonth" href="reservedView?year=<%out.print(year);%>&month=<%out.print(month-1);%>&day=${day}">◀</a>
    <span class="chmonth01"><% out.print(month+1); %>월</span>
    <a class="chmonth" href="reservedView?year=<%out.print(year);%>&month=<%out.print(month+1);%>&day=${day}">▶</a>
    </td>
    <td style="text-align: left ;" align=right width=33%>
    <span class="date">
    <%
    if(currentMonth<9 && currentDate<10){out.print(currentYear + "-0" + (currentMonth+1) + "-0" + currentDate);}
      else if (currentMonth<9 ){out.print(currentYear + "-0" + (currentMonth+1) + "-" + currentDate); }
      else if (currentDate<10){out.print(currentYear + "-" + (currentMonth+1) + "-0" + currentDate); }
      else{out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); }
      %>
      </span>
      </td>
   </tr>
  </table>
  <div class="table_background">
  <table border="1" cellpadding="0" cellspacing="0" class="maintbl"> <!-- 달력 부분 -->
   <tr style="text-align: left;" height=8%>
    <td class="week" width=14%>일</td> <!-- 일=1 -->
    <td class="week" width=14%>월</td> <!-- 월=2 -->
    <td class="week" width=14%>화</td> <!-- 화=3 -->
    <td class="week" width=14%>수</td> <!-- 수=4 -->
    <td class="week" width=14%>목</td> <!-- 목=5 -->
    <td class="week" width=14%>금</td> <!-- 금=6 -->
    <td class="week" width=14%>토</td> <!-- 토=7 -->
   </tr>
   <tr height=20%>
   <%
   cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
   int br=0; //7일마다 줄 바꾸기
   for(int i=0; i<(startDay-1); i++) { //빈칸출력
    out.println("<td class='cell'>&nbsp;</td>");
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
      int count=0;
      %>
      <td align="left">  <table border="0" cellspacing=0 cellpadding=0 width="100%" height="100%"  class="calcelltable">
      <tr ><td class="day" colspan="2">
      <%if(year>currentYear||(year==currentYear && month > currentMonth)){ // 현재 연월보다 크면 예약가능
         
        %>
        <a href="reservedView?year=<%out.print(year);%>&month=<%out.print(month);%>&day=<%=i %>" class="calcelltaleday"><%= i %></a> &nbsp;</td></tr>
        <% 
         
         
      }else if (year==currentYear && month == currentMonth &&i>=currentDate){ // 월이 같고 날짜가 클경우 예약가능
         
      %>
     <a href="reservedView?year=<%out.print(year);%>&month=<%out.print(month);%>&day=<%=i %>" class="calcelltaleday"><%= i %></a> &nbsp;</td></tr>
      <%
      }else{ // 그외 불가능
         
         %>
       <%=i %>  &nbsp; </td></tr>
         <%
      }
      %>
      <tr ><td ></td><td >&nbsp; </td></tr>
      <%String si=null;
      if(i<10){si="0"+i;}
      else{si=i+"";}
      
       if(request.getAttribute("rcellDtos")!=null){
      for(ReservedCellDto rcelldto : (ArrayList<ReservedCellDto>)request.getAttribute("rcellDtos")){
         if(rcelldto!=null){
            if(rcelldto.getDay().equals(si)){
               int hour = rcelldto.getRstarthour();
               if(hour ==9){
                  %><tr ><td class="Reservation_status" width=50%>09시 :</td><td class="Reservation_status">&nbsp;<%
                  out.print(rcelldto.getAmount()+"마리");
                  %><%
                  count ++;
               }else if(hour ==11){
                  %><tr ><td class="Reservation_status">11시 :</td><td class="Reservation_status">&nbsp;<%
                  out.print(rcelldto.getAmount()+"마리");
                  %></td></tr><%
                  count ++;
               }
               else if(hour ==13){
                  %><tr ><td class="Reservation_status">13시 :</td><td class="Reservation_status">&nbsp;<%
                  out.print(rcelldto.getAmount()+"마리");
                  %></td></tr><%
                  count ++;
                  }
               else if(hour ==15){
                  %><tr ><td class="Reservation_status">15시 :</td><td class="Reservation_status">&nbsp;<%
                  out.print(rcelldto.getAmount()+"마리");
                  %></td></tr><%
                  count ++;
               }
               else if(hour ==17){
                  %><tr ><td class="Reservation_status">17시 :</td><td class="Reservation_status">&nbsp;<%
                  out.print(rcelldto.getAmount()+"마리");
                  %></td></tr><%
               
               count ++;
            }
            
         }
        
         }
      }
       }
      for(int j=1;j<=5-count;j++){
         %>
         <tr ><td >&nbsp;</td><td >&nbsp;</td></tr>
         <%
      }
      %>
     
      
    
     
      </table>  
      </td>
      <%
   
    br++;
    if((br%7)==0 && i!=end) {
     %>
     </tr><tr height=20%>
     <% 
    }
   }
   while((br++)%7!=0) //말일 이후 빈칸출력
    out.println("<td class='cell'>&nbsp;</td>");
   %>
   </tr>
  </table>
  </div>
  </div>
  </td>
  
  <td align="left" height="100%">
  <div class="reservediv" style="margin-left: 4% ; width:80%; height:100%;">
	  <table align="center" style="padding-right: 15%">
	  <tr>
	  <td style="font-size: 40px;" >
	  <%String smonth;
	  if(month<9){smonth="0"+(month+1)+"";}
	  else{smonth=(month+1)+"";}
	  out.print(year+"-"+smonth+"-"+request.getParameter("day")); %>
	  </td>
	  </tr>
	  </table>
  
  
     <table class="reservdtable" border="1" cellspacing=0 cellpadding=0 height="100%">
     <form action="reserved" method="post" name="reservedform">
 	<input type="hidden" value="${rdate }" name="rdate">
     <tr ><td class="reservd_top_td">시간</td><td class="reservd_top_td">예약현황</td><td class="reservd_top_td">시간지정</td></tr>
     
        <c:forEach var="i" begin="9" end="17" step="2"  >
        
            
              <tr >
              
              <td class="reservd_middle_td" >${i }시&nbsp; ~&nbsp;${i+2}시 </td>
              <td class="reservation_dog" >
                 <table border="0" cellspacing=0 cellpadding=0 width="100%" height="100%" >
                    <c:forEach items="${rvdtos }" var="rvdto">
                     
                       <c:if test="${ i==rvdto.rstarthour }" >
                          
                          
                       
                       <tr >
                          <td colspan="1" class="reservation_dog" width=70% >
                             ${rvdto.psspeciesname } :&nbsp; 
                          </td>
                          <td class="reservation_dog2" width=30%>
                             ${rvdto.puppycount }마리
                          </td>
                       </tr>                
                       </c:if>
            
                    </c:forEach>
                 </table>
                 
                 <% int checkcount=0; %>
                </td>
                
                
             
                
                <c:forEach items="${ hourcheck}" var="check">
                   
                   <c:if test="${i==check }">
                     <%checkcount++; %>
                     <td class="reservd_middle_td"><input class="bottom_check" type="checkbox" name="check" value="${i }" disabled="disabled"></td>
                     <input type="hidden" name="hourcheck" value="${i }" name="checkcount">
                  </c:if>
                  
                  
                  </c:forEach>
            
               
               <%if(checkcount==0){ %>
               <td class="reservd_middle_td"><input class="bottom_check" type="checkbox" name="check" value="${i }"></td>
               
               <%} %>
                </tr>     
                 
              
        </c:forEach>
        <tr><td  colspan="3" align="center" height="1%" ><input class="bottom_button" type="button" value="예약하기" onclick="yesno()"></td></tr>
         
        
         </form>
     </table>
    
  </div>
  </td>
  </tr>
  </table>
  <div style="height:70px">
  </div>
  <%@include file="include/footer.jsp" %>
 </body>
</html>