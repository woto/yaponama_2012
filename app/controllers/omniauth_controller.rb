# encoding: utf-8

class OmniauthController < ApplicationController
  def create
    render :text => "<pre> #{request.env['omniauth.auth'].to_yaml} </pre>"
  end
end
