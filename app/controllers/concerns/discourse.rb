module Concerns::Discourse
  extend ActiveSupport::Concern
  included do

    # TODO DRY
    helper_method :get_news
    helper_method :get_faqs
    helper_method :get_our_works

    def get_news
      Rails.cache.fetch('news') do
        topics = $discourse.category_latest_topics('kompaniya/novosti').
          sort_by{|topic| topic['created_at']}.
          reverse

        topics = topics.select do |topic|
          topic['post'] = $discourse.topic(topic['id'])['post_stream']['posts'][0]['cooked']
        end
      end
    end

    def get_faqs
      Rails.cache.fetch('faqs') do
        topics = $discourse.category_latest_topics('kompaniya/chastye-voprosy').
          sort_by{|topic| topic['created_at']}.
          reverse

        topics = topics.select do |topic|
          topic['post'] = $discourse.topic(topic['id'])['post_stream']['posts'][0]['cooked']
        end
      end
    end

    def get_our_works
      Rails.cache.fetch('our_works') do
        topics = $discourse.category_latest_topics('kompaniya/avtorif-rabotaet').
          sort_by{|topic| topic['created_at']}.
          reverse

        topics = topics.select do |topic|
          topic['post'] = $discourse.topic(topic['id'])['post_stream']['posts'][0]['cooked']
        end
      end
    end

  end

end
