<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/title.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/board.js"></script>
<title>PUPPY CAFE</title>
</head>
<body style="background-color: #D2DBE9">   
   <%@ include file="include/header.jsp" %>
   <center>
   <table width="80%" border="0" cellspacing="0" cellpadding="20">
      <tr>
         <td class="titlebox">
            <span class="title01">반려견 맞춤 예약 서비스</span>
         </td>
      </tr>
      <tr>
         <td class="titlebox">
            <span class="title02">저희 애견카페는 반려견의 행복한 사회화 교육과 놀이를 위하여 원하는 환경에서 <br><br>
                           반려견과 견주가 지낼수 있도록 예약시스템을 준비하였습니다.</span>
         </td>
      </tr>
      <tr>
         <td>
            <center>
            <table width="90%" border="0" cellspacing="0" cellpadding="10">
               <tr class="contentbox">
                  <td class="content">
                  <form action="boardDelete" method="post" name="board_frm">
                     <center>                  
                     <table border="0" cellspacing="0" cellpadding="10">
                     <tr>
                              <td colspan="8" align="right">
                              <%
                                 String bid = (String) request.getAttribute("bid");
                              
                                 if((sessionId != null ) && (sessionId.equals(bid))) {      
                              %>
                                 <input class="button_type01" type="button" value="수정" onclick="script:window.location='boardModifyView?bnum=${contentView.bnum}'">
                                 <input class="button_type01" type="button" value="삭제" onclick="script:window.location='boardDelete?bnum=${contentView.bnum}'">
                                 
                              <%
                                 }
                              %>
                              <input class="button_type01" type="button" value="글목록" onclick="script:window.location='community'">   
                              </td>
                           </tr>
                        
                           <input type="hidden" value="${contentView.bnum }" name="bnum">
                           <tr>
                              <td  class="middle_td" colspan="2"><span class="content_text01">아이디  </span></td>
                              <td  colspan="2"><input class="input_type01" type="text" name="bid" value="${contentView.bid }" readonly="readonly"></td>
                              <td  class="middle_td" colspan="2" ><span class="content_text01">등록일  </span></td>
                              <td  colspan="2" ><input class="input_type01" type="text" name="bdate" value="${contentView.bdate }" readonly="readonly"></td>
                           </tr>
                           <tr>
                              <td  class="middle_td" colspan="2"><span class="content_text01">제목  </span></td>
                              <td colspan="6"><input class="input_type02" type="text" name="btitle" value="${contentView.btitle }" readonly="readonly"></td>
                           </tr>
                           <tr>
                              <td  class="middle_td" colspan="2"><span class="content_text01">내용  </span></td>
                              <td colspan="6"><textarea class="textarea_type01" rows="5" cols="30" name="bcontent" readonly="readonly">${contentView.bcontent}</textarea></td>
                           </tr>                           
                        
                        </form>      
                           <tr>
                        
                              <form action="addreply" >
                                 <input type="hidden" value="${contentView.bnum }" name="bnum">
                                 <td align="center" colspan="2"><span class="content_text01">답글</span></td>
                                 
                                 <td colspan="5"><textarea class="textarea_type02" rows="2" cols="80" name="brcontent" ></textarea></td>
                                 <td colspan="1" align="center"><input class="button_type02" type="submit" value="답글달기"></td>
                           
                              </form>
                              </tr>
                              <c:forEach items="${replys }" var="reply">
                                 <input type="hidden" value="${contentView.bnum }" name="bnum">
                                 <input type="hidden" name="brnum" value="${reply.brnum }">
                                 <tr>
                                       
                                       <td  align="right" colspan="2">${reply.brid }</td>
                                       <td   align="center" colspan="4" >${reply.brcontent }</td>
                                       
                                       <td  align="center" colspan="1" >${reply.brdate }</td>
                                       <td align="center" colspan="1">
                                          
                                          <input class="button_type02" type="button" onclick="javascript:window.location='removereply?brnum=${reply.brnum}&bnum=${contentView.bnum }'" value="삭제">
                                       </td>
                              
                                 </tr>
                              </c:forEach>
                           <tr>
                              <td colspan="8" align="right">
                                 <input class="button_type01" type="button" value="글목록" onclick="script:window.location='community'">
                              </td>
                           </tr>            
                     </table>
                     </center>                     
                  </td>                  
               </tr>
               
            </table>
            </center>         
         </td>
      </tr>
   </table>
   </center>
   <%@ include file="include/footer.jsp" %>
</body>
</html>