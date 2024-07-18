# frozen_string_literal: true

class Competition < ApplicationRecord
  belongs_to :author, class_name: 'User', primary_key: :id, foreign_key: :author_id

  validates :name, presence: true
end
