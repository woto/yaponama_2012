class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def impersonate?
    case @user.role
    when 'manager'
      @record.role.in? ['guest', 'user']
    when 'admin'
      true
    end
  end

  def update?
    if record.encrypted_password?
      ((user.admin? && record.role.in?(['user', 'manager', 'admin'])) ||
       (user.manager? && record.role == 'user') ||
       (user.manager? && (user.id == record.id) && !record.role_changed?))
    end
  end

  def create?
    if record.encrypted_password?
      ((user.admin? && record.role.in?(['user', 'manager', 'admin'])) ||
       (user.manager? && record.role == 'user'))
    end
  end

end
