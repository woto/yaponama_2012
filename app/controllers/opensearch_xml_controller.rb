class OpensearchXmlController < ApplicationController
  include SetResourceClassDummy

  def index
    render 'index', layout: false
  end

  private

end
