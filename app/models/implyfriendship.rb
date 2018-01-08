class Implyfriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :implyfriend, :class_name => "User"
end