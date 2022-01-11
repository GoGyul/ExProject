<!DOCTYPE html>
<html lang="kr">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<head>
<meta charset="UTF-8">
<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
<link rel="stylesheet" id="bootstrap-css" href="resources/css/chat_main.css">
<title>ITKey Talk</title>
</head>

<body>
	<div class="container">
		<h3 class=" text-center">
			<div class="jumbotron">
				<h1>
					<i class="fa fa-paper-plane color-blue"></i> ITKey <font class="color-blue">T</font>alk
				</h1>
				<p>ITKEY 단체 채팅방 개발을 위한 퍼블리싱 파일입니다. 해당 채팅방을 예쁘게 만들어 주세요.</p>
				<input type="hidden" id="hiddenBoardWriterName" value="${sessionScope.login.boardWriterName }">
				<input type="hidden" id="hiddenBoardWriter" value="${sessionScope.login.boardWriter }">
			</div>
			<input class="mainbtn" style="float: right;" type="button" value="메인화면" onclick="location.href='main.do' ">

		</h3>
		<div class="messaging">
			<div class="inbox_msg">
				<div class="mesgs" style="overflow-y: auto; height: 516px;">
					<div id="msgArea" class="col">
		
						
					</div>
				</div>
				<div class="type_msg" style="padding : 1%;">
						<div class="input_msg_write">
							<input type="text" id="msg" class="write_msg" placeholder="내용을 입력해 주세요." />
							<button id="button-send" class="msg_send_btn" type="button" style="margin-top: 1%; margin-right:1%;">
								<i class="fa fa-paper-plane" aria-hidden="true"></i>
							</button>
						</div>
					</div>
			</div>
		</div>
	</div>
</body>
</html>



<script>



$("#button-send").on("click", function(e) {
	sendMessage();
	$('#msg').val('');
	console.log($('#msg').val());
});

var sock = new SockJS('http://localhost:8080/sam/chat.do/');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

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
    var timeString = year + '-' + month  + '-' + day +"일, " + hours + ':' + minutes  + ':' + seconds;
	
	
	var realData = msg;
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
		console.log(realData);
	}
	
	var cur_session = $("#hiddenBoardWriterName").val(); //현재 세션에 로그인 한 사람
	
	sessionId = arr[0];
	message = arr[1];
	fileName = arr[2];
	
	console.log("cur_session : " + cur_session);
	console.log("sessionId : " + sessionId);
	console.log("fileName : " + fileName);
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId != cur_session){
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-secondary'>";
		str += "<span class='time_date'>"+timeString+"</span>";
		str += "<b>"+
		" <img src='${pageContext.request.contextPath}/resources/images/"+ fileName 
		+"' class='img-circle' style='width: 20px; height: 20px; border-radius: 100%;'> "
		+ "&nbsp; &nbsp;"+ sessionId + " : " + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	else{
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-warning'>";
		str += "<span class='time_date' style='display:flex; justify-content: flex-end;'>"+ timeString +"</span>";
		str += "<b style='display:flex; justify-content: flex-end;'>" + message + " : " + sessionId + "&nbsp; &nbsp;" + 
		"<img src='${pageContext.request.contextPath}/resources/images/"
		+ fileName + "'class='img-circle' style='width: 20px; height: 20px; border-radius: 100%;'>"+"</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	var user = '${sessionScope.login.boardWriterName }';
	var str = user + " 님이 퇴장하셨습니다.";
	
	$("#msgArea").append(str);
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	
	var user = '${sessionScope.login.boardWriterName }';
	var str = user + "님이 입장하셨습니다.";
	
	$("#msgArea").append(str);
}

</script>
