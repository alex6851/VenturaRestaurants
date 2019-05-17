class VenturaRestaurants::Restaurant
    attr_accessor :int_id, :id, :alias, :name, :image_url, :is_closed, :url, :review_count, :categories, :rating, :coordinates, :transactions, :price, :location, :phone, :display_phone, :distance

    @@all = []

    def initialize(restaurant)
        set_int_id
        restaurant_from_hash(restaurant)
        save
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
        binding.pry
    end

    def set_int_id 
        @int_id = @@all.length + 1
    end

    def restaurant_from_hash(restaurant)
        restaurant.each do |key, value|
            send("#{key}=", value)
        end
        
    end

  

    

end    