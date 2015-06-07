// To toggle icon in article form.
$('.articles').ready(function(){
	$('.article-form-link').click(function(){
		var span = $('#article-form-arrow');

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

// Javascript from Cocoon gem wiki for :has_many :through forms.
// https://github.com/nathanvda/cocoon/wiki/A-guide-to-doing-nested-model-forms
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

// Upload file size validation.
$('#new_book').ready(function(){
    $('#book_cover').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 3) {
           alert('Den största tillåtna filstorleken är 3 Mb. Var vänlig välj en mindre fil.')
       }
   });

   $('#book_pdf').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 15) {
           alert('Den största tillåtna filstorleken är 15 Mb. Var vänlig välj en mindre fil.')
       }
   });

   $('#book_epub').bind('change', function() {
       var size_in_megabytes = this.files[0].size/1024/1024;
       if (size_in_megabytes > 5) {
           alert('Den största tillåtna filstorleken är 5 Mb. Var vänlig välj en mindre fil.')
       }
   });
});

$('.portrait-upload').ready(function(){
    $('#author_portrait').bind('change', function() {
        var size_in_megabytes = this.files[0].size/1024/1024;
        if (size_in_megabytes > 3) {
            alert('Den största tillåtna filstorleken är 3 Mb. Var vänlig välj en mindre fil.')
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

// If error message is displayed article form should be visisible.
$('#new_article').ready(function(){
    if($('.alert-danger')[0]){
      $('.collapse').addClass('in');
    }
});

// Empty search text field.
$('.search-form').ready(function(){
  $('.remove-input').click(function(){
    if ($('.search-field').val().length > 0) {
      $('.search-field').val("");
    }
  });
});