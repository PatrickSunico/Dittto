class Post < ApplicationRecord
  extend FriendlyId
  acts_as_votable
  validates :title, :description, :thumbnail, presence: true
  mount_uploader :thumbnail, ThumbnailUploader

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :attachments, :dependent => :destroy
  process_in_background :thumbnail
  friendly_id :should_generate_new_friendly_id?, use: [:slugged, :history]
  friendly_id :slug_candidates, use: [:finders]

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end
end
