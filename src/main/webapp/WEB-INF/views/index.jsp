<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/title.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/img_slide.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<meta charset="UTF-8">
<title>PUPPY CAFE</title>
</head>
<body style="background-color: #D2DBE9">
<script type="text/javascript">
<% String logincheck = (String)request.getAttribute("logincheck");
if("s".equals(logincheck)) {%>
Swal.fire({
	  icon: 'success',
	  title: '로그인 성공',
	})
<%}%>	

</script>

<%@ include file="include/header.jsp" %>

	<center>
	<table width="90%" border="0" cellspacing="0" cellpadding="20">
		<tr>
			<td class="titlebox">
				<span class="title01">반려견 맞춤 예약 서비스</span>
			</td>
		</tr>
		<tr>
			<td class="titlebox">
				<span class="title02">저희 애견카페는 반려견의 행복한 사회화 교육과 놀이를 위하여 원하는 환경에서 <br><br>
									반려견과 견주가 지낼수 있도록 예약시스템을 준비하였습니다.
				</span>
			</td>
		</tr>
		<tr>
			<td >
				<center>
						
							<section class="carousel" aria-label="Gallery">
							  <ol class="carousel__viewport">
							    <li id="carousel__slide1"
							        tabindex="0"
							        class="carousel__slide" style="background: url(/resources/img/cafe-main1.png) no-repeat center;">
							      <div class="carousel__snapper">
							        <a href="#carousel__slide4"
							           class="carousel__prev">Go to last slide</a>
							        <a href="#carousel__slide2"
							           class="carousel__next">Go to next slide</a>
							           
							      </div>
							    </li>
							    <li id="carousel__slide2"
							        tabindex="0"
							        class="carousel__slide" style="background: url(/resources/img/cafe-main2.jpg) no-repeat center;">
							        
							      <div class="carousel__snapper"></div>
							      <a href="#carousel__slide1"
							         class="carousel__prev">Go to previous slide</a>
							      <a href="#carousel__slide3"
							         class="carousel__next">Go to next slide</a>
							    </li>
							    <li id="carousel__slide3"
							        tabindex="0"
							        class="carousel__slide" style="background: url(/resources/img/cafe-main3.png) no-repeat center;">
							      <div class="carousel__snapper"></div>
							      <a href="#carousel__slide2"
							         class="carousel__prev">Go to previous slide</a>
							      <a href="#carousel__slide4"
							         class="carousel__next">Go to next slide</a>
							    </li>
							    <li id="carousel__slide4"
							        tabindex="0"
							        class="carousel__slide" style="background: url(/resources/img/cafe-main4.jpg) no-repeat center;">
							      <div class="carousel__snapper"></div>
							      <a href="#carousel__slide3"
							         class="carousel__prev">Go to previous slide</a>
							      <a href="#carousel__slide1"
							         class="carousel__next">Go to first slide</a>
							    </li>
							  </ol>
							  <aside class="carousel__navigation">
							    <ol class="carousel__navigation-list">
							      <li class="carousel__navigation-item">
							        <a href="#carousel__slide1"
							           class="carousel__navigation-button">Go to slide 1</a>
							      </li>
							      <li class="carousel__navigation-item">
							        <a href="#carousel__slide2"
							           class="carousel__navigation-button">Go to slide 2</a>
							      </li>
							      <li class="carousel__navigation-item">
							        <a href="#carousel__slide3"
							           class="carousel__navigation-button">Go to slide 3</a>
							      </li>
							      <li class="carousel__navigation-item">
							        <a href="#carousel__slide4"
							           class="carousel__navigation-button">Go to slide 4</a>
							      </li>
							    </ol>
							  </aside>
							</section>
							
				</center>			
			</td>
		</tr>
	</table>
	</center>
	<%@ include file="include/footer.jsp" %>
	
</body>
</html>