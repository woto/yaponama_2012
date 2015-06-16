class Y

  BANNERS_LIMIT = 1000
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
          where(:yandex_campaign_id => nil, :yandex_banner_id => nil, :publish => true).
          order(:id).limit(BANNERS_LIMIT)

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
      "Title" => "#{spare_info_phrase.spare_info.brand.name} - #{spare_info_phrase.catalog_number}",
      "Text" => "#{spare_info_phrase.spare_info.spare_catalog.name}. Сеть магазинов.",
      "Href" => "http://www.avtorif.ru/user/products/new?catalog_number=#{spare_info_phrase.spare_info.catalog_number}",
      "Geo" => "213",
      #"ContactInfo" => {
      #   "Country" => spare_info_phrase.ycountry,
      #   "CountryCode" => spare_info_phrase.ycountry_code,
      #   "City" => spare_info_phrase.ycity,
      #   "Street" => spare_info_phrase.ystreet,
      #   "House" => spare_info_phrase.yhouse,
      #   "CityCode" => spare_info_phrase.ycity_code,
      #   "Phone" => spare_info_phrase.yphone,
      #   "CompanyName" => spare_info_phrase.ycompany_name,
      #   "ContactEmail" => spare_info_phrase.ycontact_email,
      #   "WorkTime" => spare_info_phrase.ywork_time,
      #   "OGRN" => spare_info_phrase.yogrn
      #},
      "Phrases" => [{
        "PhraseID" => phrase_id,
        "Phrase" => spare_info_phrase.phrase,
        "Price" => 4,
        "Currency" => "RUB"
      }]
    }
  end
end
