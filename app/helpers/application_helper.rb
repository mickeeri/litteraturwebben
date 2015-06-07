module ApplicationHelper

	# Returns the full title on each page.
	def full_title(page_title = '')
		base_title = "Litteraturwebben"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	# Adds class active to active navbar links.
	def is_active?(link_path)
		current_page?(link_path) ? "active" : ""
	end
end
