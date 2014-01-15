module AsyncHelper
 
  def javascript_async(*args)
    content_tag :script, type: "text/javascript" do
      "(function() {
      var script = document.createElement('script');
      script.type = 'text/javascript';
      script.async = true;
      script.src = '#{j javascript_path(*args)}';
      var other = document.getElementsByTagName('script')[0];
      other.parentNode.insertBefore(script, other);
      })();".html_safe
    end
  end

  def stylesheet_async(*args)
    content_tag :script, type: 'text/javascript' do
      "(function() {
      var link = document.createElement('link');
      link.type = 'text/css';
      link.rel = 'stylesheet';
      link.href = '#{j stylesheet_path(*args)}';
      var other = document.getElementsByTagName('link')[0];
      other.parentNode.insertBefore(link, other);
      })();".html_safe
    end
  end

end
