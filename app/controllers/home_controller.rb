class HomeController < ApplicationController
  def index
    @countries  = Country.all
  end

  def states_in_selected_country
    country = Country.find(params[:id])
    @states = country.states
  end

  def cities_in_selected_state
    state = State.find(params[:id])
    @cities = state.cities
  end

end
