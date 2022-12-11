class Auto < ApplicationRecord
	has_many :informes, dependent: :destroy
	has_many :travels, dependent: :destroy
	validates :nroA, :presence => true
	validates :color, :presence => true 
	validates :patente, :presence => true , uniqueness: true,length: {minimum: 4, message: "patente demasiado corta"}

	

end
