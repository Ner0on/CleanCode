class HomeController < ApplicationController

  def index
    @countries  = Country.all
  end

  def get_country_states
    country = Country.find(params[:id])
    states = country.states.sort_by{ |m| m.name}

    render :json => states
  end

  def get_states_cities
    state = State.find(params[:id])
    cities = state.cities.sort_by{ |m| m.name}

    render :json => cities
  end

end
