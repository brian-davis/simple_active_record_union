class Author < ApplicationRecord
  has_many :books

  scope :science_fiction, -> () {
    self.where({ full_name: ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem"] })
  }

  scope :spy, -> () {
    self.where({ full_name: ["Tom Clancy", "John Le Carré", "Ian Fleming"] })
  }

  scope :humor, -> () {
    self.where({ full_name: ["Mark Twain", "Hunter S. Thompson"]})
  }

  scope :all_my_favorite_authors, -> () {
    self.union_all(self.science_fiction, self.spy, self.humor)
  }
end
