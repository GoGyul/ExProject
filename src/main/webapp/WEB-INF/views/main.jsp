<!DOCTYPE html>
<html lang="en">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>
<title>ITKey 게시판</title>
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
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set> 
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div>
							<input id="hiddenSessionWriter" type="hidden" value="${sessionScope.login.boardWriter}">
							<h3 style="float: left">
								[안녕하세요. <b>${sessionScope.login.boardWriterName}</b>님]
							</h3>
							<c:if test="${empty sessionScope.login.boardWriterName }">
								<div align="right">
									<button onClick="location.href='login.do'" type="button" class="btn btn-default" id="login">로그인</button>
								</div>
							</c:if>
							<c:if test="${!empty sessionScope.login.boardWriterName }">
								<form action="logout.do" method="post">
									<div align="right">
										<button type="submit" class="btn btn-default" id="logOut">로그아웃</button>
									</div>
								</form>
							</c:if>
						</div> 
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content">${allBoardCount}</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content">${allWriterCount}</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content">${todayBoardCount}</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content">${todayRegistCount}</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<form id="listForm" action="main.do" name="POST">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<div class="row">
							<div class="col-sm-4">
							<c:if test="${empty sessionScope.login.boardWriterName }">
								<button type="button" class="btn btn-default" onClick="noLoginUserCantWrite()">
									<i class="fas fa-plus"></i> 새글 추가
								</button>
							</c:if>
							<c:if test="${!empty sessionScope.login.boardWriterName }">
								<button type="button" class="btn btn-default" onClick="location.href='write.do?boardWriter=${sessionScope.login.boardWriter}'">
									<i class="fas fa-plus"></i> 새글 추가
								</button>
							</c:if>
								<button type="button" class="btn btn-default" onclick="goChat()">채팅하기</button>
								<button type="button" class="btn btn-default" onclick="updateWriter($('#hiddenSessionWriter').val())">정보수정</button>
							</div>
							<div class="col-sm-2"></div>
							<div class="col-sm-2">
								<select class="form-control" name="keywordType" id="keywordType">
									<option class="optionKeywordTypeWriterAndContent" value="writerAndTitle">전체</option>
									<option class="optionKeywordTypeWriter" value="writer">작성자</option>
									<option class="optionKeywordTypeContent" value="content">글내용</option>
								</select>
							</div>
							<div class="col-sm-3">
								<input id="input-keyword" name="keyword" type="text" class="form-control" id="" placeholder="검색어를 입력하세요">
								</div>
							<div class="col-sm-1 text-right">
								<button type="submit" class="btn btn-default btn-full" id="searchBtn">
									<i class="fas fa-search"></i> 검색
								</button>
							</div>
						</div>
					</form>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 8%;">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boardList" items="${boardList }" varStatus="i">
									<input type="hidden" id="boardIdx${i.index}" value="${boardList.BOARD_IDX }">
								    	<tr>
								    	<td >
								    		${total - ((pageMaker.cri.pageNum -1) * pageMaker.cri.amount +i.index ) }
								    	</td>
									    <td id="boardWriter${i.index }">${boardList.BOARD_WRITER }</td>
									    <c:choose>
									    	<c:when test="${boardList.BOARD_PUBLIC_FL eq 'Y'}">
									    		<td>
													<i class="fas fa-unlock"></i>
												</td>
												<c:choose>
													<c:when test="${sysYear eq boardList.BOARD_WRITE_DATE }">
														<td class="title">
															<a href="getBoard.do?boardIdx=${boardList.BOARD_IDX}&keywordType=${keywordType}&keyword=${keyword}">${boardList.BOARD_TITLE } n
															</a>
															
														</td>
													</c:when>
													<c:otherwise>
														<td class="title">
															<a href="getBoard.do?boardIdx=${boardList.BOARD_IDX}&keywordType=${keywordType}&keyword=${keyword}">${boardList.BOARD_TITLE }  
															</a>
														</td>
													</c:otherwise>
												</c:choose>
									    	</c:when>
									    	<c:otherwise>
										    	<td>
													<i class="fas fa-lock"></i>
												</td>
												<c:choose>
													<c:when test="${sysYear eq boardList.BOARD_WRITE_DATE }">
														<td class="title">
														<a 
														onclick="canNotReadSecretBoard($('#boardWriter${i.index}').text(), $('#hiddenSessionWriter').val(), $('#boardIdx${i.index}').val())"
														>${boardList.BOARD_TITLE } n </a></td>
													</c:when>
													<c:otherwise>
														<td class="title">
														<a 
														onclick="canNotReadSecretBoard($('#boardWriter${i.index}').text(),$('#hiddenSessionWriter').val(), $('#boardIdx${i.index}').val())"
														>${boardList.BOARD_TITLE }  </a></td>
													</c:otherwise>
												</c:choose>
									    	</c:otherwise>
									    </c:choose>
										<td><fmt:formatDate value="${boardList.BOARD_WRITE_DATE }" pattern="yyyy-MM-dd"/></td>
									    <td>${boardList.BOARD_VIEW_COUNT }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<button type="button" class="btn btn-default" onclick="location.href='/sam/main.do'" >
							목록으로
						</button>
						<div class="col-sm-12 text-center page-div">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
						            <li class="page-item pagination_button">
						                <a class="page-link" href="${pageMaker.startPage - 1 }" >Prev</a>
						            </li>
						        </c:if>
						        <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							        <li class="page-item pagination_button ${num == pageMaker.cri.pageNum? "active" : "" }" > 
							            <a id="nowPage" class="page-link" href="${num }">${num }</a>
							        </li>
						        </c:forEach>
						        <c:if test="${pageMaker.next }">
							        <li class="page-item pagination_button">
							            <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
							        </li>
						        </c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>

</html>

<script>

function noLoginUserCantWrite(){
    alert("로그인이 필요합니다.");
}

function goChat(){
	
	let hiddenSessionWriter = $("#hiddenSessionWriter").val();
	
	if(hiddenSessionWriter == '' || hiddenSessionWriter == null || hiddenSessionWriter == undefined){
		alert("로그인한 회원만 이용 가능합니다.");
		return
	}
	
	location.href = "/sam/chat.do";
	
}

function canNotReadSecretBoard(boardWriter,sessionId, boardIdx){
	
	if(boardWriter == sessionId){
		location.href = "/sam/sercretBoard.do?boardWriter="+boardWriter+"&boardIdx="+boardIdx;
		
	}else{
		alert("다른 유저가 작성한 비공개 글 은 열람 할 수 없습니다.");
	}
}

function updateWriter(boardWriter){
	if(boardWriter == ''){
		alert("로그인 후 이용해 주세요");
		location.href = "/sam/login.do";
	}else{
		
		data = {'boardWriter' : boardWriter}
		
		$.ajax({
			type : "POST",
			url : "/sam/modifyWriter.do",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				if(data == 0){
					alert("잘못된 접근입니다.")
				}
				if(data == 1){
					location.href = "/sam/modifyWriterView.do?boardWriter="+boardWriter;
				}
			},
			error : function(data){
				console.log(data);
			}
		});
	}
	
}

$(document).ready(function() {
    //console.log($("#hKeywordType").val());
    //console.log($("#hKeyword").val());
    var listForm = $("#listForm");
    var link = document.location.href;
    var keyword = getParameterByName('keyword');
    var keywordType = getParameterByName('keywordType');
    var optionKeywordTypeTitle = $(".optionKeywordTypeWriter");
    var optionKeywordTypeContent = $(".optionKeywordTypeContent");
    var optionKeywordTypeWriterAndContent = $(".optionKeywordTypeWriterAndContent");
    function getParameterByName(name) { name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]"); 
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), 
        results = regex.exec(location.search); 
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " ")); 
    }
    function holdKeywordType(keywordType){
    	if(keywordType == "writerAndTitle"){
    		optionKeywordTypeWriterAndContent.prop("selected",true);
    	}
        if(keywordType == "writer"){
            console.log("holdKeywordType ======= title");
            optionKeywordTypeTitle.prop("selected",true);
        }
        if(keywordType == "content"){
            console.log("holdKeywordType ======= content");  
            optionKeywordTypeContent.prop("selected",true);      
        }
    }
        $(".page-link").on("click", function(e) {
        e.preventDefault();
        
        listForm.find("input[name='pageNum']").val($(this).attr("href"));
        listForm.submit();
    });
    
    document.getElementById("input-keyword").value=keyword;
    //console.log(link);
    //console.log(keyword);
    //console.log(optionKeywordTypeTitle);
    //console.log(optionKeywordTypeContent);
    holdKeywordType(keywordType);
});

</script>
