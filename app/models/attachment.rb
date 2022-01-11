class Attachment < ApplicationRecord
  mount_uploader :image, ImgUploader
end
