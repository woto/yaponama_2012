class Discourse

  def search_string
    compacted = @title.reject(&:blank?).join(' ')
    ['Страницы сайта:', "“#{compacted}”", "(#{@category['title']})"].join(' ')
  end

  def initialize category, *title
    @title = title
    @category = Rails.configuration.discourse['categories'][category]
  end

  def get_posts limit, &block
    search_opts = {"search_context[type]" => 'category', "search_context[id]" => @category['id']}
    result = $discourse.search(search_string, search_opts)

    unless result['posts'].nil?
      posts = result['posts'].take(limit)
    else
      posts = []
    end

    posts.each do |post|
      result = {}
      result[:content] = post['cooked'].html_safe
      result[:link] = "http://#{Rails.configuration.discourse['host_port']}/t/#{post['topic_slug']}/#{post['topic_id']}"
      yield result[:content], result[:link]
    end
  end

  def link_to_new
    "http://#{Rails.configuration.discourse['host_port']}/new-topic?title=#{URI.encode(search_string)}&body=#{URI.encode('Удалите этот текст и напишите свой. Не меняйте заголовок сообщения.')}&category_id=#{@category['id']}"
  end

end

#SpareCatalog.where.not(intro: "").find_each do |sc|
#  d = Discourse.new('a', sc.name)
#  p = $discourse.create_topic(title: d.search_string, raw: "#{sc.intro}", category: 14)
#  sleep 0.5
#  $discourse.wikify_post p['id']
#  sleep 0.5
#end
#
#SpareCatalog.where.not(page: "").find_each do |sc|
#  d = Discourse.new('b', sc.name)
#  p = $discourse.create_topic(title: d.search_string, raw: "#{sc.page}", category: 15)
#  sleep 0.5
#  $discourse.wikify_post p['id']
#  sleep 0.5
#end
