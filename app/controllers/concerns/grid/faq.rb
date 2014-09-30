# encoding: utf-8
#
module Grid::Faq
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['checkbox'] = {
          :type => :checkbox,
        }

        columns_hash['question'] = {
          :type => :string,
        }

        columns_hash['answer'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_question = '1'
      @grid.visible_answer = '1'
      @grid.visible_updated_at = '1'

    end

  end

end
