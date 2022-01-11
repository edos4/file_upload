1. Register at Cloudinary.com

2. Verify email

3. Login. On Dashboard, copy: cloud_name, api_key, and api_secret

4. On the config folder, create a file called cloudinary.yml with contents:
development:
  cloud_name: ENV["cloud_name"]
  api_key: ENV["api_key"]
  api_secret: ENV["api_secret"]

production:
  cloud_name: ENV["cloud_name"]
  api_key: ENV["api_key"]
  api_secret: ENV["api_secret"]

5. On Gemfile, add:
#environment variables
gem 'dotenv-rails', :require => 'dotenv/rails-now'

#file upload
gem 'carrierwave', '1.3.1'
gem 'cloudinary', '~>1.13.2'
gem 'rmagick'

6. Run bundle install

7. Create a .env file like:
cloud_name=edos
api_key=962488422773563
api_secret=cOB8t7CSS43b3cUpxfNFOxgVuCo

8. Run bundle install

9. Scaffold a model. Let's use Attachment. 
#image field will be the uploaded file
rails g scaffold attachment name:string image:string

10. Edit database.yml accordingly:

11. Run rails db:setup && rails db:migrate

12. Create an uploader: 
a. Create a folder named uploader inside app
b. Create a file named img_uploader.rb with contents:

# encoding: utf-8

class ImgUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave 
  include CarrierWave::RMagick

  version :normal do
    process :auto_orient
  end

  def auto_orient
    manipulate! do |img|
      img.auto_orient!
    end
  end
end

13. app/uploaders/img_uploader.rb should exist

14. Edit attachment.rb, add:
mount_uploader :image, ImgUploader

15. Edit app/views/attachments/_form.html.erb:
from:
<%= form.text_field :image %>

to:
<%= form.file_field :image%>

16. Run rails s

17. Open localhost:3000/attachments and add a new record