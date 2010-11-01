class User < ActiveRecord::Base
  
  include ActivityStream::Actor
  
end