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
<link rel="stylesheet" type="text/css" href="resources/css/chat.css">
<link rel="stylesheet" type="text/css" href="resources/css/ajax.main.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">

<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	function fn_chat_toggle() {
		$(".panel-whole-body").slideToggle();
	}
</script>

<style type="text/css">
	.on{background-color : red}
</style>
</head>

<body>
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set> 
<form>
	<input type="hidden" id="cntListURL" value="/sam/listCntForAjax.do" />
	<input type="hidden" id="listUrl" value="/sam/boardListForAjax.do">
	<input type="hidden" id="checkIdUrl" value="/sam/checkIdForAjax.do">
	<input type="hidden" id="sessionUrl" value="/sam/sessionForAjax.do"/> 
	<input type="hidden" id="loginCheckUrl" value="/sam/loginCheckForAjax.do"/>
	<input type="hidden" id="logoutUrl" value="/sam/logoutForAjax.do"/>
	<input type="hidden" id="countUrl" value="/sam/countForAjax.do"/>
	<input type="hidden" id="selectUrl" value="/sam/selectBoardForAjax.do">
	<input type="hidden" id="delUrl" value="/sam/deleteBoardForAjax.do">
	<input type="hidden" id="fileDownUrl" value="/sam/fileDownForAjax.do">
	<input type="hidden" id="updateWrite" value="/sam/updateWrite.do">
	<input type="hidden" id="updateViewUrl" value="/sam/updateView.do">
<!-- 
	
	<input type="hidden" id="selPage" name="selPage" value="1"/>
	<input type="hidden" id="selCnt" name="selCnt" value="15"/>
	<input type="hidden" id="searching" name="searching" value="0"/>
	
 -->
 
	<input type="hidden" id="loginId" value="">
</form>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ITKey Education</a>
				<input type="text" id="sessionName" name="boardWriterName" value="${sessionScope.loginName}">
			</div>
			
			<!-- 
				<ul class="nav navbar-nav navbar-right navbar-logout">
					<li class="login-img"><img src="" class="img-circle img-loginer" style="width: 35px; height: 35px;"></li>
					<li>
						<h5 class="h5-nav">
							<u></u><font style="color: #cacaca"> 님 안녕하세요.</font>
						</h5>
					</li>
					<li><a href="#"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
				</ul>
				
				<ul class="nav navbar-nav navbar-right navbar-login">
					<li class="li-login"><input type="text" class="form-control nav-login" id="" placeholder="로그인 아이디"></li>
					<li class="li-login"><input type="text" class="form-control nav-login" id="" placeholder="비밀번호"></li>
					<li><a href="#"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
					<li><a href="#" data-toggle="modal" data-target="#joinModal"><i class="fas fa-user-plus"></i> 회원가입</a></li>
					<li><a href="#" data-toggle="modal" data-target="#memModiModal "><i class="fas fa-user"></i> 정보수정</a></li>
				</ul>
			-->
			<div class="collapse navbar-collapse" id="myNavbar">
				

				
			</div>
		</div>
	</nav>
	<div class="limiter iframe-before-login">
		<div class="container-login100">
			<div class="wrap-login100 warp-iframe">
				<div class="login100-form">
					<div class="row">
						<div class="col-sm-12 col-sm-iframe">
							<iframe src="http://sup.itkey.co.kr/" width="100%" height="750px"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="limiter table-after-login" >
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 id="countBoard" class="overview-content">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 id="countWriter" class="overview-content">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 id="todayBoard" class="overview-content">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 id="todayWriter" class="overview-content">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button id="writeModalBtn" type="button" class="btn btn-default" data-toggle="modal" data-target="#writeModal">
								<i class="fas fa-plus"></i> 새글 추가
							</button>

						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="keywordType" name="keywordType">
								<option class="optionKeywordTypeWriterAndContent" value="writerAndContent">전체</option>
								<option class="optionKeywordTypeWriter" value="writer" >작성자</option>
								<option class="optionKeywordTypeContent" value="content">글내용</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="keyword" name="keyword" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button id="searchBtn" type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
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
										<th style="width: 10%;">조회수</th>
									</tr>
								</thead>
								<tbody id="bdList">
									<tr>
										<td>1</td>
										<td>테스트</td>
										<td>
											<i class="fas fa-lock"></i>
										</td>
										<td>
											<a href="javascript:void(0);" data-toggle="modal" data-target="#modiModal">하이하이</a>
										</td>
										<td>2019-10-13</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<button type="button" class="btn btn-default" onclick="getBoardList()" >
							목록으로
						</button>
						<div class="col-sm-12 text-center">
							<ul class="pagination">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container chatContainer">
		<div class="row chat-window col-xs-5 col-md-3" id="chat_window_1" style="margin-left: 10px;">
			<div class="col-xs-12 col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading top-bar">
						<div class="col-md-8 col-xs-8">
							<h3 class="panel-title">
								<i class="fas fa-comments"></i> ITKey 전체 채팅
							</h3>
						</div>
						<div class="col-md-4 col-xs-4" style="text-align: right;">
							<a href="javascript:void(0);" onclick="fn_chat_toggle();"><i class="fas fa-window-minimize" style="color: white"></i></a>
						</div>
					</div>
				</div>
				<div class="panel-whole-body" style="display: none;">
					<div class="panel-body msg_container_base">
						<div class="row msg_container base_sent">
						<!-- 
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_sent">
									<p>내가 보낸 내용입니다.</p>
									<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
								</div>
							</div>
							<div class="col-md-2 col-xs-2 avatar">
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>
						 -->
						</div>
						<div class="row msg_container base_receive">
							<!-- 
							<div class="col-md-2 col-xs-2 avatar">	
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>	
							 -->
							
							<div class="col-md-10 col-xs-10">
							<!-- 
							<div class="messages msg_receive">	
								<p>다른사람이 보낸 내용입니다.</p>
								<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
							</div>	 
							 -->
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="input-group">
							<input id="msg" type="text" class="form-control input-sm chat_input" placeholder="Write your message here..." />
							<span class="input-group-btn">
								<button class="btn btn-default btn-sm" id="button-send">보내기</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	
	<!--Join Modal -->
	<div class="modal fade" id="joinModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<form id="registerForm" action="/sam/registerForAjax.do" method="post" enctype="multipart/form-data">
						<div class="row">
							<div class="col-sm-12">
								<img  class="img-circle" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
							<div class="input-group">
								<input type="text" class="form-control" readonly>
								<div class="input-group-btn">
									<span class="fileUpload btn login100-form-btn login-file-btn"> <span class="upl" id="upload">업로드</span> 
									<input type="file" class="upload up" name="uploadFile" multiple="multiple" id="up" onchange="readURL(this);" />
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
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="boardWriter" class="input100" type="text" name="boardWriter" placeholder="ID">
									<span class="focus-input100" data-placeholder="&#xf207;"></span>
								</div>
								<span id="checkId" style="display: none; margin-top: -26px;"> 존재하는 아이디 입니다 </span>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter password">
									<input id="boardWriterPw" class="input100" type="password" name="boardWriterPw" placeholder="Password">
									<span class="focus-input100" data-placeholder="&#xf191;"></span>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="boardWriterName" class="input100" type="text" name="boardWriterName" placeholder="이름 입력란">
									<span class="focus-input100" data-placeholder="&#xf205;"></span>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="boardWriterPhone" class="input100" type="text" name="boardWriterPhone" placeholder="- 를 제외하고 입력해주세요">
									<span class="focus-input100" data-placeholder="&#xf2be;"></span>
								</div>
							</div>
						</div>
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input id="boardWriterEmail" class="input100" type="text" name="boardWriterEmail" placeholder="이메일을 입력해주세요.">
							<span class="focus-input100" data-placeholder="&#xf15a;"></span>
						</div>
						<span id="checkEmailMsg" style="display: none; margin-top: -26px;"> 형식에 맞지 않는 이메일입니다. </span>
	
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input id="boardWriterEmail2" class="input100" type="text" name="boardWriterEmail2" placeholder="이메일을 다시한번 입력해주세요.">
							<span class="focus-input100" data-placeholder="&#xf159;"></span>
						</div>
	
						<div class="container-login100-form-btn">
							<div id="registerBtn"  class="login100-form-btn">가입</div> 
							<a href="" id="jCancleBtn" data-dismiss="modal" class="login100-form-btn">취소</a>
						</div>
					</form>	
				</div>
			</div>
		</div>
	</div>
	<!--//Join Modal -->

	<!--MemberModify Modal -->
	<div class="modal fade" id="memModiModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<img src="" class="img-circle" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<span class="fileUpload btn login100-form-btn login-file-btn"> <span class="upl" id="upload">업로드</span> <input type="file" class="upload up" id="up" onchange="readURL(this);" />
								</span>
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
								<input class="input100" type="text" name="username" placeholder="ID는 수정불가">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="username" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="username" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="password" name="pass" placeholder="이메일.">
								<span class="focus-input100" data-placeholder="&#xf159;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="pass" placeholder="암호를 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="pass" placeholder="암호 확인.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="container-login100-form-btn">
						<a href="" class="login100-form-btn">수정</a> <a href="" class="login100-form-btn">탈퇴</a> <a href="" class="login100-form-btn">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//MemberModify Modal -->

	<!--Write Modal -->
	<div class="modal fade" id="writeModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 추가/수정
					</h4>
				</div>
				<div class="modal-body">
					<form id="boardWriteForm" action="/sam/boardWriteForAjax.do" method="post" enctype="multipart/form-data">
					<input type="text" id="sessionId" name="boardWriter" value="${sessionScope.loginId}"> 
					<input type="hidden" name="boardIdx" id="modiIdx" value="0"/>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td colspan="3" class="input-td">
											<input id="boardTitle" name="boardTitle" type="text" class="form-control input-sm" placeholder="제목을 입력해 주세요.">
										</td>
										<th>공개여부</th>
										<td colspan="3">
											<input type="radio" name="boardPublicFl" value="Y" checked="checked">공개
											<input type="radio" name="boardPublicFl" value="N">비공개
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td id="writerName"></td>
										<th>작성일자</th>
										<td id="today">${sysYear }</td>
									</tr>
									<tr>
										<td class="input-td" colspan="4">
											<textarea id="boardContent" name="boardContents" class="form-control" style="resize: none;" rows="15" id="comment" placeholder="내용을 입력해 주세요."></textarea>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td id="fileInfo" colspan="3">
											<input type="file" multiple="multiple" id="input-file-now" name="uploadFile" class="file-upload" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</form>
					<div class="row">
						<div class="col-sm-2">
							<button id="writeSaveBtn" class="btn btn-default btn-full">저장</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button id="writeCloseBtn" class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--//Write Modal -->
	
	<!--update Modal -->
	<div class="modal fade" id="updateWriteModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i>수정
					</h4>
				</div>
				<div class="modal-body">
					<form id="boardUpdateForm" action="/sam/boardUpdateForAjax.do" method="post" enctype="multipart/form-data">
					<input type="text" id="hiddenUpdateWriterId" name="boardUpdateWriter" value=""> 
					<input type="hidden" name="boardIdx" id="updateIdx" value="0"/>
					<input type="hidden" id="hiddenFileIdx" name="fileIdx" value="">
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td colspan="3" class="input-td">
											<input id="updateTitle" name="boardTitle" type="text" class="form-control input-sm" placeholder="제목을 입력해 주세요.">
										</td>
										<th>공개여부</th>
										<td colspan="3">
											<input type="radio" name="boardPublicFl" value="Y" checked="checked">공개
											<input type="radio" name="boardPublicFl" value="N">비공개
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td id="updateWriterId"></td>
										<th>작성일자</th>
										<td id="updateToday"></td>
									</tr>
									<tr>
										<td class="input-td" colspan="4">
											<textarea id="updateContent" name="boardContents" class="form-control" style="resize: none;" rows="15" id="comment" placeholder="내용을 입력해 주세요."></textarea>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td id="updateFileInfo" colspan="3">
											<input type="file" multiple="multiple" id="input-file-now" name="uploadFile" class="file-upload" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					</form>
					<div class="row">
						<div class="col-sm-2">
							<button id="updateSaveBtn" class="btn btn-default btn-full">저장</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button id="updateCloseBtn" class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--//update Modal -->

	<!--modify Modal -->
	<div class="modal fade" id="modiModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세 정보
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i id="prevBoard" class="fas fa-chevron-up"></i> 이전글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div id="prevBoardTitle" class="well well-sm">
								<button  class="btn btn-link">이전 글 제목입니다.</button>
								</a>
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div id="prevBoardDate" class="well well-sm">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td id="contentTitle">제목입니다.</td>
										<th>조회수</th>
										<td id="contentView">1</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td id="contentWriter">홍길동</td>
										<th>작성일자</th>
										<td id="contentDate">2021년01월01일</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="contentContent"></div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3" id="contentFile"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i id="nextBoard" class="fas fa-chevron-down"></i> 다음글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div id="nextBoardTitle" class="well well-sm">
								<button  class="btn btn-link">다음 글 제목입니다.</button>
								</a>
							</div>
						</div>
						<div  class="col-sm-2 col-footer">
							<div id="nextBoardDate" class="well well-sm">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div id="updateBoardDiv" class="col-sm-2">
							<button class="btn btn-default btn-full">수정</button>
						</div>
						<div id="deleteBoardDiv" class="col-sm-2">
							<button class="btn btn-default btn-full">삭제</button>
						</div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2">
							<button id="modiCloseBtn" class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
			<!--//modify Modal -->
</body>
</html>

<script>

var date = new Date();
var cdata = null;
var img = null;
var pageButtonCheck = null;

var sock = null;

function setChat(value){
	
	sock = new SockJS('http://localhost:8080/sam/ajaxMain.do');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;	
	
}		


function sendMessage() {
	sock.send($("#msg").val());
}

//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 
    var timeString = year + '-' + month  + '-' + day +", " + hours + ':' + minutes  + ':' + seconds;
	
	
	var realData = msg;
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
		console.log(realData);
	}
	
	var cur_session = $("#sessionName").val(); //현재 세션에 로그인 한 사람
	
	sessionId = arr[0];
	message = arr[1];
	fileName = arr[2];
	
	console.log("cur_session : " + cur_session);
	console.log("sessionId : " + sessionId);
	console.log("fileName : " + fileName);
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		
		var str = "<div class='row msg_container base_sent'>";
		str += "<div class='col-md-10 col-xs-10'>";
		str += "<div class='messages msg_sent'>";
		str += "<p>"+message+"</p>";
		str += "<time>"+timeString+" : <"+sessionId+"></time>";
		str += "</div>";
		str += "</div>";
		str += "<div class='col-md-2 col-xs-2 avatar'>";
		str += "<img src='${pageContext.request.contextPath}/resources/images/"+ fileName 
		+"'  class=' img-responsive '>";
		str += "</div>";
		str += "</div>";
		
		$(".msg_container_base").append(str);
		
		str = "";
	}
	else{
		
		var strRec = "<div class='row msg_container base_receive'>";
		strRec += "<div class='col-md-2 col-xs-2 avatar'>";
		strRec += "<img src='${pageContext.request.contextPath}/resources/images/"+ fileName 
		+"'  class=' img-responsive '>";
		strRec += "</div>";
		strRec += "<div class='col-md-10 col-xs-10'>";
		strRec += "<div class='messages msg_receive'>";
		strRec += "<p>"+message+"</p>";
		strRec += "<time><"+sessionId+"> : "+timeString+"</time>";
		strRec += "</div>";
		strRec += "</div>";
		strRec += "</div>";
		
		$(".msg_container_base").append(strRec);
		
		strRec = "";
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	var user = '${sessionScope.login.boardWriterName }';
	var str = user + " 님이 퇴장하셨습니다.";
	
	$(".msg_container_base").append(str);
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	
	console.log("새 유저 입장");
	var user = $("#sessionName").val();
	var str = user + "님이 입장하셨습니다.";
	
	$(".msg_container_base").append(str);
}

function readURL(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$('.img-circle').attr('src',e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function commonAjax(url, type, data, dataType){
	var result = "";
	$.ajax({
		url: url,
		type: type,
		data: data,
		dataType: dataType,
		async: false,
		success: function(rs){
			result = rs;
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return result;
}

function commonAjaxMulti(url, data, dataType){
	var result = "";
	$.ajax({
		url: url,
		type: 'post',
		data: data,
		dataType: dataType,
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		async: false,
		success: function(rs){
			result = rs;
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return result;
}

// 로그인 로그아웃상태
function sessionCheck(){
	var result = commonAjax($("#sessionUrl").val(), 'post',{}, 'json');
	var html = '';
	console.log(result);
	console.log(result.login);
	console.log(result.loginFileInfo);
	if(result.login!=null){
		console.log("로그인 상태");
		img = result.loginFileInfo.fileOriginalName;
		html += "<ul class='nav navbar-nav navbar-right navbar-logout'>";
		html += "<li class='login-img'><img src='resources/images/"+ img +"' class='img-circle img-loginer' onerror='imgError(this)' style='width: 35px; height: 35px;'></li>";
		html += "<li><h5 class='h5-nav'>";
		html += "<ul>" +result.loginName+ "</ul><font style='color : #cacaca'> 님 안녕하세요.</font>";
		html += "</h5></li>";
		html += "<li><a href='#' id='logoutBtn' onClick='logout()'><i class='fas fa-sign-out-alt'></i> 로그아웃</a></li>";
		html += "</li></ul>";
		
		$('.table-after-login').css('display','block');
		$('.iframe-before-login').css('display','none');
		$('#loginId').val(result.loginId);
		$('#writerName').html(result.loginId);
		$('#sessionId').val(result.loginId);
		$('#sessionName').val(result.loginName);
		$('.chatContainer').css('display', 'block');
		
		if(result.selPage != null) $('#selPage').val(result.selPage);
		if(result.keyWordType != null){
			$("#keywordType").val(result.keywordType);
			$("#keyword").val(result.keyword);
			$("#searching").val('1');
		}
		setChat();
		getBoardList();
		
	}else{
		console.log("비로그인 상태");
		console.log(result);
		html += "<form id='loginFormForAjax' action='/sam/loginForAjax.do' method='post'>";
		html += "<ul class='nav navbar-nav navbar-right navbar-login'>";
		html += "<li class='li-login'><input type='text' class='form-control nav-login' name='boardWriter' id='loginBoardWriter' placeholder='로그인 아이디'></li>";
		html += "<li class='li-login'><input type='password' class='form-control nav-login' name='boardWriterPw' id='loginBoardWriterPw' onkeyup='passwordKeyUp()' placeholder='비밀번호'></li>";
		html += "<li><a href='#' onclick='login()'><i class='fas fa-sign-in-alt'></i> 로그인</a></li>";
		html += "<li><a href='#' data-toggle='modal' data-target='#joinModal'><i class='fas fa-user-plus'></i> 회원가입</a></li>";
		html += "</ul></form>";
		
		$('.table-after-login').css('display','none');
		$('.iframe-before-login').css('display','block');
		$('.chatContainer').css('display', 'none');
		$('#loginId').val("");
		$('#sessionId').val("");
		$('#sessionName').val("");
		//setChat(1);
		
	}
	$('#myNavbar').html(html);
	
}


function registerTest(param){
	var result = commonAjax($('#checkIdUrl').val(), 'post', $('#registerForm').serialize(), 'text');
	console.log($('#registerForm').serialize());
	if(param == "insert"){
		if(result == 0){
			var formdata = new FormData(document.getElementById('registerForm'));
			var rs = commonAjaxMulti($('#registerForm').attr('action'), formdata, 'text');
			console.log(formdata);
			if(rs == 1){
				alert('회원가입 성공');
				$('#jCancleBtn').trigger('click');
			}else{
				alert('회원가입 실패');
			}
		}else{
			alert('이미 존재하는 아이디 입니다.');
		}
	}else if(param == "check"){
		if(result == 0){
			$('#checkId').css('display', 'none');
		}else{
			$('#checkId').css('display', 'block');
		}
	}
}

function login(){
	var result = commonAjax($('#loginCheckUrl').val(), 'post', $('#loginFormForAjax').serialize(), 'text');
	if(result == 0){
		alert("아이디가 존재하지 않습니다.");
	}else if(result == 2){
		alert("비밀번호가 틀렸습니다.");
	}else if(result == 1){
		var result = commonAjax($('#loginFormForAjax').attr('action'), 'post', $('#loginFormForAjax').serialize(), 'json');
		console.log("login result ====== "+ result);
		console.log("login result ====== "+ result.login);
		console.log("login result ====== "+ result.loginId);
		console.log("login result ====== "+ result.loginName);
		sessionCheck();
	}else{
		alert("알수없는 오류");
	}
}

function passwordKeyUp(){
	if($('#loginBoardWriterPw').val().trim() == ""){
		$('#loginBoardWriterPw').css('font-family','inherit');
	}else{
		$('#loginBoardWriterPw').attr('style','color:white !important');
		$('#loginBoardWriterPw').css('font-family','normal');
	}
}

function checkEmail(str){
	var regExp = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/;
	if(regExp.test(str)) return true;
	else return false;
}

function checkPhoneExp(str){
	var phoneExp = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
	if(phoneExp.test(str)) return true;
	else return false;
}

function logout(){
	commonAjax($('#logoutUrl').val(), 'post', {}, 'json');
	sessionCheck();
	setChat(1);
}

function getBoardList(value){
	
	var data = null;
	
	if(value == null){
		data = {};
		resetSearch();
	}else{
		data = value;
	}
	
	var result = commonAjax($('#listUrl').val(), 'post', data ,'json');
	$('#countBoard').text(result.countBoard);
	$('#countWriter').text(result.countWriter);
	$('#todayBoard').text(result.todayCountBoard);
	$('#todayWriter').text(result.todayCountWriter);
	
	var total = result.countBoard;
	var pageNum = $('#pageNum').val();
	var amount = $('#amount').val();
	var startPage = parseInt(result.pageMaker.startPage);
	var endPage = parseInt(result.pageMaker.endPage);
	var totalInt = parseInt(result.pageMaker.total);
	var pageNumInt = parseInt(result.pageMaker.cri.pageNum);
	var amount = parseInt(result.pageMaker.cri.amount);
	var startNum = parseInt(result.pageMaker.cri.startNum);
	
	console.log("토탈 "+ total +","+ pageNumInt + "," + amount);

	var html = "";
	for(var i = 0; i<result.boardList.length; i++){
		html += "<tr>";
		html += "<td style='text-align: center' > "+ (totalInt - (((pageNumInt -1 )) * amount + i ))  +" </td>";
		html += "<td style='text-align: center' > "+ result.boardList[i].BOARD_WRITER +" </td>";
		if(result.boardList[i].BOARD_PUBLIC_FL == 'N'){
			html += "<td style='text-align: center'><i class='fas fa-lock'></i></td>";
		}else{
			html += "<td style='text-align: center'><i class='fas fa-unlock'></i></td>";
		}
		html += "<td><a href='javascript:void(0);' onclick=\"modiModal('"+result.boardList[i].BOARD_PUBLIC_FL +"', '"+ result.boardList[i].BOARD_IDX +"', '"+ result.boardList[i].BOARD_WRITER +"' , '"+ $('#keywordType').val() +"' , '" + $('#keyword').val() +"')\">"+ result.boardList[i].BOARD_TITLE +"</a> </td>";        
		if(result.boardList[i].BOARD_WRITE_DATE == null){
			html += "<td style='text-align: center'>알수없음</td>";
		}else{
			html += "<td style='text-align: center'>"+ result.boardList[i].BOARD_WRITE_DATE +"</td>";
		}
		if(result.boardList[i].BOARD_VIEW_COUNT == null){
			html += "<td style='text-align: center'>"+ 0 +"</td>";
		}else{
			html += "<td style='text-align: center'>"+ result.boardList[i].BOARD_VIEW_COUNT +"</td>";
		}
		html += "</tr>";
	}
	
	console.log("pageMaker.startPage======"+result.pageMaker.startPage);
	console.log("pageMaker.endPage======"+result.pageMaker.endPage);
	console.log("pageMaker.prev======"+result.pageMaker.prev);
	console.log("pageMaker.next======"+result.pageMaker.next);
	console.log("pageMaker.total======"+result.pageMaker.total);
	console.log("pageMaker.cri.pageNum======"+result.pageMaker.cri.pageNum);
	console.log("pageMaker.cri.amount======"+result.pageMaker.cri.amount);
	console.log("pageMaker.cri.startNum======"+result.pageMaker.cri.startNum);
	
	var htmlPage = "";
	if(result.pageMaker.prev == true){
		console.log("true check prev");
		htmlPage += "<li class='page-item pagination_button'>";
		htmlPage += " <a class='page-link' onclick='pageBtn("+(startPage-1)+")' >Prev</a>";
		htmlPage += "</li>";
	}
	for(var j = result.pageMaker.startPage; j<= endPage; j++){
		htmlPage += "<li class='page-item pagination_button'>";
		htmlPage += "<a id='pageButton"+j+"' class='page-link pageBtn' onclick='pageBtn("+j+")' > "+ j +" </a>";
		htmlPage += "</li>";
		//console.log("j ==== "+j);
		
	}
	if(result.pageMaker.next == true ){
		console.log("true check next");
		htmlPage += "<li class='page-item pagination_button'>";
		htmlPage += " <a  class='page-link' onclick='pageBtn("+j+")'>Next</a>";
		htmlPage += "</li>";
	}
	$("#bdList").html(html);
	$('.pagination').html(htmlPage);
	
	console.log("pageNumint ========"+pageNumInt);
	$('#pageButton'+pageNumInt).css('background-color','bisque');
}

function pageBtn(n){
	
	var num = parseInt(n);
	var data = {
			"keywordType" : $("#keywordType").val(),
			"keyword" : $("#keyword").val(),
			"pageNum" : num
	}
	getBoardList(data);
}

function modiModal(fl, idx, writer , keywordType , keyword){
	if(fl == 'N'){
		if(writer == $('#loginId').val()){
			showCont(idx,writer,keywordType , keyword);
			if($('#modiModal').css('display') == 'none') $('#modiModal').modal();
		}else{
			alert('작성자만 볼수있는 게시글입니다.');
		}
	}else{
		showCont(idx,writer,keywordType , keyword);
		if($('#modiModal').css('display') == 'none') $('#modiModal').modal();
	}
}

function showCont(idx, writer,keywordType , keyword){
	var data = { 'boardIdx' : idx , 'boardWriter' : writer , 'keywordType' : keywordType , 'keyword' : keyword};
	var result = commonAjax($('#selectUrl').val(), 'post', data , 'json');
	
	cdata = {
		idx : result.boardInfo.boardIdx,
		boardWriter : result.boardInfo.boardWriter,
		title : result.boardInfo.boardTitle,
		content : result.boardInfo.boardContents,
		count : result.boardInfo.boardViewCount,
		date : result.boardInfo.boardWriteDate,
		publicFl : result.boardInfo.boardPublicFl,
		fileIdx : null,
		fileName : null
	};
	
	console.log(cdata.boardWriter);
	console.log(cdata.date);
	console.log(cdata.idx);
	console.log(keywordType);
	console.log(keyword);
	console.log(result.nextBoard);
	console.log(result.prevBoard);
	
	if(result.fileInfo != null ){
		cdata.fileIdx = result.fileInfo.fileIdx,
		cdata.fileName = result.fileInfo.fileOriginalName
	}
	
	if(cdata.title != null ) $('#contentTitle').text(cdata.title);
	else $('#contentTitle').text('제목없음');
	
	if(cdata.count != null) $('#contentView').text(cdata.count);
	else $('#contentView').text('0');
	
	if(cdata.boardWriter != null) $('#contentWriter').text(cdata.boardWriter);
	else $('#contentWriter').text('알수없음');
	
	if(cdata.boardWriter != null) {
		$('.contentContent').text(cdata.content);
	}else{
		$('.contentContent').text('내용없음');
	}
	
	if(cdata.date != null) $('#contentDate').text(cdata.date);
	else $('#contentDate').text('알수없음');
	
	if(result.fileInfo == null ){
		$('#contentFile').text('첨부파일이 없습니다.');
	}else{
		let htmlString = "";
		$('.contentContent').prepend("<img src='${pageContext.request.contextPath}/resources/images/"+cdata.fileName+"'/>");
		htmlString += "<button onclick=\"downFile(\'"+cdata.fileIdx+"\')\">"+ cdata.fileName +"</button>"
		$('#contentFile').html(htmlString);
		
	}
	
	if(cdata.boardWriter == $('#loginId').val()){
		$('#updateBoardDiv').html("<button onclick=\"modBtn('"+ cdata.idx +"'" + "," +"'"+ cdata.boardWriter +"'" + "," +"'"+ cdata.fileIdx +"')\" class=\"btn btn-default btn-full\">수정</button>");
		$('#deleteBoardDiv').html("<button onclick=\"delBtn('"+ cdata.idx +"'" + "," +"'"+ cdata.boardWriter +"')\" class='btn btn-default btn-full\'>삭제</button>");
	}else{
		$('#updateBoardDiv').html('');
		$('#deleteBoardDiv').html('');
	}
	
	if(result.prevBoard != null){
		$('#prevBoardTitle').html("<button class='btn btn-link' onclick=\"modiModal('"+result.prevBoard.BOARD_PUBLIC_FL +"', '"+ result.prevBoard.BOARD_IDX +"', '"+ result.prevBoard.BOARD_WRITER +"' , '"+ $('#keywordType').val() +"' , '" + $('#keyword').val() +"')\">" + result.prevBoard.BOARD_TITLE + "</button>");
		$('#prevBoardDate').text(result.prevBoard.BOARD_WRITE_DATE);
		
	}else{
		$('#prevBoardTitle').html("마지막 글입니다.");
		$('#prevBoardDate').text("");
	}
	
	if(result.nextBoard != null){
		$('#nextBoardTitle').html("<button class='btn btn-link' onclick=\"modiModal('"+result.nextBoard.BOARD_PUBLIC_FL +"', '"+ result.nextBoard.BOARD_IDX +"', '"+ result.nextBoard.BOARD_WRITER +"' , '"+ $('#keywordType').val() +"' , '" + $('#keyword').val() +"')\">" + result.nextBoard.BOARD_TITLE + "</button>");
		$('#nextBoardDate').text(result.nextBoard.BOARD_WRITE_DATE);
	}else{
		$('#nextBoardTitle').html("마지막 글입니다.");
		$('#nextBoardDate').text("");
	}
	
}

function delBtn(idx, writer){
	var answer = confirm('글을 삭제하시겠습니까?');
	if(answer){
		var result = commonAjax($('#delUrl').val(), 'post', {boardIdx : idx , boardWriter : writer});
		if(result == 'succes'){
			alert('삭제 성공');	
			$('#modiCloseBtn').trigger('click');
			getBoardList();
		}else{
			alert('삭제 실패');
		}
		
	}else{
		return;
	}
}

function modBtn(idx,writer,fileIdx){
	data = {'boardIdx' : idx , 'boardWriter' : writer , 'fileIdx' : fileIdx};
	var result = commonAjax($('#updateViewUrl').val(), 'post' , data , 'json')
	$('#modiCloseBtn').trigger('click');
	$('#updateWriteModal').modal();
	
	console.log(result.boardInfo);
	console.log(result.fileInfo);
	
	let resultFileIdx = null;
	let fileName = null;
	
	if(result.fileInfo != null ){
		resultFileIdx = result.fileInfo.fileIdx,
		fileName = result.fileInfo.fileOriginalName,
		$('#hiddenFileIdx').val(resultFileIdx);
	}else{
		$('#hiddenFileIdx').val(null);
	}
	$('#updateIdx').val(result.boardInfo.boardIdx);
	$('#updateTitle').val(result.boardInfo.boardTitle);
	$('#updateContent').val(result.boardInfo.boardContents);
	$('#updateToday').text(result.boardInfo.boardWriteDate);
	$('#updateWriterId').text(result.boardInfo.boardWriter);
	$('#hiddenUpdateWriterId').val(result.boardInfo.boardWriter);
	
	if(result.fileInfo != null){
		$('#updateFileInfo').html(fileName);
	}else{
		$('#updateFileInfo').html('<input type="file" multiple="multiple" id="input-file-now" name="uploadFile" class="file-upload" />');	
	}
	
	/*
	$('#modiIdx').val(cdata.idx);
	$('#boardTitle').val(cdata.title);
	$('#writerName').text(cdata.boardWriter);
	$('#today').text(cdata.date);
	$('#boardContent').text(cdata.content);
	if(cdata.publicFl == 'Y') {
		console.log("publicFl == Y");
		$('input:radio[name="boardPublicFl"]:input[value="Y"]').attr('checked', true);
		$('input:radio[name="boardPublicFl"]:input[value="N"]').attr('checked', false);
		
	}
	if(cdata.publicFl == 'N'){
		console.log("publicFl == N");
		$('input:radio[name="boardPublicFl"]:input[value="N"]').attr('checked', true);	
		$('input:radio[name="boardPublicFl"]:input[value="Y"]').attr('checked', false);	
	}
	if(cdata.fileIdx != null){
		$('#contentFile').html(cdata.fileName);
	}else{
		$('#contentFile').html("첨부파일이 없습니다.");
	}
	*/

}

function resetSearch(){
	$("#keyword").val("");
	$('select[id="keywordType"]').val("writerAndContent").attr("selected",true);
}

function downFile(fileIdx){
	let result = commonAjax($('#fileDownUrl').val(), 'post', {'fileIdx' : fileIdx}, 'text');
	if(result == 'fail'){
		alert('다운로드할 파일을 찾지 못함');
	}else{
		location.href= $('#fileDownUrl').val()+'?fileIdx='+fileIdx;
	}
}

$( document ).ready(function() {

	sessionCheck();
	
	$('#up').on('change', function(){
		if($('#up').val() != ''){
			var ext = $('#up').val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['png','jpg','jpeg'])==-1){
				alert("png,jpg,jpeg 파일만 업로드 할수 있습니다." );
				$('#up').val("");
				return;
			}else{
				readURL(this);
			}
		}
	});

	// 아이디 체크
	$('#boardWriter').keyup(function(){
		registerTest("check");
	});

	// 이메일 체크
	$('#boardWriterEmail').keyup(function(){
		if(checkEmail($('#boardWriterEmail').val()) || $('#boardWriterEmail').val() == ''){
			$('#checkEmailMsg').css('display', 'none');
		}else{
			$('#checkEmailMsg').css('display', 'block');
		}
	});
	
	// 회원가입 버튼 클릭 이벤트
	$('#registerBtn').click(function(){
		if($('#up').val()==''){
			alert('프로필 사진을 등록해 주세요');
		}else if($('#boardWriter').val().trim()  == ''
				||$('#boardWriterPw').val().trim() == ''
				||$('#boardWriterName').val().trim() ==''
				||$('#boardWriterPhone').val().trim() == ''
				||$('#boardWriterEmail').val().trim() == ''
				||$('#boardWriterEmail2').val().trim() == ''){
			alert('모든 항목을 빠짐 없이 작성해주세여');
		}else if(!checkPhoneExp($('#boardWriterPhone').val())){
			alert('-를 제외하고 입력해 주세요');
		}else if($('#boardWriterEmail').val().trim() != $('#boardWriterEmail2').val().trim()){
			alert('작성된 이메일이 다릅니다.');
		}else{
			registerTest("insert");
		}
	});
	
	$("#searchBtn").click(function(){
		if($('#keyword').val().trim() == ""){
			alert("검색어를 입력해 주세요");
		}else{
			var data = {
					"keywordType" : $("#keywordType").val(),
					"keyword" : $("#keyword").val()
			}
			getBoardList(data);
		}
	});
	
	$('#writeSaveBtn').click(function(){
		if($('#boardTitle').val().trim() == ''){
			alert('제목을 작성하세요');
		}else if($('#boardContent').val().trim() == ''){
			alert("내용을 작성하세요");
		}else if($('input:radio[name="boardPublicFl"]').val() == null ){
			alert('공개 여부를 설정하세요');
		}else{
			var formdata = new FormData(document.getElementById("boardWriteForm"));
			var result = commonAjaxMulti($('#boardWriteForm').attr('action'), formdata, 'text');
			if(result==1){
				alert('게시글 작성 및 수정 성공');
				$('#writeCloseBtn').trigger('click');
				getBoardList();
			}else{
				alert('작성 및 수정 실패');
			}
		}
	});
	
	$('#updateSaveBtn').click(function(){
		if($('#updateTitle').val().trim() == ''){
			alert('제목을 작성하세요');
		}else if($('#updateContent').val().trim() == ''){
			alert("내용을 작성하세요");
		}else if($('input:radio[name="boardPublicFl"]').val() == null ){
			alert('공개 여부를 설정하세요');
		}else{
			var formdata = new FormData(document.getElementById("boardUpdateForm"));
			var result = commonAjaxMulti($('#boardUpdateForm').attr('action'), formdata, 'text');
			if(result==1){
				alert('게시글 작성 및 수정 성공');
				$('#updateCloseBtn').trigger('click');
				getBoardList();
			}else{
				alert('작성 및 수정 실패');
			}
		}
	});
	
	$('#writeModalBtn').click(function(){
		$('#modiIdx').val('0');
		//$('#fileInfo').html('');
		$('input:radio[name="boardPublicFl"]:input[value="Y"]').attr('checked', true);
		$('input:radio[name="boardPublicFl"]:input[value="N"]').attr('checked', false);
	});

	$("#button-send").on("click", function(e) {
		sendMessage();
		$('#msg').val('');
		console.log($('#msg').val());
	});
	
	
	
});	


// 채팅 sock 변수에 바로 객체를 생성하지 않고 로그인 성공시 담아줌




</script>


