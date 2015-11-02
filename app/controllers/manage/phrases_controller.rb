class Manage::PhrasesController < ApplicationController
  skip_before_action :find_resources

  def index
    @q = SpareInfoPhrase.ransack(params[:q])
    @phrases = @q.result(distinct: true)
    @phrases = @phrases.includes(:spare_info => [:brand, :warehouses])
    @phrases = @phrases.limit(100)
    @phrases = @phrases.page(params[:page]).per(params[:per])
  end
end
