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