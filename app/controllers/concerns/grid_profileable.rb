# encoding: utf-8
#
module GridProfileable
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    private

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_notes = '1'
      unless @somebody
        @grid.visible_somebody_id = '1'
      end
    end

  end

end
