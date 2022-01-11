<!DOCTYPE html>
<html lang="en">

<head>
<title>ITKey 회원가입</title>
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
				<form action="doRegister.do" id="register" onsubmit="return false;" method="post"enctype="multipart/form-data">
				<div class="login100-form validate-form">
					<span class="login100-form-title p-b-27 p-t-15">회원가입</span>
					<div class="row text-center">
						<div class="col-sm-12">
							<img src="resources/images/noImage.png" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<span class="fileUpload btn login100-form-btn"> <span class="upl" id="upload">업로드</span> 
									<input type="file" class="upload up" name="uploadFiles" multiple="multiple" id="up" onchange="readURL(this);" />
								</span>
								<!-- btn-orange -->
							</div>
							<!-- btn -->
						</div>
						<!-- group -->
					</div>
					<!-- form-group -->

					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input " data-validate="Enter userId">
								<input class="input100 userId" type="text" name="boardWriter" placeholder="ID">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input " data-validate="Enter password">
								<input class="input100 password" type="password" name="boardWriterPw" placeholder="Password">
								<span class="focus-input100" data-placeholder="&#xf191;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input " data-validate="Enter writerName">
								<input class="input100 userName" type="text" name="boardWriterName" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input  " data-validate="Enter writerPhone">
								<input class="input100 userPhone" type="text" name="boardWriterPhone" placeholder="-는 제외하고 입력">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input " data-validate="Enter writerEmail">
						<input class="input100 userEmail1" type="text" name="boardWriterEmail" placeholder="이메일을 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf15a;"></span>
					</div>

					<div class="wrap-input100 validate-input " data-validate="Enter writerEmail">
						<input class="input100 userEmail2" type="text" name="boardWriterEmail" placeholder="이메일을 다시한번 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf159;"></span>
					</div>

					<div class="container-login100-form-btn">
						<button id="btn_registerInsert"  type="button" class="login100-form-btn">가입</button> <a href="login.do" class="login100-form-btn">취소</a>
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

	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('.img-circle').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	

	var btn_registerInsert = document.getElementById("btn_registerInsert");
	btn_registerInsert.onclick=function(){
		insertRegister();
	}
	
	function insertRegister(){
		var userId = $('.userId').val();
		var userpass = $('.password').val();
		var userName = $('.userName').val();
		var userPhone = $('.userPhone').val();
		var userEmail1 = $('.userEmail1').val();
		var userEmail2 = $('.userEmail2').val();
		var upload = $('#up').val();
		console.log(upload);
		if(userId.match('admin')||userId.match('ADMIN')||userId.match(' ')){
			alert("해당 아이디로 가입하실수 없습니다.");
			return
		}
		if(upload == ''){
			alert("프로필 사진을 등록해주세요");
			return
		}
		if(userId == '' || userpass == '' || userName == '' || userPhone == '' || userEmail1 == '' || userEmail2 == '' ){
			alert("모든 항목을 빈칸없이 작성해 주시기 바랍니다");
			return
		}
		
		if(userPhone.match(/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/)==null){
			alert("전화번호 양식에 맞춰 작성해 주시기 바랍니다");
			return
		}
		
		if (userEmail1.match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
			alert("이메일 양식에 맞춰 작성해주시기 바랍니다.");
			return
		}
		if(userEmail1 != userEmail2 ){
			alert("작성된 이메일이 다릅니다. 이메일을 다시 확인해주시기 바랍니다.");
			return
		}
		
		data = {
				'username' : userId
		}
		
		$.ajax({
			type : "POST",
			url : "/sam/checkId.do",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				if(data == 1 || data == 10){
					alert("중복된 아이디 입니다.");
					return
				}else{
					var answer = confirm("작성한 내용으로 가입이 진행됩니다. 회원가입 하시겠습니까?");
					if(answer == true){
						$('#register').removeAttr('onsubmit');
						$('#register').submit();
	        			 alert("회원가입완료");
	        			 
	        		 }else{
	        			 alert("회원가입 취소");
	        		 }
				}
			},
			error : function(data){
				console.log(data);
			}
		})
		
	}
	
	$(document).ready(function(){
		$('#up').on('change', function(){
			if( $("#up").val() != "" ){
				var ext = $('#up').val().split('.').pop().toLowerCase();
				if($.inArray(ext, ['png','jpg','jpeg']) == -1) {
					alert('png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					$("#up").val("");
					return;
				}else{
					readURL(this);
				}
			}
		});
	});

</script>