<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/title.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/join.js"></script>
<script type="text/javascript">
function check(){
	var mid = document.join_frm.mid.value;
	var mpw = document.join_frm.mpw.value;
	var mpw_check = document.join_frm.mpw_check.value;
	var mname = document.join_frm.mname.value;
	var mphone = document.join_frm.mphone.value;
	var pmname = document.join_frm.pmname.value;
	if(mid.length==0){
		Swal.fire({
			  icon: 'error',
			  title: '아이디는 필수 입력사항입니다.',
			})
	}
	else if(mpw.length==0){
		Swal.fire({
			  icon: 'error',
			  title: '비밀번호는 필수 입력사항입니다.',
			})
	}
	else if(mname.length==0){
		Swal.fire({
			  icon: 'error',
			  title: '이름은 필수 입력사항입니다.',
			})
	}
	else if(mphone.length==0){
		Swal.fire({
			  icon: 'error',
			  title: '전화번호는 필수 입력사항입니다.',
			})
	}
	else if(pmname.length==0){
		Swal.fire({
			  icon: 'error',
			  title: '반려견이름은 필수 입력사항입니다.',
			})
	}else{
		
		if(mpw==mpw_check){
			Swal.fire({
				  icon: 'success',
				  title: '회원가입 성공! 반갑습니다.',
				})
			document.join_frm.submit();
			
		}else{
			Swal.fire({
				  icon: 'error',
				  title: '비밀번호를 확인해주세요',
				})
		}
		
	}
	
}

</script>
<title>PUPPY CAFE</title>
</head>
<body>

	<%@ include file="include/header.jsp" %>
	<center>
	<table width="100%" border="0" cellspacing="0" cellpadding="20">
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
				<table width="100%" border="0" cellspacing="0" cellpadding="10">
					<tr class="contentbox">
						<td class="content">
							<center>						
							<table border="0" cellspacing="0" cellpadding="10">
								<form action="joinOk" method="post" name="join_frm">
									<tr>
										<td><span class="content_text01">아 이 디 : </span></td>
										<td><input class="input_type01" type="text" name="mid" id="mid"></td>
									</tr>
									<tr>
										<td><span class="content_text01">비밀번호 : </span></td>
										<td><input class="input_type01" type="password" name="mpw" id="mpw"></td>
									</tr>
									<tr>
										<td><span class="content_text01">비밀번호체크 : </span></td>
										<td><input class="input_type01" type="password" name="mpw_check" id="mpw_check"></td>
									</tr>
									<tr>
										<td><span class="content_text01">이&nbsp;&nbsp;&nbsp;&nbsp;름 : </span></td>
										<td><input class="input_type01" type="text" name="mname" id="mname"></td>
									</tr>
									<tr>
										<td><span class="content_text01">전화번호 : </span></td>
										<td><input class="input_type01" type="text" name="mphone" id="mphone"></td>
									</tr>
									<tr>
										<td><span class="content_text01">반려견이름 : </span></td>
										<td><input class="input_type01" type="text" name="pmname" id="pmname"></td>
									</tr>
									<tr>
										<td><span class="content_text01">반려견성격 : </span></td>
										<td><input class="input_type01" type="text" name="pmcharacter"></td>
									</tr>
									<tr>
										<td><span class="content_text01">반려견종류 : </span></td>
										<td><select style="font-size: 20px" name="pmspecies">
												<c:forEach items="${dto }" var="p">
												<option value="${p.psnum }">${p.psspeciesname }</option>
												</c:forEach>
												
											</select>
										</td>
									</tr>
									<tr>
										<td><span class="content_text01">반려견나이 : </span></td>
										<td><input class="input_type01" type="text" name="pmage"></td>
									</tr>
									<tr>
										<td><span class="content_text01">반려견생일 : </span></td>
										<td><input class="input_type01" type="text" name="pmbirth" placeholder="(예)2020-08-15"></td>
									</tr>
									<tr>
										
										<td colspan="2">
										<div style="text-align: right;">
											<input class="button_type01" type="button" value="가입완료" onclick="check()">
											<input class="button_type01" type="button" value="로그인" onclick="script:window.location='login'">
										</div>
										</td>
										
									</tr>
								</form>							
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