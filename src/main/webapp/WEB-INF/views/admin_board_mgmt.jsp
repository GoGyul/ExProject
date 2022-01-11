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
							<input id="hiddenSessionWriter" type="hidden" value="${sessionScope.login}">
							<h3 style="float: left">
								[안녕하세요. <b>${sessionScope.login.adminName}</b>님]
							</h3>
							<c:if test="${empty sessionScope.login }">
								<div align="right">
									<button onClick="location.href='login.do'" type="button" class="btn btn-default" id="login">로그인</button>
								</div>
							</c:if>
							<c:if test="${!empty sessionScope.login }">
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
					<form id="listForm" action="admin.do" name="POST">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<div class="row">
							<div class="col-sm-4">
								<button onclick="choiceDelete()" type="button" class="btn btn-default">선택삭제</button>
								<button onclick="location.href='/sam/adminMember.do'" type="button" class="btn btn-default">회원관리</button>
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
					</div>
					<div class="row">
						<input type="hidden" id="listSize" value="${fn:length(boardList) }">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input id="checkAll" type="checkbox" /></th>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 10%;">삭제</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="boardList" items="${boardList }" varStatus="i">
									<input type="hidden" id="boardIdx${i.index}" value="${boardList.BOARD_IDX }">
								    	<tr>
								    		<c:choose>
												<c:when test="${boardList.BOARD_DEL_YN eq 'N' }">
													<td id="checkboxView${i.index }">
														<input type="checkbox" name="checkChild" class="checkChild" id="checkboxSelect${i.index }" value="${boardList.BOARD_IDX }" />
													</td>
												</c:when>
												<c:otherwise>
													<td id="checkboxView${i.index }">
														<input type="checkbox"  name="checkChild" class="checkChild" id="checkboxSelect${i.index }" value="${boardList.BOARD_IDX }" disabled/>
													</td>
												</c:otherwise>
											</c:choose>
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
										    	</c:otherwise>
										    </c:choose>
											<td>
												<fmt:formatDate value="${boardList.BOARD_WRITE_DATE }" pattern="yyyy-MM-dd"/>
											</td>
											<c:choose>
												<c:when test="${boardList.BOARD_DEL_YN eq 'N' }">
													<td id="deleteButtonView${i.index }">
														<button class="btn btn-default btn-full" onclick="deleteSeperateBoard($('#boardIdx${i.index}').val())">삭제</button>
													</td>
												</c:when>
												<c:otherwise>
													<td id="deleteButtonView${i.index }">
														<button class="btn btn-default btn-full" style="background-color:purple; color:white;" disabled>삭제완료</button>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<button type="button" class="btn btn-default" onclick="location.href='/sam/admin.do'" >
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

function deleteSeperateBoard(boardIdx){
	
	let listSize = $("#listSize").val();
	
	let answer = confirm("삭제하시겠습니까?");
	
	if(answer){
		
		let data = {
			'boardIdx' : boardIdx	
		}
		
		$.ajax({
			url : "/sam/deleteSeperateBoard.do",
			type : "POST",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				if(data == '0'){
					alert("잘못된 접근입니다.");
					return
				}
				
				var htmlString = "";
				var htmlStringDeleteBtn = "";
				
				for(var i = 0; i<listSize; i++){
					if($("#boardIdx"+i).val() == data.BOARD_IDX){
						
						$("#checkboxView"+i).empty();
						htmlString += "<input type='checkbox'  name='checkChild' class='checkChild'  disabled/>";
						$("#checkboxView"+i).html(htmlString);
						
						$("#deleteButtonView"+i).empty();
						htmlStringDeleteBtn += "<button class='btn btn-default btn-full' style='background-color:purple; color:white;' disabled>삭제완료</button>"
						$("#deleteButtonView"+i).html(htmlStringDeleteBtn);
					}
					
				}
			},
			error : function(data){
				console.log(data);
				alert("삭제에 실패하였습니다.");
			}
		});
		
	}
}

function choiceDelete(){
	
	let answer = confirm("선택한 게시물을 삭제하시겠습니까?? 리스트 갯수는");
	
	if(answer){
		
		let checkArr = [];
		
		$('input[name=checkChild]:checked').each(function(){
			checkArr.push($(this).val());
		});
		
		if(Array.isArray(checkArr) &&  checkArr.length ===0 ){
			alert("선택된 게시글이 없습니다.");
			return
		}
		
		let data = {
			'boardIdxList' : checkArr
		}
		
		$.ajax({
			url : "/sam/choiceDelete.do",
			type : "POST",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				if(data == 0){
					alert("잘못된 접근입니다.")
				}
				if(data == 1){
					alert("선택한 게시글이 삭제되었습니다.");
					location.href = "/sam/admin.do";
				}
			},
			error : function(data){
				console.log(data);
			}
		});
		
	}
}

$(document).ready(function() {
	
	$("#checkAll").click(function(){
		$('.checkChild:not(:disabled)').prop('checked', this.checked);
	})
	
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
