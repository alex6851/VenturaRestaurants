class VenturaRestaurants::API

    def self.get_categories   
        resp = HTTParty.get("https://api.yelp.com/v3/businesses/search?term=Restaurants&location=Ventura", {headers: {"Authorization" => "Bearer #{ENV['VenturaRestaurants_KEY']}"}})
        binding.pry
        restaurants = resp["businesses"]

        Yelp
    end

end