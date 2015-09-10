class DeprecatedController < ApplicationController

  skip_before_action :create_resource
  skip_before_action :verify_authenticity_token

  def create
    render plain: "OK"
  end
end
