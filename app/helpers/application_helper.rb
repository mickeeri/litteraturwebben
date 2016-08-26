module ApplicationHelper
  # Returns the full title on each page.
  def full_title(page_title = '')
    base_title = 'Litteraturwebben'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Adds class active to active navbar links.
  def active?(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  # Fallback img for CarrierWave uploader.
  # http://stackoverflow.com/questions/22946123/fallback-image-with-carrierwave
  def display_cover(book)
    if book.cover.nil?
      image_tag('/path/to/default_cover.png', alt: 'Omslag saknas.')
    else
      image_tag(book.cover.url, alt: "Omslag för #{book.title}")
    end
  end

  def display_portrait(author)
    if author.portrait.nil?
      image_tag('/path/to/default_cover.png', alt: 'Författarbild saknas.')
    else
      image_tag(author.portrait.url, alt: "Författarbild för #{author.name}")
    end
  end
end
