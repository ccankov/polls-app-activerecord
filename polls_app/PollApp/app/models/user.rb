class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def polls_started
    user_responses = Response.where(user_id: id)

    Poll.joins(:answer_choices)
      .joins("LEFT OUTER JOIN (#{user_responses.to_sql}) AS user_responses
        ON answer_choices.id = user_responses.answer_id")
      .group('polls.id')
  end

  def completed_polls
    polls_started
      .having('COUNT(user_responses.answer_id) = COUNT(DISTINCT questions.id)').load
  end

  def incomplete_polls
    polls_started
      .having('COUNT(user_responses.answer_id) > 0 AND
       COUNT(user_responses.answer_id) <> COUNT(DISTINCT questions.id)').load
  end


end
