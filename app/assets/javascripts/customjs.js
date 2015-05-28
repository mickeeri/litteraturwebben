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
            console.log('replace OLD author ...');
            e.stopPropagation();
            console.log($(this));
            $(this).find(".author_from_list").remove();
            $(this).find("a.add_fields").hide();
        });
});


// $("select.author-options").change(function () {
//     $("select.author-options option").prop('disabled', false);
//     $("select.author-options option:selected:not([value='0'])").each(function (i) {
//         $("select.author-options option:nth-child(" + ((+this.value) + 1) + ")").prop('disabled', true)
//     });
// });


// Upload fileds
$('#new_book').ready(function(){
    $('#book_cover').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 5) {
           alert('Den största tillåtna filstorleken är 5MB. Var vänlig välj en mindre fil.')
       }
   });

   $('#book_pdf').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 20) {
           alert('Den största tillåtna filstorleken är 20MB. Var vänlig välj en mindre fil.')
       }
   });

   $('#book_epub').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 8) {
           alert('Den största tillåtna filstorleken är 8MB. Var vänlig välj en mindre fil.')
       }
   });
});

$('.portrait-upload').ready(function(){
    $('#book_cover').bind('change', function() {
        var size_in_megabytes = this.files[0].size/1024/1024;
        if (size_in_megabytes > 5) {
            alert('Den största tillåtna filstorleken är 5MB. Var vänlig välj en mindre fil.')
        }
    });
});

// Function that disables selected options in other dropdowns.
// Source: http://stackoverflow.com/questions/25423108/disable-select-option-in-group-of-select-dropdowns-when-option-is-selected
$('#new_book').ready(function(){
    $('#authors').on('change', '.author-options', function () {
        // Get the selected options of all positions
        var allSelected = $(".author-options").map(function () {
            return $(this).val();
        }).get();

        // set all enabled
        $(".author-options option").removeAttr("disabled");

        // Disable selected options in other positions
        $(".author-options option:not(:selected):not([value='0'])").each(function () {
            if ($.inArray($(this).val(), allSelected) != -1) {
                $(this).attr('disabled', true);
            }
        });
    });
});







