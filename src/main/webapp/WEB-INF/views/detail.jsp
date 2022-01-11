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
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세보기
					</h4>
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-up"></i> 이전글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<c:if test="${ empty prevBoard }">
									더이상 글이 존재하지 않습니다..
								</c:if>
								<c:if test="${ !empty prevBoard }">
									<button class="btn btn-link" onclick="location.href='getBoard.do?boardIdx=${prevBoard.BOARD_IDX}&keywordType=${keywordType}&keyword=${keyword}'">${prevBoard.BOARD_TITLE}</button>
								</c:if>	
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">${prevBoard.BOARD_WRITE_DATE}</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td>${detailBoard.BOARD_TITLE}</td>
										<th>조회수</th>
										<td>${detailBoard.BOARD_VIEW_COUNT}</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>${detailBoard.BOARD_WRITER}</td>
										<th>작성일자</th>
										<td>${detailBoard.BOARD_WRITE_DATE}</td>
									</tr>
									<tr>
										<td colspan="4">
										<c:choose>
											<c:when test="${empty detailBoard.FILE_ORIGINAL_NAME }">
											</c:when>
											<c:otherwise>
												<img src="${pageContext.request.contextPath}/resources/images/${detailBoard.FILE_ORIGINAL_NAME}" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
											</c:otherwise>
										</c:choose>
											<div class="detail-content"> ${detailBoard.BOARD_CONTENTS} </div>
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
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-down"></i> 다음글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<c:if test="${ empty nextBoard }">
									더이상 글이 존재하지 않습니다..
								</c:if>
								<c:if test="${ !empty nextBoard }">
									<button class="btn btn-link" onclick="location.href='getBoard.do?boardIdx=${nextBoard.BOARD_IDX}&keywordType=${keywordType}&keyword=${keyword}'" >${nextBoard.BOARD_TITLE}</button>	
								</c:if>	
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">${nextBoard.BOARD_WRITE_DATE}</div>
						</div>
					</div>
					<div class="row">
						<input type="hidden" id="hiddenBoardIdx" value="${detailBoard.BOARD_IDX }">
						<input type="hidden" id="hiddenBoardWriter" value="${detailBoard.BOARD_WRITER }">
						<input type="hidden" id="hiddenBoardPublicFl" value="${detailBoard.BOARD_PUBLIC_FL }">
						<c:choose>
							<c:when test="${sessionScope.login.boardWriter eq 'ADMIN'}">
								<div class="col-sm-2">
									<button class="btn btn-default btn-full" onclick="location.href='admin.do';">목록</button>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-sm-2">
									<button class="btn btn-default btn-full" onclick="location.href='main.do';">목록</button>
								</div>
							</c:otherwise>
						</c:choose>
						
						<div class="col-sm-6"></div>
						<c:choose>
							<c:when test="${detailBoard.BOARD_WRITER eq sessionScope.login.boardWriter}" >
								<div class="col-sm-2">
									<button class="btn btn-default btn-full" onclick="location.href='update.do?boardIdx=${detailBoard.BOARD_IDX}&boardPublicFl=${detailBoard.BOARD_PUBLIC_FL}&boardWriter=${detailBoard.BOARD_WRITER }'">수정</button>
								</div>
								<div class="col-sm-2">
									<button class="btn btn-default btn-full" onclick="doDelete(
										 $('#hiddenBoardIdx').val(), $('#hiddenBoardWriter').val()
									)">삭제</button>
								</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div id="dropDownSelect1"></div>
</body>

</html>

<script>

	function doDelete(boardIdx,boardWriter){
		
		var answer = confirm("정말 삭제하시겠습니까? 복구하실수 없습니다.");
		
		if(answer){
			
			data = {
				'boardIdx' : boardIdx,	
				'boardWriter' : boardWriter
			}
			
			$.ajax({
				type : "POST",
				url : "/sam/doDelete.do",
				data : data,
				dataType : "JSON",
				success : function(data){
					console.log(data);
					if(data == 0){
						alert("잘못된 접근입니다.")
					}
					if(data == 1){
						alert("삭제에 성공하였습니다.")
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
