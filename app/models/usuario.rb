class Usuario < ApplicationRecord
	has_many :informes, dependent: :destroy

    has_one_attached :active_storage_blobs
    has_one_attached :image
end
