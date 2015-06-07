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

	# Fallback img for CarrierWave pic uploader.
	# http://stackoverflow.com/questions/22946123/fallback-image-with-carrierwave
	def display_cover(book)
		unless book.cover.nil?
			image_tag(book.cover.url)
		else
			image_tag("/path/to/default_cover.png")
		end
	end

	def display_portrait(author)
		unless author.portrait.nil?
			image_tag(author.portrait.url)
		else
			image_tag("/path/to/default_cover.png")
		end
	end
end
