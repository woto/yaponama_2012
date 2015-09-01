class ActualizeBotRules < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Bot.where(Arel::Nodes::NamedFunction.new('LENGTH', [Bot.arel_table[:user_agent]]).lt(1)).each do |b|
          b.update(user_agent: nil)
        end
        Bot.where.not(user_agent: nil).each do |b|
          b.update(user_agent: "%#{b.user_agent}%")
        end
      end
    end
  end
end
