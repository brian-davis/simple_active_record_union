require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    Rails.application.load_seed
  end

  test "science_fiction scope" do
    e = ["Foundation", "2001: A Space Odyssey", "Solaris"]
    r = Book.science_fiction.pluck(:title)
    assert r.all? { |a| e.include?(a) }
  end

  test "spy scope" do
    e = ["Clear and Present Danger", "Tinker, Tailor, Soldier, Spy", "On Her Majesty's Secret Service"]
    r = Book.spy.pluck(:title)
    assert r.all? { |a| e.include?(a) }
  end

  test "humor scope" do
    e = ["The Innocents Abroad", "Fear and Loathing in Las Vegas"]
    r = Book.humor.pluck(:title)
    assert r.all? { |a| e.include?(a) }
  end
end
