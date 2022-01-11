<!DOCTYPE html>
<html lang="ko">

<head>
<title>ITKey 글상세</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="resources/css/table.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
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
				<div class="login100-form">
					<h4>
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 작성 / 수정
					</h4>
					<form id="doWrite" action="writeBoard.do" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th class="padding-lg">제 목</th>
										<td colspan="3">
											<input name="boardTitle" type="text" class="form-control write-form" id="title" placeholder="제목을 작성해 주세요." >
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td colspan="1">${sessionScope.login.boardWriterName}</td>
										<input type="hidden" name="boardWriter" value="${sessionScope.login.boardWriter}">
										<th>공개여뷰</th>
										<td colspan="1">
											<input type="radio" name="boardPublicFl" value="Y" checked="checked">공개
											<input type="radio" name="boardPublicFl" value="N">비공개
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="detail-content">
												<textarea name="boardContents" class="form-control write-form" rows="14" id="content" placeholder="내용을 작성해 주세요." ></textarea>
											</div>
										</td>
									</tr>
									<tr>
										<th class="padding-lg">첨부파일</th>
										<td colspan="3">
											<input type="file" class="upload up" name="uploadFiles" multiple="multiple" id="up" onchange="readURL(this);" >
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-2">
							<button type="button" class="btn btn-default btn-full" onclick="location.href='main.do';">목록</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button id="writeBtn" type="button" onclick="writeBoard()" class="btn btn-default btn-full">저장</button>
						</div>
					</div>
					</form>
				</div>
			</div>
			<div id="dropDownSelect1"></div>
</body>

</html>

<script>

function writeBoard(){
	
	var boardPublicFl = $('input[name=boardPublicFl]:checked').val();
	var title = $("#title").val();
	var content = $("#content").val();
	
	if(title.replace(/\s+/g, '') == '' || content.replace(/\s+/g, '') == ''){
		alert("제목 혹은 내용을 입력해주세요");
		return
	}
	
	console.log(boardPublicFl);
	
	if(boardPublicFl == 'N'){
		var answer = confirm("비공개 글은 관리자와 본인을 제외한 다른 사용자는 접근이 불가합니다. 그래도 진행하겠습니까?????");
		if(answer){
			$("#doWrite").submit();
		}
	}
	if(boardPublicFl == 'Y'){
		$("#doWrite").submit();
	}
	
}

</script>
