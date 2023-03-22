<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/memberResInfo.css">

</head>
<body >
<div class="content" align="center">
<!-- 콘텐츠 -->

</div>
<div class="popup">
  <!--팝업-->
   <div class="popup_layer"> <!--팝업창-->
      <div class="text_area"><!--텍스트 영역-->
         <strong class="title"></strong>
         <table style="text-align: center" border=0 cellspacing=0 cellpadding=0 width="100%" >
   <tr align="center">
      <td class="table_title" width="33%">날짜</td>
      <td class="table_title" width="33%">시간</td>
      <td class="table_title" width="33%">취소/변경</td>
   
   </tr> 
   <c:forEach items="${ resinfo}" var="res">
   
      <tr align="center">
         <td class="table_td_font">${res.year }-${res.month }-${res.day }</td>
         <c:choose>
         <c:when test="${res.rstarthour<10 }">
         <td class="table_td_font">0${res.rstarthour }시 ~ ${res.rstarthour+2 }시</td>
         </c:when>
         <c:otherwise>
         <td class="table_td_font">${res.rstarthour }시 ~ ${res.rstarthour+2 }시</td>
         </c:otherwise>
         </c:choose>
         <td class="table_title">
            <input class="button_type01" type="button" value="삭제" onclick="javascript:window.location='resdelete?rnum=${res.rnum}'">
            <input class="button_type01" type="button" value="변경" onclick="opener.location.href='reservedmodify?year=${res.year}&month=${res.month -1}&day=${res.day }&starthour=${res.rstarthour }&rnum=${res.rnum }';window.close();">
         </td>
      </tr>
   
   </c:forEach>
   


</table>
      </div>
      <div class="btn_area" align="right"><!--버튼 영역-->
         <input class="button_type02" type="button" value="확인" class="btn" onclick="window.close()">
      </div>
   </div>
   <div class="popup_dimmed"></div> <!--반투명 배경-->
</div>
</body>



</html>