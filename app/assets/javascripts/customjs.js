

$('#latest-books-track').ready(function(){
	setInterval(function() {
		var left = parseInt($('#latest-books-track').css('left'));

		if(left < -600) {
			// left = 10;
			// $('#latest-books-track').css('left', left);
		}
		else {
			if ($('#right').is(":hover")) {
				$('#latest-books-track').css('left', left-4);
			}
		}

		if(left > 10) {
			// left = -750;
			// $('#latest-books-track').css('left', left);
		}
		else {
			if ($('#left').is(":hover")) {
				$('#latest-books-track').css('left', left+4);
			}
		}
	}, 10);
});


$(document).ready(function(){

	alert("hej!");

	var left = parseInt($('#latest-books-track').css('left'));

	$('#latest-books-track').on("swipeleft", function(){

		$('#latest-books-track').css('left', left+20);

	});

	$('#latest-books-track').on("swiperight", function(){

	$('#latest-books-track').css('left', left-20);
	alert("Swiperight");

	});
});
