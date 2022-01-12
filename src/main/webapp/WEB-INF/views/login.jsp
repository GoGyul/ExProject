<!DOCTYPE html>
<html lang="en">

<head>
<title>ITKey 로그인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">

<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
</head>

<body>

	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<form>
					<div class="login100-form">
						<div class="text-center" style="width: 100%">
							<img src="resources/images/logo.png" width="50%">
						</div>
	
						<span class="login100-form-title p-b-34 p-t-27"> ITKey Edu<br>Project Login
						</span>
	
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input class="input100 writerId" type="text" name="username" placeholder="ID">
							<span class="focus-input100" data-placeholder="&#xf207;"></span>
						</div>
	
						<div class="wrap-input100 validate-input" data-validate="Enter password">
							<input class="input100 writerPW" type="password" name="pass" placeholder="비밀번호">
							<span class="focus-input100" data-placeholder="&#xf191;"></span>
						</div>
	
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1"> ID 저장 </label>
						</div>
	
						<div class="container-login100-form-btn">
							<button type="button" onclick="logOn($('.writerId').val(),$('.writerPW').val())" class="login100-form-btn">로그인</button> <a href="register.do" class="login100-form-btn">회원가입</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>

</html>

<script>

$(document).ready(function(){
	let userInputId = getCookie("userInputId");
	$("input[name='username']").val(userInputId);
	
	if($("input[name='username']").val() != ""){
		$('#ckb1').attr("checked",true);
	}
	
	$('#ckb1').change(function(){
		console.log("쿠키 체인지")
		if($('#ckb1').is(":checked")){
			let userInputId = $('input[name="username"]').val();
			setCookie("userInputId",userInputId,7);
		}
	});
	
	$("input[name='username']").keyup(function(){
		console.log("키업")
		if($("#ckb1").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='username']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
	});	
	

});

function setCookie(cookieName, value, exdays){
	let exdate = new Date();
	exdate.setDate(exdate.getDate()+exdays);
	let cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + " = " + cookieValue;
}

function deleteCookie(cookieName){
	let expireDate = new Date();
	expireDate.setDate(expireDate.getDate() -1);
	document.cookie = cookieName + " = " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName){
	cookieName = cookieName + "=";
	let cookieData = document.cookie;
	let start = cookieData.indexOf(cookieName);
	let cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		let end = cookieData.indexOf(';',start);
		if(end == -1) end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}

function logOn(id, pw){
	console.log(id,pw);

	data = {
			'username' : id,
			'password' : pw
	}
	console.log(data);
	
	$.ajax({
		type : "POST",
		url : "/sam/logOn.do",
		data : data,
		dataType : "JSON",
        success : function(data){
        	
        	console.log(data);
        	
        	 if(data == 0){
        		 var answer = confirm("아이디가 존재하지 않습니다 회원가입 하시겠습니까?");
        		 if(answer == true){
        			 location.href = '/sam/register.do';
        		 }
        	 }
        	 
        	 if(data == 1){
        		 alert("비밀번호가 일치하지 않습니다.");
        	 }
        	 
        	 if(data == 10){
        		 alert("로그인 되셨습니다.");
        		 location.href = '/sam/main.do';
        	 }
        	 if(data == 11){
        		 alert("관리자님 반갑습니다.");
        		 location.href = '/sam/admin.do';
        	 }
        	
        },
        error : function(data){
        	console.log(data);
        }
		
	});
	
}

</script>
