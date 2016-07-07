class Restaurant

	attr_accessor :name, :phone, :address, :rating, :price, :reviews, :opening_hours


	def initialize(attributes)
		attributes.each {|attr_name, attr_value| self.send("#{attr_name}=", attr_value)}
	end



end