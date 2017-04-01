require "active_record"
require "simple_active_record_union/version"

# > Author.union(Author.all, Author.all).count
#    (2.2ms)  SELECT COUNT(*) FROM (SELECT "authors".* FROM "authors" UNION SELECT "authors".* FROM "authors") AS authors
#  => 8
# > Author.union_all(Author.all, Author.all).count
#    (3.4ms)  SELECT COUNT(*) FROM (SELECT "authors".* FROM "authors" UNION ALL SELECT "authors".* FROM "authors") AS authors
#  => 16
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
