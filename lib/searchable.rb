require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    what_i_want = []
    params.each do |key, _|
      what_i_want << "#{key} = ?"
    end
    what_i_want = what_i_want.join(" AND ")
    selected = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{what_i_want}
    SQL

    selected.map do |result|
      self.new(result)
    end

  end
end

class SQLObject
  extend Searchable
end
