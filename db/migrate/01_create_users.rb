class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
            t.string :name
            t.string :username
            t.string :password
            t.integer :balance
            #WISHLIST and PRE-ORDERS SHALL BE ADDED!
        end
    end
end

# This is to create a database table. 
# The table is called users.
# table has 4 rows

# ONCE ALL THE TABLES YOU WANT ARE CREATED, YOU MUST DO rake db:migrate
# THEN DO rake db:seed