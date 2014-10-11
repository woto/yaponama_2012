class BrandMate

  class << self

    def find_or_create_canonical name
      brand = find_canonical name
      if brand.nil?
        brand = Brand.create find_params(name)
      end
      brand
    end

    def find_or_create_canonical! name
      brand = find_canonical name
      if brand.nil?
        brand = Brand.create! find_params(name)
      end
      brand
    end

    def find_canonical name
      brand = Brand.find_by find_params(name)
      if brand && brand.brand_id?
        brand = brand.brand
      end
      brand
    end

    private

    def find_params(name)
      { name: name.mb_chars.upcase }
    end
  end
end
