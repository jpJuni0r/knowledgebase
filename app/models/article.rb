class Article < ApplicationRecord
  validates :question, length: { minimum: 4 }
  validates :answer, length: { minimum: 4 }
end
