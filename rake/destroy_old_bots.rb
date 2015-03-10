class DestroyOldBots
  def self.destroy_old_bots
    Somebody.where(bot: true).find_each do |s|
      s.destroy
    end
  end
end
