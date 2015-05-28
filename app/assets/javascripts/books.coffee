# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Function that disables already selected options in new dropdowns.
# Source: http://cookieshq.co.uk/posts/nested-forms-on-steroids-with-cocoon/
$(document).ready ->
	$('#authors').on('cocoon:before-insert', (e, authorToBeAdded) ->
	    assignedAuthors = []
	    $(this).find('.nested-fields select').each ->
    		assignedAuthors.push $(this).val()

	    $.each assignedAuthors, (index, authorId) ->
	     	if authorId != ''
	        	authorToBeAdded.find("option[value='#{authorId}']").attr('disabled', true)

	).on('cocoon:before-remove', (e, authorToBeRemoved) ->
	 	authorToRestore = authorToBeRemoved.find('select').val()

  	$(this).find('.nested-fields select').each ->
    	$(this).find("option[value='#{authorToRestore}']").attr('disabled', false)
	)

	# $('#authors').on('change', '.author-options') (e) ->
	# 	alert("author-optons change")
	# 	assignedAuthors = []
	# 	$(this).parents('.nested-fields').find('select').each ->
	#     	thisSelect = $(this)
	#     	if thisSelect.val() != ''
	#       		assignedAuthors.push thisSelect.val()

	#     	if assignedAuthors.length == 0
	#       		thisSelect.parents('.nested-fields').siblings().find("option").attr('disabled', false)
	#     	else
	#       		$.each assignedAuthors, (index, authorId) ->
	#         		thisSelect.parents('.nested-fields').siblings().find("option[value='#{authorId}']").attr('disabled', true)

	    #$('#authors').on('change', '.author-options', function