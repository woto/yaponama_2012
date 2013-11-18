# encoding: utf-8
#
# TODO удалить
##encoding: utf-8
#
#module GridAccount
#  extend ActiveSupport::Concern
#  include AbstractGridable
#
#  included do
#
#    def adjust_columns!(columns_hash)
#
#      #columns_hash['checkbox'] = {
#      #  :type => :checkbox
#      #}
#
#      columns_hash['id'] = {
#        :type => :single_integer
#      }
#
#      columns_hash['debit'] = {
#        :type => :number
#      }
#
#      columns_hash['credit'] = {
#        :type => :number
#      }
#
#      columns_hash['accountable_id'] = {
#        :type => :string
#      }
#
#      columns_hash['accountable_type'] = {
#        :type => :string
#      }
#
#      columns_hash['created_at'] = {
#        :type => :date
#      }
#
#      columns_hash['updated_at'] = {
#        :type => :date
#      }
#
#    end
#
#    def set_preferable_columns
#      #@grid.checkbox_visible = '1'
#      @grid.id_visible = '1'
#      @grid.debit_visible = '1'
#      @grid.credit_visible = '1'
#    end
#
#  end
#
#end
