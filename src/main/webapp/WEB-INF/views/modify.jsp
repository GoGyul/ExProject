<!DOCTYPE html>
<html lang="en">

<head>
<title>ITKey 정보수정</title>
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
<h1>${writer }</h1>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form validate-form">
					<span class="login100-form-title p-b-27 p-t-15">정보수정</span>
					<div class="row text-center">
						<div class="col-sm-12">
							<img src="${pageContext.request.contextPath}/resources/images/${writer.FILE_ORIGINAL_NAME}" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<form id="fileForm"  method="post" enctype="multipart/form-data">
									<span class="fileUpload btn login100-form-btn"> <span class="upl" id="upload">업로드</span> 
										<input type="hidden" id="hiddenFileIdx" value="${writer.FILE_IDX }">
										<input type="file" class="upload up" id="up" multiple="multiple" onchange="readURL(this);" />
									</span>
								</form>
								<!-- btn-orange -->
							</div>
							<!-- btn -->
						</div>
						<!-- group -->
					</div>
					<!-- form-group -->

					<div class="row">
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input id="boardWriter" class="input100" type="text" name="boardWriter" value="${writer.BOARD_WRITER }" readonly>
								<input id="boardWriterIdx" class="input100" type="hidden" name="boardWriterIdx" value="${writer.BOARD_WRITER_IDX }">
								<input id="sessionId" class="input100" type="hidden" name="sessionId" value="${sessionScope.login.boardWriter}">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input id="boardWriterName" class="input100" type="text" name="boardWriterName" value="${writer.BOARD_WRITER_NAME }">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input id="boardWriterPhone" class="input100" type="text" name="boardWriterPhone" placeholder="'-'를 빼고 입력해주세요" value="${writer.BOARD_WRITER_PHONE }">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input id="boardWriterEmail" class="input100" type="text" name="boardWriterEmail" value="${writer.BOARD_WRITER_EMAIL }">
								<span class="focus-input100" data-placeholder="&#xf159;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input id="boardWriterPw" class="input100" type="password" name="boardWriterPw" placeholder="암호를 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input id="boardWriterPw2" class="input100" type="password" name="boardWriterPw2" placeholder="암호 확인.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="container-login100-form-btn">
						<a onclick="doUpdate()" class="login100-form-btn">수정</a> 
						<a onclick="doWithdraw() " class="login100-form-btn">탈퇴</a> 
						<a href="/sam/main.do" class="login100-form-btn">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>

</html>


<script>

$("#up").change(function(){
    
	var boardWriter = $('#boardWriter').val();
	var fileIdx = $('#hiddenFileIdx').val();
    var formData = new FormData();
    var temp = $("#up")[0].files[0];
    console.log(temp);
    
    for(var i=0; i<$('#up')[0].files.length; i++){
		  formData.append('uploadFile', $('#up')[0].files[i]);
	}
	 
 
    $.ajax({
        type : 'post',
        url : '/sam/uploadFileAjax.do?fileIdx='+fileIdx+"&boardWriter="+boardWriter,
        enctype: 'multipart/form-data',
        data : formData,
        processData : false,
        dataType : "json",
        contentType : false,
        success : function(data) {
            if(data == 0){
            	alert("파일 업로드에 실패하였습니다.");
            }
            if(data == 1){
            	alert("이미지 변경 성공");
            }
        },
        error : function(error) {
            alert("에러");
           
        }
    });      
 
});    

	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('.img-circle').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	function doUpdate(){
		
		var boardWriter = $('#boardWriter').val();
		var boardWriterName = $('#boardWriterName').val();
		var boardWriterPhone = $('#boardWriterPhone').val();
		var boardWriterEmail = $('#boardWriterEmail').val();
		var boardWriterPw = $('#boardWriterPw').val();
		var boardWriterPw2 = $('#boardWriterPw2').val();
		var boardWriterIdx = $('#boardWriterIdx').val();
		
		if(boardWriter == '' || boardWriterName == '' || boardWriterPhone == '' || boardWriterEmail == ''){
			alert("모든 항목을 빈칸없이 작성해 주시기 바랍니다");
			return
		}
		
		if(boardWriterPhone.match(/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/)==null){
			alert("전화번호 양식에 맞춰 작성해 주시기 바랍니다");
			return
		}
		if (boardWriterEmail.match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
			alert("이메일 양식에 맞춰 작성해주시기 바랍니다.");
			return
		}
		
		if(boardWriterPw == '' || boardWriterPw2 == ''){
			alert("비밀번호를 입력해주세요");
			return
		}
		if(boardWriterPw != boardWriterPw2){
			alert("비밀번호가 일치하지 않습니다.");
			return
		}
		
		var answer = confirm("작성한 내용으로 수정이 진행됩니다. 진행 하시겠습니까?");
		
		if(answer){
			data = {
					'boardWriter' : boardWriter,
					'boardWriterName' : boardWriterName,
					'boardWriterPhone' : boardWriterPhone,
					'boardWriterEmail' : boardWriterEmail,
					'boardWriterPw' : boardWriterPw,
					'boardWriterIdx' : boardWriterIdx
				}
				$.ajax({
					type : "POST",
					url : "/sam/modifyWriterProcess.do",
					data : data,
					dataType : "JSON",
					success : function(data){
						console.log(data);
						if(data == 0){
							alert('잘못된 접근입니다');
							return
						}
						if(data == 1){
							alert("수정에 성공하였습니다.");
							location.href = "/sam/main.do";
						}
					},
					error : function(data){
						console.log(data);
					}
				});
		}
		
		return
		
	}
	
	function doWithdraw(){
		
		var boardWriter = $('#boardWriter').val();
		var boardWriterIdx = $('#boardWriterIdx').val(); 
		var sessionId = $('#sessionId').val();
		
		var answer = confirm("정말 탈퇴하시겠습니까? 복구하실수 없습니다.");
		
		if(sessionId ==null || boardWriter != sessionId){
			alert("잘못된 접근입니다."+boardWriter+","+sessionId);
			return
		}
		
		if(answer){
			
			alert("탈퇴완료"+boardWriter +"," + boardWriterIdx);
			
			data = {
				'boardWriter' : boardWriter,
				'boardWriterIdx' : boardWriterIdx	
			}
			
			$.ajax({
				type : "POST",
				url : "/sam/doWithdraw.do",
				data : data,
				dataType : "JSON",
				success : function(data){
					console.log(data);
					if(data == 0){
						alert('잘못된 접근입니다');
						return
					}
					if(data == 1){
						alert("탈퇴하였습니다.");
						location.href = "/sam/main.do";
					}
				},
				error : function(data){
					console.log(data);
				}
			});
			
		}
		
	} 

</script>

