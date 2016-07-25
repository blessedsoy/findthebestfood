class Restaurant

	attr_accessor :name, :phone, :address, :rating, :price, :price_level, :reviews, :opening_hours, :open_now
   PRICE_LEVEL = {
    '0' => "Free",
    '1' => "Inexpensive",
    '2' => "Moderate",
    '3' => "Expensive",
    '4' => "Very Expensive"
   }

   @@all=[]

	def initialize(attributes)
		attributes.each {|attr_name, attr_value| self.send("#{attr_name}=", attr_value)}
        
    self.name = self.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
    self.open_now = "Unavailable"
    self.add_opening_hours
    self.check_if_created

    @@all << self
	end


  def check_if_created
    @@all.collect do |restaurant|
      if restaurant.name == self.name
        restaurant.price = PRICE_LEVEL[restaurant.price_level.to_s] || "Unavailable"
        restaurant.rating = ((restaurant.rating + self.rating) / 2).round(1)
        restaurant.reviews =  self.reviews if self.reviews
      end
    end
  end

  def add_opening_hours
      if self.opening_hours && self.opening_hours.size > 0
        self.open_now = self.opening_hours["open_now"]
        self.opening_hours = self.opening_hours["weekday_text"]
      end    
  end

  def self.all 
    @@all
  end

end