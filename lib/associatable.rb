require_relative "searchable"

module Associatable

  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      search_params = {}
      search_params[options.primary_key] = self.send(options.foreign_key)
      options.model_class.where(search_params).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      search_params = {}
      search_params[options.foreign_key] = self.send(options.primary_key)
      options.model_class.where(search_params)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end

  def has_one_through(name, through_name, source_name)

    define_method(name) do
     through_options = self.class.assoc_options[through_name]
     source_options =
       through_options.model_class.assoc_options[source_name]

     through_table = through_options.table_name
     through_pk = through_options.primary_key
     through_fk = through_options.foreign_key

     source_table = source_options.table_name
     source_pk = source_options.primary_key
     source_fk = source_options.foreign_key

     key_val = self.send(through_fk)
     results = DBConnection.execute(<<-SQL, key_val)
       SELECT
         #{source_table}.*
       FROM
         #{through_table}
       JOIN
         #{source_table}
       ON
         #{through_table}.#{source_fk} = #{source_table}.#{source_pk}
       WHERE
         #{through_table}.#{through_pk} = ?
     SQL

     source_options.model_class.parse_all(results).first
   end
  end

end
