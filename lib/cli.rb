class VenturaRestaurants::CLI
    def start
        puts "Welcome to the Yelp Fusion API Gem."
        VenturaRestaurants::API.get_restaurants
        binding.pry
    end

    def select_restaurant
        VenturaRestaurants::Restaurant.all[1]
    end

    def list_restaurants_in_category      
        restaurants_in_category = []
        VenturaRestaurants::Restaurant.all.each do |restaurant|
            restaurants_in_category << restaurant.name if restaurant.categories[0]["title"] =~ /#{@input}/
            end
            restaurants_in_category.each do |restaurant|
            puts "#{restaurant}"
        end           
    end

    def get_user_input 
        @input = gets.strip
        if @input.is_a? Integer
            @input = @intput - 1 
        end
    end


    def list_categories
        categories = []
        VenturaRestaurants::Restaurant.all.each do |restaurant|
             categories << restaurant.categories[0]["title"]
            end
        categories.uniq!.each do |category|
            puts "#{category}"
        end           
    end

    def list_restaurants
        #View all restaurants in a category
        restaurants = []
        VenturaRestaurants::Restaurant.all.each do |restaurant|
            puts restaurant.name
        end 

    end

end