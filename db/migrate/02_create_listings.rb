class CreateListings < ActiveRecord::Migration[5.2]
    def change
        create_table :listings do |t|
            t.integer :user_id
            t.integer :elephant_id
            t.integer :price
            t.string :title
            t.timestamps
            #USER DESCRIPTION SHALL BE ADDED!
        end
    end
end