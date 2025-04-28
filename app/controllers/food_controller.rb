class FoodController < ApplicationController
  def estimate
    render ({ :template => "macros/calculate" })
  end

  def results
    @the_image = params.fetch("image_param", nil)
    @the_description = params.fetch("description_param")

    c = OpenAI::Chat.new
    c.system ("You are a nutrisionist that speaks like Gordon Ramsey. The user will give you an image and/or a description of a meal. Your job is to estimate the macronutrients and calories in it.")


    c.user("Here is an image:", image: @the_image)
    c.user(@the_description)

    c.schema = '{
      "name": "nutritional_info",
      "schema": {
        "type": "object",
        "properties": {
          "carbohydrates": {
            "type": "number",
            "description": "The amount of carbohydrates in grams."
          },
          "protein": {
            "type": "number",
            "description": "The amount of protein in grams."
          },
          "fat": {
            "type": "number",
            "description": "The amount of fat in grams."
          },
          "total_calories": {
            "type": "number",
            "description": "The total caloric content in kilocalories."
          }
        },
        "required": [
          "carbohydrates",
          "protein",
          "fat",
          "total_calories"
        ],
        "additionalProperties": false
      },
      "strict": true
    }'
    @structured_output = c.assistant!

    @g_carbs = @structured_output.fetch("carbohydrates")
    @g_protein = @structured_output.fetch("protein")
    @g_fat = @structured_output.fetch("fat")
    @kcal = @structured_output.fetch("total_calories")

    render ({ :template => "macros/results" })
  end
end
