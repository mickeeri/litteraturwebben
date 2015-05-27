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




// $('#latest-books-track').ready(function(){
// 	var left = parseInt($('#latest-books-track').css('left'));

// 	$('#right').click(function(){
// 		$('#latest-books-track').css('left', left+4);
// 	});

// 	$('#right').click(function(){
// 		$('#latest-books-track').css('left', left-4);
// 	});
// });

// $(document).ready(function(){
// 	console.log("hallå!");

// 	$('.select optional').addClass('form-control');
// });


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

// For cocoon form
// $("#authors a.add_fields").
//   data("association-insertion-position", 'before').
//   data("association-insertion-node", 'this');

// $('#authors').on('cocoon:after-insert',
//      function() {
//          $(".authorship-fields a.add_fields").
//              data("association-insertion-position", 'before').
//              data("association-insertion-node", 'this');
//          $('.authorship-fields').on('cocoon:after-insert',
//               function() {
//                 $(this).children("#author_from_list").remove();
//                 $(this).children("a.add_fields").hide();
//               });
// 	});

$(document).ready(function() {
    $("#authors a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#authors').bind('cocoon:after-insert',
         function(e, author) {
             console.log('inserting new author ...');
             $(".authorship-fields a.add-author").
                 data("association-insertion-position", 'after').
                 data("association-insertion-node", 'this');
             $(this).find('.authorship-fields').bind('cocoon:after-insert',
                  function() {
                    console.log('insert new author ...');
                    console.log($(this));
                    $(this).find(".author_from_list").remove();
                    $(this).find("a.add_fields").hide();
                  });
         });

    $('.authorship-fields').bind('cocoon:after-insert',
        function(e) {
            alert('replace OLD author ...');
            e.stopPropagation();
            console.log($(this));
            $(this).find(".author_from_list").remove();
            $(this).find("a.add_fields").hide();
        });
});


// $("select.select").change(function () {
//     $("select.select option").prop('disabled', false);
//     $("select.select option:selected:not([value='0'])").each(function (i) {
//         $("select.select option:nth-child(" + ((+this.value) + 1) + ")").prop('disabled', true)
//     });
// });






