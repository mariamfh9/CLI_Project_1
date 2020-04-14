class Api

    def self.cook(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url))  #to get back JSON in strings
        recipes = JSON.parse(response)["meals"] #usable JSON, recipes points at an array of meals
        new_ingredient = Ingredient.new(ingredient) #creates a new ingredient
        recipes.each do |d| #go through all the recipes and make a new meal for each one
           new_recipe = Recipe.new(name: d["strMeal"], meal_id: d["idMeal"], ingredient: ingredient)
           new_ingredient.recipes << new_recipe #relationship between ingredient and recipe
        end 
    end 

    def self.get_recipe_details(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.meal_id}"
        response = Net::HTTP.get(URI(url))
        data = JSON.parse(response)["meals"]
        recipe.instructions = data[0]["strInstructions"]
    end 

end 