class VenturaRestaurants::CLI
    @@white = "\e[1;37m"
    @@blue = "\e[0;34m"
    @@yellow = "\u001b[33m"
    @@cyan = "\e[0;36m"
    @@bold = "\u001b[1m"
    @@background_blue = "\u001b[34m"
    @@green = "\u001b[32m"
    @@background_red = "\u001b[41m"
    @@background_green = "\u001b[42m"
    @@reversed = "\u001b[7m"
    @@reset = "\u001b[0m"


    
    def start
        @input = ""
        puts "#{@@green}#{@@reversed}Welcome to the Restaurants of Ventura App.#{@@reset}"
        puts ""
        puts ""
        VenturaRestaurants::API.get_restaurants
        

        while @input != "N"
            puts "#{@@green}#{@@reversed}Type 'genre' to view Restaurants by genre and type 'all' to view all the restaurants!#{@@reset}"
            get_user_input
            
            case @input
            when "genre"
                list_categories
                puts "#{@@green}#{@@reversed}Type in the name of the Genre(or part of the name)#{@@reset}"
                get_user_input
                select_category_and_list_restaurants_in_category
                puts "#{@@green}#{@@reversed}Select the number of the Restaurant OR type 'all' OR type 'back' to go back to the top#{@@reset}"
                get_user_input
                if @input == "all"
                    select_and_display_all_restaurants_in_category          
                elsif @input != "back"
                    input_to_index
                    select_restaurant_in_category
                    display_restaurant_details
                end    
            when "all"
                list_restaurants
                puts "#{@@green}#{@@reversed}Select the number of the Restaurant OR type 'all' OR type 'back' to go back to the top#{@@reset}"
                get_user_input
                if @input == "all"
                    select_and_display_all_restaurants
                elsif @input != "back"   
                    input_to_index 
                    select_restaurant
                    display_restaurant_details
                end
            end
            if @input != "back"
                puts "#{@@green}#{@@reversed}Do you want to see another restaurant?#{@@reset}"
                get_user_input
            end
        end  
    end

    def select_and_display_all_restaurants
        VenturaRestaurants::Restaurant.all.each do |restaurant| 
            @restaurant = restaurant
            display_restaurant_details
        end
    end

    def select_restaurant   
        @restaurant = VenturaRestaurants::Restaurant.all[@input]
    end

    def select_and_display_all_restaurants_in_category
        @restaurants_in_category.each do |restaurant|
            @restaurant = restaurant
            display_restaurant_details
        end
    end

    def display_restaurant_details
        puts ""
        puts "    #{@@yellow}#{@@reversed}#{@restaurant.name}#{@@reset}"
        puts ""
        puts "#{@@blue}Phone: #{@@cyan}#{@restaurant.display_phone}"
        puts "#{@@blue}Price: #{@@cyan}#{@restaurant.price}"
        puts "#{@@blue}Rating: #{@@cyan}#{@restaurant.rating}"
        puts "#{@@blue}Review Count: #{@@cyan}#{@restaurant.review_count}"
        puts "#{@@blue}Yelp Page: #{@@cyan}#{@restaurant.url}"
        puts "#{@@blue}Is Closed?: #{@@cyan}#{@restaurant.is_closed}"
        puts ""
    end

    def select_restaurant_in_category
       @restaurant = @restaurants_in_category[@input]
    end

    def select_category_and_list_restaurants_in_category      
        @restaurants_in_category = []
        VenturaRestaurants::Category.all.each do |category|
            @restaurants_in_category << category.restaurant if category.name =~ /#{@input}/
            end
            @restaurants_in_category.each_with_index do |restaurant, index|
            puts "#{@@green}#{index + 1}. #{restaurant.name}"
        end           
    end

    def get_user_input 
        @input = gets.strip
    end

    def input_to_index
        @input = @input.to_i - 1
    end


    def list_categories
        categories = []
        VenturaRestaurants::Category.all.each do |category|
            categories << category.name
        end
        categories.uniq!.each do |category|
            puts "#{@@green}#{category}"
        end
          
    end

    def list_restaurants
        VenturaRestaurants::Restaurant.all.each_with_index do |restaurant, index|
            puts "#{@@green}#{index + 1}. #{restaurant.name}"
        end 

    end

end