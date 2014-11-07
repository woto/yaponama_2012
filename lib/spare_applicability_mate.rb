class SpareApplicabilityMate

  class << self

    def guess_spare_catalog titles, catalog_number, manufacturer
      nbayes = NBayes::Base.new

      SpareCatalog.select(:content, :name).all.each do |spare_catalog|
        nbayes.train( spare_catalog.content.split(/\s+/), spare_catalog.name )
      end

      tokens = titles.
        transform_keys{ |title| ERB::Util.html_escape(title)}.
        map{|title, repeats| "#{title} " * repeats}.
        join(', ').
        to_s.
        split(/[[:punct:][:space:]]/).
        reject{|item| item.length < 3}.
        map{|item| item.gsub(/[^[:word:]]/, '')}.
        reject{|item| ['ДЕТАЛЬ', 'ЗАПЧАСТЬ'].include? item}

        result = nbayes.classify(tokens).max_by {|_key, value| value}[0]
        SpareCatalogWorker.perform_async(catalog_number, manufacturer, result)

        result
    end
  end
end
