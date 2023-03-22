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
var syear =<%=session.getAttribute("syear") %>
var smonth =<%=Integer.parseInt((String)session.getAttribute("smonth")) %>
var sday =<%=session.getAttribute("sday") %>
var shour = <%=session.getAttribute("shour") %>
function yesno(){
	
	
	
	Swal.fire({
		  title: '변경하시겠습니까??',
		  text: syear+"년"+smonth+"월"+sday+"일"+shour+"시 예약이 선택하신 시간으로 변경됩니다",
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
 <body>
 <%@ include file="include/header.jsp"%>

 
    
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
 
   <div class ="div0">
  <div align="center" class="div1">
  <table border=0 width=45%> <!-- 달력 상단 부분 -->
   <tr>
    <td align=center width=200> <!-- 년 도-->
    <a class="chyear" href="reservedmodify?year=<%out.print(year-1);%>&month=<%out.print(month);%>&day=${day}">◀</a>
    <span style="text-align: right: ;" class="chyear01"><% out.print(year); %>년</span>
    <a class="chyear" href="reservedmodify?year=<%out.print(year+1);%>&month=<%out.print(month);%>&day=${day}">▶</a>
    </td>
    <td align=center width=300> <!-- 월 -->
    <a class="chmonth" href="reservedmodify?year=<%out.print(year);%>&month=<%out.print(month-1);%>&day=${day}">◀</a>
    <span class="chmonth01"><% out.print(month+1); %>월</span>
    <a class="chmonth" href="reservedmodify?year=<%out.print(year);%>&month=<%out.print(month+1);%>&day=${day}">▶</a>
    </td>
    <td style="text-align: center ;" align=right width=200>
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
		  <a href="reservedmodify?year=<%out.print(year);%>&month=<%out.print(month);%>&day=<%=i %>" class="calcelltaleday"><%= i %></a> &nbsp;</td></tr>
		  <% 
		   
		   
	   }else if (year==currentYear && month == currentMonth &&i>=currentDate){ // 월이 같고 날짜가 클경우 예약가능
		   
	   %>
	  <a href="reservedmodify?year=<%out.print(year);%>&month=<%out.print(month);%>&day=<%=i %>" class="calcelltaleday"><%= i %></a> &nbsp;</td></tr>
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
  <div class="reservediv">
  <form action="reservedmodifyOk" method="post" name="reservedform">
  <input type="hidden" value="${rdate }" name="rdate">
  	<table class="reservdtable" border="1" cellspacing=0 cellpadding=0>
  	<tr><td class="reservd_top_td" colspan="3"><%out.print(year+"-"+(month+1)+"-"+request.getParameter("day")); %> </td></tr>
  	<tr ><td class="reservd_top_td">시간</td><td class="reservd_top_td">예약현황</td><td class="reservd_top_td">시간지정</td></tr>
  	
  		<c:forEach var="i" begin="9" end="17" step="2"  >
  		
				
  				<tr align="center">
  				
  				<td class="reservd_middle_td" >${i }시&nbsp; ~&nbsp;${i+2}시 </td>
  				<td class="reservation_dog" >
	  				<table border="0" cellspacing=0 cellpadding=0 width="100%" height="80%" >
		  				<c:forEach items="${rvdtos }" var="rvdto">
							
			  				<c:if test="${ i==rvdto.rstarthour }" >
			  					
			  					
			  				
			  				<tr >
				  				<td class="reservation_dog" width=50% >
				  					${rvdto.psspeciesname } :&nbsp; 
				  				</td>
				  				<td class="reservation_dog2" >
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
							<td class="reservd_middle_td"><input class="bottom_check" type="checkbox" name="check" value="${i }" disabled="disabled">
							</td>
							<input type="hidden" name="hourcheck" value="${i }" name="checkcount">
						</c:if>
						
						
						</c:forEach>
				
					
					<%if(checkcount==0){ %>
					<td class="reservd_middle_td"><input class="bottom_check" type="checkbox" name="check" value="${i }"></td>
					
					<%} %>
	 				</tr>  	
  					
  				
  		</c:forEach>
  		
  		<tr><td  colspan="3" align="center" height=5% ><input class="bottom_button" type="button" value="변경하기" onclick="yesno()"></td></tr>
  		 
  		
  		
  	</table>
  	<input type="hidden" value="${rnum }" name="rnum">
  	</form>
  </div>
  </div>
  <div style="height:70px">
  </div>
  <%@include file="include/footer.jsp" %>
 </body>
</html>