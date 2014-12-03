class DestroyOldBots
  def self.destroy_old_bots
    Somebody.where("created_at < ?", Time.zone.now - 1.month).where(bot: true).destroy_all && nil
  end
end
