module GridHelper

        when 'cached_main_profile'
          res = []
          begin
            JSON.parse(val).tap do |cached_main_profile|
              cached_main_profile["names"].each do |cached_name|
                res << refactor_cached_name(cached_name)
              end
              cached_main_profile["phones"].each do |cached_phone|
                res << refactor_cached_value(cached_phone)
              end
              cached_main_profile["emails"].each do |cached_email|
                res << refactor_cached_value(cached_email)
              end
              cached_main_profile["passports"].each do |cached_passport|
                res << refactor_cached_passport(cached_passport)
              end
            end
          rescue
          end
          refactor_mmm(res)
        when 'cached_names'
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_name|
              res << refactor_cached_name(cached_name)
            end
          rescue
          end
          refactor_mmm(res)
        when *['cached_phones', 'cached_emails']
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_phone|
              res << refactor_cached_value(cached_phone)
            end
          rescue
          end
          refactor_mmm(res)
        when 'cached_passports'
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_passport|
              res << refactor_cached_passport(cached_passport)
            end
          rescue
          end
          refactor_mmm(res)
        when *['catalog_number']
          if item.class == Product
            if item.hide_catalog_number
              res = "".html_safe
              if admin_zone?
                res << h(val)
              end
              res << " " << icon('asterisk text-muted')
            else
              val
            end
          end

  def refactor_cached_name(cached_name)
    [cached_name.try(:[], 'surname'),
    cached_name.try(:[], 'name'),
    cached_name.try(:[], 'patronymic')].join(' ')
  end

  def refactor_cached_value(cached_phone)
    cached_phone.try(:[], 'value')
  end

  def refactor_cached_passport(cached_passport)
    [cached_passport.try(:[], 'seriya'),
    cached_passport.try(:[], 'nomer'),
    cached_passport.try(:[], 'mesto_rozhdeniya')].join(', ')
  end

  def refactor_mmm(arr)
    content_tag(:ul, :class => "list-unstyled") do
      arr.collect{ |item| content_tag(:li, h(item)) }.join.html_safe
    end
  end

end
