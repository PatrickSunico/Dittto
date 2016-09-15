class Attachment < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  validates :post, presence: true
  process_in_background :image
end
