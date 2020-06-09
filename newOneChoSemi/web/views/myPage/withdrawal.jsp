<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	String memberPwd = (String)session.getAttribute("loginUser.getMemberPwd()");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
	padding-top: 2%;
}

fieldset {
	height: auto;
	margin: 5px;
	margin-bottom: 50px;
	background: white;
	padding-left: 50px;
	padding-right: 50px;
	text-align: center;
}

/* 테이블 좌측 라벨 td */
td.mt-2 {
	padding: 12px;
	text-align: right;
	min-width: 33%;
}

/* 테이블 우측 input td */
td {
	text-align: left;
	width: 33%;
}
td.deleteId{
	text-align:center;
	vertical-align:middle;
	font-size:30px !important;
	padding:0 !important;
}
label.deleteId{
	margin:0 !important;
}

/* 버튼 CSS */
.button1 {
	padding: 8px 18px;
	margin: 5px;
	border-radius: 8px;
	color: black;
	border: 1px solid #115D8C;
	background-color: white;
	width: 105px;
	height: 42px;
}

.button1 :hover {
	border-radius: 8px !important;
	background: #6AAED9 !important;
	color: white !important;
	transition: 0.2s !important;
}

.button1 :active {
	border-radius: 8px !important;
	background: #012340 !important;
}

/* The Modal (background) */
.modal {
	display: none;
	/* Hidden by default */
	position: fixed;
	/* Stay in place */
	z-index: 1030;
	/* Sit on top */
	padding-top: 2%;
	/* Location of the box */
	left: 0;
	top: 0;
	width: 100%;
	/* Full width */
	height: 100%;
	/* Full height */
	overflow: auto;
	/* Enable scroll if needed */
	background-color: rgb(0, 0, 0);
	/* Fallback color */
	background-color: rgba(0, 0, 0, 0.4);
	/* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 35% !important;
}

.wdchk {
	text-decoration: none;
	list-style: none;
}

ul ul {
	list-style-type: none !important;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

/* input 테두리 */
input:focus {
	outline: 2px solid #6AAED9;
}

label {
	margin: 0 !important;
	margin: 5px 0px;
	padding: 5px 10px;
	text-align: right;
}
/* input 테두리 */
        input:focus {
            outline: 2px solid #6AAED9;
        }
        input[type=password]{
        	padding: 5px 10px;
        	margin:5px 0;
        	display:inline-block;
        	border:1px solid #ccc;
        }
        /* 테이블 우측 input td */
        td {
            text-align: left;
            width: 35%;
        }
        .table td, .table th{
        	vertical-align:middle !important;
        }
        #password3{
        	min-width:140px !important;
        }
        label #password3{
        	padding-left:0px !important;
        }
 
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<div class="container">
		<div class="row">
		<div class="col-md-3">
		<div class="panel panel-info">
			<div class="panel-heading">
				<!-- 패널 타이틀1 -->
				<h3 class="panel-title">
					<span>마이 페이지</span>
				</h3>
			</div>
			<!-- 사이드바 메뉴목록1 -->
			<ul class="list-group">
				<a href="grade.jsp">
					<li class="list-group-item">회원 등급</li>
				</a>
				<a href="<%=request.getContextPath()%>/infor.me?memberId=<%=loginUser.getMemberId()%>">
					<li class="list-group-item">개인 정보 수정</li>
				</a>
				<%-- <a href="<%=request.getContextPath();%>/list.bo"> --%>
				<a href="orderHistory.jsp">
					<li class="list-group-item">주문 내역 조회</li>
				</a>
				<a href="wishList.jsp">
					<li class="list-group-item">위시리스트</li>
				</a>
				<a href="withdrawal.jsp">
					<li class="list-group-item">회원 탈퇴</li>
				</a>
			</ul>
		</div>
	</div>
			<%@include file="myPageCategory.jsp"%>
			<!-- 9단길이의 첫번째 열 -->
			<div class='col-md-9'>
				<fieldset>
					<form id="withdrawalform" action="<%=request.getContextPath()%>/withdrawal.me">
						<table class="table">
							<thead>
								<tr>
									<br>
									<th colspan="3" scope="col"
										style='border-bottom: 2px solid black'>
										<h1><label name="withdrawalMemberName"><%=loginUser.getMemberName() %>님 회원탈퇴</label></h1>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr style="display:none;" >
									<td colspan="3" class="deleteId"><input type="text" class="deleteId" name="withdrawalMemberId" value="<%=loginUser.getMemberId() %>"></td>
								</tr>
								<tr style='border-bottom: 2px solid black'>
									<td scope="row" class="mt-2"><label>비밀번호 : </label></td>
									<td colspan="2"><input type='password' id='password1'
										name='password1'></td>
								</tr>
								<tr style='border-bottom: 2px solid black'>
									<td scope="row" class="mt-2" width="210px !important"><label>비밀번호 확인 : </label></td>
									<td colspan="1" style="padding-right:0px !important;"><input type='password' id='password2'
										name='password2'></td>
									<td colspan='1' style="padding-left:0px !important;"><label id='password3' style="text-align:left"></label></td>
								</tr>
								<tr>
									<td scope="row" colspan='3' class="mt-2">
										<button id='myBtn' data-toggle='modal' data-target='#intro'
											type='button' class='button1'>탈퇴하기</button> &nbsp;&nbsp; <a
										href='grade.html'><button type='button' class='button1'>취소</button></a>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</fieldset>
			</div>

			 <!-- The Modal -->
			<div id="myModal" class="modal">

				<div class="modal-content">
					<div class='modal-header'>
						<h3>회원탈퇴</h3>
						<button type='button' class="close" data-dismiss='modal'
							aria-hidden="='true'">&times;</button>
					</div>
					<div class='modal-body'>
						<form>
							<ul>
								<li class='wdchk'>탈퇴사유(중복 체크 가능)
									<ul>
										<li class='wdchk'><input type='checkbox' id='chk1' name="no1"><label
											for='chk1'>&nbsp;상품 다양성/품질 불만</label></li>
										<li class='wdchk'><input type='checkbox' id='chk2' name="no2"><label
											for='chk2'>&nbsp;상품 정보 부족</label></li>
										<li class='wdchk'><input type='checkbox' id='chk3' name="no3"><label
											for='chk3'>&nbsp;이용빈도 낮음</label></li>
										<li class='wdchk'><input type='checkbox' id='chk4' name="no4"><label
											for='chk4'>&nbsp;개인정보 유출 우려</label></li>
										<li class='wdchk'><input type='checkbox' id='chk5' name="no5"><label
											for='chk5'>&nbsp;시스템 오류 빈번</label></li>
										<li class='wdchk'><input type='checkbox' id='chk6' name="no6"><label
											for='chk6'>&nbsp;아이디 변경</label></li>
										<li class='wdchk'><input type='checkbox' id='chk7' name="no7"><label
											for='chk7'>&nbsp;초식 동물 입양</label></li>
										<li class='wdchk'><input type='checkbox' id='chk8' name="no8"><label
											for='chk8'>&nbsp;배송지연</label></li>
									</ul>
								</li>
							</ul>
						</form>
					</div>
					<div class='modal-footer'>
						<input type='button' class='btn btn-default' data-dismiss='modal'
							value="탈퇴하기" onclick="altFunction(realt);">
						<div id='area2' class='area'></div>

						<a href='grade.html'><button type='button'
								class='btn btn-primary'>취소</button></a>
					</div>
				</div>

			</div>
			<script>
				var delText = document.getElementById("password2");
				$(function(){
					$("#myBtn").click(function(){
						if("<%=loginUser.getMemberPwd()%>");
					})
				})
				
				
			</script>
			<script>
				function altFunction(otherFunction) {
					for (var i = 5; i > 0; i--) {
						var result = true;
						result = otherFunction(i);
						if (result == false) {
							break;
						}
					}
					if (result == true) {
						alert("ㅂㅂ");
						$("#withdrawalform").submit();
					} else {
						alert('남아 주셔서 감사합니다.');
					}
				}
				function realt(i) {
					var result = true;
					if (i > 4) {
						result = confirm('탈퇴하지 마세요.');
					} else if (i > 3) {
						result = confirm('하지 마세요.');
					} else if (i > 1) {
						result = confirm('하지 말라고 했다.');
					} else {
						result = confirm('마지막 기회입니다.');
					}
					return result;
				}
			</script>

			<!-- <script>
				// Get the modal
				var modal = document.getElementById("myModal");

				// Get the button that opens the modal
				var btn = document.getElementById("myBtn");

				// Get the <span> element that closes the modal
				var span = document.getElementsByClassName("close")[0];

				// When the user clicks the button, open the modal 
				btn.onclick = function() {
					modal.style.display = "block";
				}

				// When the user clicks on <span> (x), close the modal
				span.onclick = function() {
					modal.style.display = "none";
				}

				// When the user clicks anywhere outside of the modal, close it
				window.onclick = function(event) {
					if (event.target == modal) {
						modal.style.display = "none";
					}
				}
			</script> -->

			<script>
				$(function() {
					$('#password2').change(
							function() {
								if ($('#password1').val() != $(this).val()) {
									$('#password3').text('비밀번호 불일치').css(
											'color', 'red');
								} else {
									$('#password3').text('비밀번호 일치').css(
											'color', 'green');
								}
							});
					$('#password1').change(
							function() {
								if ($('#password2').val() != $(this).val()
										&& $('#password2').val().length > 0) {
									$('#password3').text('비밀번호 불일치').css(
											'color', 'red');
								} else if ($('#password2').val() == $(this)
										.val()) {
									$('#password3').text('비밀번호 일치').css(
											'color', 'green');
								}
							});
				});
			</script>
			
			<script>
            	$(function(){
            		$(".button1").mouseenter(function(){
            			$(this).css({"background":"#6AAED9","color":"white","transition":"0.2s","border-radius":"8px"});
            		}).mouseout(function(){
            			$(this).css({"padding":"8px 18px","border-radius":"8px","color":"black","border":"1px solid #11538C","background-color":"white",
            			"width":"105px", "height":"42px"});
            		});
            	});
            </script>
			<%@ include file="../common/footer.jsp"%>

</body>
</html>