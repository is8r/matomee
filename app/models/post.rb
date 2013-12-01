class Post < ActiveRecord::Base
  mount_uploader :thumb, ThumbUploader
end
