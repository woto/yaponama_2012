class Ckpages::PublicController < Ckpages::AscendantController
  skip_before_action :set_resource_class, :find_resource
end
