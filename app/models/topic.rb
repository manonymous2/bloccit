class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public, :text
  has_many :posts
end
