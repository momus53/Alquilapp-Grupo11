class Usuario < ApplicationRecord
	has_many :informes, dependent: :destroy

end
