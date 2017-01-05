class WelcomeController < ApplicationController
  def index
    flash[:notice] = "早安！good morning"
  end
end
