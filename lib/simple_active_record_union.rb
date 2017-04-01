require "active_record"
require "simple_active_record_union/version"

# > Author.union(Author.all, Author.all).count
#    (2.2ms)  SELECT COUNT(*) FROM (SELECT "authors".* FROM "authors" UNION SELECT "authors".* FROM "authors") AS authors
#  => 8
#
# > Author.union_all(Author.all, Author.all).count
#    (3.4ms)  SELECT COUNT(*) FROM (SELECT "authors".* FROM "authors" UNION ALL SELECT "authors".* FROM "authors") AS authors
#  => 16
#
# > Author.science_fiction.pluck(:full_name)
#    (0.3ms)  SELECT "authors"."full_name" FROM "authors" WHERE "authors"."full_name" IN ('Isaac Asimov', 'Arthur C. Clarke', 'Stanisław Lem')
#  => ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem"]
#
# > Author.spy.pluck(:full_name)
#    (0.3ms)  SELECT "authors"."full_name" FROM "authors" WHERE "authors"."full_name" IN ('Tom Clancy', 'John Le Carré', 'Ian Fleming')
#  => ["Tom Clancy", "John Le Carré", "Ian Fleming"]
#
# > Author.humor.pluck(:full_name)
#    (0.2ms)  SELECT "authors"."full_name" FROM "authors" WHERE "authors"."full_name" IN ('Mark Twain', 'Hunter S. Thompson')
#  => ["Mark Twain", "Hunter S. Thompson"]
#
# > Author.union(Author.science_fiction, Author.spy).pluck(:full_name)
#    (0.4ms)  SELECT "authors"."full_name" FROM (SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Isaac Asimov', 'Arthur C. Clarke', 'Stanisław Lem') UNION SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Tom Clancy', 'John Le Carré', 'Ian Fleming')) AS authors
#  => ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem", "Tom Clancy", "John Le Carré", "Ian Fleming"]
#
# > Author.union(Author.science_fiction, Author.spy, Author.humor).pluck(:full_name)
#    (0.5ms)  SELECT "authors"."full_name" FROM (SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Isaac Asimov', 'Arthur C. Clarke', 'Stanisław Lem') UNION SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Tom Clancy', 'John Le Carré', 'Ian Fleming') UNION SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Mark Twain', 'Hunter S. Thompson')) AS authors
#  => ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem", "Tom Clancy", "John Le Carré", "Ian Fleming", "Mark Twain", "Hunter S. Thompson"]
#
# > Author.union_all(Author.science_fiction, Author.spy, Author.humor).pluck(:full_name)
#    (0.3ms)  SELECT "authors"."full_name" FROM (SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Isaac Asimov', 'Arthur C. Clarke', 'Stanisław Lem') UNION ALL SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Tom Clancy', 'John Le Carré', 'Ian Fleming') UNION ALL SELECT "authors".* FROM "authors" WHERE "authors"."full_name" IN ('Mark Twain', 'Hunter S. Thompson')) AS authors
#  => ["Isaac Asimov", "Arthur C. Clarke", "Stanisław Lem", "Tom Clancy", "John Le Carré", "Ian Fleming", "Mark Twain", "Hunter S. Thompson"]
#
module SimpleActiveRecordUnion
  def union *subqueries
    unions = subqueries.map { |subquery| "#{subquery.to_sql}" }.join(" UNION ")
    statement = "(#{unions}) AS #{self.table_name}"
    self.from(self.connection.unprepared_statement { statement })
  end

  def union_all *subqueries
    unions = subqueries.map { |subquery| "#{subquery.to_sql}" }.join(" UNION ALL ")
    statement = "(#{unions}) AS #{self.table_name}"
    self.from(self.connection.unprepared_statement { statement })
  end
end

ActiveRecord::Base.class_eval do
  extend SimpleActiveRecordUnion
end
