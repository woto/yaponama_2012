class Admin::Opts::AbstractController < ApplicationController
  include Admin::Admined

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]
end
