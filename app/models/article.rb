class Article < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
end
