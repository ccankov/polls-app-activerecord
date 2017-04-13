class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    answer_freqs = self.answer_choices.left_outer_joins(:responses)
      .select('answer_choices.*, COUNT(responses.answer_id) as freq')
      .group('answer_choices.id')
    freq_hash = Hash.new(0)
    answer_freqs.each {|a| freq_hash[a.text] = a.freq }
    freq_hash
  end
end
