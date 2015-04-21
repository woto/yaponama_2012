class Manage::PhrasesController < ApplicationController
  def index
    @q = SpareInfoPhrase.ransack(params[:q])
    @phrases = @q.result(distinct: true)
    @phrases = @phrases.includes(:spare_info => [:brand, :warehouses])
    @phrases = @phrases.limit(100)
    @phrases = @phrases.page(params[:page]).per(params[:per])
  end
end
