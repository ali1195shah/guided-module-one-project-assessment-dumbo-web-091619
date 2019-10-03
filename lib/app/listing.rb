class Listing < ActiveRecord::Base
    belongs_to :user
    belongs_to :elephant
    #If we want to use Prompt, we should write the code below that line.
    @@prompt = TTY::Prompt.new

    def self.main_menu(user)
        system 'clear'
        user.reload
        puts "--- Main Menu ---"
        @@prompt.select("What would you like to do? 🐘") do |menu|
            menu.choice "🐘  Check My Balance", -> { user.show_my_balance(user) }
            menu.choice "🐘  See My Elephant(s)", -> { user.my_elephant }
            menu.choice "🐘  See All Listings That Are Available", -> { Listing.display_all_listings(user) }
            menu.choice "🐘  See My Order History", -> { user.order_history }
            menu.choice "🐘  See My Account Settings", -> { User.account_settings(user) }
            menu.choice "🐘  Exit", -> { puts "Have a Nice Day!" }
        end
    end

    def self.display_all_listings(user)
        system 'clear'
        available_listings = Listing.all.select{|listing| listing.status == "open"} # This means select the listing of those that have the status "open".
        title_arr = available_listings.map{|listing| listing.title} # This will map over the available_listings array and sholve the title of the listing into titale_arr
        # binding.pry
        chosen_title = @@prompt.select("Here are all the Titles for Listings: ", title_arr) # a list of whats inside title_arr will display and the user will pick one. 

        listing1 = available_listings.find{|listing| listing.title == chosen_title} # This will match what availabe_listings with chosen_title.
        elephant_id = listing1.elephant_id # When it finds a match, elephant_id will be assigned what ever is in listing1.elephant_id
        # binding.pry
        elephant_obj1 = Elephant.all.find{|elephant| elephant.id == elephant_id} # This will go over the Elephant table and look at all the id of all the elephant and try to find one that matches elephant_id which is a variable.
        Listing.show_details(user, elephant_obj1, listing1) # This will show all the datails of the selected elephant. the show.defails method is below.
    end

    def self.show_details(user, elephant_obj, listing)
            puts "Name: #{elephant_obj.name}"
            puts "From: #{elephant_obj.affiliation}"
            puts "Date of Birth: #{elephant_obj.dob}"
            puts "Species: #{elephant_obj.species}"
            puts "Gender: #{elephant_obj.gender}"
            puts "About: #{elephant_obj.note}"
            puts "Price: $#{listing.price}"

        @@prompt.select("<--------->") do |sub|
            sub.choice "Buy This Elephant!", -> { user.buy_elephant(listing)} # If the user wants to buy it, it will user the method in the User class.
            sub.choice "Go Back to List...", -> { Listing.display_all_listings(user)} # If the user wants to go back.
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)} # This will go to the main main_menu.
        end
    end

end

# ******************************************************************************************************************************************************************************************************************************************
# If the user wants to buy it, it will user the method in the User class.

# def buy_elephant(listing)
#     system 'clear'
#     if listing.status == "open" && self.valid_money?(listing) # This checks if the status of the elephant is "open" and if the user has more money that then what the elephant costs.
#         elephant = Elephant.all.find_by(id: listing.elephant_id) # This will find the elephant by the id that is equal to listing.elephant_id.
#         upd = self.balance - listing.price # users money after the transaction.
#         upd2 = User.all.find_by(id: listing.user_id).balance + listing.price # This is adding the money from the user to the user1/Elephant_sect account.
#         User.all.find_by(id: listing.user_id).update(balance: upd2)
#         self.update(balance: upd) # This is now the new user balance.
#         elephant.update(worth: listing.price)
#         Listing.create({user_id: self.id,elephant_id: elephant.id,pre_user_id: listing.user_id,price: listing.price,title: "you own that elephant",status: "transaction"})
#         listing.update(status: "closed") #we change it to .delete
#         user_listings = User.all.find_by(id: listing.user_id).listings
#         user_listings.find_by(elephant_id: listing.elephant_id, status: "transaction").update(status: "closed transaction")
#         # binding.pry
#         puts "Congrats! You have owned an 🐘 💩. We hope to see you around!"
#         sleep(3)
#         Listing.main_menu(self)
#     else
#         puts "Sorry, you don't have enough 💰 or the listing that you trying to reach is not available!"
#     end
# end