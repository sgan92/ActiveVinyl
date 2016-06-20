require_relative '../lib/sql_object'

class Character < SQLObject
  finalize!

  belongs_to :show
end

class Show < SQLObject
  finalize!

  has_many :characters
end
