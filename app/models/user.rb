# frozen_string_literal: true

class User < ApplicationRecord
  has_many :competitions, foreign_key: :author_id
end
