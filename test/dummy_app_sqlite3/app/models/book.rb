class Book < ApplicationRecord
  belongs_to :author

  scope :science_fiction, -> () {
    self.where({ author_id: Author.science_fiction.pluck(:id) })
  }

  scope :spy, -> () {
    self.where({ author_id: Author.spy.pluck(:id) })
  }

  scope :humor, -> () {
    self.where({ author_id: Author.humor.pluck(:id) })
  }
end
