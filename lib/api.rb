class VenturaRestaurants::API

    def self.get_restaurants   
        resp = HTTParty.get("https://api.yelp.com/v3/businesses/search?term=Restaurants&location=Ventura", {headers: {"Authorization" => "Bearer #{ENV['YELP_API_KEY']}"}})
        restaurants = resp["businesses"]       
        VenturaRestaurants::Restaurant.new_from_collection(restaurants)
    end 
end