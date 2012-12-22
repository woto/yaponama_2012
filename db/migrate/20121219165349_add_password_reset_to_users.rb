class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime
  end
end

# TODO хочу чтобы поля назывались confirmation_token (это в средствах связи уже наверное) и reset_password_token как было на yaponama.ru и devise
