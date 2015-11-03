class Y

  BANNERS_LIMIT = 500
  CREATE_CAMPAIGNS = true
  UPDATE_CAMPAIGNS_IDS = []

  def self.y

    if UPDATE_CAMPAIGNS_IDS.any?
      # Обновляем имеющиеся объявления
      UPDATE_CAMPAIGNS_IDS.each do |campaign_id|
        banner_infos = YandexDirect.new(:GetBanners, "param" => {"CampaignIDS" => [campaign_id],
                                                                 "GetPhrases" => 'WithPrices'}).send.data
        spare_info_phrases = []
        banner_infos.map! do |banner_info|
          spare_info_phrase = SpareInfoPhrase.find_by(:yandex_campaign_id => banner_info["CampaignID"], 
                                                      :yandex_banner_id => banner_info["BannerID"])
          spare_info_phrases << spare_info_phrase
          phrase_id = banner_info["Phrases"][0]["PhraseID"]
          spare_info_phrase.update!(:yshows => banner_info["Phrases"][0]["Shows"],
                                    :yclicks => banner_info["Phrases"][0]["Clicks"])
          _banner(spare_info_phrase.yandex_campaign_id, spare_info_phrase.yandex_banner_id, phrase_id, spare_info_phrase)
        end
        banners_ids = YandexDirect.new(:CreateOrUpdateBanners, "param" => banner_infos).send.data
        spare_info_phrases.each_with_index do |spare_info_phrase, i|
          spare_info_phrase.update!(:yandex_banner_updated_at => Time.zone.now)
        end
      end
    end


    if CREATE_CAMPAIGNS
      # Создаем новые объявления
      loop do

        spare_info_phrases = SpareInfoPhrase.
          joins(:spare_info => [:brand, :spare_catalog, { :warehouses => :place }] ).
          select("spare_info_phrases.id id, brands.name _brand, spare_info_phrases.catalog_number catalog_number, spare_infos.catalog_number _ncn, spare_catalogs.name _catalog, warehouses.price _price, spare_info_phrases.phrase _phrase, deliveries_places.ycountry, deliveries_places.ycountry_code, deliveries_places.ycity, deliveries_places.ystreet, deliveries_places.yhouse, deliveries_places.ycity_code, deliveries_places.yphone, deliveries_places.ycompany_name, deliveries_places.ycontact_email, deliveries_places.ywork_time, deliveries_places.yogrn, 1").
          where(:yandex_campaign_id => nil, :yandex_banner_id => nil, :publish => true).
          where.not(:deliveries_places => { :partner => true } ).
          order(:id).limit(BANNERS_LIMIT)

        # TODO Replace length to count. Rails bug. https://github.com/rails/rails/issues/11824
        # UP: Добавил капельку магии ", 1"
        unless spare_info_phrases.count == BANNERS_LIMIT
          break
        else
          campaign_id = _campaign.send.data
          banners = []
          spare_info_phrases.each do |spare_info_phrase|
            banners << _banner(campaign_id, 0, 0, spare_info_phrase)
          end
          banners_ids = YandexDirect.new(:CreateOrUpdateBanners, "param" => banners).send.data
          spare_info_phrases.each_with_index do |spare_info_phrase, i|
            spare_info_phrase.update!(
              :yandex_campaign_id => campaign_id, 
              :yandex_banner_id => banners_ids[i], 
              :yandex_banner_updated_at => Time.zone.now
            )
          end
        end
      end
    end
  end

  def self._campaign
    YandexDirect.new(:CreateOrUpdateCampaign, "param" => {
      "Login" => "avtorif-2014", 
      "CampaignID" => 0, 
      "Name" => "Запчасти #{Time.now.utc}",
      "FIO" => "Корнев Руслан", 
      "Currency" => "RUB",
      "Strategy" => {
        "StrategyName" => "HighestPosition"
      }, 
      "AdditionalMetrikaCounters" => [14980414],
      "ClickTrackingEnabled" => "Yes",
      "EmailNotification"=> {
        "Email" => "avtorif-2014@yandex.ru",
        "WarnPlaceInterval" => 60,
        "MoneyWarningValue" => 20,
      }, 
      "StatusBehavior" => "No", 
      "ContextLimit" => "Limited", 
      "ContextLimitSum" => 0, 
      "AutoOptimization" => "No", 
      "StatusMetricaControl" => "Yes", 
      "StatusOpenStat" => "Yes", 
      "AddRelevantPhrases" => "No",
      "DayBudget" => {
        "Amount" => 300,
        "SpendMode" => "Default"
      }
    })
  end

  def self._banner(campaign_id, banner_id, phrase_id, spare_info_phrase)
    {
      "BannerID" => banner_id,
      "CampaignID" => campaign_id,
      "Title" => "#{spare_info_phrase._brand} - #{spare_info_phrase.catalog_number}",
      #"Text" => "#{spare_info_phrase.spare_info.cached_spare_catalog} #{ActionController::Base.helpers.number_to_currency(spare_info_phrase.spare_info.min_cost, :precision => 0, :delimiter => '')} от #{spare_info_phrase.spare_info.min_days} дн.",
      "Text" => "#{spare_info_phrase._catalog} #{ActionController::Base.helpers.number_to_currency(spare_info_phrase._price, :precision => 0, :delimiter => '')} Приходите!",
      "Href" => "http://www.avtorif.ru/user/products/new?catalog_number=#{spare_info_phrase._ncn}",
      "Geo" => "213",
      "ContactInfo" => {
         "Country" => spare_info_phrase.ycountry,
         "CountryCode" => spare_info_phrase.ycountry_code,
         "City" => spare_info_phrase.ycity,
         "Street" => spare_info_phrase.ystreet,
         "House" => spare_info_phrase.yhouse,
         "CityCode" => spare_info_phrase.ycity_code,
         "Phone" => spare_info_phrase.yphone,
         "CompanyName" => spare_info_phrase.ycompany_name,
         "ContactEmail" => spare_info_phrase.ycontact_email,
         "WorkTime" => spare_info_phrase.ywork_time,
         "OGRN" => spare_info_phrase.yogrn
      },
      "Phrases" => [{
        "PhraseID" => phrase_id,
        "Phrase" => spare_info_phrase._phrase,
        "Price" => 5,
        "Currency" => "RUB"
      }]
    }
  end
end
