class Usuario < ApplicationRecord
    has_one_attached :active_storage_blobs
    has_one_attached :image
end