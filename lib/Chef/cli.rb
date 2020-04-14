class Cli

    def run
        puts " "
        puts "Welcome to your journey to becoming a Chef!".yellow
        puts " "
        prompt_ingredient
        prompt
        input = gets.strip.downcase
        while input != 'exit'
            if input == 'list'
                
                print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
            elsif input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).recipes.length
                
                recipe = Ingredient.find_by_ingredient(@ingredient).recipes[input.to_i-1]
                Api.get_recipe_details(recipe) if !recipe.instructions
                print_recipe(recipe) 
            elsif input == "ingredient" 
                prompt_ingredient

            else 
                puts "I do not understand - please try again"  
                puts " "
            end 
            prompt
            input = gets.strip.downcase
        end 
        puts " "
        puts "See ya later!".blue
        puts " "
    end 

    def print_recipes(recipes)
        space
        puts " "
        puts "These are all the recipes made with #{@ingredient}:"
        puts " "
        recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end 
        space
    end 

    def print_recipe(recipe)
        space
        puts "#{recipe.name} Recipe"
        space
        puts "Origin: #{recipe.origin}".magenta
        space
        puts "Ingredients:".magenta
        puts " "
        recipe.ingredients.each_with_index do |ingredient, index|
            puts "#{ingredient}-#{recipe.measures[index]}"
        end 
        puts " "
        puts "Now we can start cooking! Here is the recipe:".magenta
        puts " "
        puts "#{recipe.instructions}".cyan
        puts " "

    end 

    def prompt
        puts " "
        puts "Select a 'number' to see the recipe, type 'list' to see the list again, type 'ingredient' to select a new ingredient, or 'exit'.".magenta
        puts " "
    end 

    def prompt_ingredient
        puts " "
        puts "Enter an ingredient and we'll make a meal out of it!".cyan
        puts " "
        @ingredient = gets.strip.downcase
        Api.cook(@ingredient) if !Ingredient.find_by_ingredient(@ingredient) 
        print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
    end 

    def space
        puts " "
        puts "____________________".yellow
        puts " "
    end 

end 