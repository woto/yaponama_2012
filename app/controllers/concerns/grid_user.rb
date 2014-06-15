# encoding: utf-8
#
module GridUser

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :single_integer
      }

      columns_hash['discount'] = {
        :type => :number
      }

      columns_hash['prepayment'] = {
        :type => :number
      }

      columns_hash['role'] = {
        :type => :set,
        :set => Hash[*Rails.configuration.somebody_roles.select{|k, v| v['real'] == true}.map{|k, v| [v['title'], k]}.flatten],
      }

      columns_hash['password_reset_sent_at'] = {
        :type => :date
      }

      columns_hash['ipgeobase_name'] = {
        :type => :string
      }

      columns_hash['ipgeobase_names_depth_cache'] = {
        :type => :string
      }

      columns_hash['accept_language'] = {
        :type => :string
      }

      columns_hash['user_agent'] = {
        :type => :string
      }
 
      columns_hash['russian_time_zone_manual_id'] = {
        :type => :set,
        :set =>  Rails.configuration.russian_time_zones.map{|k, v| [v, k]}
      }

      columns_hash['cached_russian_time_zone_auto_id'] = {
        :type => :set,
        :set =>  Rails.configuration.russian_time_zones.map{|k, v| [v, k]}
      }

      columns_hash['use_auto_russian_time_zone'] = {
        :type => :boolean
      }

      columns_hash['remote_ip'] = {
        :type => :string
      }

      columns_hash['creation_reason'] = {
        :type => :set,
        :set => eval("Hash[*Rails.configuration.#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
      }

      columns_hash['notes'] = {
        :type => :string,
      }

      columns_hash['notes_invisible'] = {
        :type => :string,
      }

      columns_hash['creator_id'] = {
        :type => :belongs_to,
        :belongs_to => User,
      }

      columns_hash['phantom'] = {
        :type => :boolean
      }

      columns_hash['bot'] = {
        :type => :boolean
      }

      columns_hash['logout_from_other_places'] = {
        :type => :boolean
      }
      columns_hash['online'] = {
        :type => :boolean
      }

      columns_hash['chat'] = {
        :type => :string
      }

      columns_hash['place_id'] = {
        :type => :string
      }

      columns_hash['post'] = {
        :type => :string
      }

      columns_hash['profile_id'] = {
        :type => :string
      }

      columns_hash['cached_profile'] = {
        :type => :string
      }

      columns_hash['cached_location'] = {
        :type => :string
      }

      columns_hash['cached_title'] = {
        :type => :string
      }

      columns_hash['cached_referrer'] = {
        :type => :string
      }

      columns_hash['first_referrer'] = {
        :type => :string
      }

      columns_hash['cached_screen_width'] = {
        :type => :string
      }

      columns_hash['cached_screen_height'] = {
        :type => :string
      }

      columns_hash['cached_client_width'] = {
        :type => :string
      }

      columns_hash['cached_client_height'] = {
        :type => :string
      }

      columns_hash['order_rule'] = {
        :type => :set,
        :set => Hash[*Rails.configuration.somebody_order_rules.map{|k, v| [v, k]}.flatten],
      }

      columns_hash['cached_credit'] = {
        :type => :number
      }

      columns_hash['cached_debit'] = {
        :type => :number
      }

      columns_hash['stats_count'] = {
        :type => :number
      }

      columns_hash['cached_talk'] = {
        :type => :string
      }

      columns_hash['total_talks'] = {
        :type => :number
      }

      columns_hash['unread_talks'] = {
        :type => :number
      }

      columns_hash['transport'] = {
        :type => :string
      }

      columns_hash['created_at'] = {
        :type => :date
      }

      columns_hash['updated_at'] = {
        :type => :date
      }


    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_bot = '1'
      @grid.visible_user_agent = '1'
      @grid.visible_stats_count = '1'
      @grid.visible_cached_location = '1'
      @grid.visible_cached_title = '1'
      @grid.visible_online = '1'
      @grid.visible_updated_at = '1'

    end

  end

end

