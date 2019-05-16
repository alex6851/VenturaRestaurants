class VenturaRestaurants::CLI
    def start
        puts "Welcome to the Yelp Fusion API Gem."
        VenturaRestaurants::API.get_categories
    end

    def menu
    end

end