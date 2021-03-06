class VenturaRestaurants::CLI
    BLUE = "\e[0;34m"
    YELLOW = "\u001b[33m"
    CYAN = "\e[0;36m"
    GREEN = "\u001b[32m"
    REVERSED = "\u001b[7m"
    RESET = "\u001b[0m"

# allow a user to exit at least in 2 of sub-menus (at any time would be best)
# allow case insensitive responses 
# ensure program doesn't crash on bad input
    
    def start
        @input = ""
        puts "#{GREEN}#{REVERSED}Welcome to the Restaurants of Ventura App.#{RESET}"
        puts ""
        puts ""
        VenturaRestaurants::API.get_restaurants
        
        #I changed from a while loop because I found the "loop do" loop to be more predictable.
        loop do
            puts "#{GREEN}#{REVERSED}Type 'genre' to view Restaurants by genre and type 'all' to view all the restaurants!#{RESET}"
            puts ""
            puts "#{GREEN}#{REVERSED}Or type EXIT at ANY time to end the program#{RESET}"
            @restaurant = nil
            get_user_input
            validate_genre_or_all
            
            case @input
            when "genre"
                get_categories
                list_categories
                puts "#{GREEN}#{REVERSED}Select the number of the Genre or type 'back'#{RESET}"
                get_user_input
                
                if @input != "back"
                    input_to_index
                    select_category
                    validate_category
                    list_restaurants_in_category
                    puts "#{GREEN}#{REVERSED}Select the number of the Restaurant OR type 'all' OR type 'back' to go back to the top#{RESET}"
                    get_user_input
                end
                
                
                if @input == "all"
                    select_all_restaurants_in_category_and_display_details         
                elsif @input != "back"
                    input_to_index
                    select_restaurant_in_category
                    validate_restaurant_in_category
                    display_restaurant_details
                end    
            when "all"
                list_restaurants
                puts "#{GREEN}#{REVERSED}Select the number of the Restaurant OR type 'all' OR type 'back' to go back to the top#{RESET}"
                get_user_input
                
                if @input == "all"
                    select_and_display_all_restaurants
                elsif @input != "back"   
                    input_to_index
                    select_restaurant
                    validate_restaurant               
                    display_restaurant_details
                end
            end
            if @input != "back"
                puts "#{GREEN}#{REVERSED}Do you want to see another restaurant? Y/N #{RESET}"
                get_user_input
                if  @input == "n"
                    break
                end
            end
        end  
    end
    

    def validate_genre_or_all
        while @input != "genre" && @input != "all"
           puts "#{GREEN}#{REVERSED}I dont understand please type genre or all#{RESET}"
           get_user_input
        end
    end

    def select_and_display_all_restaurants
        VenturaRestaurants::Restaurant.all.each do |restaurant| 
            @restaurant = restaurant
            display_restaurant_details
        end
    end
    def validate_restaurant
        while @restaurant == nil
         puts "#{GREEN}#{REVERSED}Sorry about that we couldnt find your restaurant could you type it in again for me?#{RESET}"
         get_user_input
         input_to_index
         select_restaurant
        end
    end
    def select_restaurant   
        @restaurant = VenturaRestaurants::Restaurant.all[@input]
    end

    def select_all_restaurants_in_category_and_display_details
        @restaurants_in_category.each do |restaurant|
            @restaurant = restaurant
            display_restaurant_details
        end
    end

    def display_restaurant_details
        puts ""
        puts "    #{YELLOW}#{REVERSED}#{@restaurant.name}#{RESET}"
        puts ""
        puts "#{BLUE}Phone: #{CYAN}#{@restaurant.display_phone}"
        puts "#{BLUE}Price: #{CYAN}#{@restaurant.price}"
        puts "#{BLUE}Rating: #{CYAN}#{@restaurant.rating}"
        puts "#{BLUE}Review Count: #{CYAN}#{@restaurant.review_count}"
        puts "#{BLUE}Yelp Page: #{CYAN}#{@restaurant.url}"
        puts "#{BLUE}Is Closed?: #{CYAN}#{@restaurant.is_closed}"
        puts ""
    end

    def validate_restaurant_in_category
        #Here I validate if the number selected is in array.
        #The default value of @restaurant is "nil" so if you select a number thats in the @restaurants_in_category array then @restaurant will change from "nil."
        while @restaurant == nil
            puts "#{GREEN}#{REVERSED}Sorry about that we couldnt find your restaurant could you type it in again for me?#{RESET}"
            get_user_input
            input_to_index
            select_restaurant_in_category
        end

    end

    def select_restaurant_in_category 
       @restaurant = @restaurants_in_category[@input]
    end

    def select_category      
        @restaurants_in_category = []
        VenturaRestaurants::Category.all.each do |category|
            @restaurants_in_category << category.restaurant if category.name == @categories[@input]    
        end 
    end

    def validate_category
        #Here I validate if the number selected is in array.
        while @categories[@input] == nil
            puts "#{GREEN}#{REVERSED}Sorry about that we couldnt find the category could you type it in again for me?#{RESET}"
            get_user_input
            input_to_index
            select_category
        end
    end

    def list_restaurants_in_category
        @restaurants_in_category.each_with_index do |restaurant, index|
            puts "#{GREEN}#{index + 1}. #{restaurant.name}"
        end        
    end

    def get_user_input
        @input = gets.strip.downcase
    #This allows the user to end the program at anytime by typing 'exit.'
        if @input == "exit"
            abort
        end
    end

    def input_to_index
        #this is where I validate if the user input is an Integer.
        while !(@input =~ /\d/) && !(@input =~ /\d\d/)                   
              puts "#{GREEN}#{REVERSED}I'm sorry I didnt understand, I'm looking for a number.#{RESET}"
              get_user_input
        end      
            @input = @input.to_i - 1 
    end


    def get_categories
        @categories = []
        VenturaRestaurants::Category.all.each do |category|
            @categories << category.name
        end
    end

    def list_categories
        @categories.uniq!.each_with_index do |category, index|
            puts "#{GREEN} #{index + 1}. #{category}"
        end
    end

    def list_restaurants
        VenturaRestaurants::Restaurant.all.each_with_index do |restaurant, index|
            puts "#{GREEN}#{index + 1}. #{restaurant.name}"
        end 

    end

end