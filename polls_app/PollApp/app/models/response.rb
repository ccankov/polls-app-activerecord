class Response < ApplicationRecord
  validates :answer_id, presence: true
  validates :user_id, presence: true
  validate :not_duplicate_response
  validate :not_author_response

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def not_duplicate_response
    if sibling_responses.exists?(user_id: id)
      errors[:user_id] << ' has already responded to this question.'
    end
  end

  def sibling_responses
    question.responses.where.not('responses.id = ?', id)
  end

  def not_author_response
    if question.poll.author_id == user_id
      errors[:user_id] << ' cannot be the author.'
    end
  end
end
