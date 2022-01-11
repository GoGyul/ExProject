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
					<div class="row">
						<form id="listForm" action="adminMember.do" name="POST">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<div class="row">
							<div class="col-sm-4">
								<button onclick="choiceDelete()" type="button" class="btn btn-default">선택탈퇴</button>
								<button onclick="location.href='/sam/admin.do'" type="button" class="btn btn-default">게시글 관리</button>
							</div>
							<div class="col-sm-2"></div>
							<div class="col-sm-2">
								<select class="form-control" name="keywordType" id="keywordType">
									<option class="optionKeywordTypeWriterAndNameAndPhoneAndEmail" value="writerAndNameAndPhoneAndEmail">전체</option>
									<option class="optionKeywordTypeWriter" value="writer">아이디</option>
									<option class="optionKeywordTypeName" value="name">이름</option>
									<option class="optionKeywordTypePhone" value="phone">휴대전화</option>
									<option class="optionKeywordTypeEmail" value="email">이메일</option>
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
					<input type="hidden" id="listSize" value="${fn:length(writerList) }">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input id="checkAll" type="checkbox" /></th>

										<th style="width: 5%;">아이디</th>
										<th style="width: 5%;">이름</th>
										<th style="width: 10%;">핸드폰</th>
										<th style="width: 10%;">이메일</th>
										<th style="width: 5%;">탈퇴</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="writerList" items="${writerList }" varStatus="i">
									<input type="hidden" id="boardWriterIdx${i.index}" value="${writerList.BOARD_WRITER_IDX }">
									<tr>
										<c:choose>
											<c:when test="${writerList.DEL_YN eq 'N' }">
												<td id="checkboxView${i.index }">
													<input type="checkbox" name="checkChild" class="checkChild" id="checkboxSelect${i.index }" value="${writerList.BOARD_WRITER_IDX }" />
												</td>
											</c:when>
											<c:otherwise>
												<td id="checkboxView${i.index }">
													<input type="checkbox"  name="checkChild" class="checkChild" id="checkboxSelect${i.index }" value="${writerList.BOARD_WRITER_IDX }" disabled/>
												</td>
											</c:otherwise>
										</c:choose>
										<td>${writerList.BOARD_WRITER }</td>
										<td>${writerList.BOARD_WRITER_NAME }</td>
										<td>${writerList.BOARD_WRITER_PHONE }</td>
										<td>${writerList.BOARD_WRITER_EMAIL }</td>
										<c:choose>
											<c:when test="${writerList.DEL_YN eq 'N' }">
												<td id="withdrawButtonView${i.index }">
													<button class="btn btn-default btn-full" onclick="deleteSeperateWriter($('#boardWriterIdx${i.index}').val())">탈퇴</button>
												</td>
											</c:when>
											<c:otherwise>
												<td id="withdrawButtonView${i.index }">
													<button class="btn btn-default btn-full" style="background-color:purple; color:white;" disabled>탈퇴완료</button>
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
						<button type="button" class="btn btn-default" onclick="location.href='/sam/adminMember.do'" >
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

function deleteSeperateWriter(boardWriterIdx){
	
	let listSize = $("#listSize").val();
	
	let answer = confirm("정말 탈퇴 시키겠습니까?");
	
	if(answer){
		
		let data = {
			'boardWriterIdx' : boardWriterIdx	
		}
		
		$.ajax({
			url : "/sam/deleteSeperateWriter.do",
			type : "POST",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				
				if(data == '0'){
					alert("잘못된 접근입니다.");
					return
				}
				
				let htmlString = "";
				let htmlStringWithdrawBtn = "";
				
				for(var i = 0; i<listSize; i++){
					if($("#boardWriterIdx"+i).val() == data.BOARD_WRITER_IDX){
						
						$("#checkboxView"+i).empty();
						htmlString += "<input type='checkbox'  name='checkChild' class='checkChild'  disabled/>";
						$("#checkboxView"+i).html(htmlString);
						
						$("#withdrawButtonView"+i).empty();
						htmlStringWithdrawBtn += "<button class='btn btn-default btn-full' style='background-color:purple; color:white;' disabled>탈퇴완료</button>"
						$("#withdrawButtonView"+i).html(htmlStringWithdrawBtn);
					}
				}
				alert("완료되었습니다.");
			},
			error : function(data){
				console.log(data);
				alert("삭제에 실패하였습니다.");
			}
		});
		
	}
}

function choiceDelete(){
	
	let listSize = $("#listSize").val();
	
	let answer = confirm("선택한 회원을 탈퇴하시겠습니까???");
	
	if(answer){
		
		let checkArr = [];
		
		$('input[name=checkChild]:checked').each(function(){
			checkArr.push($(this).val());
		});
		
		if(Array.isArray(checkArr) &&  checkArr.length ===0 ){
			alert("선택된 회원이 없습니다..");
			return
		}
		
		let data = {
			'boardWriterIdxList' : checkArr
		}
		
		$.ajax({
			url : "/sam/choiceDeleteWriter.do",
			type : "POST",
			data : data,
			dataType : "JSON",
			success : function(data){
				console.log(data);
				if(data == '0'){
					alert("잘못된 접근입니다.");
					return
				}
				
				alert("선택한 회원이 탈퇴처리 되셨습니다.");
				
				let htmlString = "";
				let htmlStringWithdrawBtn = "";
				let value = [];
				
				for(var i = 0; i<listSize; i++){
					for(var j = 0; j<data.length; j++){
						if($("#boardWriterIdx"+i).val() == data[j].boardWriterIDX){
							value.push(i);
							$("#checkboxView"+i).empty();
							htmlString += "<input type='checkbox'  name='checkChild' class='checkChild'  disabled/>";
							$("#checkboxView"+i).html(htmlString);
							
							$("#withdrawButtonView"+i).empty();
							htmlStringWithdrawBtn += "<button class='btn btn-default btn-full' style='background-color:purple; color:white;' disabled>탈퇴완료</button>"
							$("#withdrawButtonView"+i).html(htmlStringWithdrawBtn);
							
							htmlString = "";
							htmlStringWithdrawBtn = "";
						}
					}
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
    var optionKeywordTypeWriter = $(".optionKeywordTypeWriter");
    var optionKeywordTypeName = $(".optionKeywordTypeName");
    var optionKeywordTypePhone = $(".optionKeywordTypePhone");
    var optionKeywordTypeEmail = $(".optionKeywordTypeEmail");
    var optionKeywordTypeWriterAndNameAndPhoneAndEmail = $(".optionKeywordTypeWriterAndNameAndPhoneAndEmail");
    
    function getParameterByName(name) { name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]"); 
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), 
        results = regex.exec(location.search); 
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " ")); 
    }
    function holdKeywordType(keywordType){
    	if(keywordType == "writerAndNameAndPhoneAndEmail"){
    		optionKeywordTypeWriterAndNameAndPhoneAndEmail.prop("selected",true);
    	}
        if(keywordType == "writer"){
            console.log("holdKeywordType ======= writer");
            optionKeywordTypeWriter.prop("selected",true);
        }
        if(keywordType == "name"){
            console.log("holdKeywordType ======= content");  
            optionKeywordTypeName.prop("selected",true);      
        }
        if(keywordType == "phone"){
            console.log("holdKeywordType ======= phone");  
            optionKeywordTypePhone.prop("selected",true);      
        }
        if(keywordType == "email"){
            console.log("holdKeywordType ======= email");  
            optionKeywordTypeEmail.prop("selected",true);      
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
