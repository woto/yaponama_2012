module ProductSerializer
  extend ActiveSupport::Concern
  included do
    helper_method :serialize_product

    def serialize_product(catalog_number:,
                         brand_id:,
                         deliveries_place_id:,
                         quantity_ordered:,
                         sell_cost:,
                         titles:,
                         title:,
                         buy_cost:,
                         quantity_available:,
                         probability:,
                         min_days:,
                         max_days:)
      hash = {}
      method(__method__).parameters.map do |_, name|
        hash[name] = binding.local_variable_get(name)
      end
      product_verifier.generate(hash)
    end

    def deserialize_product(token)
      product_verifier.verify(token)
    end

    def product_verifier
      ActiveSupport::MessageVerifier.new Rails.configuration.secret_key_base
    end

  end
end
