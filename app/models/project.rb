class Project < ActiveRecord::Base

  # validations
  validates_presence_of :title, :description, :link
  # associations

  default_scope -> { order('created_at DESC') }
end
