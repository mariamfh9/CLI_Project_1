class Recipe
    attr_accessor :name, :meal_id, :ingredient, :instructions, :ingredients, :origin, :measures
    @@all = []

    def initialize(name:, meal_id:, ingredient:)
        @name = name 
        @meal_id = meal_id
        @ingredient = ingredient
        @ingredients = []
        @measures = []
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.find_by_ingredient(ingredient)
        @@all.select {|d| d.ingredient == ingredient}
    end 


    
end 