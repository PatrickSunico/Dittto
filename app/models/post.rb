class Post < ApplicationRecord
  extend FriendlyId
  acts_as_votable
  validates :title, :description, :thumbnail, presence: true
  mount_uploader :thumbnail, ThumbnailUploader

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :attachments, :dependent => :destroy
  process_in_background :thumbnail
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

end
