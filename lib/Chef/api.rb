class Api

    def self.cook(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url))  
        recipes = JSON.parse(response)["meals"]
        new_ingredient = Ingredient.new(ingredient) 

        if recipes.length > 0 
            recipes.each do |d|
                new_recipe = Recipe.new(name: d["strMeal"], meal_id: d["idMeal"], ingredient: ingredient)
                new_ingredient.recipes << new_recipe 
            end 
     
        else 
            new_ingredient.recipes = []
        end 

    end 

    def self.get_recipe_details(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.meal_id}"
        response = Net::HTTP.get(URI(url))
        data = JSON.parse(response)["meals"][0]
        recipe.instructions = data["strInstructions"]
        recipe.origin = data["strArea"]
        data.keys.each do |k| 
           recipe.ingredients << data[k] if (k.include? "Ingredient") && data[k] 
           recipe.measures << data[k] if (k.include? "Measure") && data[k] 
        end 
    end 

end 