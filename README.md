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
Clone this git repo. A .sql file has been made available, but feel free to use your own. Simply replace the paths in `lib/db_connection.rb`.

Once that's done, you can either make your own model accordingly and require `sql_object`:

```ruby
#model.rb

require_relative "./lib/sq_object"

class Character > SQLObject
  finalize!
  # finalize! is a method in SQLObject that sets attributes and their values.
end
```

Afterwards, go into your console, and using irb/pry, you can then load the file to access the methods available in ActiveVinyl.

```bash
[1] pry(main)> load 'model.rb'
  => true
[2] pry(main)> Character.all
  => [#<Character:0x007fdf09b14780
  @attributes={:id=>1, :name=>"Walter White", :tv_id=>4}>,
 #<Character:0x007fdf09b145f0
  @attributes={:id=>2, :name=>"Jesse Pinkman", :tv_id=>4}>,
 #<Character:0x007fdf09b144b0
  @attributes={:id=>3, :name=>"Sarah Manning", :tv_id=>1}>,
 #<Character:0x007fdf09b14370
  @attributes={:id=>4, :name=>"Alison Hendrix", :tv_id=>1}>,
 #<Character:0x007fdf09b14230
  @attributes={:id=>5, :name=>"Chandler Bing", :tv_id=>3}>,
 #<Character:0x007fdf09b140f0
  @attributes={:id=>6, :name=>"Phoebe Buffay", :tv_id=>3}>,
 #<Character:0x007fdf09b0ff50
  @attributes={:id=>7, :name=>"Barney Stinson", :tv_id=>2}>]

[3] pry(main)> Character.find(2)
  {"id"=>2, "name"=>"Jesse Pinkman", "tv_id"=>4}
  => #<Character:0x007fdf09b14870 @attributes={:id=>2, :name=>"Jesse Pinkman", :tv_id=>4}>

[4] pry(main)> Character.all.first.attributes
  => {:id=>1, :name=>"Walter White", :show_id=>4}

```

We can also utilize `.where` in ActiveVinyl. (Don't worry about requiring anything else in the file, everything has already been required outside of sql_object).

```bash
[6] pry(main)> Character.where(show_id:  1)
=> [
#<Character:0x007fc6c9891088 @attributes={:id=>3, :name=>"Sarah Manning", :show_id=>1}>,
 #<Character:0x007fc6c98908b8 @attributes={:id=>4, :name=>"Alison Hendrix", :show_id=>1}>
 ]
```

To access the association methods, you will have to create more models for the database you may wish to use. Or, you can use the ones provided. (Since these models are so small to demonstrate uses of ActiveVinyl, they were put in a single file.)

```ruby
# model.rb
require_relative '../lib/sql_object'

class Character < SQLObject
  finalize!

  belongs_to :show
end

class Show < SQLObject
  finalize!

  has_many :characters
end

```

```bash
[7] pry(main)> Character.all.first.show
  => #<Show:0x007fc9b1118ff0 @attributes={:id=>4, :name=>"Breaking Bad", :showType_id=>1}>

[8] pry(main)> Show.all.first.characters
  => [
  #<Character:0x007fa4ec1b0ba0 @attributes={:id=>3, :name=>"Sarah Manning", :show_id=>1}>,
   #<Character:0x007fa4ec1b0920 @attributes={:id=>4, :name=>"Alison Hendrix", :show_id=>1}>
   ]

```
