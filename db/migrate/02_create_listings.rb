class CreateListings < ActiveRecord::Migration[5.2]
    def change
        create_table :listings do |t|
            t.integer :user_id
            t.integer :elephant_id
            t.integer :pre_user_id
            t.integer :price
            t.string :title
            t.string :status
            t.timestamps
            #USER DESCRIPTION SHALL BE ADDED!
        end
    end
end


# def alt_elephants
#     elephants_arr = []

#     listings_related_to_user = Listing.all.select{|listing|
#     listing.user_id == self.id}.all.select{|listing|     
#         listing.status == "transaction"
#     }

#     elephants_id_list = listings_related_to_user.all.map{|listing| listing.elephant_id}

#     elephants_id_list.all.each do |id|
#         elephants_arr << Elephant.all.find_by(id: id)
#     end

# end


# This is to create a database table. 
# The table is called listings. (ALL TABLES MUST BE PLURAL)
# All tables have id row
# This table has 7 rows