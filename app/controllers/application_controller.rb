class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_country_states
    country = Country.find(params[:id])
    states = country.states.sort_by{ |m| m.name.gsub!('"','')}

    render :json => states
  end

  def get_states_cities
    state = State.find(params[:id])
    cities = state.cities.sort_by{ |m| m.name}
    
    render :json => cities
  end

end
