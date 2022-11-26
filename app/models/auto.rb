class Auto < ApplicationRecord
	has_many :informes, dependent: :destroy
	has_many :travels
	#validates :nroA, :presence => true
	validates :color, :presence => true
	validates :patente, :presence => true , length: {minimum: 4, message: "patente demasiado corta"}

	

end
