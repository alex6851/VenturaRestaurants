class VenturaRestaurants::Category
    attr_accessor :name, :restaurant

    @@all = []

    def initialize(name, restaurant)
        @name = name
        @restaurant = restaurant
        save
    end

    def save 
        @@all << self
    end

    def self.all
        @@all
    end

end