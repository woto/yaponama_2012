module Concerns::Models::Authorization

  extend ActiveSupport::Concern

  included do
    enum role: ["guest", "user", "manager", "admin"]
    before_update :prohibit_downgrading_role_to_guest, if: -> {role_changed?}
    validates :role, presence: true

    def prohibit_downgrading_role_to_guest
      if role_was != 'guest' && role == 'guest'
        errors[:role] << "Нельзя менять роль на гостя" and false
      end
    end
  end

  def seller?
    ["manager", "admin"].include? role
  end

  def buyer?
    ["guest", "user"].include? role
  end

end
