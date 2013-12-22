class Post < ActiveRecord::Base
  mount_uploader :thumb, ThumbUploader

  validates :title, presence: true, length: { minimum: 1, maximum: 250 }
  validates :description, presence: true
  validates :url, presence: true
  belongs_to :site

end
