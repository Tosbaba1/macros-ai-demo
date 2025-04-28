class FoodController < ApplicationController
  def estimate
    render ({ :template => "macros/calculate" })
  end

  def results
    @the_image = params.fetch("image_param")
    @the_description = params.fetch("description_param")

    render ({ :template => "macros/results" })
  end
end
