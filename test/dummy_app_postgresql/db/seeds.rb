# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

authors = [
  { full_name: "Isaac Asimov" },
  { full_name: "Arthur C. Clarke" },
  { full_name: "Stanisław Lem"},
  { full_name: "Tom Clancy" },
  { full_name: "John Le Carré" },
  { full_name: "Ian Fleming" },
  { full_name: "Mark Twain" },
  { full_name: "Hunter S. Thompson" }
]

Author.create(authors)

Author.find_by({ full_name: "Isaac Asimov"}).books.create({ title: "Foundation" })
Author.find_by({ full_name: "Arthur C. Clarke"}).books.create({ title: "2001: A Space Odyssey" })
Author.find_by({ full_name: "Stanisław Lem"}).books.create({ title: "Solaris" })
Author.find_by({ full_name: "Tom Clancy"}).books.create({ title: "Clear and Present Danger" })
Author.find_by({ full_name: "John Le Carré"}).books.create({ title: "Tinker, Tailor, Soldier, Spy" })
Author.find_by({ full_name: "Ian Fleming"}).books.create({ title: "On Her Majesty's Secret Service" })
Author.find_by({ full_name: "Mark Twain"}).books.create({ title: "The Innocents Abroad" })
Author.find_by({ full_name: "Hunter S. Thompson"}).books.create({ title: "Fear and Loathing in Las Vegas" })


