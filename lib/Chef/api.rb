class Api

    def self.cook(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url))
        recipes = JSON.parse(response)["meals"]
        recipes.each {|d| Recipe.new(name: d["strMeal"], meal_id: d["idMeal"], ingredient: ingredient)}

    end 

    def self.get_recipe_details(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.meal_id}"
        response = Net::HTTP.get(URI(url))
        data = JSON.parse(response)["meals"]
        recipe.instructions = data[0]["strInstructions"]
    end 

end 