class Post < ApplicationRecord
  acts_as_paranoid
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :body,  presence: true

	has_attached_file :avatar, styles: { thumb: "400x400>" }
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  	scope :search, ->(query) { where("title like ?", "%#{query}%") }


  	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
  			csv << column_names
  			all.each do |post|
  				csv << post.attributes.values_at(*column_names)
  			end
  		end
  	end
end
