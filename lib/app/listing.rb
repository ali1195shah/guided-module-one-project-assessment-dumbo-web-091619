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
        available_listings = Listing.all.select{|listing| listing.status == "open"}
        title_arr = available_listings.map{|listing| listing.title}
        # binding.pry
        chosen_title = @@prompt.select("Here are all the Titles for Listings: ", title_arr)

        listing1 = available_listings.find{|listing| listing.title == chosen_title}
        elephant_id = listing1.elephant_id
        # binding.pry
        elephant_obj1 = Elephant.all.find{|elephant| elephant.id == elephant_id}
        Listing.show_details(user, elephant_obj1, listing1)
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
            sub.choice "Buy This Elephant!", -> { user.buy_elephant(listing)}
            sub.choice "Go Back to List...", -> { Listing.display_all_listings(user)}
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)}
        end
    end

end


