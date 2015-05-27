class Ckpages::Public404Controller < Ckpages::Ascendant404Controller
  skip_before_action :set_resource_class, :find_resource
end
