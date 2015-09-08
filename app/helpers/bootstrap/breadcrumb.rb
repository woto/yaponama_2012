class Bootstrap::Breadcrumb < Bootstrap::Bootstrap

  def item title, url=nil
    if url
      @template.content_tag :li do
        @template.link_to title, url
      end
    else
      @template.content_tag :li, title, class: 'active'
    end
  end

end
