class IndexController < ApplicationController
  def index
    @countries  = Country.all
  end
end
