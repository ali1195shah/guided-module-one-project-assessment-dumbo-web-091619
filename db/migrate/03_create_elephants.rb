class CreateElephants < ActiveRecord::Migration[5.2]
    def change
        create_table :elephants do |t|
            t.string :name
            t.string :affiliation
            t.string :species
            t.string :gender
            t.string :dob
            t.string :note
            t.integer :worth
            #WIKILINK SHALL BE ADDED!
        end
    end
end


# This is to create a database table. 
# The table is called elephants.
# table has 7 rows