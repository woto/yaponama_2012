module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        @template.url_for @params.merge(@param_name => (page))
      end
    end
  end
end
