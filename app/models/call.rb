# encoding: utf-8
#
class Call < ActiveRecord::Base
  include BelongsToSomebody

  belongs_to :phone
  has_many :talks, :as => :talkable
  mount_uploader :file, UploadUploader

  after_create :create_associated
  
  def value=(value)
    self.phone = Phone.where(:phone => value).first_or_initialize
  end

  def create_associated

    if phone.new_record?
      # fill user
      user = phone.build_user(SiteConfig.default_user_attributes)
      user.build_account
      user.creation_reason = 'call'

      # fill phone
      phone.phone_type = 'unknown'
      phone.creation_reason = 'call'

      user.save!
      phone.save!

    end

    Talk.create!(:talkable => self, :user => phone.user)

  end

end
