class Question < ActiveRecord::Base
	validates :title, :body, presence: true
	
	belongs_to :user
	has_many :answers
	has_many :attachments, as: :attachmentable
	has_many :comments, as: :commentable

	accepts_nested_attributes_for :attachments

	default_scope -> { order :created_at }

	before_destroy :destroy_answers

	private

	def destroy_answers
     self.answers.delete_all   
    end
end