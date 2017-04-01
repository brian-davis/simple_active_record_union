require 'test_helper'


class AuthorTest < ActiveSupport::TestCase
  def setup
    Author.destroy_all
    Book.destroy_all
    Rails.application.load_seed
  end

  test "science_fiction scope" do
    e = ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem"]
    r = Author.science_fiction.pluck(:full_name)
    assert r.all? { |a| e.include?(a) }
  end

  test "spy scope" do
    e = ["Tom Clancy", "John Le Carré", "Ian Fleming"]
    r = Author.spy.pluck(:full_name)
    assert r.all? { |a| e.include?(a) }
  end

  test "humor scope" do
    e = ["Mark Twain", "Hunter S. Thompson"]
    r = Author.humor.pluck(:full_name)
    assert r.all? { |a| e.include?(a) }
  end

  test "all_my_favorite_authors scope" do
    e = ["Mark Twain", "Hunter S. Thompson", "Tom Clancy", "John Le Carré", "Ian Fleming", "Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem"]
    r = Author.all_my_favorite_authors.pluck(:full_name)
    assert r.all? { |a| e.include?(a) }
  end
end
