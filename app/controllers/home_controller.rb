class HomeController < ApplicationController
  before_action :clear_user_session

  def index
  end

  private

  def clear_user_session
    session[:player_id] = nil
  end

end
