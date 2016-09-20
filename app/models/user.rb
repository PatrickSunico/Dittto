class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :userhandle, use: :slugged
  validates :first_name, :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :userhandle

  # If User Deletes Account Remove all post and comments associated with the user
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  # Mount Uploader for Avatar
  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar

  def slug_candidates
    [
      :userhandle,
      [:userhandle, :id]
    ]
  end

end
