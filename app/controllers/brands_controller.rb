# encoding: utf-8

class BrandsController < ApplicationController
  def index
    @brand = Brand.where(:name => params[:brand]).first

    commentable_helper @brand
  end
end
