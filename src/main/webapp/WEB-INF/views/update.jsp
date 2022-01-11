<!DOCTYPE html>
<html lang="kr">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 수정하기
					</h4>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td>
											<input type="text" class="form-control write-form" name="boardTitle" id="title" value="${detailBoard.BOARD_TITLE }">
											<input id="hiddenBoardIdx" type="hidden" value="${detailBoard.BOARD_IDX }">
											<input id="hiddenBoardWriter" type="hidden" value="${detailBoard.BOARD_WRITER }">
										</td>
										<th>조회수</th>
										<td>${detailBoard.BOARD_VIEW_COUNT }</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>${detailBoard.BOARD_WRITER }</td>
										<th>작성일자</th>
										<td>${detailBoard.BOARD_WRITE_DATE }</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="detail-content">
												<textarea class="form-control write-form" rows="14" name="boardContents" id="contents" placeholder="${detailBoard.BOARD_CONTENTS }">${detailBoard.BOARD_CONTENTS }</textarea>
											</div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3">
											<c:choose>
												<c:when test="${empty detailBoard.FILE_ORIGINAL_NAME }">
												
												</c:when>
												<c:otherwise>
													${detailBoard.FILE_ORIGINAL_NAME }
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="location.href='main.do';">목록</button>
						</div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="doUpdate(
								$('#hiddenBoardIdx').val(), $('#title').val(), $('#contents').val(), $('#hiddenBoardWriter').val()
							)">완료</button>
						</div>
					</div>
				</div>
			</div>
			<div id="dropDownSelect1"></div>
</body>

</html>

<script>

	function doUpdate(boardIdx, title, contents, boardWriter){
		
		var answer = confirm("수정하시겠습니까?");
		if(answer){
			
			data = {
					'boardIdx' : boardIdx,
					'title' : title,
					'contents' : contents,
					'boardWriter' : boardWriter
				}
			
			$.ajax({
				type : "POST",
				url : "/sam/doUpdate.do",
				data : data,
				dataType : "JSON",
				success : function(data){
					console.log(data);
					if(data == 0){
						alert("잘못된 접근입니다.")
					}
					if(data == 1){
						alert("수정에 성공하였습니다.")
						location.href = "main.do";
					}
				},
				error : function(data){
					console.log(data);
				}
			});
		}
		
	}
	
	
	
</script>
