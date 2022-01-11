<!DOCTYPE html>
<html lang="en">
<head>
<title>Exception</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<style>
.base-glyphicon {
	font-size: 10em;
	color: #CF4E50;
	margin-top: 40px;
}

.panel-exception {
	margin-top: 20%;
	min-height: 400px;
	width: 50%;
	margin-left: auto;
	margin-right: auto;
}

.pan-title {
	font-size: 5em;
	color: #CF4E50;
}

.pan-content {
	font-size: 1.7em;
}

.alert-glyphicon {
	color: #CF4E50;
	font-size: 5em;
	margin-top: 20px;
	margin-left: 20px;
}

.alert-title {
	font-weight: bold;
	color: #CF4E50;
}
</style>
	<div class="container text-center">
		<div class="panel panel-default panel-exception">
			<div class="panel-body text-center">
				<span class="glyphicon glyphicon-alert base-glyphicon"></span>
				<h1 class="pan-title">404</h1>
				<p class="pan-content">요청한 페이지를 찾을수 없습니다.</p>
			</div>
		</div>
		<button type="button" class="btn btn-danger btn-lg" onclick="alert_modal();">Ajax Exception 발생시 Alert</button>

	</div>
</body>

<script>
	function alert_modal() {
		$("#alertModal").modal("show");
		setTimeout(function() {
			$("#alertModal").modal("hide");
		}, 1500);
	}
</script>

<div class="modal fade" id="alertModal" role="dialog" style="margin-top: 15%;">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-body">
				<div class="row">
					<div class="col-sm-3">
						<span class="glyphicon glyphicon-alert alert-glyphicon"></span>
					</div>
					<div class="col-sm-9">
						<h1 class="alert-title">404</h1>
						<p class="alert-contents">요청한 페이지를 찾을수 없습니다.</p>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

</html>
