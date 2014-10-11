class SpareApplicabilityMate

  class << self

    def guess_spare_catalog titles, catalog_number, manufacturer
      nbayes = NBayes::Base.new

      SpareCatalog.all.each do |spare_catalog|
        nbayes.train( spare_catalog.content.split(/\s+/), spare_catalog.name )
        # nbayes.train( [spare_catalog.content], spare_catalog.name 
      end

      # tokens = mf_scope[:titles].keys.map{|val| ERB::Util.html_escape(val)}.join(', ').to_s.split(/\s+/)
      # tokens = mf_scope[:titles].keys.map{|val| ERB::Util.html_escape(val)}.join('###').to_s.split(/###/)
      tokens = titles.
        keys.
        map{|val| ERB::Util.html_escape(val)}.
        join(', ').
        to_s.
        split(/[[:punct:][:space:]]/).
        reject{|item| item.length < 3}.
        map{|item| item.gsub(/[^[:word:]]/, '')}

      tokens = tokens.reject{|item| ['ДЕТАЛЬ', 'ЗАПЧАСТЬ'].include? item}

      if tokens.any?

        # tokens

        result = nbayes.classify(tokens)

        # <h4>
        #   <a href="#"> <%= result.max_class %> </a>
        # </h4>

        counter = 0
        zzz = nil


        result.sort_by {|k, v| -v}.take(10).each do |item, rate|
          if counter == 0
            SpareCatalogWorker.perform_async(catalog_number, manufacturer, item)
            counter += 1
            zzz = item
          end

        end

        zzz

      end

    end

  end

end
