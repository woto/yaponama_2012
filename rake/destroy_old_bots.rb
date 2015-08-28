class DestroyOldBots
  def self.destroy_old_bots
    Somebody.where(bot: true).find_each do |s|
      begin
        s.destroy
      rescue
      end
    end
  end
end
