class Listing < ActiveRecord::Base
    belongs_to :user
    belongs_to :elephant
    #If we want to use Prompt, we should write the code below that line.
    @@prompt = TTY::Prompt.new

    def self.main_menu(user)
        puts "--- Main Menu ---"
        @@prompt.select("What would you like to do? 🐘") do |menu|
            menu.choice "🐘  Check My Balance", -> { user.show_my_balance(user) }
            menu.choice "🐘  See My Elephant(s)", -> { user.my_elephant(user) }
            menu.choice "🐘  See All Listings That Are Available", -> { Listing.display_all_listings(user) }
            menu.choice "🐘  See My Order History", -> { Listing.order_history }
            menu.choice "🐘  See my Account Settings", -> { User.account_settings }
        end
    end

    def self.display_all_listings(user)
        title_arr = Listing.all.map(&:title)
        chosen_title = @@prompt.select("Here are all the Titles for Listings: ", title_arr)

        listing1 = Listing.all.find{|listing| listing.title == chosen_title}
        elephant_id = listing1.elephant_id
        elephant_obj = Elephant.all.find{|elephant| elephant.id == elephant_id}

            puts "Name: #{elephant_obj.name}"
            puts "From: #{elephant_obj.affiliation}"
            puts "Date of Birth: #{elephant_obj.dob}"
            puts "Species: #{elephant_obj.species}"
            puts "Gender: #{elephant_obj.gender}"
            puts "About: #{elephant_obj.note}"
            puts "Bought for: $#{elephant_obj.worth}"

        @@prompt.select("<--------->") do |sub|
            sub.choice "Buy This Elephant", -> { user.buy_elephant(listing1)}
            sub.choice "Go Back to Main Menu...", -> {Listing.main_menu(user)}
        end
    end

    def order_history
        if order_history.size == 0
            puts "You don't have any orders 😭"
        else
            puts "Here are your past orders: "
            # First we shoud do the buy method.
        end
    end

end


