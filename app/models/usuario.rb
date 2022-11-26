class Usuario < ApplicationRecord
	has_many :informes, dependent: :destroy
    has_many :travels
    validates :email, uniqueness: true, confirmation: { case_sensitive: false }
    validates :dni, uniqueness: true
    has_one_attached :active_storage_blobs
    has_one_attached :image
end
