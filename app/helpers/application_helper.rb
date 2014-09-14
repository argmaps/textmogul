module ApplicationHelper
  def page_title(title)
    content_for :title, title
    content_tag :title, title
  end

  def page_header_title(title)
    content_for :page_header_title, title
  end
end
