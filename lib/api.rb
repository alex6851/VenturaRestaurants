class VenturaRestaurants::API

    def self.get_restaurants   
        resp = HTTParty.get("https://api.yelp.com/v3/businesses/search?term=Restaurants&location=Ventura&radius=30000", {headers: {"Authorization" => "Bearer #{ENV['YELP_API_KEY']}"}})
        restaurants = resp["businesses"]
        binding.pry      
        VenturaRestaurants::Restaurant.new_from_collection(restaurants)
    end 
end
