class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public, :text
  has_many :posts
  has_many :posts, dependent: :destroy
end
