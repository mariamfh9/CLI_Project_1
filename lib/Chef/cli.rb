class Cli

    def run
        puts " "
        puts "Welcome to your journey to becoming a Chef!"
        puts " "
        prompt_ingredient
        prompt
        input = gets.strip.downcase
        while input != 'exit'
            if input == 'list'
                
                print_recipes(Recipe.find_by_ingredient(@ingredient))
            elsif input.to_i > 0 && input.to_i <= Recipe.find_by_ingredient(@ingredient).length
                
                recipe = Recipe.find_by_ingredient(@ingredient)[input.to_i-1]
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
        puts "See ya later!"
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
    end 

    def print_recipe(recipe)
        puts " "
        puts recipe.name
        puts " "
        puts "Now we can start cooking! Here is the recipe:"
        puts " "
        puts recipe.instructions

    end 

    def prompt
        puts " "
        puts "Select a 'number' to see the recipe, type 'list' to see the list again, type 'ingredient' to select a new ingredient, or 'exit'."
        puts " "
    end 

    def prompt_ingredient
        puts " "
        puts "Enter an ingredient and we'll make a meal out of it!"
        puts " "
        @ingredient = gets.strip.downcase
        Api.cook(@ingredient) 
        print_recipes(Recipe.all)
    end 

    def space
        puts " "
        puts "____________________"
        puts " "
    end 

end 