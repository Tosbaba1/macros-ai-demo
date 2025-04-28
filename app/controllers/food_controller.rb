class FoodController < ApplicationController
  def estimate
    render ({ :template => "macros/calculate" })
  end
end
