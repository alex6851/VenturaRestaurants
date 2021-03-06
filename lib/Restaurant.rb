class VenturaRestaurants::Restaurant
    attr_accessor :id, :alias, :name, :image_url, :is_closed, :url, :review_count, :categories, :rating, :coordinates, :transactions, :price, :location, :phone, :display_phone, :distance

    @@all = []

    def initialize(restaurant)
        restaurant_from_hash(restaurant)
        save     
        category_from_restaurant(restaurant)
    end

    def save 
        @@all << self
      end
       
    def self.all
        @@all
    end

    def self.new_from_collection(restaurants)
        restaurants.each do |restaurant|
            new(restaurant)
        end 
    end

    def restaurant_from_hash(restaurant)
        restaurant.each do |key, value|
            send("#{key}=", value)
        end
        
    end

    def category_from_restaurant(restaurant)
        self.categories.each do |category|
        VenturaRestaurants::Category.new(category["title"],self)
        end
    end
  

    

end    