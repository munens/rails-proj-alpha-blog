class Article < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true, length: {minimum: 3, maximum: 20}

	# also validate the description:
	validates :description, presence: true, length: {minimum: 10, maximum: 300}
	validates :user_id, presence: true
end