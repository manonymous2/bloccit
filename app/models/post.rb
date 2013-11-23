class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic
    has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true  

  # models/topic.rb
class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts
end
end