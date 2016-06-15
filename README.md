# ActiveVinyl
---
ActiveVinyl provides Object Relational Mapping (ORM), which is used to convert data between incompatiable types. In this repo, ActiveVinyl will be using a .sql file and converting it to a ruby object.

## What does ActiveVinyl Do?
---
- `all` : returns an array of all records in the Database pertaining to that model.
-  `find` : like ActiveRecord, ActiveVinyl will find the model with the corresponding `id`.
-  `insert` : inserts a new row in the table with the given params.
-  `update` : updates a row with the given params.
-  `save` : saves or updates a row depending if the `id` is already present
- `where` : prevents SQL injection, takes a params argument, which then is used in a SQL query to return objects that match the params.
- `belongs_to` : takes the association name and an options hash, a method is then built with this association name
- `has_many` : similar to belongs_to (except like ActiveRecord, goes the other way.)
- `has_one_through` : combines two `belongs_to` associations to make a join query using the options of `table_name`, `foreign_key`, and `primary_key`. These values are stored in `assoc_options`. This method then fetches the associated object.
    + takes in three arguments: `association name`, `the third model name`, and `source model name`.

## How to Use
---
Clone this git repo, and require `sql_object` like:

```ruby
require_relative "./lib/sq_object"

class MODEL_NAME > SQLObject
  #code here
end
```
