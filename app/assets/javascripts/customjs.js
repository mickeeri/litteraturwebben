// $('#latest-books-track').ready(function(){
// 	setInterval(function() {
// 		var left = parseInt($('#latest-books-track').css('left'));

// 		if(left < -600) {
// 			// left = 10;
// 			// $('#latest-books-track').css('left', left);
// 		}
// 		else {
// 			if ($('#right').is(":hover")) {
// 				$('#latest-books-track').css('left', left-4);
// 			}
// 		}

// 		if(left > 10) {
// 			// left = -750;
// 			// $('#latest-books-track').css('left', left);
// 		}
// 		else {
// 			if ($('#left').is(":hover")) {
// 				$('#latest-books-track').css('left', left+4);
// 			}
// 		}
// 	}, 10);
// });


$('#latest-books-track').ready(function(){

	var left = parseInt($('#latest-books-track').css('left'));

		$('#test').on("swipe", function(){

		$('#latest-books-track').css('left', left-40);

	});

	$('#test').on("swipeleft", function(){

		$('#latest-books-track').css('left', left+20);

	});

	$('#latest-books-track').on("swiperight", function(){

	$('#latest-books-track').css('left', left-20);
	alert("Swiperight");

	});
});


$('.article_form').ready(function(){
	$('.article-form-link').click(function(){
		var span = $('.glyphicon');

		if (span.hasClass('glyphicon-chevron-right')) {
			span.removeClass('glyphicon-chevron-right');
			span.addClass('glyphicon-chevron-down');
		}
		else {
			span.removeClass('glyphicon-chevron-down')
			span.addClass('glyphicon-chevron-right')
		}
	});
});

$("#authors a.add_fields").
  data("association-insertion-position", 'before').
  data("association-insertion-node", 'this');

$('#authors').on('cocoon:after-insert',
     function() {
         $(".authorship-fields a.add_fields").
             data("association-insertion-position", 'before').
             data("association-insertion-node", 'this');
         $('.authorship-fields').on('cocoon:after-insert',
              function() {
                $(this).children("#author_from_list").remove();
                $(this).children("a.add_fields").hide();
              });
});




