class Post < ActiveRecord::Base

  # validations
  validates_presence_of :title, :content, :slug

  # associations

  default_scope -> { order('created_at DESC') }

  extend FriendlyId
  friendly_id :title , use: [:slugged, :history]

end
