class RenameUrlToRedirectUrlInPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.rename :url, :redirect_url
    end
  end
end
