class BrandMate

  class << self

    def find_conglomerate(name)
      brand = Brand.find_by find_params(name)
      if brand && brand.brand_id?
        brand = find_conglomerate brand.brand.name
      end
      brand
    end

    def find_conglomerate_by_id(id)
      brand = Brand.find_by_id id
      if brand && brand.brand_id?
        brand = find_conglomerate_by_id brand.brand.id
      end
      brand
    end

    def find_company(name)
      brand = Brand.find_by find_params(name)
      if brand && brand.brand_id? && !brand.conglomerate?
        brand = find_company brand.brand.name
      end
      brand
    end

    def find_company_by_id(id)
      brand = Brand.find_by_id id
      if brand && brand.brand_id? && !brand.conglomerate?
        brand = find_company_by_id brand.brand.id
      end
      brand
    end

    def find_or_create_company(name)
      brand = find_company name
      if brand.nil?
        brand = Brand.create! find_params(name)
      end
      brand
    end

    def find_or_create_conglomerate(name)
      brand  = find_conglomerate name
      if brand.nil?
        brand = Brand.create! find_params(name)
      end
      brand
    end

    private

    def find_params(name)
      { name: (name || "ОРИГИНАЛ").mb_chars.upcase }
    end

  end
end
