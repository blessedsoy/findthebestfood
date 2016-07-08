class Restaurant

	attr_accessor :name, :phone, :address, :rating, :price, :price_level, :reviews, :opening_hours
   PRICE_LEVEL = {
    '0' => "Free",
    '1' => "Inexpensive",
    '2' => "Moderate",
    '3' => "Expensive",
    '4' => "Very Expensive"
   }

	def initialize(attributes)
		attributes.each {|attr_name, attr_value| self.send("#{attr_name}=", attr_value)}
    @price = PRICE_LEVEL[@price_level.to_s] || "Unavailable"
	end



end