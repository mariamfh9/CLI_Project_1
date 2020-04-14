class Recipe
    attr_accessor :name, :meal_id, :ingredient, :instructions
    @@all = []

    def initialize(name:, meal_id:, ingredient: )
        @name = name 
        @meal_id = meal_id
        @ingredient = ingredient
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.find_by_ingredient(ingredient)
        @@all.select {|d| d.ingredient == ingredient}
    end 


    
end 