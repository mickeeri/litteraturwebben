module ApplicationHelper

	# Returns the full title on each page.
	def full_title(page_title = '')
		base_title = "Litteraturappen"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
end
