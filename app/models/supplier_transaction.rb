# rrda
#
class SupplierTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody

  serialize :cached_main_profile_before, JSON
  serialize :cached_main_profile_after, JSON

end
